function [phi, n, dU, dr] = mymisorientation(r1,r2)
%MYMISORIENTATION calculates the misorientation between two Rodrigues
%vectors
%
%   Determine the misorientation for Rodrigues vectors r1 and r2
%   assuming cubic symmetry.
%   
%   EXAMPLE:
%       [phi, n, dU, dr] = mymisorientation(r1,r2)
%
%       where phi is the angle of rotation,
%              n  is the axis of rotation,
%             dU  is the misorientation matrix, and
%             dr  is the misorientation in Rodrigues notation
%   
%   Originally from Soeren Schmidt, DTU Physics, Denmark.
%   Modified by Jules Dake, Uni Ulm, Germany.
%   

% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! %
%   26.06.2014 - changed "M=B*A'*squeeze(G(i,:,:));" to
%   "M=A'*B*squeeze(G(i,:,:));" 
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! %

%A = r2U(r1);
%B = r2U(r2);
A = angleAxis2U(r1,2*atand(norm(r1)));
B = angleAxis2U(r2,2*atand(norm(r2)));

% Cubic symmetry 
G( 1,:,:) = [ 1  0  0;  0  1  0;  0  0  1];
G( 2,:,:) = [ 0 -1  0;  1  0  0;  0  0  1];
G( 3,:,:) = [-1  0  0;  0 -1  0;  0  0  1];
G( 4,:,:) = [ 0  1  0; -1  0  0;  0  0  1];
G( 5,:,:) = [ 1  0  0;  0  0 -1;  0  1  0];
G( 6,:,:) = [ 1  0  0;  0 -1  0;  0  0 -1];
G( 7,:,:) = [ 1  0  0;  0  0  1;  0 -1  0];
G( 8,:,:) = [ 0  0  1;  0  1  0; -1  0  0];
G( 9,:,:) = [-1  0  0;  0  1  0;  0  0 -1];
G(10,:,:) = [ 0  0 -1;  0  1  0;  1  0  0];
G(11,:,:) = [ 0  0  1;  1  0  0;  0  1  0];
G(12,:,:) = [ 0  1  0;  0  0  1;  1  0  0];
G(13,:,:) = [ 0 -1  0;  0  0 -1;  1  0  0];
G(14,:,:) = [ 0  0  1; -1  0  0;  0 -1  0];
G(15,:,:) = [ 0 -1  0;  0  0  1; -1  0  0];
G(16,:,:) = [ 0  0 -1; -1  0  0;  0  1  0];
G(17,:,:) = [ 0  0 -1;  1  0  0;  0 -1  0];
G(18,:,:) = [ 0  1  0;  0  0 -1; -1  0  0];
G(19,:,:) = [ 0  1  0;  1  0  0;  0  0 -1];
G(20,:,:) = [ 0 -1  0; -1  0  0;  0  0 -1];
G(21,:,:) = [-1  0  0;  0  0  1;  0  1  0];
G(22,:,:) = [-1  0  0;  0  0 -1;  0 -1  0];
G(23,:,:) = [ 0  0  1;  0 -1  0;  1  0  0];
G(24,:,:) = [ 0  0 -1;  0 -1  0; -1  0  0];

max_Tr=0;
 
for i=1:24
    % M=B*A'*squeeze(G(i,:,:)); % in Soeren's original code
    M = A'*B*squeeze(G(i,:,:)); % this is now post-multiplication!!
    Tr = M(1,1) + M(2,2) + M(3,3);
    
    if Tr > max_Tr
       max_Tr = Tr;
       dU = M;
    end
    
end

dr = U2r(dU);
phi = 2.*atand(norm(dr)); % misorientation angle. = acosd((max_Tr-1)/2)
n = dr/norm(dr); % misorientation axis

end
