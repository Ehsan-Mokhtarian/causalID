close all
clear
clc

%% Example 5 in the paper
G =[0 0 1 0 0 0 0 0 0;
    0 0 0 1 0 0 0 0 0;
    0 0 0 0 1 0 0 0 0;
    0 0 0 0 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0;
    0 0 0 1 1 0 0 0 0;
    1 1 0 0 0 0 0 0 0;
    0 1 1 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0];
N = 1:6;
T = [1 2];
S = 5;
C = 6;
L = zeros(9,9,2);
L(3,5,1)=1;
L(2,4,2)=1;
figure
xdata = [1 1 2 2 3 3 1 1.5 2];
ydata = [2 1 2 1 2 1 1.5 1.5 1.5];
plot(digraph(G),'XData',xdata,'YData',ydata);
title('N=\{1,2,3,4,5,6\}, C=\{6\}, T=\{1,2\}, S=\{5\}, L_C(0)=\{(3,5)\}, L_C(1)=\{(2,4)\}');

%% Calling the algorithms
ID1 = ID_classic(N,T,S,G);
ID2 = ID_new(N,T,S,G,L,C);

%% Display the results
fprintf('The causal effect of T={1,2} on S={5} from G is\n')
if ID1
    fprintf('identifiable\n\n');
else
    fprintf('non-identifiable\n\n');
end

fprintf('The causal effect of T={1,2} on S={5} from G and L_C=(L_C(0)={(3,5)}, L_C(1)={(2,4)}) is\n')
if ID2
    fprintf('identifiable\n');
else
    fprintf('non-identifiable\n');
end
