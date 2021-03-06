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
[SPSFf_t,SPSFf_e,SPSFRe,SPSFV,SPSFdp] = SP_Full_SF(D_s,rho,SF,mu);
% disp(SPSFf_t)
% disp(SPSFf_e)
[SPMFf_t,SPMFf_e,SPMFRe,SPMFV,SPMFdp] = SP_Full_MF(D_s,rho,MF_SP,mu);
% disp(SPMFf_t)
% disp(SPMFf_e)
[SPUSFf_t,SPUSFf_e,SPUSFRe,SPUSFV,SPUSFdp] = SP_Up_SF(D_s,rho,SF,mu);
% disp(SPUSFf_t)
% disp(SPUSFf_e)
%disp(SPUSFRe)
[SPUMFf_t,SPUMFf_e,SPUMFRe,SPUMFV,SPUMFdp] = SP_Up_MF(D_s,rho,MF_SP,mu);
% disp(SPUMFf_t)
% disp(SPUMFf_e)
%disp(SPUMFRe)
[SPDSFf_t,SPDSFf_e,SPDSFRe,SPDSFV,SPDSFdp] = SP_Dn_SF(D_s,rho,SF,mu);
% disp(SPDSFf_t)
% disp(SPDSFf_e)
%disp(SPDSFRe)
[SPDMFf_t,SPDMFf_e,SPDMFRe,SPDMFV,SPDMFdp] = SP_Dn_MF(D_s,rho,MF_SP,mu);
% disp(SPDMFf_t)
% disp(SPDMFf_e)
%disp(SPDMFRe)
[LPMFf_t,LPMFf_e,LPMFRe,LPMFV,LPMFdp] = LP_MF(D_l,rho,MF_LP,mu);
% disp(LPMFf_t)
% disp(LPMFf_e)
[LPLFf_t,LPLFf_e,LPLFRe,LPLFV,LPLFdp] = LP_LF(D_l,rho,LF,mu);
% disp(LPLFf_t)
% disp(LPLFf_e)


%%% FIGURE 1 %%%
figure('Visible','on','Name','Figure 1')
smFdp = [SPSFdp,SPMFdp];
smFV = [SPSFV,SPMFV];
smUPdp = [SPUSFdp,SPUMFdp];
smUPV = [SPUSFV,SPUMFV];
smDNdp = [SPDSFdp,SPDMFdp];
smDNV = [SPDSFV,SPDMFV];
lgdp = [LPMFdp,LPLFdp];
lgV = [LPMFV,LPLFV];
plot(smFV,smFdp,'+-',smUPV,smUPdp,'o-',smDNV,smDNdp,'*-',lgV,lgdp,'s-')
legend('Small Pipe Full','Small Pipe Upstream','Small Pipe Downstream','Large Pipe','Location','Northwest')
title('Velocity vs. \DeltaP')
xlabel('Velocity (m/s)')
ylabel('\DeltaP (Pa)')

%%% FIGURE 2 %%%
figure('Visible','on','Name','Figure 2')
% smDNfe = log10([SPDSFf_e,SPDMFf_e]);
% smDNft = log10([SPDSFf_t,SPDMFf_t]);
% smDNRe = log10([SPDSFRe,SPDMFRe]);
% lgfe = log10([LPMFf_e,LPLFf_e]);
% lgft = log10([LPMFf_t,LPLFf_t]);
% lgRe = log10([LPMFRe,LPLFRe]);
smDNfe = [SPDSFf_e,SPDMFf_e];
smDNft = [SPDSFf_t,SPDMFf_t];
smDNRe = [SPDSFRe,SPDMFRe];
lgfe = [LPMFf_e,LPLFf_e];
lgft = [LPMFf_t,LPLFf_t];
lgRe = [LPMFRe,LPLFRe];
loglog(smDNRe,smDNfe,'+-',smDNRe,smDNft,'s:',lgRe,lgfe,'o-',lgRe,lgft,'*:') 
legend('Small Downstream f_e_x_p','Small Downstream f_t_h_e_o_r_y','Large f_e_x_p','Large f_t_h_e_o_r_y',...
'Location','Northeast')
title('Reynolds Number vs. f_e_x_p')
xlabel('log(Re)')
ylabel('log(f_e_x_p)')

%%% FIGURE 3 %%%
figure('Visible','on','Name','Figure 3')
% smDNfe = log10([SPDSFf_e,SPDMFf_e]);
% smDNft = log10([SPDSFf_t,SPDMFf_t]);
% smDNRe = log10([SPDSFRe,SPDMFRe]);
% smUPfe = log10([SPUSFf_e,SPUMFf_e]);
% smUPft = log10([SPUSFf_t,SPUMFf_t]);
% smUPRe = log10([SPUSFRe,SPUMFRe]);
smDNfe = [SPDSFf_e,SPDMFf_e];
smDNft = [SPDSFf_t,SPDMFf_t];
smDNRe = [SPDSFRe,SPDMFRe];
smUPfe = [SPUSFf_e,SPUMFf_e];
smUPft = [SPUSFf_t,SPUMFf_t];
smUPRe = [SPUSFRe,SPUMFRe];
loglog(smDNRe,smDNfe,'+-',smDNRe,smDNft,'s:',smUPRe,smUPfe,'o-',smUPRe,smUPft,'*:')
legend('Small Downstream f_e_x_p','Small Downstream f_t_h_e_o_r_y','Small Upstream f_e_x_p'...
,'Small Upstream f_t_h_e_o_r_y','Location','Northeast')
title('Reynolds Number vs. f_e_x_p')
xlabel('log(Re)')
ylabel('log(f_e_x_p)')




