%% MATLAB Code for Analysis of Gamified Parsing Learning

exp_pre = [14,11,12,14,10,15,12,12,14,9,10,14,10,10,15,12,11,15,15,10];
exp_post = [25,24,21,27,23,25,25,21,27,23,24,20,23,21,25,24,23,20,20,22];
exp_ret = [20,24,19,25,21,21,25,24,23,23,24,23,20,21,24,21,25,18,20,22];

ctrl_pre = [10,14,12,8,14,9,11,8,11,13,9,9,11,13,9,9,8,9,12,12];
ctrl_post = [21,18,19,22,21,17,20,15,18,16,22,18,18,16,22,18,16,20,20,20];
ctrl_ret = [18,13,13,15,13,13,17,15,17,18,18,17,17,18,18,18,18,15,12,17];

exp_gain = exp_post - exp_pre;
ctrl_gain = ctrl_post - ctrl_pre;

[h_gain, p_gain] = ttest2(exp_gain, ctrl_gain);
[h_ret, p_ret] = ttest2(exp_ret, ctrl_ret);

n1 = length(exp_ret);
n2 = length(ctrl_ret);
pooled_sd = sqrt(((n1 - 1)*var(exp_ret) + (n2 - 1)*var(ctrl_ret)) / (n1 + n2 - 2));
cohen_d = (mean(exp_ret) - mean(ctrl_ret)) / pooled_sd;

%% Learning Gain Plot
figure;
bar([mean(exp_gain), mean(ctrl_gain)]);
hold on;
errorbar([1, 2], [mean(exp_gain), mean(ctrl_gain)], [std(exp_gain), std(ctrl_gain)], 'k.', 'LineWidth', 1.5);
title(sprintf('Learning Gain (p = %.3f)', p_gain));
ylabel('Gain Score');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;

%% Retention Score Plot
figure;
bar([mean(exp_ret), mean(ctrl_ret)]);
hold on;
errorbar([1, 2], [mean(exp_ret), mean(ctrl_ret)], [std(exp_ret), std(ctrl_ret)], 'k.', 'LineWidth', 1.5);
title(sprintf('Retention Score (p = %.3f, Cohen\\'s d = %.2f)', p_ret, cohen_d));
ylabel('Retention Score');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;
