# Causal Effect Identification
# Paper: Causal Effect Identification with Context-specific Independence Relations of Control Variables
ID_classic.m: Function  ID_classic(N,T,S,G) determines whether the causal effect of T on S is identifiable from DAG G with observed variables N. <br>
ID_new.m: Function ID_new(N,T,S,G,L,C) determines whether the causal effect of T on S is identifiable from DAG G with observed variables N and label set L with the set of control variables C. <br>
example.m: This file corresponds to the Example 5 of the paper. We show how to call the algorithms in this file. 
