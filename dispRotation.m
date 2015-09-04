function [h, r] = dispRotation(U1,varargin)
%dispRotation 
%   
%   h = dispRotation(U1) shows how the rotation matrix U1 transforms
%   the reference coordinate system by applying U1 to the vertices of a
%   reference cube. Returns the figure handle h (and Rodrigues vector).
%   
%   This assumes:
%       - matrix products computed by pre-multiplication, e.g., M = B*A^-1
%       - right-handed coordinate system (right-handed rotation)
%       - rotation matrix describes rotation from reference system to
%         current/rotated system
%   
%   
%   Jules Dake
%   12 Nov 2014, Uni Ulm
%   


%% Parse input variables
p = inputParser;

addRequired(p,'U1',@isnumeric);

defaultColor = [0 0 1];
addParameter(p,'Color',defaultColor,@isnumeric);
defaultReference = eye(3);
addParameter(p,'Reference',defaultReference,@isnumeric);

parse(p,U1,varargin{:});
defColor = p.Results.Color;
Uref =p.Results.Reference;

% color of reference coordinate system
refColor = [0.4 0.4 0.4];
% length of coordinate system axes
a = 1;


%% Main

% org = [-1 -1 -1];
% 
% v0(1,:) = [-1, -1,  1,  1, -1, -1,  1,  1];
% v0(2,:) = [-1,  1,  1, -1, -1,  1,  1, -1];
% v0(3,:) = [-1, -1, -1, -1,  1,  1,  1,  1];

org = [0 0 0];

v0(1,:) = [0, 0,  1,  1, 0, 0,  1,  1];
v0(2,:) = [0,  1,  1, 0, 0,  1,  1, 0];
v0(3,:) = [0, 0, 0, 0,  1,  1,  1,  1];

v1 = Uref*v0;

% Apply transformation (matrix pre-multiplication, right-hand-rule
% for positive rotation)
v2 = U1*v1;

figure;
% Draw lower square
x = [v2(1,1:4), v2(1,1)];
y = [v2(2,1:4), v2(2,1)];
z = [v2(3,1:4), v2(3,1)];
l_handle=line(x,y,z);
set(l_handle,'color',defColor,'LineWidth',1)

% Draw upper square
x = [v2(1,5:8), v2(1,5)];
y = [v2(2,5:8), v2(2,5)];
z = [v2(3,5:8), v2(3,5)];
l_handle=line(x,y,z);
set(l_handle,'color',defColor,'LineWidth',1)

% Draw vertical lines connecting squares
for I=1:4
    x = [v2(1,I), v2(1,I+4)];
    y = [v2(2,I), v2(2,I+4)];
    z = [v2(3,I), v2(3,I+4)];
    l_handle=line(x,y,z);
    set(l_handle,'color',defColor,'LineWidth',1)
end


% set view and mark origin with blue sphere
% view(-175,28)
% view(-110,-302)
% view(-105,-23) % freaky view!!
% view(3)

% plot point at origin
hold on
scatter3(v1(1,1),v1(2,1),v1(3,1),12,refColor,'filled')
scatter3(v2(1,1),v2(2,1),v2(3,1),12,defColor,'filled')

% axis options
axis equal
xlabel('x'); ylabel('y'); zlabel('z');

% % plot rotation axis
% r = U2r(U1); % ----> check this function for correctness!
% % % old way of normalizing r
% % [~,n] = mymisorientation([0 0 0],r);
% n = r/norm(r);
% % double length of unit vector n (so it will be as long as other vectors)
% n2 = n*2 + org;
% % mArrow3(org,n2,'color','k');
% mArrow3([0 0 0],n,'color','k');

plotAxes3D(a,'origin',org,'Color',refColor,'Orientation',Uref);

end
