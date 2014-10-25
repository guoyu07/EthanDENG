

 %        This program computes the value function and the optimal
 %        decision rules of the linear-quadratic approximation to the
 %        problem described in Exercise 6.

 %        Author:   Jorge Duran
 %        e-mail: xurxo@eco.uc3m.es

syms z k x
a = 0.33;               %  alpha
b = 0.96;               %  beta
p = 0.95;               %  rho
d = 0.10;               %  delta

r = log(exp(z)*k^a-x);

 %  Step 1:  Compute the steady state
K = ( (a*b)/(1-b*(1-d)) )^(1/(1-a));
X = d*K;
Z = 0;
R = log(exp(Z)*K^a - X);

 %  Step 2:  Construct the quadratic expansion of the utility function
 % format the Jacobi Matrix 
J = jacobian(r,[z,k,x]);
 % format the Hessian Matrix
H = hessian(r,[z,k,x]);

 % Evaluate the Jacobi Matrix and Hessian Matrix at the steady state
DJ = double(subs(J',[z,k,x],[Z,K,X]))
D2H = double(subs(H,[z,k,x],[Z,K,X]))

W = [Z K X]';

  Q11 = R - W'*DJ + 0.5*W'*D2H*W;
  Q12 = 0.5*(DJ-D2H*W);
  Q22 = 0.5*D2H;

  Q=[ Q11  Q12'
      Q12  Q22];

 % Step 3:  Compute the optimal value function.

 % Step 3.1:  Partition matrix Q to separate the state and control variables

  Qff = Q(1:3,1:3);
  Qfd = Q(4,1:3);
  Qdd = Q(4,4);

 % Step 3.2:  Input matrix B

  B = [ 1 0  0  0
        0 p  0  0
        0 0 1-d 1];

 % Step 3.3:  Input matrix P0

  P = [-0.1      0      0
         0    -0.1      0
         0       0   -0.1  ];

 % Step 3.4:  Initialize auxiliary matrix A

  A=ones(3);

 % Step 3.5:  Iterate on Bellman's equation until convergence

  while (norm(A-P)/norm(A))>0.0000001
    A = P;
    M=B'*P*B;
      Mff = M(1:3,1:3);
      Mfd = M(4,1:3);
      Mdd = M(4,4);
    P=Qff + (b*Mff) - (Qfd'+(b*Mfd)')*inv(Qdd+(b*Mdd))*(Qfd+(b*Mfd));
  end

 % Step 4:  Output the results

  disp(' ')
  disp(' The linear policy for investment is d*=J''F, where vector J is:')
  J=-(inv(Qdd+(b*Mdd))*(Qfd+(b*Mfd)))';
  J
  disp(' ')
  disp(' The optimal value function is V*=F''PF, where matrix P is:')
  P

 % END OF MATLAB FILE

 % The output of this program should be the following:



 % J =

 %    0.4983
 %    0.8607
 %   -0.0411


 % P =

 %   -0.4025    8.0839    0.7369
 %    8.0839    1.0029   -0.1915
 %    0.7369   -0.1915   -0.0819