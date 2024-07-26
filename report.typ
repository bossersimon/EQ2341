
#align(center, text(17pt)[
  *EQ2341 Project*
  ])

#align(center, text(15pt)[ 
  *Assignment 1*
  ])

Code and data for all assignments is available at https://github.com/bossersimon/EQ2341/tree/main/Assignment_1 .

*1) Calculation of $P(S_t = j)$ : * 

$ q = vec(0.75, 0.25); quad A = mat(0.99, 0.01; 0.03, 0.97) $
$ p_1 = q^T\A = mat(0.75, 0.25) = q^T => \
=> p A = p $ (constant for all t)

*2) Measured relative frequencies:* 
$ S_1: 0.749; quad S_2: 0.251 $


*3) Calculation of $E[X], "var"[X]$ for the first infinite-duration HMM:*

$E[X] = E_S\[E_X\[X|S]] ; quad E[X|S=1] = mu _1 = 0 , quad E[X|S=2] = mu _2 = 3 $

$P(S = 1) = 0.75 $

$P(S = 2) = 0.25 $


Law of total expectation: 

$E[X] = sum_j E[X|S=j]P(S=j) = \
=0 + 3*0.25 = 0.75$

Total variance $"var"[X]$:

$sigma_1 = 1, quad sigma_2 = 2$

$"var"[X] = E_S\["var"_X\[X|S]] + "var"_S\[E_X\[X|S]] = "{p.14 in textbook}" =\
  = "var"_X\[X|S=1]P(S=1) + "var"_X\[X|S=2]P(S=2) + \
  + (mu_1 - mu)^2P(S=1) + (mu_2 - mu)^2P(S=2) = \
  = sigma_1^2P(S=1) + sigma_2^2P(S=2) + P(S=1)mu^2 + P(S=2)(mu_2 - mu)^2 = \ 
  = 3.4375
$

*Measured results*: 
$ E[X] approx 0.81; quad "var"[X] approx 3.59 $

*4) 1st Infinite-duration HMM*

The plot alternates between sequences of mean 0 and 3 and with different durations. It tends to stay longer in state 1 but occasionally falls into state 2 and then quickly switches again. This behaviour was otherwise easy to read off the transition probability matrix. The plot is shown in @hmm1. 

#figure(
  image("images/A.1q4.png", width: 80%),
  caption: [500 contiguous samples from the first infinite-duration HMM],
) <hmm1>

*5) 2nd Infinite HMM*

Since the mean values of the two states are now the same we can't get any information about the states from the mean of the output. What sets them apart is just the variance but this can also be interpreted from the graph (@hmm2), as larger deviances from the mean suggests that we are in the second state. Overall it's slightly harder to determine where the state changes than with the previous HMM, but it shows similar transition behaviour (that it generally stays for longer in state 1).

#figure(
  image("images/A.1q5.png", width: 80%),
  caption: [500 contiguous samples from the second infinite-duration HMM],
) <hmm2>

*6) Finite HMM*

$ q = vec(0.5, 0.5); quad A = mat(0.6, 0.3, 0.1; 0.05, 0.95, 0); quad B = vec(N(0,1), N(2,3)) $

Some sequence lengths: $ mat(12, 41, 224, 38, 68, 47, 44, 36, 3) $

The lengths are quite spread, and they are rarely longer than 200 samples even though the maximum amount was set to 500. This is expected beacuse the probability of not having entered the Exit-state will decrease with the number of generated samples. Plotting the lengths of different generated sequences in a histogram results in an exponentially decreasing curve (@fig3).

#figure(
  image("images/A.1q6.png", width: 80%),
  caption: [Histogram showing lengths of 600 generated sequences],
) <fig3>

*7) Vector-valued HMM*

$ q = vec(0.5,0.5); quad A = mat( 0.7,0.2,0.1; 0.05, 0.95,0); quad B = vec(b_1~ N(mu_1,Sigma_1), b_2 ~N(mu_2, Sigma_2)) $
$ mu_1 = vec(0,1), Sigma_1 = mat(2,1;1,4) $
$ mu_2 = vec(2,3), Sigma_2 = mat(2,0;0,1) $

The following was calculated using _np.mean()_ and _np.cov()_ on the generated samples:

