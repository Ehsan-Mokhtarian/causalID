function ID = ID_new(N,T,S,G,L,C)
% ID_new(N,T,S,G,L,C) determines whether the causal effect of T on S is
% identifiable from DAG G with observed variables N and label set L with
% the set of control variables C

GG = G;
GG(C,:) = 0;
c = size(L,3);
for i=1:c
    if ~ID_classic(N,T,S,GG-L(:,:,i))
        ID = false;
        return
    end
end
ID = true;
end
