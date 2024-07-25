
#align(center, text(17pt)[
  *EQ2341 Project*
  ])

#align(center, text(15pt)[ 
  *Assignment 1*
  ])


Calculation of $P(S_t = j)$ :

$ q = vec(0.75, 0.25); quad A = mat(0.99, 0.01; 0.03, 0.97) $
$ p_1 = q^T\A = mat(0.75, 0.25) = q^T => \
=> p A = p $ (constant for all t)

*Measured frequencies:* between .69 and .82 for S1

Calculation of the total expectation $E[X_t]$ for the first infininte-duration HMM:

$E[X] = E_S\[E_X\[X|S]]$ ;  $E[X|S=1] = #sym.mu\ _1 = 0 $, $E[X|S=2] = #sym.mu\ _2 = 3 $

$P(S = 1) = 0.75 $

$P(S = 2) = 0.25 $


Law of total expectation: 

$E[X] = sum_j E[X|S=j]P(S=j) = \
=0 + 3*0.25 = 0.75$


Total variance $"var"[X]$:
/*
$"var"[X] = E_S\["var"_X\[X|S]] + "var"_S\[E_X\[X|S]] $

$E_S\["var"_X\[X|S]] = "var"[X|S=1]P(S=1) + "var"[X|S=2]P(S=2) = 1.25$

$"var"_S\[E_X\[X|S]] = E_S\[(E[X|S])^2] - (E_S]\[E[X|S]])^2 $ 

$E_S\[E[X|S]] = mu_1P(S=1) + mu_2P(S=2) = mu_2P(S=2)$

$E_S\[(E[X|S])^2] = mu_1^2P(S=1) + mu_2^2P(S=2) = mu_2^2P(S=2)$

$"var"_S\[E_X\[X|S]] = mu_2P(S=2) - mu_2^2P(S=2) = 1.69$

$ => "var"_X = 2.94$

*/

$"var"[X] = E_S\["var"_X\[X|S]] + "var"_S\[E_X\[X|S]] = {p.14} =\
  = "var"_X\[X|S=1]P(S=1) + "var"_X\[X|S=2]P(S=2) + \
  + (mu_1 - mu)^2P(S=1) + (mu_2 - mu)^2P(S=2) = \
  = sigma_1^2P(S=1) + sigma_2^2P(S=2) + P(S=1)mu^2 + P(S=2)(mu_2 - mu)^2 = \ 
  = 3.4375
$

*Measured results*: mean: Usually 70-80 but sometimes below 60 and above 90.
variance: Between 3 and 4


#figure(
  image("images/A.1q4.png", width: 80%),
  caption: [500 contiguous samples from the first infinite-duration HMM],
)

The plot alternates between sequences of mean 0 and 3 and with different durations. It tends to stay longer in state 1 but occasionally falls into state 2 and then quickly switches again. This behaviour was otherwise easy to read off the transition probability matrix.

#figure(
  image("images/A.1q5.png", width: 80%),
  caption: [500 contiguous samples from the second infinite-duration HMM],
)

= 5 (2nd infinite hmm)
Since the mean values of the two states are now the same we can't get any information about the states from the mean of the output. What sets them apart is just the variance but this can also be interpreted from the graph, as larger deviances from the mean suggests that we are in the second state. Overall it's slightly harder to determine where the state changes than with the previous HMM, but it shows similar transition behaviour (that it generally stays for longer in state 1).

= 6 (finite hmm)

$ q = vec(0.5, 0.5); quad A = mat(0.6, 0.3, 0.1; 0.05, 0.95, 0); quad B = vec(N(0,1), N(2,3)) $

Code in appendix

Some lengths: [12, 41, 224, 38, 68, 47, 44, 36, 3]

The lengths are quite spread, and they are rarely longer than 200 samples even though the maximum amount was set to 500. This is expected beacuse the probability of not having entered the Exit-state will decrease with the number of generated samples. Plotting the lengths of different generated sequences in a histogram results in an exponentially decreasing curve (@fig3).

#figure(
  image("images/A.1q6.png", width: 80%),
  caption: [Histogram showing lengths of 600 generated sequences],
) <fig3>

= 7

$ q = vec(0.5,0.5); quad A = mat( 0.7,0.2,0.1; 0.05, 0.95,0); quad B = vec(b_1~ N(mu_1,sigma_1), b_2 ~N(mu_2, sigma_2)) $
$ mu_1 = vec(0,1), sigma_1 = mat(2,1;1,4) $
$ mu_2 = vec(2,3), sigma_2 = mat(2,0;0,1) $

#align(center, text(15pt)[ 
  *Assignment 2*
  ])

The code for this part is included as a link in the end of the report.

One issue that arose with this part has to do with the scaling of the Forward- and Backward variables. According to the instructions, the _forward()_ function should be applied directly to the scaled probabilities produced by _prob()_, but this gives a different answer. Normalizing the columns of pX (output of _prob()_ ) instead gives the following:

$ c = mat(0.8757894, 0.15196629, 0.45640399, 0.05811253) $

The correct answer according to the verification section is obtained by scaling so that the largest value in each column of pX becomes $1$:

$ "pX" = mat(0.39104269, 0.01358297, 0.17136859; 0.05546042, 0.19552135, 0.13899244) $

 $ "pX"/mat("np.max(p) for p in pX") = mat(1. ,0.06947052 , 1. ; 0.14182701 ,1. , 0.81107303) $

This gives 

$ c = mat(1. ,0.16252347 ,0.82658096 ,0.05811253) $