%%% Functions to solve for Friction factor %%%
function [f_t,f_e,Reo,Vo,dpo] = SP_Full_SF(D_s,rho,SF,mu)
SP_Full_SF_high = [43.3,44.1,44.5,44.9,45.6,45.9,48.5,50.9,58.5]; %Flag 1
SP_Full_SF_high2 = 189.2;
SP_Full_SF_low = [43.2,42.5,42.1,41.8,41.2,41.0,38.5,36.2,29.0]; %Flag 1
SP_Full_SF_low2 = 165.7;

A = area(D_s);
L = in_to_m(96);

[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Full_SF_high,SP_Full_SF_low,SF,A,L,rho,D_s,mu,1);

dp1 = delta_P(SP_Full_SF_high2,SP_Full_SF_low2,0);
dpo = [dp,dp1];
Q = flow_convert(SF(end));
V1 = velocity(Q,A);
Vo = [V,V1];
re1 = reynolds(rho,V1,D_s,mu);
Reo = [Re,re1];
fe1 = f_exp(dp1,D_s,L,rho,V1);
ft1 = f_theorey(re1,D_s);
f_t = [f_t,ft1];
f_e = [f_e,fe1];

function [f_t,f_e,Re,V,dp] = SP_Full_MF(D_s,rho,MF_SP,mu)
SP_Full_MF_high = [176.8,179.0,184.4,201.8,229.9];
SP_Full_MF_low = [176.6,175,169.5,155.1,129.5];

A = area(D_s);
L = in_to_m(96);

[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Full_MF_high,SP_Full_MF_low,MF_SP,A,L,rho,D_s,mu,0);

function [f_t,f_e,Re,V,dp] = SP_Up_SF(D_s,rho,SF,mu)
SP_Up_SF_high = [43.3,43.7,44,44.2,44.4,44.5,45.7,46.9,50.9,55.4]; %Flag 1
SP_Up_SF_low = [43.3,43.1,42.9,42.7,42.6,42.4,41.3,40.4,37,33.2]; %Flag

A = area(D_s);
L = in_to_m(48);

f_t = [];
f_e = [];
[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Up_SF_high,SP_Up_SF_low,SF,A,L,rho,D_s,mu,1);

function [f_t,f_e,Re,V,dp] = SP_Up_MF(D_s,rho,MF_SP,mu)
SP_Up_MF_high = [178.8,178,181,190.7,204.5];
SP_Up_MF_low = [176.8,176.4,174.6,169,159.5];

A = area(D_s);
L = in_to_m(48);

[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Up_MF_high,SP_Up_MF_low,MF_SP,A,L,rho,D_s,mu,0);

function [f_t,f_e,Re,V,dp] = SP_Dn_SF(D_s,rho,SF,mu)
SP_Dn_SF_high = [41.6,41.9,42.1,42.3,42.6,42.8,44.2,45.6,49.2,54.5]; %Flag 1
SP_Dn_SF_low = [41.5,41.5,41.2,41,40.5,40.3,39,37.6,34.1,29.1]; %Flag 1

A = area(D_s);
L = in_to_m(48);

[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Dn_SF_high,SP_Dn_SF_low,SF,A,L,rho,D_s,mu,1);

function [f_t,f_e,Re,V,dp] = SP_Dn_MF(D_s,rho,MF_SP,mu)
SP_Dn_MF_high = [176.6,177.9,181.1,189.9,205];
SP_Dn_MF_low = [176.6,175.9,173.3,165.5,152.1];

A = area(D_s);
L = in_to_m(48);

[f_t,f_e,Re,V,dp] = solve_friction_factors(SP_Dn_MF_high,SP_Dn_MF_low,MF_SP,A,L,rho,D_s,mu,0);

function [f_t,f_e,Re,V,dp] = LP_MF(D_l,rho,MF_LP,mu)
LP_MF_high = [42,42.4,42.7,43.3,45.2,47,51.7,57.5]; %Flag 1
LP_MF_low = [41.9,41.6,41.3,10.8,38.9,37.3,32.7,27.1]; %Flag 1

A = area(D_l);
L = in_to_m(96);

[f_t,f_e,Re,V,dp] = solve_friction_factors(LP_MF_high,LP_MF_low,MF_LP,A,L,rho,D_l,mu,1);

function [f_t,f_e,Re,V,dp] = LP_LF(D_l,rho,LF,mu)
LP_LF_high = [176.2,178.4,182.9,188.7,197.8,221.8];
LP_LF_low = [176.4,175.9,171.5,165,157,138.2];

A = area(D_l);
L = in_to_m(96);

[f_t,f_e,Re,V,dp] = solve_friction_factors(LP_LF_high,LP_LF_low,LF,A,L,rho,D_l,mu,0);


%%% Functions used to solve for parameters needed to sove for friction
%%% factor
function [f_t,f_e,reo,Vo,dpo] = solve_friction_factors(high,low,flow,A,L,rho,D,mu,flag)
f_t = [];
f_e = [];
reo = [];
Vo = [];
dpo = [];
for i = 2:length(high)
    dp = delta_P(high(i),low(i),flag);
    dpo = [dpo,dp];
    Q = flow_convert(flow(i-1));
    V = velocity(Q,A);
    Vo = [Vo,V];
    re = reynolds(rho,V,D,mu);
    reo = [reo,re];
    fe = f_exp(dp,D,L,rho,V);
    ft = f_theorey(re,D);
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
    deltH = (((h1-h10) - (h2-h20)) * 10)/2;
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

function out = f_theorey(re,D)
if re > 2000
    E = .0015;
    denom = -1.8 * log10(6.9/re); %((E/D)/3.7)^1.11 + 
    out = (1/denom)^2;
else
    out = 64/re;
end

function out = f_exp(delt,D,L,rho,V)
out = (2* delt * D) / (L * rho * V^2);

