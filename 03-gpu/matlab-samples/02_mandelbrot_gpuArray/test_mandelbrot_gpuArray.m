
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% CPU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gpuArray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Setup
t = tic();
x = gpuArray.linspace( xlim(1), xlim(2), gridSize );
y = gpuArray.linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );
z0 = complex( xGrid, yGrid );
count = ones( size(z0), 'gpuArray' );

% Calculate
z = z0;
for n = 0:maxIterations
    z = z.*z + z0;
    inside = abs( z )<=2;
    count = count + inside;
end
count = log( count );

count = gather( count ); % Fetch the data back from the GPU
naiveGPUTime = toc( t );

% Show
%imagesc( x, y, count )
%axis off
%title( sprintf( '%1.3fsecs (naive GPU) = %1.1fx faster', ...
%    naiveGPUTime, cpuTime/naiveGPUTime ) )

fprintf('naiveGPUTime: %1.3fsecs (naive GPU) = %1.1fx faster\n', naiveGPUTime, cpuTime/naiveGPUTime);

