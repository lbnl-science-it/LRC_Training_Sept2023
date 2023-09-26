

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


%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%


% Setup
t = tic();
x = gpuArray.linspace( xlim(1), xlim(2), gridSize );
y = gpuArray.linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );

% Calculate
count = arrayfun( @pctdemo_processMandelbrotElement, ...
                  xGrid, yGrid, maxIterations );

% Show
count = gather( count ); % Fetch the data back from the GPU
gpuArrayfunTime = toc( t );
%imagesc( x, y, count )
%axis off
%title( sprintf( '%1.3fsecs (GPU arrayfun) = %1.1fx faster', ...
%    gpuArrayfunTime, cpuTime/gpuArrayfunTime ) );

fprintf('gpuArrayfunTime: %1.3fsecs (GPU arrayfun) = %1.1fx faster\n', gpuArrayfunTime, cpuTime/gpuArrayfunTime );

