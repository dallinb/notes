# Python and Using NetworkX and PyPlot to Visualise a Graph

NetworkX
[[1](https://networkx.github.io/documentation/stable/)]
[[2](https://conference.scipy.org/proceedings/SciPy2008/paper_2/)]
contains a few empirical data sets.  In this example, we are going
to use the _Karate Club_
[[3](https://networkx.github.io/documentation/stable/auto_examples/graph/plot_karate_club.html?highlight=karate)] data set.

In this very basic example, we load the data set, create a figure and then
use PyPlot to display the figure.

```Python
import networkx as nx
import matplotlib.pyplot as plt

G = nx.karate_club_graph()
figure = nx.draw(G,
                 with_labels=True,
                 node_color="lightblue",
                 edge_color="gray")
plt.show(figure)
```

## References

- [1] _Overview of NetworkX_ available at
<https://networkx.github.io/documentation/stable/> accessed 2019-12-31.
- [2] Aric A. Hagberg, Daniel A. Schult and Pieter J. Swart,
“[Exploring network structure, dynamics, and function using NetworkX](http://conference.scipy.org/proceedings/SciPy2008/paper_2/)”,
in
[Proceedings of the 7th Python in Science Conference (SciPy2008),](http://conference.scipy.org/proceedings/SciPy2008/index.html)
Gäel Varoquaux, Travis Vaught, and Jarrod Millman (Eds),
(Pasadena, CA USA), pp. 11–15, Aug 2008
- [3] _Network X: Karate Club_ available at
<https://networkx.github.io/documentation/stable/auto_examples/graph/plot_karate_club.html?highlight=karate>
accessed 2019-12-31.
