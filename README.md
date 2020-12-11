This repository contains the code used to produce the results of the manuscript: **[An empirical comparison between stochastic and deterministic centroid initialisation for K-Means variations](https://arxiv.org/abs/1908.09946)**

## Generate manuscript results 

To reproduce the results of the paper run *nag\_init\_methods\_generate.m* which will produce the folder *NAG_init_res*. This folder will be populated with several files in the format: *[modelName]\_model\_[setNo].mat* (for each clustering algorithm a subfolder will be created). Each of these files contains a struct array (rows: initialisation method, columns: number of data sets - default: 40). For stochastic methods multiple values are available based on the repetition of the clustering solution (default: 50).

**Struct fields:**

- *centers:* initial clustering centroids.
- *idx:* cluster index of each data point.
- *centroids:* final clustering centroids.
- *iterations:* number of iterations until convergence (not for Hartigan-Wong).
- *Silh2 & Silh:* silhouette index of the clustering solution (Silh2 was used in the manuscript).
- *wcd:* within-cluster-distance.
- *bcd:* between-cluster-distance.
- *clPur:* purity index of the clustering solution.

*nag\_init\_methods\_timing.m* runs the execution time analysis. It requires the folder *NAG_init_res* generated by *nag\_init\_methods\_generate.m*.

The results of *nag\_init\_methods\_generate.m* and *nag\_init\_methods\_timing.m* where then used to generate the figures and tables of the manuscript. For the results of a previous version of the manuscript (arXiv: [https://arxiv.org/abs/1908.09946](https://arxiv.org/abs/1908.09946)) code for plotting is provided, refer to commit [9e9a00](https://github.com/avouros/Code-KMeans-benchmark/tree/9e9a00ed7c9410ce97f56173e8ec85aa86cfcc08)


## Current dependences:

The results were produced using MATLAB R2018b with the following toolboxes:

1. Statistics and Machine Learning Toolbox
2. Parallel Computing Toolbox (if this toolbox is not available execution is still possible).
3. [The NAG Toolbox for MATLAB](https://www.nag.co.uk/nag-toolbox-matlab) to run Hartigan and Wong's K-Means.


## Citations for software and datasets that we have used in this project

### Datasets

**Clustering basic benchmark:**

[Fränti, Pasi, and Sami Sieranoja. "K-means properties on six clustering benchmark datasets." Applied Intelligence 48.12 (2018): 4743-4759.](https://link.springer.com/article/10.1007/s10489-018-1238-7)

**Gap models:**

[Tibshirani, Robert, Guenther Walther, and Trevor Hastie. "Estimating the number of clusters in a data set via the gap statistic." Journal of the Royal Statistical Society: Series B (Statistical Methodology) 63.2 (2001): 411-423.](https://rss.onlinelibrary.wiley.com/doi/abs/10.1111/1467-9868.00293)

**Weighted Gap models (YanYe):**

[Yan, Mingjin, and Keying Ye. "Determining the number of clusters using the weighted gap statistic." Biometrics 63.4 (2007): 1031-1037.](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1541-0420.2007.00784.x)

**Brodinova dataset generator:**

[Brodinová, Šárka, et al. "Robust and sparse k-means clustering for high-dimensional data." Advances in Data Analysis and Classification (2017): 1-28.](https://link.springer.com/article/10.1007/s11634-019-00356-9)

MATLAB code was based on the R implementation of the algorithm; package: [`wrsk`](https://github.com/brodsa/wrsk)

**Real datasets**

[Dua, D. and Graff, C. (2019). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.](https://archive.ics.uci.edu/ml/index.php)


### Clustering Algorithms

**Hartigan-Wong K-Means:**

MATLAB's and Python's default K-Means clustering is Lloyd's K-Means (initialized with the K-Means++ method) while R uses Hartigan-Wong' K-Means. Here we use [NAG Toolbox for MATLAB](https://www.nag.co.uk/nag-toolbox-matlab) Hartigan and Wong's K-Means implementation thus in order to use this algorithm the toolbox is required.

### Clustering Initialization

**K-Means++:**

Original algorithm is described in the study of [Arthur, D., & Vassilvitskii, S. (2007). k-means++: the advantages of careful seeding, p 1027–1035. In SODA'07: proceedings of the eighteenth annual ACM-SIAM symposium on discrete algorithms. Society for Industrial and Applied Mathematics, Philadelphia, PA.](https://theory.stanford.edu/~sergei/papers/kMeansPP-soda.pdf). MATLAB implementation was based on the instructions of the [MSDN Magazine Blog: Test Run - K-Means++ Data Clustering](https://msdn.microsoft.com/en-us/magazine/mt185575.aspx)

**Maximin:**

Stochastic version: [Gonzalez, T. F. (1985). Clustering to minimize the maximum intercluster distance. Theoretical computer science, 38, 293-306.](https://www.sciencedirect.com/science/article/pii/0304397585902245). Deterministic version: [Katsavounidis, I., Kuo, C. C. J., & Zhang, Z. (1994). A new initialization technique for generalized Lloyd iteration. IEEE Signal processing letters, 1(10), 144-146.](https://ieeexplore.ieee.org/abstract/document/329844).

**ROBIN:**

Original algorithm (deterministic) is described in the study of [Al Hasan, M., Chaoji, V., Salem, S., & Zaki, M. J. (2009). Robust partitional clustering by outlier and density insensitive seeding. Pattern Recognition Letters, 30(11), 994-1002.](https://www.sciencedirect.com/science/article/abs/pii/S0167865509000956): MATLAB code was originally based on the R implementation of the algorithm (stochastic version); package: [`wrsk`](https://github.com/brodsa/wrsk)

**Density K-Means++:**

[Nidheesh, N., KA Abdul Nazeer, and P. M. Ameer. "An enhanced deterministic K-Means clustering algorithm for cancer subtype prediction from gene expression data." Computers in biology and medicine 91 (2017): 213-221.](https://www.sciencedirect.com/science/article/pii/S0010482517303402)

MATLAB code was based on the R implementation of the algorithm; code: [`dkmpp_0.1.0`](https://github.com/nidheesh-n/dkmpp)

**Kaufman:**

MATLAB implementation was based on the pseudocode of [Pena, J. M., Lozano, J. A., & Larranaga, P. (1999). An empirical comparison of four initialization methods for the k-means algorithm. Pattern recognition letters, 20(10), 1027-1040.](https://www.sciencedirect.com/science/article/pii/S0167865599000690)

