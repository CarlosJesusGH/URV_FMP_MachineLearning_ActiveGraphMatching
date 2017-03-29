function [m, n] = CJ_lsilda(Data, Class)
clear;

%test of ILDA
load('reduced_ORL_3parts.mat');
chunksize = 5;
n = size(X_org,2);
[T, Tinv, m, r, W, Y, lab, nc] = initLS_ILDA2(X_org, lab_org);
[d, b] = size(X_inc);
X = X_org; lab = lab_org;
nupdate = ceil(b/chunksize);
times = zeros(nupdate, 1);
precs = zeros(nupdate, 1);
i_ch = 1;
for i = 1:b
    x = X_inc(:, i); p = lab_inc(i);    
    tic
    u = (x - m)/(n+1);
    n = n+1;
    m = m+ u;
    if r < d
        [Tinv, W, Y, lab, nc, T, r] = LS_ILDA2(Tinv, W, Y, lab, nc, u, p, T, r);
    else
        [Tinv, W, Y, lab, nc] = LS_ILDA2(Tinv, W, Y, lab, nc, u, p);
    end
    times(i_ch) = times(i_ch) + toc; 
    if(mod(i, chunksize) == 0)
        X = [W'*X_org, W'*X_inc(:, 1:i)];
        precs(i_ch) = KNN(X, lab,  W'*X_tst, lab_tst);
        i_ch = i_ch + 1;
    end
end
X = [W'*X_org, W'*X_inc];
lab = [lab_org; lab_inc];
if(mod(i, chunksize) ~= 0)
    precs(i_ch) = KNN(X, lab,  W'*X_tst, lab_tst);
end

time_spent_in_each_round = times'
precision_in_each_round = precs'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('data_50_first_letterlow')
%test of ILDA
chunksize = 5;

% load('ORL_3parts.mat')
lim_orig = 100;
Data_T = Data.';
Class(Class<0) = Class(Class<0) + 3; %changing to positive values the negative ones
X_org = Data_T(:,1:lim_orig);
lab_org = Class(1:lim_orig);
X_inc = Data_T(:,lim_orig:end);
lab_inc = Class(lim_orig:end);



n = size(X_org,2);
[d, b] = size(X_inc);

[X, Xinv, m, W, Y, lab, nc] = initLS_ILDA1(X_org, lab_org);

times = zeros(ceil(b/chunksize), 1);
precs = zeros(ceil(b/chunksize), 1);
i_ch = 1;
for i = 1:b
    x = X_inc(:, i); p = lab_inc(i);    
    tic
    u = (x - m)/(n+1);
    n = n+1;
    m = m+ u;
    if n >= d
        error('the number of instances must be smaller than their dimension, or use LS_ILDA2');
    end
    [X, Xinv, W, Y, lab, nc] = LS_ILDA1(X, Xinv, W, Y, lab, nc, u, p);
     times(i_ch) = times(i_ch) + toc;
%     if(mod(i, chunksize) == 0)
%         precs(i_ch) = KNN(W'*X, lab,  W'*(X_tst - repmat(m, 1, size(X_tst,2))), lab_tst);
%         i_ch = i_ch + 1;
%     end
end
% if(mod(i, chunksize) ~= 0)
%     precs(i_ch) = KNN(W'*X, lab,  W'*(X_tst - repmat(m, 1, size(X_tst,2))), lab_tst);
% end
time_spent_in_each_round = times'
precision_in_each_round = precs'

end



%% never used (commented from original code)
%    x = X_inc(:, i); p = lab_inc(i);
%    X_org = [X_org, x];
%    X = X_org - repmat(sum(X_org, 2)/(n+i),1, n+i);
%    p = lab_inc(i);
%    np = sum(Y(:,p) > 0);
%    y =  [(1/sqrt(np + 1) - 1/sqrt(np))*(Y(:, p) > 0); 1/sqrt(np + 1)];
%    Y = [Y;  zeros(1, 40)];
%    Y(:, p) = Y(:,p) + y;
%    W = pinv(X)'*Y;   