$ "cov" = mat(1.93467522, 0.24082159; 0.24082159, 1.03941542); quad mu = vec(1.8934840514693778, 2.8932389585408287) . $

We note that the calculated mean and covariances lie somewhere inbetween those of each of the states, so this seems to work.

#align(center, text(15pt)[ 
  *Assignment 2*
  ])

One issue that appeared during this part has to do with the scaling of the Forward- and Backward variables. According to the instructions, the _forward()_ function should be applied directly to the scaled probabilities produced by _prob()_, but this gives a different answer. Normalizing the columns of pX (output of _prob()_ ) instead gives the following:

$ c = mat(0.8757894, 0.15196629, 0.45640399, 0.05811253) $

The correct answer according to the verification section is obtained by scaling so that the largest value in each column of pX becomes $1$:

$ "pX" = mat(0.39104269, 0.01358297, 0.17136859; 0.05546042, 0.19552135, 0.13899244) $

 $ "pX"/mat("np.max(p) for p in pX") = mat(1. ,0.06947052 , 1. ; 0.14182701 ,1. , 0.81107303) $

This gives 

$ c = mat(1. ,0.16252347 ,0.82658096 ,0.05811253). $

Obviously, the columns of pX do not add up to $1$ in this case. Perhaps this is not very important as long as numerical problems are avoided as discussed in p.237 in the textbook. 

#align(center, text(15pt)[ 
  *Assignment 3*
  ])

Data for the project was collected using the Sensor Fusion app. $11$ recordings were made, containing roughly $23$ minutes of activity data in total. I'm the only person doing recordings because I thought it was the easiest and fastest way. Of course, using data from multiple people would result in a more useful and more general classifier. 

For feature extraction, the euclidian norm of the recorded acceleration was first calculated, and subtracting the gravitational acceleration leaves us with the movement signal only. This made the resulting signal independent of the orientation of the phone which is convenient for this task. Then the absolute value was taken to obtain the magnitude as can be seen in @acc. Furthermore, the mean of this magnitude was calculated for equally spaced segments (of $100$ samples), leaving us with a number of windowed segments $x_t$ which were used as features for model training and testing, shown in @meanAcc. These windows were then used as features for model training and testing. The exact same result is obtained with a moving average.

#set math.equation(
  numbering: "(1)",
  supplement: [Eq.]
)

$ x_t = (sum_(l=100t)^(100(t+1)-1) abs(sqrt(a_x^2+a_y^2+a_z^2) - 9.82))/100 $ <eq1>


#figure(
  image("images/A.3_acc.png", width: 100%),
  caption: [Magnitude of acceleration for a recording],
) <acc>

#figure(
  image("images/A.3_meanAcc.png", width: 100%),
  caption: [Segmented mean of recording],
) <meanAcc>


More features could've been added to provide additional useful information to the classifier. In this solution however, a single type of feature was arguably sufficient, owing to the simplicity of the task; The differences in acceleration between the three activities are so large and clear-cut. More features would probably be needed if more activities were to be added (e.g. walking up/down stairs, cycling), or if there was no clear-cut distinction between the activities. And this classifier may have trouble classifying a faster walk on the verge of running for example.

In order to label the features ($x_t$) in the recordings, a simple threshold mechanism was used as can be seen in @labels. The thresholds were chosen based on inspection and all recordings were also checked for inconsistencies or outliers. This can be thought of as a "rough" sliding window detector. 

The recordings were also divided into smaller segments of 50 samples in order to facilitate the division into train- and test data later on. Instead of 11 recordings of different lengths, there are now 27 sub-segments of roughly equal length. For training of an ergodic HMM this does not matter as long as each recording contains at least a few transitions.

#figure(
  image("images/A.3_labels2.png", width: 100%),
  caption: [Labeled sub-segment of a recording],
) <labels>


= HMM Initialization

The inital HMM was chosen as

#set math.equation( numbering: none)
$ q = vec(1/3,1/3,1/3); quad A = mat(0.9,0.09,0.01; 0.05,0.9,0.05; 0.01,0.09,0.9); quad B = vec(b_1(x),b_2(x), b_3(x)), $ where state 1 = "Standing", state 2 = "Walking", state 3 = "Running".

An infinite-duration ergodic HMM is chosen to model the behaviour so it may start in any state. This choice is due to the fact that there is no way to get locked up in any subset of states (You cannot run forever), and there is no periodicity in these types of activities.