Obviously, the columns of pX do not add up to $1$ in this case. Perhaps this is not very important as long as numerical problems are avoided as discussed in *p.237*. 

Your assignment report should include

• A copy of your finished \@MarkovChain/forward function.

• A copy of your finished \@HMM/logprob function

• A copy of your finished \@MarkovChain/backward function.


#align(center, text(15pt)[ 
  *Assignment 3*
  ])

A comprehensive presentation that highlights the motivation, methodology, experimental results, and analysis of your activity recognition classifier.

• Well-documented and organized code that implements the HMM-based
classifier. You can either include the code directly in the submission or provide a link to an accessible repository where the code is hosted.

• The recorded data used for training and evaluation. Include the data inthe submission or provide a link to an accessible repository where the data is hosted.

• A README file that provides clear instructions on how to run and re-
produce the results obtained from your code. Include any specific depen-
dencies or setup requirements, if applicable.


Data for the project was collected using the Sensor Fusion app. Hmmhmm recordings were done, comprising? hmmmhmm minutes of activity data. I'm the only person doing the recordings because I thought it was the easiest and fastest way. Of course, using data from multiple people would probably result in a more useful and more general classifier. I think however that the point of the project is to simply train an HMM and if it's not good it won't really matter, and if it performs exceptionally well (close to 100% accuracy) I will probably know why.

For feature extraction, the absolute value of the euclidean norm was calculated for each recorded signal (i.e. the norm of the acceleration) and the mean was then calculated for equally large segments of the resulting signal. This resulted in a number of windows ($x_t$), each 100 samples long, containing the mean value of each segment (@eq1). These windows were then used as features for model training and testing. 

#set math.equation(
  numbering: "(1)",
  supplement: [Eq.]
)

$ x_t = (sum_(l=100t)^(100(t+1)-1) sqrt(a_x^2+a_y^2+a_z^2))/100 $ <eq1>

Additional features could've been added to provide more useful information to the classifier, which is usually the case. In this solution however, a single type of feature was sufficient, owing to the simplicity of the task; The differences in acceleration between the three activities is so large and clear-cut that no more information was needed. More features would probably be needed if more activities were to be added (e.g. walking up/down stairs, cycling), or if there was no clear-cut distinction between the activities. And this classifier may have trouble classifying a faster walk on the verge of running for example.

In order to label the features ($x_t$) in the recordings, a simple threshold mechanism was used as can be seen in *fig...*. The thresholds were chosen based on inspection and all recordings were also checked for inconsistencies or outliers. 

= HMM Initialization
The train/test data was divided in a *{hmm}* split.

The inital HMM was chosen as

#set math.equation( numbering: none)
$ q = vec(1/3,1/3,1/3); quad A = mat(0.9,0.09,0.01; 0.05,0.9,0.05; 0.01,0.09,0.9); quad B = vec(b_1(x),b_2(x), b_3(x)), $ where state 1 = "Standing", state 2 = "Walking", state 3 = "Running".

An infinite-duration ergodic HMM is chosen to model the behaviour, so it may start in any state. This choice is due to the fact that there is no way to get locked up in any subset of states (You cannot run forever), and there is no periodicity in these types of activities.

The following assumptions were made; That each activity is equally probable, so the elements of $q$ are equal for all states. For the transition probabilities it is more probable to stay in a certain state for at least a few seconds than to transition directly. Given that the data was sampled at $100$Hz and that each window is $100$ samples long, the diagonal values were set quite high to reflect this behaviour. A segment of any state is therefore considered to be $9s$ on average, but there is no correct answer here ("How long is a walk?"). The non-diagonal elements are also somewhat arbitrary; From the "standing" state it is quite improbable to start running directly, as is the transition from "running" to "standing". Conversely, while in the "walking" state, it's assumed that it's equally likely to start running and to stop walking.

The emission probability distributions are chosen as three separate (scalar) gaussian distributions. There is just a single feature and plotting the features of a recording in a histogram gives a bell curve so this seems like a reasonable choice. One such histogram is shown in *fig ...*. The distributions were initialized by fitting to clusters of data for each activity as discussed in *section 6.2.4*.


$ B = vec(b_1~N(0.21, 0.13), b_2~N(1.74, 0.46), b_3~N(5.97, 0.99)) $

 

= HMM Training

The HMM was trained using the Baum-Welch algorithm. It was done automatically using *Eq 6.10, 6.13* in the course book. The output probability distributions were however not updated. GMM's were not used, so *7.6.5* was not relevant, and the mean and variances are already estimated as the weighted average of the observed data and observed variances, respectively.

One issue prior to training was that some output probabilities evaluated to zero when applied to feature data. This is arguably because the distributions are so far away from each other and some samples of running would result in a zero probability of standing still. This sounds alright but in order to avoid numerical problems later on all probabilities below a certain (small) threshold $epsilon$ were set to the threshold value using the $max()$-function.

Another *concern* is related to the scaling of the Forward- and Backward variables as mentioned in Assignment 2...

The resulting HMM after training is given by 

$ q = vec(0.43, 0.29, 0.28); quad A = mat(0.86,0.13,0.01; 0.04,0.92,0.04; 6e-7,0.06,0.937); quad B = vec(b_1~N(0.21, 0.13), b_2~N(1.74, 0.46), b_3~N(5.97, 0.99)). $ 

= Classifier Evaluation

Ideas for improvements:
Use z- coordinate; for stairs, running
More data
More people
More states
Synthetic data
Comment on choice of features
