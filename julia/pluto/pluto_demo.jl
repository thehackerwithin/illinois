### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ cfef9466-f842-11ea-261b-2b80bceb9dc1
using Pkg; Pkg.activate(".")

# ╔═╡ e3ae18fe-f842-11ea-0847-3bbca7d15e33
using CSV, Plots, PlutoUI, Dates

# ╔═╡ 3d64ff2c-f843-11ea-1991-05b467a6f3c8
csv = CSV.File("case_data-2.csv", normalizenames=true)

# ╔═╡ 4b5f4dda-f843-11ea-0154-9ba0ec840e23
rate = csv.New_Cases

# ╔═╡ 8fe751c8-f843-11ea-2b38-85b03e0a0a14
dates = Date.(first.(split.(csv._time, "T")))

# ╔═╡ a759712e-f843-11ea-1852-ff3fde291d2b
@bind ymin Slider(0:1:50; default=0)

# ╔═╡ aa5e2c38-f844-11ea-2d83-a31ffeadbac0
@bind ymax Slider(60:300; default=200)

# ╔═╡ 99d6c060-f843-11ea-21d9-fdffbdb596d3
plot(dates, rate, xlabel="Date", ylabel="# of tests", ylim=(ymin, ymax))

# ╔═╡ c4665d34-f845-11ea-016a-5f0faa7aaf7f
@gif for i in 1:length(dates)
	plot(dates[1:i], rate[1:i], xlabel="Date", ylabel="# of tests", ylim=(ymin, ymax))
end

# ╔═╡ Cell order:
# ╠═cfef9466-f842-11ea-261b-2b80bceb9dc1
# ╠═e3ae18fe-f842-11ea-0847-3bbca7d15e33
# ╠═3d64ff2c-f843-11ea-1991-05b467a6f3c8
# ╠═4b5f4dda-f843-11ea-0154-9ba0ec840e23
# ╠═8fe751c8-f843-11ea-2b38-85b03e0a0a14
# ╠═99d6c060-f843-11ea-21d9-fdffbdb596d3
# ╠═a759712e-f843-11ea-1852-ff3fde291d2b
# ╠═aa5e2c38-f844-11ea-2d83-a31ffeadbac0
# ╠═c4665d34-f845-11ea-016a-5f0faa7aaf7f
