function [phi, n, dU, dr] = calcmisor(a,b,varargin)
%calcmisor Calculate the misorientation between two grains/objects
%
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


%% Parse input variables
p = inputParser;

addRequired(p,'a',@isnumeric);
addRequired(p,'b',@isnumeric);

defSymmetry = 'cubic';
addParameter(p,'Symmetry',defSymmetry,@ischar);

parse(p,a,b,varargin{:});
symmetry = p.Results.Symmetry;


%% Get symmetry relations

if strcmpi(symmetry,'cubic')
    G = getsymmetry(symmetry);
else
    error('Function only works for ''cubic'' symmetry at the moment')
end

% check input a
if length(a(:)) == 3
    A = r2U(a);
elseif length(a(:)) == 9
    A = a;
else
    error('Input should be Rodrigues vecotrs or rotation matrices')
end

% check input b
if length(b(:)) == 3
    B = r2U(b);
elseif length(a(:)) == 9
    B = b;
else
    error('Input should be Rodrigues vecotrs or rotation matrices')
end

% Calculate minimum misorientation by applying symmetry operations
max_Tr=0;
for i=1:24
    % right-handed rotation and coordinate systems, premultiplication, and
    % M takes A to B: B = M*A -> M = B*A', G applys cubic symmetry
    M = squeeze(G(i,:,:))'*B*A';
    % rotation angle given by:
    %     theta = acosd((U(1,1) + U(2,2) + U(3,3) - 1)/2)
    % thus, the larger the trace, the smaller the angle
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
