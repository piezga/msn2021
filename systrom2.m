%In [6] update bayesiana

k = [20, 40, 55, 90];
gamma = 1/9;
%array per ogni possibile valore di Rt
rt_max = 12;
rt_range = linspace(0,12,rt_max*100+1);

%per ora importo i dati giusti
likelihood_matrix = importdata('likelihood.txt');

figure
plot(rt_range,likelihood_matrix(:,1),rt_range,likelihood_matrix(:,2),rt_range,likelihood_matrix(:,3))
title('No Bayes')

%Bayes: cumprod(A,dim) con dim=2 per moltiplicare sulla stessa riga
nnposteriors = cumprod(likelihood_matrix,2);
posteriors = normalize(nnposteriors,'norm');

figure
plot(rt_range, posteriors(:,1), rt_range, posteriors(:,2), rt_range, posteriors(:,3))
title('Update bayesiana')


%qual � il valore pi� probabile di Rt per ogni giorno?

[likelyprob,index] = max(posteriors);
likelyvalues = rt_range(index);

%confidence interval
%sbagliato

distrib = zeros(1,10^6);
for i = 1:10^6
    num = poissrnd(likelyvalues(1));
    distrib(i) = num;
end
[R, conf] = poissfit(distrib);
