#########################
# STATS 542 Assignment 3
#########################
# author: Nathan Walter
# netid: walter9

# Set up and load libraries ----
# Remove all working variables
rm(list = ls());
set.seed(0);

# Load neccessary libraries
library(MASS)
library(e1071)
library(klaR)
library(glmnet)
library(tree)
library(randomForest)
library(gbm)
library(ggplot2)

# Determines if printing is needed
print.results = TRUE;

# enter correct directory
setwd("C:/Users/walte_000/Dropbox/Nathan Walter/Talks/2016-05 The Hacker Within");

load("hw3Data.Rdata");

# create the reponse as a factor
traindata$Y = as.factor(traindata$Y);
train.n     = length(traindata$Y);
test.n      = length(testdata$Y);

# Print an 8 and a 3 for an example
example_3 = matrix(as.numeric(traindata[1,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(example_3, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

example_8 = matrix(as.numeric(traindata[3,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(example_8, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

# My Naive Bayes Parametric ----
response.levels = levels(traindata$Y);
num.levels      = length(response.levels);
num.predictors  = length(traindata[,-1]);
prior           = sum(traindata$Y == response.levels[1])/train.n;
means           = matrix(0, num.levels, num.predictors);
vars            = matrix(0, num.levels, num.predictors);

for(k in 1:num.levels) {
  means[k,] = apply(traindata[traindata$Y == response.levels[k],-1], 2, mean);
  vars[k,]  = apply(traindata[traindata$Y == response.levels[k],-1], 2, var);
}

nonzero.vars         = apply(vars == 0, 2, sum) == 0;
nonzero.vars.y       = matrix(FALSE, 1, num.predictors + 1);
nonzero.vars.y[1,-1] = apply(vars == 0, 2, sum) == 0;

term1       = colSums((t(testdata[,nonzero.vars.y]) - means[1,nonzero.vars])^2/(2.0*vars[1,nonzero.vars]));
term2       = colSums((t(testdata[,nonzero.vars.y]) - means[2,nonzero.vars])^2/(2.0*vars[2,nonzero.vars]));
logvars     = sum(log(vars[2,nonzero.vars]/vars[1,nonzero.vars]));
bayes.probs = logvars/2 + log(prior/(1-prior)) - term1 + term2;

mybayes.predict = rep("8", length(bayes.probs));
mybayes.predict[bayes.probs > 0] = "3";
mybayes.error   = sum(mybayes.predict != testdata$Y)/test.n;

# LDA ----
lda.fit     = lda(traindata$Y ~ ., traindata);
lda.predict = predict(lda.fit, testdata);
lda.error   = sum(lda.predict$class != testdata$Y)/test.n;
lda.pred.train  = predict(lda.fit, traindata);
lda.error.train = sum(lda.pred.train$class != traindata$Y)/train.n;

# plot LDA model 3 and 8
lda_3 = matrix(as.numeric(lda.fit$means[1,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(lda_3, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

lda_8 = matrix(as.numeric(lda.fit$means[2,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(lda_8, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

# LDA plot misclassified ----
lda_misclass_3 = matrix(as.numeric(testdata[73,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(lda_misclass_3, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

lda_misclass_8 = matrix(as.numeric(testdata[6,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(lda_misclass_8, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

# Naive Bayes parametric with zero sd's ----
bayes.zeros.fit     = naiveBayes(traindata$Y ~ ., traindata);
bayes.zeros.predict = predict(bayes.zeros.fit, testdata);
bayes.zeros.error   = sum(bayes.zeros.predict != testdata$Y)/test.n;
bayes.zeros.pred.train  = predict(bayes.zeros.fit, traindata);
bayes.zeros.error.train = sum(bayes.zeros.pred.train != traindata$Y)/train.n;

# plot naive bayes
means_3 = rep(0,256)
means_8 = rep(0,256)
for(i in 1:256) {
  means_3[i] = bayes.zeros.fit$tables[[i]][1]
  means_8[i] = bayes.zeros.fit$tables[[i]][2]
}
heatmap(matrix(means_3, nrow = 16, ncol = 16, byrow = TRUE), Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))
heatmap(matrix(means_8, nrow = 16, ncol = 16, byrow = TRUE), Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

# bayes plot misclassified ----
bayes_misclass_3 = matrix(as.numeric(testdata[2,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(bayes_misclass_3, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

bayes_misclass_8 = matrix(as.numeric(testdata[10,2:257]), nrow = 16, ncol = 16, byrow=TRUE)
heatmap(bayes_misclass_8, Rowv=NA, Colv=NA, revC = TRUE, scale="none", col=grey(seq(0,1,0.01)))

# Naive Bayes parametric ----
bayes.para.fit     = naiveBayes(traindata$Y ~ ., traindata[,nonzero.vars.y]);
bayes.para.predict = predict(bayes.para.fit, testdata);
bayes.para.error   = sum(bayes.para.predict != testdata$Y)/test.n;
bayes.para.pred.train  = predict(bayes.para.fit, traindata);
bayes.para.error.train = sum(bayes.para.pred.train != traindata$Y)/train.n;

# Naive Bayes non-parametric
bayes.nonpara.fit     = NaiveBayes(traindata$Y ~ ., traindata[,nonzero.vars.y], usekernel=TRUE);
bayes.nonpara.predict = predict(bayes.nonpara.fit, testdata)$class;
bayes.nonpara.error   = sum(bayes.nonpara.predict != testdata$Y)/test.n;
bayes.nonpara.pred.train  = predict(bayes.nonpara.fit, traindata);
bayes.nonpara.error.train = sum(bayes.nonpara.pred.train != traindata$Y)/train.n;

if(print.results) {
  cat(sprintf("LDA prediction test error is: %.4f\n", lda.error));
  cat(sprintf("bayes parametric with zero sd's prediction test error is: %.4f\n", bayes.zeros.error));
  cat(sprintf("my bayes parametric without zero sd's prediction test error is: %.4f\n", mybayes.error));
  cat(sprintf("bayes parametric prediction test error is: %.4f\n", bayes.para.error));
  cat(sprintf("Same as the mybayes\n"));
  cat(sprintf("bayes non-parametric prediction test error is: %.4f\n", bayes.nonpara.error));

  cat(sprintf("LDA prediction train error is: %.4f\n", lda.error.train));
  cat(sprintf("bayes parametric with zero sd's prediction train error is: %.4f\n", bayes.zeros.error.train));
  cat(sprintf("my bayes parametric without zero sd's prediction train error is: %.4f\n", bayes.para.error.train));
  cat(sprintf("bayes parametric prediction train error is: %.4f\n", bayes.para.error.train));
  cat(sprintf("Same as the mybayes\n"));
  cat(sprintf("bayes non-parametric prediction train error is: %.4f\n", bayes.nonpara.error.train));
}

# redo with princple componet analysis
pca           = princomp(traindata[,-1], cor = FALSE, scores = TRUE);
comp.var      = apply(pca$scores, 2, var);
comp.cumsum   = cumsum(comp.var)/sum(comp.var);
num.comps     = sum(comp.cumsum < 0.95) + 1;
pca.traindata = data.frame(as.matrix(traindata[,-1]) %*% pca$loadings[,1:num.comps]);
pca.testdata  = data.frame(as.matrix(testdata[,-1]) %*% pca$loadings[,1:num.comps]);

# PCA LDA
pca.lda.fit     = lda(traindata$Y ~ ., pca.traindata);
pca.lda.predict = predict(pca.lda.fit, pca.testdata);
pca.lda.error   = sum(pca.lda.predict$class != testdata$Y)/test.n;
pca.lda.pred.train  = predict(pca.lda.fit, pca.traindata);
pca.lda.error.train = sum(pca.lda.pred.train$class != traindata$Y)/train.n;

# PCA Naive Bayes parametric
pca.bayes.para.fit     = naiveBayes(traindata$Y ~ ., pca.traindata);
pca.bayes.para.predict = predict(pca.bayes.para.fit, pca.testdata);
pca.bayes.para.error   = sum(pca.bayes.para.predict != testdata$Y)/test.n;
pca.bayes.para.pred.train  = predict(pca.bayes.para.fit, traindata);
pca.bayes.para.error.train = sum(pca.bayes.para.pred.train != traindata$Y)/train.n;

# PCA Naive Bayes non-parametric
pca.bayes.nonpara.fit     = NaiveBayes(traindata$Y ~ ., pca.traindata, usekernel=TRUE);
pca.bayes.nonpara.predict = predict(pca.bayes.nonpara.fit, pca.testdata)$class;
pca.bayes.nonpara.error   = sum(pca.bayes.nonpara.predict != testdata$Y)/test.n;
pca.bayes.nonpara.pred.train  = predict(pca.bayes.nonpara.fit, traindata);
pca.bayes.nonpara.error.train = sum(pca.bayes.nonpara.pred.train != traindata$Y)/train.n;

if(print.results) {
  cat(sprintf("\nNumber of components after PCA with 95%% of data explained is %d\n", num.comps));
  cat(sprintf("PCA LDA prediction test error is: %.4f\n", pca.lda.error));
  cat(sprintf("PCA bayes parametric prediction test error is: %.4f\n", pca.bayes.para.error));
  cat(sprintf("PCA bayes non-parametric prediction test error is: %.4f\n\n", pca.bayes.nonpara.error));
  
  cat(sprintf("\nNumber of components after PCA with 95%% of data explained is %d\n", num.comps));
  cat(sprintf("PCA LDA prediction train error is: %.4f\n", pca.lda.error.train));
  cat(sprintf("PCA bayes parametric prediction train error is: %.4f\n", pca.bayes.para.error.train));
  cat(sprintf("PCA bayes non-parametric prediction train error is: %.4f\n\n", pca.bayes.nonpara.error.train));
}

# Logistic Regression Full ----
lr.full         = glm(traindata$Y ~ ., data = traindata, family = binomial(link=logit));
lr.full.predict = predict(lr.full, testdata, type="response");
lr.full.class   = matrix("3", 1, test.n);
lr.full.class[lr.full.predict > 0.5] = "8";
lr.full.error   = sum(lr.full.class != testdata$Y)/test.n;

# Logistic Regression AIC
base.model     = glm(traindata$Y ~ 1, data = traindata, family = binomial(link=logit));
lr.aic         = step(base.model, scope=list(upper=lr.full), trace=FALSE, direction="forward", k = 2);
lr.aic.predict = predict(lr.aic, testdata, type="response");
lr.aic.class   = matrix("3", 1, test.n);
lr.aic.class[lr.aic.predict > 0.5] = "8";
lr.aic.error   = sum(lr.aic.class != testdata$Y)/test.n;
lr.aic.terms   = attr(lr.aic$terms, "term.labels");
  
# Logistic Regression BIC
lr.bic         = step(base.model, scope=list(upper=lr.full), trace=FALSE, direction="forward", k=log(train.n));
lr.bic.predict = predict(lr.bic, testdata, type="response");
lr.bic.class   = matrix("3", 1, test.n);
lr.bic.class[lr.bic.predict > 0.5] = "8";
lr.bic.error   = sum(lr.bic.class != testdata$Y)/test.n;
lr.bic.terms   = attr(lr.bic$terms, "term.labels");
  
# Logistic Regression Lasso
lr.lasso         = cv.glmnet(data.matrix(traindata[,-1]), traindata[,1], family="binomial", alpha=1);
lr.lasso.predict = predict(lr.lasso, s=lr.lasso$lambda.min, newx = data.matrix(testdata[,-1]), type = "response");
lr.lasso.coef    = predict(lr.lasso, s=lr.lasso$lambda.min, type = "coefficients");
lr.lasso.class   = matrix("3", 1, test.n);
lr.lasso.class[lr.lasso.predict > 0.5] = "8";
lr.lasso.error   = sum(lr.lasso.class != testdata$Y)/test.n;
lr.lasso.terms   = (attr(lr.lasso.coef, "Dimnames")[[1]])[as.numeric(lr.lasso.coef) != 0];

if(print.results) {
  cat(sprintf("lr full error is: %.4f\n", lr.full.error));
  
  cat(sprintf("lr aic error is: %.4f\n", lr.aic.error));
  cat(sprintf("%d terms used for aic: \n", length(lr.aic.terms)));
  print(lr.aic.terms);
  
  cat(sprintf("lr bic error is: %.4f\n", lr.bic.error));
  cat(sprintf("%d terms used for bic: \n", length(lr.bic.terms)));
  print(lr.bic.terms);
  
  cat(sprintf("lr lasso error is: %.4f\n", lr.lasso.error));
  cat(sprintf("%d terms used for lasso: \n", length(lr.lasso.terms)));
  print(lr.lasso.terms);
}

# PCA Logistic Regression Full
lr.pca.full         = glm(traindata$Y ~ ., data = pca.traindata, family = binomial(link=logit));
lr.pca.full.predict = predict(lr.pca.full, pca.testdata, type="response");
lr.pca.full.class   = matrix("3", 1, test.n);
lr.pca.full.class[lr.pca.full.predict > 0.5] = "8";
lr.pca.full.error   = sum(lr.pca.full.class != testdata$Y)/test.n;

# PCA Logistic Regression AIC
base.pca.model     = glm(traindata$Y ~ 1, data = pca.traindata, family = binomial(link=logit));
lr.pca.aic         = step(base.pca.model, scope=list(upper=lr.pca.full), trace=FALSE, direction="forward", k = 2);
lr.pca.aic.predict = predict(lr.pca.aic, pca.testdata, type="response");
lr.pca.aic.class   = matrix("3", 1, test.n);
lr.pca.aic.class[lr.pca.aic.predict > 0.5] = "8";
lr.pca.aic.error   = sum(lr.pca.aic.class != testdata$Y)/test.n;
lr.pca.aic.terms   = attr(lr.pca.aic$terms, "term.labels");

# PCA Logistic Regression BIC
lr.pca.bic         = step(base.pca.model, scope=list(upper=lr.pca.full), trace=FALSE, direction="forward", k=log(train.n));
lr.pca.bic.predict = predict(lr.pca.bic, pca.testdata, type="response");
lr.pca.bic.class   = matrix("3", 1, test.n);
lr.pca.bic.class[lr.pca.bic.predict > 0.5] = "8";
lr.pca.bic.error   = sum(lr.pca.bic.class != testdata$Y)/test.n;
lr.pca.bic.terms   = attr(lr.pca.bic$terms, "term.labels");

# PCA Logistic Regression Lasso
lr.pca.lasso         = cv.glmnet(data.matrix(pca.traindata), traindata[,1], family="binomial", alpha=1);
lr.pca.lasso.predict = predict(lr.pca.lasso, s=lr.pca.lasso$lambda.min, newx = data.matrix(pca.testdata), type = "response");
lr.pca.lasso.coef    = predict(lr.pca.lasso, s=lr.pca.lasso$lambda.min, type = "coefficients");
lr.pca.lasso.class   = matrix("3", 1, test.n);
lr.pca.lasso.class[lr.pca.lasso.predict > 0.5] = "8";
lr.pca.lasso.error   = sum(lr.pca.lasso.class != testdata$Y)/test.n;
lr.pca.lasso.terms   = (attr(lr.pca.lasso.coef, "Dimnames")[[1]])[as.numeric(lr.pca.lasso.coef) != 0];

if(print.results) {
  cat(sprintf("\nlr pca full error is: %.4f\n", lr.pca.full.error));
  
  cat(sprintf("lr pca aic error is: %.4f\n", lr.pca.aic.error));
  cat(sprintf("%d terms used for pca aic: \n", length(lr.pca.aic.terms)));
  print(lr.pca.aic.terms);
  
  cat(sprintf("lr pca bic error is: %.4f\n", lr.pca.bic.error));
  cat(sprintf("%d terms used for pca bic: \n", length(lr.pca.bic.terms)));
  print(lr.pca.bic.terms);
  
  cat(sprintf("lr pca lasso error is: %.4f\n", lr.pca.lasso.error));
  cat(sprintf("%d terms used for pca lasso: \n", length(lr.pca.lasso.terms)));
  print(lr.pca.lasso.terms);
}

# SVM Linear
svm.linear         = svm(traindata$Y ~ ., traindata, scale = TRUE, kernel = "linear");
svm.linear.predict = predict(svm.linear, testdata);
svm.linear.error   = sum(svm.linear.predict != testdata$Y)/test.n;

# SVM Quadratic
svm.quad         = svm(traindata$Y ~ ., traindata, scale = TRUE, kernel = "polynomial", degree = 2);
svm.quad.predict = predict(svm.quad, testdata);
svm.quad.error   = sum(svm.quad.predict != testdata$Y)/test.n;

# SVM Guassian
#obj = tune(svm, Y~., data=traindata, ranges=list(gamma = 1/seq(.5*train.n, 2*train.n, train.n/10), cost = c(.1,1,2,4,10)), tunecontrol = tune.control(sampling = "fix"))
svm.gaus         = svm(traindata$Y ~ ., traindata, scale = TRUE, kernel = "radial");
svm.gaus.predict = predict(svm.gaus, testdata);
svm.gaus.error   = sum(svm.gaus.predict != testdata$Y)/test.n;

if(print.results) {
  cat(sprintf("\nsvm linear error is: %.4f\n", svm.linear.error));
  cat(sprintf("svm quadratic error is: %.4f\n", svm.quad.error));
  cat(sprintf("svm guassian error is: %.4f\n", svm.gaus.error));
}

# With PCA
# SVM Linear
pca.svm.linear         = svm(traindata$Y ~ ., pca.traindata, scale = TRUE, kernel = "linear");
pca.svm.linear.predict = predict(pca.svm.linear, pca.testdata);
pca.svm.linear.error   = sum(pca.svm.linear.predict != testdata$Y)/test.n;

# SVM Quadratic
pca.svm.quad         = svm(traindata$Y ~ ., pca.traindata, scale = TRUE, kernel = "polynomial", degree = 2);
pca.svm.quad.predict = predict(pca.svm.quad, pca.testdata);
pca.svm.quad.error   = sum(pca.svm.quad.predict != testdata$Y)/test.n;

# SVM Guassian
#obj = tune(svm, Y~., data=pca.traindata, ranges=list(gamma = 1/seq(.5*train.n, 2*train.n, train.n/10)), 
#           tunecontrol = tune.control(sampling = "fix"))
pca.svm.gaus         = svm(traindata$Y ~ ., pca.traindata, scale = TRUE, kernel = "radial");
pca.svm.gaus.predict = predict(pca.svm.gaus, pca.testdata);
pca.svm.gaus.error   = sum(pca.svm.gaus.predict != testdata$Y)/test.n;

if(print.results) {
  cat(sprintf("\nsvm pca linear error is: %.4f\n", pca.svm.linear.error));
  cat(sprintf("svm pca quadratic error is: %.4f\n", pca.svm.quad.error));
  cat(sprintf("svm pca guassian error is: %.4f\n", pca.svm.gaus.error));
}

# Full Tree
tree.full            = tree(traindata$Y ~ ., traindata, mindev = 0.0005, minsize = 1, split="deviance");
tree.full.prediction = predict(tree.full, testdata, type="class");
tree.full.error      = sum(tree.full.prediction != testdata$Y)/test.n;
pdf("~/Documents/2010.UIUC.Course Work/STATS 542/Homework3/FullTree.pdf",width=7, height=8);
plot(tree.full);
text(tree.full, cex = 0.5);
dev.off();

# prune tree based on dev
cv.tree.dev         = cv.tree(tree.full, K = 10, FUN=prune.tree);
bestsize.dev        = cv.tree.dev$size[which.min(cv.tree.dev$dev)];
tree.pruned.dev     = prune.tree(tree.full, best = bestsize.dev, method = "deviance");
tree.prediction.dev = predict(tree.pruned.dev, testdata, type="class");
tree.error.dev      = sum(tree.prediction.dev != testdata$Y)/test.n;
pdf("~/Documents/2010.UIUC.Course Work/STATS 542/Homework3/DevTree.pdf",width=7, height=8);
plot(tree.pruned.dev);
text(tree.pruned.dev, cex = 0.5);
dev.off();

#prune tree based on misclass
cv.tree.mis         = cv.tree(tree.full, FUN=prune.misclass);
bestsize.mis        = cv.tree.mis$size[which.min(cv.tree.mis$dev)];
tree.pruned.mis     = prune.tree(tree.full, best = bestsize.mis, method = "misclass");
tree.prediction.mis = predict(tree.pruned.mis, testdata, type="class");
tree.error.mis      = sum(tree.prediction.mis != testdata$Y)/test.n;
pdf("~/Documents/2010.UIUC.Course Work/STATS 542/Homework3/MisTree.pdf",width=7, height=8);
plot(tree.pruned.mis);
text(tree.pruned.mis, cex = 0.5);
dev.off();

if(print.results) {
  cat(sprintf("\ntree full error is: %.4f\n", tree.full.error));
  cat(sprintf("tree pruned dev of size %d error is: %.4f\n", bestsize.dev, tree.error.dev));
  cat(sprintf("tree pruned mis of size %d error is: %.4f\n\n", bestsize.mis, tree.error.mis));
}

# Random Forest
forest = randomForest(traindata$Y ~ ., traindata, importance=TRUE);
forest.predict = predict(forest, testdata, type = "class");
forest.error = sum(forest.predict != testdata$Y)/test.n;

if(print.results) {
  cat(sprintf("random forest error is: %.4f\n", forest.error));
}
pdf("~/Documents/2010.UIUC.Course Work/STATS 542/Homework3/RandomForest.pdf",width=5, height=4);
plot(forest)
dev.off();
pdf("~/Documents/2010.UIUC.Course Work/STATS 542/Homework3/RandomForestImportance.pdf",width=5, height=7);
varImpPlot(forest)
dev.off();

# Bagging
y.as.numeric = as.numeric(traindata$Y == "3") # convert to 0 and 1, 1 is a 3

for( shrink.param in c(1, .5, .1, .05, .01, .001) ) {
  gbm.full = gbm(y.as.numeric ~ ., data = traindata[,-1], distribution = "adaboost", n.trees = 1000, 
                 interaction.depth = 3, shrinkage = shrink.param, train.fraction = 1, cv.folds = 5);
  gbm.interation = gbm.perf(gbm.full, method = "cv");
  gbm.prediction = as.numeric(predict(gbm.full, testdata, n.trees = gbm.interation, type = "response") > 0.5);
  gbm.error = sum(gbm.prediction != as.numeric(testdata$Y == "3"))/test.n;
  cat(sprintf("boost with shrinkage param %f and iterations %d has error: %.4f\n", shrink.param, gbm.interation, gbm.error));
}

