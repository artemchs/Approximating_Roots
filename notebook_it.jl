### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ 7710fcd7-77aa-4617-b5ae-ef23e37f9c82
using Roots

# ╔═╡ 3f69cbd1-2b0b-4d36-873b-10175438ed85
using ForwardDiff

# ╔═╡ 4a538dc0-4897-11f1-991c-bd4747535024
md"# Approssimare gli zeri di una funzione"

# ╔═╡ 00efff6f-187f-4d32-95de-4047cbb06bc7
md"
### Metodo di Newton

1. Scegli una prima approssimazione a una soluzione dell'equazione $f(x) = 0$. Un grafico di $y = f(x)$ può essere d'aiuto.

2. Usa la prima approssimazione per ottenere una seconda, la seconda per ottenerne una terza, e così via, usando la formula

```math
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}, \text{ if } f'(x_n) \neq 0.
```
"

# ╔═╡ a3726c7f-2acd-4426-9090-e074ef375613
md"### Esempio"

# ╔═╡ 3b4c4935-2f14-446b-9101-6bf98ebbdfa6
md"
Possiamo usare il metodo di Newton per trovare approssimazioni decimali di $\sqrt{2}$ stimando la radice positiva dell'equazione $f(x) = x^2 - 2 = 0$.

Dato che $f(x) = x^2 - 2$, allora $f'(x) = 2x$. Quindi,
```math
\begin{align*}
x_{n+1} &= x_n - \frac{x_n^2-2}{2x_n} \\
		&= x_n - \frac{x_n}{2} + \frac{1}{x_n} \\
		&= \frac{x_n}{2} + \frac{1}{x_n}.
\end{align*}
```

L'equazione
```math
x_{n+1} = \frac{x_n}{2} + \frac{1}{x_n}
```
ci permette di passare da un'approssimazione alla successiva con pochi tasti.
"

# ╔═╡ 42c08e17-538f-48a5-a853-ff28c976c850
md"Sia il valore iniziale $x_0 = 1$ e $n = 3$."

# ╔═╡ 0830c0e5-a5bd-4602-9437-a762c320b28a
function example_approximate_x(n)
    v = Float64[1]

    for i = 2:(n+1)
        push!(v, v[i-1] / 2 + 1 / v[i-1])
    end

    return v
end

# ╔═╡ 8a84ca8c-7683-4074-9d7d-a3ebc09b2a4b
println(example_approximate_x(3))

# ╔═╡ f3b4ba74-c6b8-4cb6-b8f8-6a9610feed24
md"Con sole tre iterazioni abbiamo approssimato $\sqrt{2}$ correttamente fino a cinque cifre decimali, o, equivalentemente, a sei cifre, $\sqrt{2} = 1.41421$.
E diventa ancora più preciso all'aumentare di $n$:"

# ╔═╡ 62c5e9bb-aaad-4f62-941f-1595268c4c6b
println(example_approximate_x(10)[10])

# ╔═╡ 4a8e18a7-8e80-4ac3-b122-fe11bcecd89c
md"### Implementazione"

# ╔═╡ b185a23e-599d-4c4b-9a09-a4458f4130ca
f(x) = sin(x)

# ╔═╡ d0d09f9b-a5a2-4a9e-97f3-c75c7ef6aba1
x_0 = 2π / 3

# ╔═╡ 126a3297-5ddd-4f16-ab41-3d1343eafdf9
n = 10

# ╔═╡ c5c058e3-4338-43db-8d59-39b77bebed8f
function find_tangent_line_zero(f, x_n)
    find_zero(x -> ForwardDiff.derivative(f, x_n) * (x - x_n) + f(x_n), x_n)
end

# ╔═╡ 549268cd-32a1-4f51-b120-3637bf530ff2
function approximate_x(n)
    v = Float64[x_0]

    for i = 2:(n+1)
        push!(v, find_tangent_line_zero(f, v[i-1]))
    end

    v
end

# ╔═╡ da6e7004-de0c-4a24-abf0-6e2c91c56ca6
approximate_x(n)[n]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
Roots = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"

[compat]
ForwardDiff = "~1.3.3"
Roots = "~3.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "375949276082f4abf4f59a1e1402297c67731acd"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "2eeb2c9bef11013efc6f8f97f32ee59b146b09fb"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.44"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CommonSolve]]
git-tree-sha1 = "78ea4ddbcf9c241827e7035c3a03e2e456711470"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.6"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cddeab6487248a39dae1a960fff0ac17b2a28888"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "1.3.3"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

    [deps.InverseFunctions.weakdeps]
    Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Roots]]
deps = ["Accessors", "CommonSolve", "Printf"]
git-tree-sha1 = "91cfb1cb4f6e27557cc2df798a31eff6089a41eb"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "3.0.0"

    [deps.Roots.extensions]
    RootsChainRulesCoreExt = "ChainRulesCore"
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"
    RootsUnitfulExt = "Unitful"

    [deps.Roots.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2700b235561b0335d5bef7097a111dc513b8655e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.7.2"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"
"""

# ╔═╡ Cell order:
# ╟─4a538dc0-4897-11f1-991c-bd4747535024
# ╟─00efff6f-187f-4d32-95de-4047cbb06bc7
# ╟─a3726c7f-2acd-4426-9090-e074ef375613
# ╟─3b4c4935-2f14-446b-9101-6bf98ebbdfa6
# ╟─42c08e17-538f-48a5-a853-ff28c976c850
# ╠═0830c0e5-a5bd-4602-9437-a762c320b28a
# ╠═8a84ca8c-7683-4074-9d7d-a3ebc09b2a4b
# ╟─f3b4ba74-c6b8-4cb6-b8f8-6a9610feed24
# ╠═62c5e9bb-aaad-4f62-941f-1595268c4c6b
# ╟─4a8e18a7-8e80-4ac3-b122-fe11bcecd89c
# ╠═7710fcd7-77aa-4617-b5ae-ef23e37f9c82
# ╠═3f69cbd1-2b0b-4d36-873b-10175438ed85
# ╠═b185a23e-599d-4c4b-9a09-a4458f4130ca
# ╠═d0d09f9b-a5a2-4a9e-97f3-c75c7ef6aba1
# ╠═126a3297-5ddd-4f16-ab41-3d1343eafdf9
# ╠═c5c058e3-4338-43db-8d59-39b77bebed8f
# ╠═549268cd-32a1-4f51-b120-3637bf530ff2
# ╠═da6e7004-de0c-4a24-abf0-6e2c91c56ca6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
