import numpy as np
from .DiscreteD import DiscreteD

class MarkovChain:
    """
    MarkovChain - class for first-order discrete Markov chain,
    representing discrete random sequence of integer "state" numbers.
    
    A Markov state sequence S(t), t=1..T
    is determined by fixed initial probabilities P[S(1)=j], and
    fixed transition probabilities P[S(t) | S(t-1)]
    
    A Markov chain with FINITE duration has a special END state,
    coded as nStates+1.
    The sequence generation stops at S(T), if S(T+1)=(nStates+1)
    """
    def __init__(self, initial_prob, transition_prob):

        self.q = initial_prob  #InitialProb(i)= P[S(1) = i]
        self.A = transition_prob #TransitionProb(i,j)= P[S(t)=j | S(t-1)=i]
        self.nStates = transition_prob.shape[0]
        self.is_finite = False

        if self.A.shape[0] != self.A.shape[1]:
            self.is_finite = True

    def probDuration(self, tmax):
        """
        Probability mass of durations t=1...tMax, for a Markov Chain.
        Meaningful result only for finite-duration Markov Chain,
        as pD(:)== 0 for infinite-duration Markov Chain.
        
        Ref: Arne Leijon (201x) Pattern Recognition, KTH-SIP, Problem 4.8.
        """
        pD = np.zeros(tmax)

        if self.is_finite:
            pSt = (np.eye(self.nStates)-self.A.T)@self.q # why I-A.T ?

            for t in range(tmax):
                pD[t] = np.sum(pSt) # ? 
                pSt = self.A.T@pSt

        return pD

    def probStateDuration(self, tmax):
        """
        Probability mass of state durations P[D=t], for t=1...tMax
        Ref: Arne Leijon (201x) Pattern Recognition, KTH-SIP, Problem 4.7. 
                                                                    -> 5.7?
        """
        t = np.arange(tmax).reshape(1, -1)
        aii = np.diag(self.A).reshape(-1, 1)
        
        logpD = np.log(aii)*t+ np.log(1-aii)
        pD = np.exp(logpD)

        return pD

    def meanStateDuration(self):
        """
        Expected value of number of time samples spent in each state
        """
        return 1/(1-np.diag(self.A))
    
    def rand(self, tmax):
        """
        S=rand(self, tmax) returns a random state sequence from given MarkovChain object.
        
        Input:
        tmax= scalar defining maximum length of desired state sequence.
           An infinite-duration MarkovChain always generates sequence of length=tmax
           A finite-duration MarkovChain may return shorter sequence,
           if END state was reached before tmax samples.
        
        Result:
        S= integer row vector with random state sequence,
           NOT INCLUDING the END state,
           even if encountered within tmax samples
        If mc has INFINITE duration,
           length(S) == tmax
        If mc has FINITE duration,
           length(S) <= tmaxs
        """
        
        # Sets "next state" discrete distributions for each current state
        # (B matrix)
        D = [];
        for i in self.A:   # Each row in A gets a distribution
            D.append(DiscreteD(i)) 

        # set initial state by sampling from q
        s = np.random.choice( np.arange(1,self.nStates+1), p=self.q )

        S = np.zeros([1,tmax])
        S[0,0] = s
        # sample from MC
        t = 1
        while t<tmax:
            if s > len(D): # if END-state
                break
            s = D[ int(S[0,t-1]) -1].rand(1)
            S[0,t] = s
            t = t+1
        return S[S != 0]

    def viterbi(self):
        pass
    
    def stationaryProb(self):
        pass
    
    def stateEntropyRate(self):
        pass
    
    def setStationary(self):
        pass

    def logprob(self):
        pass

    def join(self):
        pass

    def initLeftRight(self):
        pass
    
    def initErgodic(self):
        pass

    def forward(self, pX):
    # pX proportional to the state-conditional probability mass or density values for each state and each frame in the observed feature sequence.
        # init

        alfaTemp = np.array( np.multiply( self.q, pX[:,0]) ) # q_j@b_j(x_t) 
    #    print(f"alfaTemp: {alfaTemp}")
        c = np.array( sum(alfaTemp) )
        alfaHat = np.zeros([self.nStates,pX.shape[1]])
        alfaHat[:,0] = alfaTemp/c 

        # forward step
        for t in range(1,len(pX[0])): 
            for j in range(self.nStates):
                alfaHat[j,t] = pX[j,t]*sum(np.multiply( alfaHat[:,t-1], self.A[:,j] ))
            c = np.append( c, sum(alfaHat[:,t]) )
            alfaHat[:,t] = alfaHat[:,t]/c[t] 

        if self.is_finite:
            c = np.append(c, sum( alfaHat[:,-1]*self.A[:,-1]) )

        return [alfaHat, c]

    def finiteDuration(self):
        pass
    
    def backward(self, pX, c):

        """initialization"""

        beta =  np.zeros( [self.nStates, pX.shape[1]] )
        betaHat =  np.zeros( [self.nStates, pX.shape[1]] )
        if self.is_finite:
            beta[:,-1] = self.A[:,-1]
            betaHat[:,-1] = beta[:,-1]/(c[-2]*c[-1])
        else: 
            beta[:,-1] = 1
            betaHat[:,-1] = 1/c[-2]

        """step"""
        for n in range(0, pX.shape[1]-1):
            t = pX.shape[1]-2-n

            for i in range(self.nStates):
                betaHat[i,t] = (1/c[t])*sum( self.A[i,0:self.nStates]*pX[:,t+1]*betaHat[:,t+1] )

        return betaHat

    def adaptStart(self):
        pass

    def adaptSet(self):
        pass

    def adaptAccum(self):
        pass
