function [y1] = lqr_neural_network(x1)
%LQR_NEURAL_NETWORK neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 19-Dec-2017 13:50:07.
% 
% [y1] = lqr_neural_network(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 4xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [1.00049610702943;1.00018071267494;3.48002970707029e-06;2.09891099479664e-05];
x1_step1.gain = [0.0202022858469001;0.0202020965979439;2.00003310780415;2.00010647279421];
x1_step1.ymin = -1;

% Layer 1
b1 = [-0.71424754345053498;-1.1956797271098849;-0.20403219718249643;-0.78805313520856068];
IW1_1 = [0.56284339031032615 0.39651285858497209 0.044914057583391433 -0.00021676263035112154;0.70563885436972029 0.16659090397445395 -0.77531830651734535 -0.00077668551700368741;0.052676703704342402 0.4314973566595966 -0.076026918485989359 0.00011322500398246001;-0.53876059691897416 -0.38868981027520505 -0.034660296727132778 -0.00021872462985435335];

% Layer 2
b2 = [0.94164294471939625;0.08382586217944836;-0.86559006719122544;-0.65750276019580967];
LW2_1 = [-1.5616920644545111 1.0474822804457531 0.91976401978975764 0.87591075525617512;-0.75004145563383262 0.075393887472550644 -0.27062389878237975 0.80268136503152876;-1.0330267158783175 0.047022786518991291 -0.31315392574241141 0.028028200518746958;0.19740412426587106 -0.58978334076395345 -0.04357657390377212 -0.13007106480869401];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.00205262113141574;0.000484915555006233;0.0345095407008588;6215428.47365926];
y1_step1.xoffset = [-974.702579396933;-4200.91916740632;-68.2144611483333;-10.0000001031759];

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
