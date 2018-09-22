function Fluids_Lab_Calculations
%%% Constants %%%
rho = 997;
mu = 8.9*10^-4;

%%% Pipe Diameters %%%
D_s = in_to_m(.344);
D_l = in_to_m(.605);

%%% Flow Vectors %%%
SF = [.085,.128,.162,.196,.228,.298,.371,.523,.698];
MF_SP = [.26,.54,1.0,1.5];
MF_LP = [.26,.54,.75,1.0,1.26,1.77,2.31];
LF = [1.06,1.93,3.01,4.08,5.98];

%%% Function Calls %%%%
[SPSFf_t,SPSFf_e] = SP_Full_SF(D_s,rho,SF,mu);

[SPMFf_t,SPMFf_e] = SP_Full_MF(D_s,rho,MF_SP,mu);

function [f_t,f_e] = SP_Full_SF(D_s,rho,SF,mu)
SP_Full_SF_high = [43.3,44.1,44.5,44.9,45.6,45.9,48.5,50.9,58.5]; %Flag 1
SP_Full_SF_high2 = 189.2;
SP_Full_SF_low = [43.2,42.5,42.1,41.8,41.2,41.0,38.5,36.2,29.0]; %Flag 1
SP_Full_SF_low2 = 165.7;

A = area(D_s);
L = in_to_m(96);

[f_t,f_e] = solve_friction_factors(SP_Full_SF_high,SP_Full_SF_low,SF,A,L,rho,D_s,mu);

dp = delta_P(SP_Full_SF_high2,SP_Full_SF_low2,0);
Q = flow_convert(SF(end));
V = velocity(Q,A);
re = reynolds(rho,V,D_s,mu);
fe = f_exp(dp,D_s,L,rho,V);
ft = f_theorey(re);
f_t = [f_t,ft];
f_e = [f_e,fe];

function [f_t,f_e] = SP_Full_MF(D_s,rho,MF_SP,mu)
SP_Full_MF_high = [176.8,179.0,184.4,201.8,229.9];
SP_Full_MF_low = [176.6,175,169.5,155.1,129.5];

A = area(D_s);
L = in_to_m(96);

[f_t,f_e] = solve_friction_factors(high,low,flow,A,L,rho,D,mu)

function [f_t,f_e] = SP_Up_SF(D_s,rho,SF,mu)
SP_Up_SF_high = [43.3,43.7,44,44.2,44.4,44.5,45.7,46.9,50.9,55.4]; %Flag 1
SP_Up_SF_low = [43.3,43.1,42.9,42.7,42.6,42.4,41.3,40.4,37,33.2]; %Flag

A = area(D_s);
L = in_to_m(48);

f_t = [];
f_e = [];
for i = 2:length(SP_Up_SF_high)
    dp = delta_P(SP_Up_SF_high(i),SP_Up_SF_low(i),1);
    Q = flow_convert(SF(i-1));
    V = velocity(Q,A);
    re = reynolds(rho,V,D_s,mu);
    fe = f_exp(dp,D_s,L,rho,V);
    ft = f_theorey(re);
    f_t = [f_t,ft];
    f_e = [f_e,fe];
end

function [f_t,f_e] = SP_Up_MF(D_s,rho,MF_SP,mu)
SP_Up_MF_high = [178.8,178,181,190.7,204.5];
SP_Up_MF_low = [176.8,176.4,174.6,169,159.5];

A = area(D_s);
L = in_to_m(48);

[f_t,f_e] = solve_friction_factors(SP_Up_MF_high,SP_Up_MF_low,MF_SP,A,L,rho,D_s,mu);

function [f_t,f_e] = SP_Dn_SF(D_s,rho,SF,mu)
SP_Dn_SF_high = [41.6,41.9,42.1,42.3,42.6,42.8,44.2,45.6,49.2,54.5]; %Flag 1
SP_Dn_SF_low = [41.5,41.5,41.2,41,40.5,40.3,39,37.6,34.1,29.1]; %Flag 1

function [f_t,f_e] = SP_Dn_MF(D_s,rho,MF_SP,mu)
SP_Dn_MF_high = [176.6,177.9,181.1,189.9,205];
SP_Dn_MF_low = [176.6,175.9,173.3,165.5,152.1];

function [f_t,f_e] = LP_MF(D_s,rho,MF_LP,mu)
LP_MF_high = [42,42.4,42.7,43.3,45.2,47,51.7,57.5]; %Flag 1
LP_MF_low = [41.9,41.6,41.3,10.8,38.9,37.3,32.7,27.1]; %Flag 1

function [f_t,f_e] = LP_LF(D_s,rho,LF,mu)
LP_LF_high = [176.2,178.4,182.9,188.7,197.8,221.8];
LP_LF_low = [176.4,175.9,171.5,165,157,138.2];


function [f_t,f_e] = solve_friction_factors(high,low,flow,A,L,rho,D,mu)
f_t = [];
f_e = [];
for i = 2:length(high)
    dp = delta_P(high(i),low(i),1);
    Q = flow_convert(flow(i-1));
    V = velocity(Q,A);
    re = reynolds(rho,V,D,mu);
    fe = f_exp(dp,D,L,rho,V);
    ft = f_theorey(re);
    f_t = [f_t,ft];
    f_e = [f_e,fe];
end

function out = in_to_m(in)
out = in * .0254;

function out = flow_convert(flow)
out = (flow * .00378541) / 60;

function out = area(D)
out = pi * (D^2/4);

function out = delta_P(h1,h2,flag)
if flag == 1
    h10 = 43.3;
    h20 = 43.2;
    deltH = ((h1-h10) - (h2-h20)) * 10;
else
    h10 = 176.8;
    h20 = 176.6;
    deltH = ((h1-h10) - (h2-h20)) * 10;
end
out = deltH * 9.8;

function out = velocity(Q,A)
out = Q/A;

function out = reynolds(rho,V,D,mu)
out = (rho * V * D) / mu;

function out = f_theorey(re)
out = 64/re;

function out = f_exp(delt,D,L,rho,V)
out = (2* delt * D) / (L * rho * V^2);

