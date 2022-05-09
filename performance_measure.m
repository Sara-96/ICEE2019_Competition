function [acc, icc]=performance_measure(true_target,classification_output)

%%% Perform varous mesaure for output of classification and regression methods.
% inputs:
%     - true_target: Label of samples
%     - classification_output: classification output on samples


% outputs:
%     - acc: Accuracy measure
%     - icc: Indepe measure





%%%%%% ICC measure
icc=round((10000*ICC(3,'single', [true_target classification_output])))/100;

%%%%%% Accuracy measure
acc=sum(true_target==classification_output)/length(true_target);



%%%%%% Show Curve
if flag==1
    figure
    plot(X,Y,'--')
    xlabel('False Positive Rate')
    ylabel('True Positive Rate')
end


end