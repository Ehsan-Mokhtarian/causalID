function ID = ID_classic(N,T,S,G)
% ID_classic(N,T,S,G) determines whether the causal effect of T on S is
% identifiable from DAG G with observed variables N

G_NT = G_M(G,mysetdiff(N,T),N);
D = myintersect(N, find(Anc(S, G_NT)));
ID = ID_Q(D,N,G);
end

% Main functions
function ID = ID_Q(D,N,G)
C_N = c_components(N,N,G);
C_D = c_components(D,N,G);
k = size(C_D,1);
for i=1:k
    C = C_D(i,:);
    x = find(C,1);
    T = C_N(C_N(:,x)==1,:);
    C = find(C);
    T = find(T);
    if ~ID_Q2(C,T,N,G)
        ID = false;
        return
    end
end
ID = true;
end

function ID = ID_Q2(C,T,N,G)
c = length(C);
t = length(T);
G_T = G_M(G,T,N);
A = myintersect(T, find(Anc(C, G_T)));
a = length(A);
if a==c
    ID = true;
    return
end
if a==t
    ID = false;
    return
end
C_A = c_components(A,N,G);
x = C(1);
TT = find(C_A(C_A(:,x)==1,:));
ID = ID_Q2(C,TT,N,G);
end

% Minor functions
function H = c_components(S,N,G)
GG = G;
GG(N,:) = 0;
SS = find(Anc(S,GG)); % SS = DUP_S \cup S
DUP = mysetdiff(SS,S);
GS = GG([S DUP],[S DUP]);
C = conncomp(digraph(GS),'Type','weak');
s = length(S);
C_S = C(1:s);
k = max(C_S);
n = size(G,1);
H = zeros(k,n);
for i=1:k
    H(i,S(C_S==i)) = 1;
end
end

function GM = G_M(G,M,N)
NM = mysetdiff(N,M);
GG = G;
GG(NM,:) = 0;
MM = Anc(M,GG);
GM = G.*MM.*MM';
end

function B = Anc(S,G)
n = size(G,1);
A = ((G+eye(n))^(n-1))>0;
B = (sum(A(:,S),2)>0)';
end

function C = myintersect(A,B)
A = A(:)'; B = B(:)';

if isempty(A)
    ma = 0;
else
    ma = max(A);
end

if isempty(B)
    mb = 0;
else
    mb = max(B);
end

if ma==0 || mb==0
    C = [];
else
    bits = zeros(1, max(ma,mb));
    bits(A) = 1;
    C = B(logical(bits(B)));
end
end

function C = mysetdiff(A,B)

if isempty(A)
    C = [];
    return;
elseif isempty(B)
    C = A;
    return;
else
    bits = zeros(1, max(max(A), max(B)));
    bits(A) = 1;
    bits(B) = 0;
    C = A(logical(bits(A)));
end

end