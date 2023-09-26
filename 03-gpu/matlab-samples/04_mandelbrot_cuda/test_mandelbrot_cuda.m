
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CPU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% cuda
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Ensure the GPU is available and selected
gpu = gpuDevice;
fprintf('GPU Device: %s GPU selected.\n', gpu.Name);
[n,indx] = gpuDeviceCount;
fprintf('GPU Device Count: %d.\n', n);

% Load the kernel
cudaFilename = 'pctdemo_processMandelbrotElement.cu';
ptxFilename = ['pctdemo_processMandelbrotElement.',parallel.gpu.ptxext];
kernel = parallel.gpu.CUDAKernel( ptxFilename, cudaFilename );

% Setup
t = tic();
x = gpuArray.linspace( xlim(1), xlim(2), gridSize );
y = gpuArray.linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );

% Make sure we have sufficient blocks to cover all of the locations
numElements = numel( xGrid );
kernel.ThreadBlockSize = [kernel.MaxThreadsPerBlock,1,1];
kernel.GridSize = [ceil(numElements/kernel.MaxThreadsPerBlock),1];
                              
% Call the kernel
count = zeros( size(xGrid), 'gpuArray' );
count = feval( kernel, count, xGrid, yGrid, maxIterations, numElements );
       
% Show
count = gather( count ); % Fetch the data back from the GPU
gpuCUDAKernelTime = toc( t );
%imagesc( x, y, count )
%axis off
%title( sprintf( '%1.3fsecs (GPU CUDAKernel) = %1.1fx faster', ...
%    gpuCUDAKernelTime, cpuTime/gpuCUDAKernelTime ) );

fprintf( 'gpuCUDAKernelTime: %1.3fsecs (GPU CUDAKernel) = %1.1fx faster\n', gpuCUDAKernelTime, cpuTime/gpuCUDAKernelTime );

