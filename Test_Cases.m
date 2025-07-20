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
title(sprintf('Retention Score (p = %.3f, Cohen''s d = %.2f)', p_ret, cohen_d));
ylabel('Retention Score');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;

%% Engagement Time Comparison (Mean ± SD)

exp_eng = [115, 118, 104, 65, 96, 116, 92, 112, 81, 80, 65, 65, 114, 107, 63, 89, 70, 89, 90, 83];
ctrl_eng = [70, 67, 55, 60, 62, 71, 59, 65, 61, 58, 63, 68, 69, 64, 60, 66, 70, 62, 61, 68]; % simulated

figure;
bar([mean(exp_eng), mean(ctrl_eng)], 'FaceColor', 'flat');
hold on;
errorbar([1 2], [mean(exp_eng), mean(ctrl_eng)], ...
         [std(exp_eng), std(ctrl_eng)], 'k.', 'LineWidth', 1.5);
title('Engagement Time Comparison (Mean ± SD)');
ylabel('Time Spent (minutes)');
xticks([1 2]);
xticklabels({'Experimental', 'Control'});
grid on;

% Add mean ± SD labels
text(1, mean(exp_eng) + 2, sprintf('%.1f ± %.1f', mean(exp_eng), std(exp_eng)), 'HorizontalAlignment', 'center');
text(2, mean(ctrl_eng) + 2, sprintf('%.1f ± %.1f', mean(ctrl_eng), std(ctrl_eng)), 'HorizontalAlignment', 'center');


%% Pre-Test and Post-Test Score Comparison (Mean ± SD)

% Data (same as used before)
exp_pre = [14,11,12,14,10,15,12,12,14,9,10,14,10,10,15,12,11,15,15,10];
exp_post = [25,24,21,27,23,25,25,21,27,23,24,20,23,21,25,24,23,20,20,22];

ctrl_pre = [10,14,12,8,14,9,11,8,11,13,9,9,11,13,9,9,8,9,12,12];
ctrl_post = [21,18,19,22,21,17,20,15,18,16,22,18,18,16,22,18,16,20,20,20];

% Compute means and stds
means = [mean(exp_pre), mean(exp_post); mean(ctrl_pre), mean(ctrl_post)];
stds  = [std(exp_pre), std(exp_post); std(ctrl_pre), std(ctrl_post)];

% Plot
figure;
bar(means, 'grouped');
hold on;

% Error bars
ngroups = size(means, 1);
nbars = size(means, 2);
groupwidth = min(0.8, nbars/(nbars + 1.5));

for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, means(:,i), stds(:,i), 'k.', 'LineWidth', 1.5);
end

% Labels
set(gca, 'XTickLabel', {'Experimental', 'Control'});
legend({'Pre-Test', 'Post-Test'}, 'Location', 'northwest');
ylabel('Score');
title('Pre-Test and Post-Test Score Comparison (Mean ± SD)');
grid on;

% Add mean ± SD text annotations
for i = 1:nbars
    for j = 1:ngroups
        x_val = (j - groupwidth/2 + (2*i-1)*groupwidth / (2*nbars));
        y_val = means(j,i);
        label = sprintf('%.1f ± %.1f', means(j,i), stds(j,i));
        text(x_val, y_val + 1, label, 'HorizontalAlignment', 'center', 'FontSize', 8);
    end
end
