# Schelling's Model

This project implements a simple code to simulate the well known Schelling's model of segregation. The code is written in Julia and uses the [Agents.jl](https://juliadynamics.github.io/Agents.jl/stable/) library.

## Repository Structure

- `agents.jl` – defines the agent types used in the simulation.
- `model.jl` – contains the model initialization function and the step functions.
- `functions.jl` – includes helper functions used to run and analyze the simulation.
- `example.ipynb` – Jupyter notebook with a simple simulation run and example plots.
- `Project.toml` / `Manifest.toml` – define the Julia environment for reproducibility.
- `README.md` – project description and usage instructions.
- `LICENSE` – open-source license (MIT) under which this project is distributed.

## Getting Started

### Requirements

- Julia (>= 1.6 recommended)
- [Agents.jl](https://github.com/JuliaDynamics/Agents.jl)
- Other dependencies are listed in `Project.toml`

### Installation

Clone the repository:

```bash
git clone https://github.com/FlavioBrandoli/Schelling-s-model.git
cd Schelling-s-model
````

Open Julia and activate the project environment:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

This will install all required dependencies listed in the `Project.toml` and `Manifest.toml` files.

To run simulations or explore the model:

👉 Refer to the [`example.ipynb`](example.ipynb) notebook, which includes all necessary `using` and `include` statements, as well as an example workflow for initializing and running the model.


## Theoretical Background

Schelling's model is one of the first examples of an agent-based model (ABM). Thanks to its simplicity, it is often used for pedagogical purposes and as a starting point to create more complex ABMs.

Developed in 1971 by the economist Thomas Schelling, the model shows how a mild preference by individuals for neighbors of their own group results, in the long term, in macroscopic segregation patterns.

For an explanation of the model's structure and agent behavior, see the [`example.ipynb`](example.ipynb) notebook.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Author

Flavio Brandoli
Politecnico di Torino – MSc Physics of Complex Systems
Complexity Science Hub Vienna – Thesis Host Institution
