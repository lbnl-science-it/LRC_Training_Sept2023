
maxIterations = 500;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

tic;
x = linspace(xlim(1),xlim(2),gridSize);
y = linspace(ylim(1),ylim(2),gridSize);
[xGrid,yGrid] = meshgrid(x,y);
z0 = xGrid + 1i*yGrid;

cpuCount = ones(size(z0));
z = z0;
for n = 0:maxIterations
  z = z.*z + z0;
  inside = abs(z)<=2;
  cpuCount = cpuCount + inside;
end
cpuCount = log(cpuCount);
cpuTime = toc

fprintf('cpuTime: %1.3f s\n', cpuTime);

%figure
%imagesc(x,y,cpuCount);
%c = colormap([jet;flipud(jet);0 0 0]);
%axis off
%title(sprintf('CPU Exection: %1.3f s',cpuTime));

