function U=r2U(r)
%r2U
%
%   U = r2U(r) converts the three-component Rodrigues vector r to a 3x3
%   rotation matrix U
%
%   Code from S. Schmidt (DTU)
%   It appears he used A. Morawiec's book "Orientations and Rotations" as
%   his source (see pg. 22)
%

  r2_0=r(1)^2;
  r2_1=r(2)^2;
  r2_2=r(3)^2;
  
  r2=r2_0+r2_1+r2_2;
  a=1.-r2;
  b=1./(1.+r2);
  c=2.*b;
  r01=r(1)*r(2);
  r02=r(1)*r(3);
  r12=r(2)*r(3);


  U(1,1) = (a+2.*r2_0)*b;
  U(2,2) = (a+2.*r2_1)*b;
  U(3,3) = (a+2.*r2_2)*b;

  U(1,2)=(r01+r(3))*c;
  U(2,1)=(r01-r(3))*c;

  U(1,3)=(r02-r(2))*c;
  U(3,1)=(r02+r(2))*c;

  U(2,3)=(r12+r(1))*c;
  U(3,2)=(r12-r(1))*c;
  
end
  