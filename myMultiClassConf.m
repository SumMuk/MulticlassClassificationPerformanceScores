function [TPR, TNR, TP, FP, FN, TN,F1_score,MCC,PRECISION, Overall_Result] = myMultiClassConf(cm_mat,num_labels) 
 

for i = 1:num_labels
    TP(i) = cm_mat(i,i);
    FP(i) = sum(cm_mat(:, i), 1) - TP(i);
    FN(i) = sum(cm_mat(i, :), 2) - TP(i);
    TN(i) = sum(cm_mat(:)) - TP(i) - FP(i) - FN(i);

    Accuracy(i) = (TP(i)+TN(i))./(TP(i)+FP(i)+TN(i)+FN(i));

    TPR(i) = TP(i)./(TP(i) + FN(i));%tp/actual positive  RECALL SENSITIVITY
    if isnan(TPR(i))
        TPR(i) = 0;
    end
    PRECISION(i) = TP(i)./ (TP(i) + FP(i)); % tp / PRECISION
    if isnan(PRECISION(i))
        PRECISION(i) = 0;
    end
    TNR(i) = TN(i)./ (TN(i)+FP(i)); %tn/ actual negative  SPECIFICITY
    if isnan(TNR(i))
        TNR(i) = 0;
    end
    FPR(i) = FP(i)./ (TN(i)+FP(i));
    if isnan(FPR(i))
        FPR(i) = 0;
    end
    F1_score(i) = (2*(PRECISION(i) * TPR(i))) / (PRECISION(i)+TPR(i));
    P(i)=TP(i)+FN(i);
            N(i)=FP(i)+TN(i);
    MCC(i)= (TP(i) .* TN(i) - FP(i) .* FN(i)) ./  sqrt( (TP(i) + FP(i)) .* (TP(i) + FN(i)) .* (TN(i) + FP(i)) .* (TN(i) + FN(i)) );
        %    MCC=max(MCC);
    if isnan(F1_score(i))
        F1_score(i) = 0;
    end
end
%overall result
            Overall_Result.Sensitivity=mean(TPR);
            Overall_Result.Specificity=mean(TNR);
            Overall_Result.Precision=mean(PRECISION);
            Overall_Result.FalsePositiveRate=mean(FPR);
            Overall_Result.F1_score=mean(F1_score);
            Overall_Result.MatthewsCorrelationCoefficient=mean(MCC);
             
