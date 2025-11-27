mu = [0; 0];
Sigma = [1, 0.5; 0.5, 2];
rng(1);  % 设置随机种子以确保结果可重复性
X = mvnrnd(mu, Sigma, 1000);
% 提取 X 的第一个维度，即 X1
X1 = X(:, 1);
X2 = X(:, 2);
% 创建一个新的 figure
figure;
% 绘制原始分布
subplot(2, 1, 1);
scatter(X1, X2, 'b.');
title('原始多元高斯分布');
xlabel('X');
ylabel('Y');

% 绘制 X1 的边缘高斯分布的直方图
subplot(2, 2, 3);
histogram(X1, 'Normalization', 'pdf', 'EdgeColor', 'w');
title('边缘高斯分布示例 - X1');
xlabel('X1');
ylabel('概率密度');

% 计算边缘高斯分布的理论概率密度函数
mu_X1 = mu(1);
sigma_X1 = sqrt(Sigma(1, 1));
x_range = linspace(min(X1), max(X1), 100);
pdf_X1 = normpdf(x_range, mu_X1, sigma_X1);

% 绘制理论概率密度函数
hold on;
plot(x_range, pdf_X1, 'r', 'LineWidth', 2);
legend('样本直方图', '理论概率密度函数');

% 标出均值和标准差
text(mu_X1, 0.1, sprintf('均值: %.2f', mu_X1), 'Color', 'r', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center');
text(mu_X1 - sigma_X1, 0.15, sprintf('标准差: %.2f', sigma_X1), 'Color', 'g', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
hold off;

% 在 Y=1 的条件下提取 X1 的样本
Y_condition = X(:, 2) <= 1;
X1_conditioned = X(Y_condition, 1);

% 绘制在 Y=1 条件下 X1 的直方图
subplot(2, 2, 4);
histogram(X1_conditioned, 'Normalization', 'pdf', 'EdgeColor', 'w');
title('条件高斯分布示例 - 在 Y<=1 条件下 X1');
xlabel('X1');
ylabel('概率密度');

% 计算条件高斯分布的理论概率密度函数
mu_X1_conditioned = mean(X1_conditioned);
sigma_X1_conditioned = std(X1_conditioned);
pdf_X1_conditioned = normpdf(x_range, mu_X1_conditioned, sigma_X1_conditioned);

% 绘制理论概率密度函数
hold on;
plot(x_range, pdf_X1_conditioned, 'r', 'LineWidth', 2);
legend('样本直方图', '理论概率密度函数');

% 标出均值和标准差
text(mu_X1_conditioned, 0.15, sprintf('均值: %.2f', mu_X1_conditioned), 'Color', 'r', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
text(mu_X1_conditioned - sigma_X1_conditioned, 0.2, sprintf('标准差: %.2f', sigma_X1_conditioned), 'Color', 'g', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
hold off;