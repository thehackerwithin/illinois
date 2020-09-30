### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e003c93e-0342-11eb-3475-a7e062522612
begin
	using Pkg; Pkg.activate(".")
	using CSV, Plots, Dates, GLM, DataFrames
end

# ╔═╡ 8598b314-0343-11eb-0974-5dd52d8562c3
csv = CSV.read("case_data.csv", normalizenames=true)

# ╔═╡ 6c494f2a-0345-11eb-19f6-a3d541e7f693
csv[:tests] = CSV.File("test_data.csv", normalizenames=true).Total_Daily_Tests_Results

# ╔═╡ 32ba5b62-0347-11eb-11e1-e91fb77fa9a2
csv[:date] =  Date.(first.(split.(csv._time, `T`)))

# ╔═╡ c75ea32e-0345-11eb-03e2-c705e180661a
olm = lm(@formula(New_Cases ~ date), csv);

# ╔═╡ f1e09c7c-0347-11eb-0eeb-5f25f3e72792
begin
	plot(csv.date, csv.New_Cases, yscale=:linear)
	plot!(csv.date, predict(olm))
end

# ╔═╡ 91be4cf0-0348-11eb-1044-192a17d508b1


# ╔═╡ 8a213bd0-0344-11eb-2669-25e0f0887ca0
dates = Date.(first.(split.(csv._time, `T`)))

# ╔═╡ 0550bf42-0345-11eb-373c-ef0ea8e8158c
plot(dates, csv.Case_Positivity_)

# ╔═╡ 0e9489f8-0345-11eb-246a-e3a38fe39852
plot(dates, csv.New_Cases)

# ╔═╡ Cell order:
# ╠═e003c93e-0342-11eb-3475-a7e062522612
# ╠═8598b314-0343-11eb-0974-5dd52d8562c3
# ╠═6c494f2a-0345-11eb-19f6-a3d541e7f693
# ╠═32ba5b62-0347-11eb-11e1-e91fb77fa9a2
# ╠═c75ea32e-0345-11eb-03e2-c705e180661a
# ╠═f1e09c7c-0347-11eb-0eeb-5f25f3e72792
# ╠═91be4cf0-0348-11eb-1044-192a17d508b1
# ╠═8a213bd0-0344-11eb-2669-25e0f0887ca0
# ╠═0550bf42-0345-11eb-373c-ef0ea8e8158c
# ╠═0e9489f8-0345-11eb-246a-e3a38fe39852
