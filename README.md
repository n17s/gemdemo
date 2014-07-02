Demo code for Generalized Eigenvector based features
=======

The files here demonstrate the algorithm in our ICML 2014 paper
[Discriminative Features via Generalized Eigenvectors](http://jmlr.org/proceedings/papers/v32/karampatziakis14.html "GEM paper")

For the purposes of this demo, we use the calibrated least squares algorithm from our [least squares paper](http://jmlr.org/proceedings/papers/v32/agarwala14.html) as the optimizer. A version of this algorithm is included in this repository. You can also check [the least squares repository](http://github.com/fest/secondorderdemos) for other algorithms (that work as well or better with the features here)

gemdriver does the following on the mnist digit dataset
* extracts GEM features and fits a multiclass classifier 
* extracts two layers of GEM features and fits a multiclass classifier