The following assumptions were made; That each activity is equally probable, so the elements of $q$ are equal for all states. For the transition probabilities it is more probable to stay in a certain state for at least a few seconds than to transition directly. Given that the data was sampled at $100$Hz and that each window is $100$ samples long, the diagonal values were set quite high to reflect this behaviour. A segment of any state is therefore considered to be $9s$ on average, but there is no correct answer here ("How long is a walk?"). The non-diagonal elements are also somewhat guesstimated; From the "Standing" state it is quite improbable to start running directly, as is the transition from "Running" to "Standing". Conversely, while in the "Walking" state, it's assumed that it's equally likely to start running and to stop walking.

The emission probability distributions are chosen as three separate (scalar) Gaussian distributions. There is just a single feature and collecting the features of a recording in a histogram resembles a bell curve so this seems like a reasonable choice. One such histogram is shown in @hist. The distributions were initialized by fitting to clusters of data for each activity as discussed in section 6.2.4 in the textbook. They are defined in @eqB below. 

#set math.equation(numbering: "(1)")
$ B = vec(b_1~N(0.21, 0.13), b_2~N(1.76, 0.45), b_3~N(6.01, 0.99)) $ <eqB>
#set math.equation(numbering: none )

#figure(
  image("images/A.3_hist.png", width: 80%),
  caption: [Amplitudes of recorded "Walking" feature samples],
) <hist>

= HMM Training
The train/test data was divided in a 3:1 split. This choice is of little importance and it seemed to work fine like this, but a 1:1- or a 4:1- split would probably work also.

The HMM was then trained using the Baum-Welch algorithm. It was done automatically by following Eq. $6.10$ and $6.13$ in the course book. The output probability distributions were however not updated; GMM's were not used, so Eq. $7.6.5$ (in the course book) was not relevant, and the mean and variances are already estimated as the weighted average of the observed data and observed variances, respectively. If more data was collected to update the model, these distributions would have to be updated also.

One issue prior to training was that some output probabilities evaluated to zero when applied to feature data. This is arguably because the distributions are so far away from each other and some samples of running would result in a zero probability of standing still. This sounds alright but in order to avoid numerical problems later on all probabilities below a certain (small) threshold $epsilon$ were set to the threshold value using the $max()$-function.

The resulting HMM after training is given by 

$ q = vec(0.17, 0.56, 0.28); quad A = mat(0.86,0.13,0.01; 0.04,0.92,0.04; 4e-3,0.06,0.935); quad B = vec(b_1~N(0.21, 0.13), b_2~N(1.76, 0.45), b_3~N(6.01, 0.99)) . $ 

= Classifier Evaluation


The most probable sequences in the test data according to the HMM were obtained using the Viterbi algorithm, which were then compared to the true labels. The classification is summarized in the confusion matrix in @confusion. In total 99.59% of the states were correctly classified. 

#figure(
  image("images/A.3_confusion.png", width: 80%),
  caption: [Confusion matrix showing classification results on the test dataset],
) <confusion>

The classifier worked well in this case, but considering there was only one person collecting the data it might not prove useful on data from other people. This model is rather dumb; it only looks at the magnitude of the input signal and is probably sensitive to outliers even though a moving average was used. What speaks for the model is that it is simple and contains only a single feature, i.e. very low complexity. The few misclassifications could probably have been avoided by including more features to discriminate the signals, for example a signal that can account for the frequency of the activity.

In a different problem if more activities were included, it would've been a more complicated task. Perhaps you would've needed the z-coordinate of the acceleration after all for distinguishing walking on the ground from walking in a staircase. A more complex problem would obviously need more data. 

There were also some things that I thought about but didn't implement; Since gathering data this way is a bit tedious (in other cases it can also be very expensive), you could make out the distribution(s) from a smaller amount of data and sample from this to generate more data. For this project, I figured that generating synthetic recordings using an existing transition matrix wouldn't exactly improve the accuracy of the resulting matrix, for example. 

Cross-validation could've been used to get a better idea of the quality of the model. Especially when the amount of training data is small. This is more imporant for more complex models, so it was omitted in this project. Looking at the performance on the test data, I would argue that the model is not overfitting at least, but as mentioned above it probably generalizes poorly. 
