function [k] = GSR_FEATURES3(input_segment)
sig_prime=log(abs(input_segment)) - log(abs(circshift(input_segment',1)))' ;
sig_prime=sig_prime(:,2:end);
sig_prime_normalized=(sig_prime-mean(sig_prime,2))./std(sig_prime')' ;

%ar model
n_arma=10;
m_degree_zero=ar(input_segment,n_arma);
q =m_degree_zero.Report.Parameters.ParVector;
k([1,2,3,4,5,6,7]) = q([2,3,4,6,5,7,10]);

m_degree_one=ar(sig_prime_normalized,n_arma);
q=m_degree_one.Report.Parameters.ParVector;
k([8,9,10,11,12])=q([1,3,4,6,10]);

%%%kurtosis
k(13)=kurtosis(input_segment);

%%%sum of derivatives
k(14)=sum(sig_prime_normalized,2);


end

