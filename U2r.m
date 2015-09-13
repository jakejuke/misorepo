function r = U2r(U)
%U2r Convert a rotation matrix to a Rodrigues vector
%
%   r = U2r(U), where U is a 3x3 orthogonal rotation matrix
%
%   Based on code from S. Schmidt (DTU)
%   It appears he used A. Morawiec's book "Orientations and Rotations" as
%   his source (see pg. 22)
%   
%   Modified by J. Dake to keep the sign of the Rodrigues vector consistent
%   with the following definitions:
%       1. right-handed coordinate systems
%       2. right-handed rotation is positive
%       3. rotation takes ref. coordinate system to crystal/sample system
%       4. use premultiplication of matrices
%
%   Jules Dake
%   Uni Ulm, 13 Sep 2015
%

% % From Soeren's U2r.m code (gives wrong direction!)
% rSoeren = [(U(2,3)-U(3,2))/(1+U(1,1)+U(2,2)+U(3,3)) ...
%             (U(3,1)-U(1,3))/(1+U(1,1)+U(2,2)+U(3,3)) ...
%             (U(1,2)-U(2,1))/(1+U(1,1)+U(2,2)+U(3,3))];
        
% % From Engler2010 (also gives wrong direction!)
% theta = acosd((U(1,1) + U(2,2) + U(3,3) - 1)/2);
% nEngler = [(U(2,3)-U(3,2))/(2*sind(theta)), ...
%            (U(3,1)-U(1,3))/(2*sind(theta)), ...
%            (U(1,2)-U(2,1))/(2*sind(theta))];
% rEngler = nEngler*tand(theta/2);

% Modified version of Soeren's code (sign flipped)
r = [(U(3,2)-U(2,3))/(1+U(1,1)+U(2,2)+U(3,3)) ...
     (U(1,3)-U(3,1))/(1+U(1,1)+U(2,2)+U(3,3)) ...
     (U(2,1)-U(1,2))/(1+U(1,1)+U(2,2)+U(3,3))];
 
end
