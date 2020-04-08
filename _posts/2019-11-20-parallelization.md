---
layout: post
title: Parallelization
author: Cail Daley and Paul 'Yubo' Yang
date: November 20
category: posts
tags: meeting
---

Cail: Over the past two decades, graphical processing units (GPUs) have become one of the most successful tools for accelerating numerical computing. On Wednesday I’ll begin by discussing the hardware considerations that have led to the prevalence of GPUs; then we’ll turn to some of the principles of GPU programming. We’ll close by examining GPU implementations of some common algorithms like image blurring and matrix multiplication. Slides hosted [here](html/gpu_slides.html)!

[ECE 408 Applied Parallel Programming course website](https://wiki.illinois.edu/wiki/display/ECE408/ECE408+Home)

Paul: Dask is an intuitive and flexible graph execution engine for Python. I will demonstrate how to parallelize Python analysis code by adding a few lines of dask in a way that is fully compatible with serial execution (i.e. you can turn off dask with a flag). If time permits, I will go over more advanced features of dask such as: building your own cluster and visualizing parallel execution (dask dashboard).
Tutorial files are available on in [this][dask-para] Github repository.

[dask-para]: https://github.com/Paul-St-Young/thw-dask-para
