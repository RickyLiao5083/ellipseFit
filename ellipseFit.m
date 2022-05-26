function [theta, sse]=ellipseFit(data)

n=size(data(1,:));
x0=sum(data(1,:))/n(2);
y0=sum(data(2,:))/n(2);
center0=[x0 y0];		% Initial guess of the center
center=fminsearch(@(x)sseOfEllipseFit(x, data), center0);	% Use fminsearch to find center
[sse, radius]=sseOfEllipseFit(center, data);	% Use sseOfEllipseFit to obtain the final sse &amp; radius
theta=[center, radius];

% Function that returns SSE and the linear parameters
function [sse, radius]=sseOfEllipseFit(center, data)
x=data(1,:);
y=data(2,:);
n=size(x);
A=[(x'-center(1)).^2 (y'-center(2)).^2];
a=A\ones(n(2),1);
sse=sum(((x-center(1)).^2.*a(1)+(y-center(2)).^2.*a(2)-1).^2);
radius=[1/sqrt(a(1)) 1/sqrt(a(2))];