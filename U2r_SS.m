function r = U2r_SS(U)
%U2r converts rotation matrix to Rodrigues vector
%
%   r = U2r(U), where U is a 3x3 orthogonal rotation matrix
%
%   Code from S. Schmidt (DTU)
%   It appears he used A. Morawiec's book "Orientations and Rotations" as
%   his source (see pg. 22)
%   
%   For definition of permutation symbol epsilon see:
%   http://mathworld.wolfram.com/PermutationSymbol.html
%

  dn=1+U(1,1)+U(2,2)+U(3,3);
  
  for i=1:3
    r(i)=0;
    for j=1:3
      for k=1:3
        r(i) = r(i) - epsilon_SS(i,j,k)*U(k,j);
      end
    end
  
    r(i)=r(i)/dn;
    
  end

