% Sample Data for 40 participants (20 experimental, 20 control)
exp_pre = randi([8 15], 1, 20);
exp_post = randi([20 27], 1, 20);
exp_ret = randi([18 25], 1, 20);

ctrl_pre = randi([8 15], 1, 20);
ctrl_post = randi([15 22], 1, 20);
ctrl_ret = randi([12 18], 1, 20);

exp_gain = exp_post - exp_pre;
ctrl_gain = ctrl_post - ctrl_pre;

% Engagement time (simulate)
exp_eng = randi([60 120], 1, 20);
ctrl_eng = randi([45 75], 1, 20);

% ====== 1. Learning Gain T-Test ======
[h1, p1] = ttest2(exp_gain, ctrl_gain);
figure;
bar([mean(exp_gain), mean(ctrl_gain)]);
hold on;
errorbar([1 2], [mean(exp_gain), mean(ctrl_gain)], ...
         [std(exp_gain), std(ctrl_gain)], 'k.', 'LineWidth', 1.5);
title(sprintf('Learning Gain Comparison (p = %.3f)', p1));
ylabel('Gain Score');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;

% ====== 2. Retention Score T-Test & Cohen’s d ======
[h2, p2] = ttest2(exp_ret, ctrl_ret);
n1 = length(exp_ret); n2 = length(ctrl_ret);
pooled_sd = sqrt(((n1-1)*var(exp_ret) + (n2-1)*var(ctrl_ret)) / (n1 + n2 - 2));
cohen_d = (mean(exp_ret) - mean(ctrl_ret)) / pooled_sd;

figure;
bar([mean(exp_ret), mean(ctrl_ret)]);
hold on;
errorbar([1 2], [mean(exp_ret), mean(ctrl_ret)], ...
         [std(exp_ret), std(ctrl_ret)], 'k.', 'LineWidth', 1.5);
title(sprintf('Retention Score (p = %.3f), Cohen''s d = %.2f', p2, cohen_d));
ylabel('Retention Score');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;

% ====== 3. Engagement Time (Mean ± SD) ======
figure;
bar([mean(exp_eng), mean(ctrl_eng)]);
hold on;
errorbar([1 2], [mean(exp_eng), mean(ctrl_eng)], ...
         [std(exp_eng), std(ctrl_eng)], 'k.', 'LineWidth', 1.5);
title('Engagement Time Comparison');
ylabel('Time Spent (minutes)');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;
