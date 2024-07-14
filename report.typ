
= EQ2341 Project

= Assignment 1

= 4 (First infinite hmm)

Calculating total expectation $E[X#sub[t]]$:

$E[X] = E#sub[S]\[E#sub[X]\[X|S]]$

$E[X|S=1] = #sym.mu#sub[1] = 0 $

$E[X|S=2] = #sym.mu#sub[2] = 3 $

$P(S#sub[t] = 1) = 0,75 $

$P(S#sub[t] = 2) = 0,25 $

Measured results: between .69 and .82 for S1

Law of total expectation: 

$E[X] = sum_j E[X|S=j]P(S=j) \
=0 + 3*0.25 = 0.75$

Total variance _var_$[X#sub[t]]$:
= (Check this)


_var_$[X] = E#sub[S]\[$_var_$#sub[X]\[X|S]] + $_var_$#sub[S]\[E#sub[X]\[X|S]] $

$E#sub[S]\[$_var_$#sub[X]\[X|S]] = $_var_$[X|S=1]P(S=1) + 
$_var_$[X|S=2]P(S=2)$

_var_$#sub[S]\[E#sub[X]\[X|S]] = E#sub[S]\[(E[X|S])^2]  
- (E#sub[S]\[E[X|S]])^2 $ 

$E#sub[s]\[E[X|S]] = #sym.mu#sub[1]P(S=1) + #sym.mu#sub[2]P(S=2) $

$E#sub[s]\[(E[X|S])^2] = #sym.mu#sub[1]^2P(S=1) + #sym.mu#sub[2]^2P(S=2)$

_var_$#sub[S]\[E#sub[X]\[X|S]] = #sym.mu#sub[1]P(S=1) + #sym.mu#sub[2]P(S=2) - ( #sym.mu#sub[1]^2P(S=1) + #sym.mu#sub[2]^2P(S=2) ) = 1.875$

Measured results: mean: Usually 70-80 but sometimes below 60 and above 90.
variance: Between 3 and 4

The plot alternates between sequences of mean 0 and 3 and with different durations. It tends to stay in the current state and with occational swithcing rather than swtiching rapidly between the two states This behaviour was otherwise easy to realize from the transition probability matrix.

#figure(
  image("images/A.1q4.png", width: 80%),
  caption: [500 contiguous samples from the first infinite-duration HMM],
)

= 5 (2nd infinite hmm)
Since the means are now the same we can't get any information about the states from the mean of the output. What sets them apart is just the variance but this can also be interpreted from the graph, as larger deviances from the mean suggests that we are in the second state. 

= 6 (finite hmm)

$ q = (.5, .5) $
$ A = ([.6, .3, .1], [.05, .95, 0])$

$#sym.mu#sub[1] = 0, #sym.sigma#sub[1] = 1$
$#sym.mu#sub[2] = 2, #sym.sigma#sub[2] = 3$

lengths: :

The lengths are quite spread, and they are rarely longer than 200 samples even though the maximum amount was set to 500. This is expected beacuse the probability of not having entered the Exit-state will decrease with the number of generated samples. Plotting the lengths in a histogram also results in an exponentially decreasing curve.

= 7


Assignment 2 :


