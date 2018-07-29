function [A,B,D,E,I]=E7x(R,C)
% Subprogram for 7th order Elliptical LPF
N=7;U=11;M=1;Y=11;  
% create space for and zero A1 & B2 matrices
A1=zeros(U+N);B2=zeros(U+N,N+M);
%
% R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15]
%    1  2  3  4  5  6  7  8  9  10  11  12  13  14  15
%
% C = [C1 C2 C3 C4 C5 C6 C7];
%      1  2  3  4  5  6  7 
%
% For column alignment:
%
% V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11   iC1 iC2 iC3 iC4 iC5 iC6 iC7
% 1  2  3  4  5  6  7  8  9  10  11    12  13  14  15  16  17  18
%
% Create A1
%
%       -V1/R2      +iC1
A1(1,1)=-1/R(2);A1(1,12)=1; % -Ein/R1 - V1/R2 + iC1 = 0
%
G2=1/R(3)+1/R(5); % For row 2 below
%   +V1/R3        -V2*G2       +iC2
A1(2,1)=1/R(3);A1(2,2)=-G2;A1(2,13)=1; % V1/R3 -V2*G2 + iC2 = 0
%
A1(3,3)=-1/R(6);A1(3,4)=1/R(6);A1(3,13)=-1;A1(3,14)=1; % -V3/R6 + V4/R6 - iC2 + iC3 = 0
%
G4=1/R(6)+1/R(9)+1/R(10); % For row 4 below
%
% V3/R6        +V6/R9        +V8/R10         -V4*G4       +iC4 = 0
A1(4,3)=1/R(6);A1(4,6)=1/R(9);A1(4,8)=1/R(10);A1(4,4)=-G4;A1(4,15)=1; 
A1(5,1)=1/R(4);A1(5,5)=-1/R(4);A1(5,15)=-1;A1(5,14)=-1;
A1(6,5)=1/R(7);A1(6,6)=-1/R(7);A1(6,14)=-1;
A1(7,6)=1/R(8);A1(7,7)=-1/R(8);A1(7,17)=-1;A1(7,18)=-1;
A1(8,4)=1/R(10);A1(8,8)=-(1/R(10)+1/R(11));A1(8,16)=1;
A1(9,10)=1/R(12);A1(9,9)=-1/R(12);A1(9,17)=1;A1(9,16)=-1;
G10=1/R(12)+1/R(14)+1/R(15); % For row 10 below
A1(10,18)=1;A1(10,10)=-G10;A1(10,11)=1/R(14);A1(10,9)=1/R(12);
A1(11,7)=1/R(13);A1(11,11)=-1/R(13);A1(11,17)=-1;
A1(12,1)=-1; % 0-V1=E1
A1(13,3)=1;A1(13,2)=-1; % V3-V2=E2
A1(14,6)=1;A1(14,3)=-1; % V6-V3=E3
A1(15,5)=1;A1(15,4)=-1; % V5-V4=E4
A1(16,9)=1;A1(16,8)=-1; % V9-V8=E5
A1(17,11)=1;A1(17,9)=-1; % V11-V9=E6
A1(18,7)=1;A1(18,10)=-1; % V7-V10=E7
%
% B2
%
E1=1;E2=1;E3=1;E4=1;E5=1;E6=1;E7=1;Ein=1;
% E1 E2 E3 E4 E5 E6 E7 Ein  Source
% 1  2  3  4  5  6  7  8    Column of B2
%
B2(12,1)=E1;
B2(13,2)=E2;
B2(14,3)=E3;
B2(15,4)=E4;
B2(16,5)=E5;
B2(17,6)=E6;
B2(18,7)=E7;
B2(1,8)=Ein/R(1);
%
P=diag([C(1) C(2) C(3) C(4) C(5) C(6) C(7)]);
%
% Template "canned" statements
%
V=A1\B2;H=V(U+1:U+N,1:N+M);I=eye(N);
AB=P\H;A=AB(1:N,1:N);B=AB(1:N,N+1:N+M);
D=V(Y:Y,1:N);E=V(Y:Y,N+1:N+M);