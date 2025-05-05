clc;
clear;
close;
%%                  Initial values
m1 = 1.1;
m2 = 0.87;
m3 = 0.56;
m4 = 0.77;
%%%
L1 = 0.95;
L2 = 1.1;
L3 = 0.49;
L4 = 0.88;
%%%
I1 = 0.12;
I2 = 0.17;
I3 = 0.15;
I4 = 0.19;
%%%
g=9.81;
%%                  Parameters
Lc1 = L1/2;
Lc2 = L2/2;
Lc3 = L3/2;
Lc4 = L4/2;
%%%
I1234 = I1+I2+I3+I4;
I234 = I2+I3+I4;
I34 = I3+I4;
%%%
L12 = L1+L2;
L123 = L1+L2+L3;
L1234 = L1+L2+L3+L4;
L23 = L2+L3;
L234=L2+L3+L4;
L34=L3+L4;
%%%
m234=m2+m3+m4;
m34=m3+m4;
%%%
theta1 = m2*L1*Lc2+m3*L1*L2+m4*L1*L2;
theta2 = m4*L1*L3+m3*L1*Lc3;
theta3 = m4*L1*Lc4;
theta4 = m3*L2*Lc3+m4*L2*L3;
theta5 = m4*L2*Lc4;
theta6 = m4*L3*Lc4;
theta7 = (m1*Lc1^2)+(m2*L12^2)+(m3*L123^2)+(m4*L1234^2)+I1234;
theta8 = (m2*Lc2^2)+(m3*L23^2)+(m4*L234^2)+I234;
theta9 = (m3*Lc3^2)+(m4*L34^2)+I34;
theta10 = (m4*Lc4^2)+I4;
theta11 = m1*Lc1+m234*L1;
theta12 = m2*Lc2+m34*L2;
theta13 = m3*Lc3+m4*L3;
theta14 = m4*Lc4;
%%%
Theta = [theta1; theta2; theta3; theta4; theta5; theta6; theta7; ...
    theta8; theta9; theta10; theta11; theta12; theta13; theta14];
