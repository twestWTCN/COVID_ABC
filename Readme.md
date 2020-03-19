#
# Epidemiological Modelling of COVID-19 with Approximate Bayesian Computation- Projections and Strategy

This project involves the application of the Approximate Bayesian Computation framework to the current COVID-19 pandemic. The general aim of this project is to make a synthesis of the current transmission data supplied by various global health agencies (see data section below), with epidemiological modelling. We aim to use inverse modelling to test transmission models of the coronavirus and make projections for its spread under a range of different containment scenarios. For access to contribute, please contact [timothy.west92@gmail.com](mailto:timothy.west92@gmail.com).

# Data

The current scripting uses data taken from the 2019 Novel Coronavirus COVID-19 (2019-nCoV) Data Repository by Johns Hopkins CSSE ([https://github.com/CSSEGISandData/COVID-19](https://github.com/CSSEGISandData/COVID-19)). This dataset is updated daily and compiled from primary data collected by a number of global health agencies.

# Epidemiological Model

The current forward model used in this project is based upon a generalized SEIR (Susceptible-Exposed-Infectious-Recovered-Susceptible) model, for a simple tutorial please see: [https://idmod.org/docs/malaria/model-seir.html#seirs-with-vital-dynamics](https://idmod.org/docs/malaria/model-seir.html#seirs-with-vital-dynamics). The exact forward model was coded by E.Cheynet [1] and can be found at [https://github.com/ECheynet/SEIR](https://github.com/ECheynet/SEIR). The aim of this project is to test and compare alternative models so we are looking for possible variant models from contributors.

# Model Optimization

This project inverts the forward epidemiological model using Approximate Bayesian Computation [2] using an implementation that has been adapted from a toolbox introduced in [3]. This model uses priors over parameters to specify a single model, and then uses an interative, stochastic sampler to approximate a posterior density of parameters, given the empirical data. These posteriors can then be used to provide an explicit post-hoc model comparison between competing generative models.

# Installation

This repository has dependencies

1. SPM12 - https://github.com/spm/spm12
2. ABC Inference Neural Paper - https://github.com/cagnan-lab/ABC_Inference_Neural_Paper
3. Small plotting packages included in COVID Dependencies folder.

Once the dependencies are downloaded, you need to alter the paths included in 'ABCAddPaths' (included as part of the ABC Inference Neural Paper package) to link to your GITHUB root path, and link to the SPM12 path (which may or not also be on your GITHUB path). Please add your PC name in the switch/case format seen in this file.

To get started run 'firstRun_v1.m', having set the path on line two to point to the ABC package path. If things aren't working, feel free to contact me. 


# To Do:

1. Link data directly to the CSSEGIS repository.
2. Test predicted parameters with those in current literature.
3. Translate predictions from countries with advanced infections to those without (e.g. from China to UK)
4. Implement alternative models of epidemiological spread and compare with model comaparison framework.
5. Use predicted models to make projections under a range of containment scenarios.

timothy.west92@gmail.com


[1] E. Cheynet (2020). Generalized SEIR Epidemic Model (fitting and computation) (https://www.github.com/ECheynet/SEIR), GitHub. Retrieved March 18, 2020.

[2] Beaumont MA, Zhang W, Balding DJ. Approximate Bayesian Computation in Population Genetics. Genetics. 2002;162: 2025 LP – 2035. Available: [http://www.genetics.org/content/162/4/2025.abstract](http://www.genetics.org/content/162/4/2025.abstract)

[3] Timothy O. West, Luc Berthouze, Simon F. Farmer, Hayriye Cagnan, Vladimir Litvak. Mechanistic Inference of Brain Network Dynamics with Approximate Bayesian Computation. bioRxiv 785568; doi: https://doi.org/10.1101/785568