%%                  syms initial values
q1 = pi\6;
q2 = pi\6;
q3 = pi\6;
q4 = pi\6;
%%%
dq1 = 0;
dq2 = 0;
dq3 = 0;
dq4 = 0;
%%                  Controller related
Gamma = eye(14);
K_P_c = 200;
K_D_c = 10;
Lambda_c = K_P_c/K_D_c;
K_P = K_P_c*eye(4);
K_D = K_D_c*eye(4);
Lambda = Lambda_c*eye(4);
%%
sampling_time = 0.01;
final_time = 5;
q_plot = zeros(4,round(final_time/sampling_time)+1);
qdesired_plot = zeros(4,round(final_time/sampling_time)+1);
Theta_hat = 0.9*Theta;
for t = 0:sampling_time:final_time
    %%%
    c1 = cos(q1);
    c12 = cos(q1+q2);
    c123 = cos(q1+q2+q3);
    c1234 = cos(q1+q2+q3+q4);
    c2 = cos(q2);
    c23 = cos(q2+q3);
    c234 = cos(q2+q3+q4);
    c3 = cos(q3);
    c34 = cos(q3+q4);
    c4 = cos(q4);
    %%%
    s2 = sin(q2);
    s23 = sin(q2+q3);
    s234 = sin(q2+q3+q4);
    s3 = sin(q3);
    s34 = sin(q3+q4);
    s4 = sin(q4);
    %%%
    dq12 = dq1+dq2;
    dq123 = dq1+dq2+dq3;
    dq1234 = dq1+dq2+dq3+dq4;
    dq23 = dq2+dq3;
    dq234 = dq2+dq3+dq4;
    dq34 = dq3+dq4;
    dq1_2 = dq1-dq2;
    %%                 Matrix M
    M11 = 2*c2*theta1+2*c23*theta2+2*c234*theta3+2*c3*theta4+ ...
        2*c34*theta5+2*c4*theta6+theta7;
    M21 = c2*theta1+c23*theta2+c234*theta3+2*c3*theta4+...
        2*c34*theta5+2*c4*theta6+theta8;
    M31 = c23*theta2+c234*theta3+c3*theta4+c34*theta5+2*c4*theta6+theta9;
    M41 = c234*theta3+c34*theta5+c4*theta6+theta10;
    M12 = M21;
    M22 = 2*c3*theta4+2*c34*theta5+2*c4*theta6+theta8;
    M32 = c3*theta4+c34*theta5+2*c4*theta6+theta9;
    M42 = c34*theta5+c4*theta6+theta10;
    M13 = M31;
    M23 = M32;
    M33 = 2*c4*theta6+theta9;
    M43 = c4*theta6+theta10;
    M14 = M41;
    M24 = M42;
    M34 = M43;
    M44 = theta10;
    %%%
    M = [M11 M12 M13 M14; M21 M22 M23 M24; M31 M32 M33 M34; M41 M42 M43 M44];
    %%                  Matrix C
    C11 = -dq2*s2*theta1-dq23*s23*theta2-dq234*s234*theta3- ...
        dq3*s3*theta4-dq34*s34*theta5-dq4*s4*theta6;
    C12 = -dq12*s2*theta1-dq123*s23*theta2-dq1234*s234*theta3- ...
        dq3*s3*theta4-dq34*s34*theta5-dq4*s4*theta6;
    C13 = dq123*s23*theta2-dq1234*s234*theta3-dq123*s3*theta4- ...
        dq1234*s34*theta5-dq4*s4*theta6;
    C14 = -dq1234*s234*theta3-dq1234*s34*theta5-dq1234*s4*theta6;
    C21 = dq1*s2*theta1+dq1*s23*theta2+dq1*s234*theta3-dq3*s3*theta4- ...
        dq34*s34*theta5-dq4*s4*theta6;
    C22 = -dq3*s3*theta4-dq34*s34*theta5-dq4*s4*theta6;
    C23 = -dq123*s3*theta4-dq1234*s34*theta5-dq4*s4*theta6;
    C24 = -dq1234*s34*theta5-dq1234*s4*theta6;
    C31 = -dq1*s23*theta2-dq1*s234*theta3-dq1_2*s3*theta4- ...
        dq1_2*s34*theta5-dq4*s4*theta6;
    C32 = dq12*s3*theta4+dq12*s34*theta5-dq4*s4*theta6;
    C33 = -dq4*s4*theta6;
    C34 = -dq1234*s4*theta6;
    C41 = dq1*s234*theta3+dq12*s34*theta5+dq123*s4*theta6;
    C42 = dq12*s34*theta5+dq123*s4*theta6;
    C43 = dq123*s4*theta6;
    C44 = 0;
    %%%
    C = [C11 C12 C13 C14; C21 C22 C23 C24; C31 C32 C33 C34; C41 C42 C43 C44];
    %%                  Gravitational vector
    g11 = g*c1*theta11+g*c12*theta12+g*c123*theta13+g*c1234*theta14;
    g21 = g*c12*theta12+g*c123*theta13+g*c1234*theta14;
    g31 = g*c123*theta13+g*c1234*theta14;
    g41 = g*c1234*theta14;
    %%%
    G = [g11; g21; g31; g41];
    %%                  Desired
    q1desired = 0.1*cos(0.05*t)+0.55;
    q2desired = 0.1*cos(0.1*t)+0.85;
    q3desired = 0.1*cos(0.15*t)+0.75;
    q4desired = 0.01*cos(0.5*t)+1;
    qdesired = [q1desired; q2desired; q3desired; q4desired];
    %%%
    dq1desired = -0.0050*sin(0.0500*t);
    dq2desired = -0.0100*sin(0.1000*t);
    dq3desired = -0.0150*sin(0.1500*t);
    dq4desired = -0.0050*sin(0.5000*t);
    dqdesired = [dq1desired; dq2desired; dq3desired; dq4desired];
    %%%
    ddq1desired = -2.5000e-04*cos(0.0500*t);
    ddq2desired = -0.0010*cos(0.1000*t);
    ddq3desired = -0.0022*cos(0.1500*t);
    ddq4desired = -0.0025*cos(0.5000*t);
    ddqdesired = [ddq1desired; ddq2desired; ddq3desired; ddq4desired];   
    %%                  Joints
    q =[q1; q2; q3; q4];
    dq = [dq1; dq2; dq3; dq4];
    %%                  Error
    error = qdesired-q;
    derror = dqdesired-dq;
    %%%
    alpha = ddqdesired+Lambda*derror;
    beta = dqdesired+Lambda*error;
    %%%
    alpha1 = alpha(1);
    alpha2 = alpha(2);
    alpha3 = alpha(3);
    alpha4 = alpha(4);
    %%%
    beta1 = beta(1);
    beta2 = beta(2);
    beta3 = beta(3);
    beta4 = beta(4);
    %%%
    alpha12 = alpha1+alpha2;
    alpha123 = alpha1+alpha2+alpha3;
    alpha1234 = alpha1+alpha2+alpha3+alpha4;
    alpha23 = alpha2+alpha3;
    alpha234 = alpha2+alpha3+alpha4;
    alpha34 = alpha3+alpha4;
    %%%
    beta12 = beta1+beta2;
    beta123 = beta1+beta2+beta3;
    beta234 = beta2+beta3+beta4;
    beta34 = beta3+beta4;
    %%                  Regressor matix
    Y11 =(2*alpha1+alpha2)*c2-(beta1*dq2+beta2*dq12)*s2 ;
    Y12 = (2*alpha1+alpha23)*c23-(beta1*dq23+(beta2-beta3)*dq123)*s23;
    Y13 = (2*alpha1+alpha234)*c234-(beta1*dq234+beta234*dq1234)*s234;
    Y14 = (2*alpha12+alpha3)*c3-(beta12*dq3+beta3*dq123)*s3;
    Y15 = (2*alpha12+alpha34)*c34-(beta12*dq34+beta34*dq1234)*s34;
    Y16 = (2*alpha123+alpha4)*c4-(beta123*dq4+beta4*dq1234)*s4;
    Y17 = alpha1;
    Y18 = alpha2;
    Y19 = alpha3;
    Y110 = alpha4;
    Y111 = g*c1;
    Y112 = g*c12;
    Y113 = g*c123;
    Y114 = g*c1234;
    %%%
    Y21 = (alpha1)*c2+(beta1*dq1)*s2;
    Y22 = (alpha1)*c23+(beta1*dq1)*s23;
    Y23 = (alpha1)*c234+(beta1*dq1)*s234;
    Y24 = (2*alpha12+alpha3)*c3-(beta12*dq3+beta3*dq123)*s3;
    Y25 = (2*alpha12+alpha34)*c34-(beta12*dq34+beta34*dq1234)*s34;
    Y26 = (2*alpha123+alpha4)*c4-(beta123*dq4+beta4*dq1234)*s4;
    Y27 = 0;
    Y28 = alpha12;
    Y29 = alpha3;
    Y210 = alpha4;
    Y211 = 0;
    Y212 = g*c12;
    Y213 = g*c123;
    Y214 = g*c1234;
    %%%
    Y31 = 0;
    Y32 = (alpha1)*c23-(beta1*dq1)*s23;
    Y33 = (alpha1)*c234-(beta1*dq1)*s234;
    Y34 = (alpha12)*c3-(beta1*(dq1-dq2)-beta2*(dq12))*s3;
    Y35 = (alpha12)*c34-(beta1*(dq1-dq2)-beta2*(dq12))*s34;
    Y36 = (2*alpha123+alpha4)*c4-(beta123*dq4+beta4*dq1234)*s4;
    Y37 = 0;
    Y38 = 0;
    Y39 = alpha123;
    Y310 = alpha4;
    Y311 = 0;
    Y312 = 0;
    Y313 = g*c123;
    Y314 = g*c1234;
    %%%
    Y41 = 0;
    Y42 = 0;
    Y43 = (alpha1)*c234+(beta1*dq1)*s234;
    Y44 = 0;
    Y45 = (alpha12)*c34+(beta12*dq12)*s34;
    Y46 = (alpha123)*c4+(beta123*dq123)*s4;
    Y47 = 0;
    Y48 = 0;
    Y49 = 0;
    Y410 = alpha1234;
    Y411 = 0;
    Y412 = 0;
    Y413 = 0;
    Y414 = g*c1234;
    %%
    Y = [Y11 Y12 Y13 Y14 Y15 Y16 Y17 Y18 Y19 Y110 Y11 Y112 Y113 Y114;
        Y21 Y22 Y23 Y24 Y25 Y26 Y27 Y28 Y29 Y210 Y211 Y212 Y213 Y214;
        Y31 Y32 Y33 Y34 Y35 Y36 Y37 Y38 Y39 Y310 Y311 Y312 Y313 Y314;
        Y41 Y42 Y43 Y44 Y45 Y46 Y47 Y48 Y49 Y410 Y411 Y412 Y413 Y414];
    %%%
    s = beta-dq;
    temp_ctrl = Gamma*Y'*s;
    Theta_hat = Theta_hat+temp_ctrl*sampling_time;
    ctrl = Y*Theta_hat+K_P*error+K_D*derror;
    %%%                 state update
    ddq = M\(ctrl-G-C*dq);
    dq = dq+(ddq)*sampling_time;
    q = q+dq*sampling_time+0.5*ddq*(sampling_time^2);
    %%%
    k=(t+sampling_time)/sampling_time;
    k=round(k);
    q_plot(:,k) = q;
    qdesired_plot(:,k) = qdesired;
    %%%
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
        %%%
    dq1 = dq(1);
    dq2 = dq(2);
    dq3 = dq(3);
    dq4 = dq(4);
end
%%
plot(0:sampling_time:final_time,q_plot(4,:),'k--');
hold on;
plot(0:sampling_time:final_time,qdesired_plot(4,:),'k');
hold on;
plot(0:sampling_time:final_time,q_plot(3,:),'r--');
hold on;
plot(0:sampling_time:final_time,qdesired_plot(3,:),'r');
hold on;
plot(0:sampling_time:final_time,q_plot(2,:),'b--');
hold on;
plot(0:sampling_time:final_time,qdesired_plot(2,:),'b');
hold on;
plot(0:sampling_time:final_time,q_plot(1,:),'g--');
hold on;
plot(0:sampling_time:final_time,qdesired_plot(1,:),'g');
