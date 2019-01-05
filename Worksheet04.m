close all
clear all
clc
format short g

Nx_Ny = [7;15;31;63];

Nx = [7,15,31,63];
Ny = [7,15,31,63];

runtime_GS = zeros(4,1);
storage_GS = zeros(4,1);
runtime_Full_matrix = zeros(4,1);
storage_Full_matrix = zeros(4,1);
runtime_Sparse_matrix = zeros(4,1);
storage_Sparse_matrix = zeros(4,1);

for i = 1:length(Nx)
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    tic
    GS = Gauss_Seidel(Nx(i), Ny(i), b);
    runtime_GS(i) = toc;
    storage_GS(i) = numel(GS) + numel(b);
end

for i = 1:length(Nx)
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    Full_matrix = Matrix_A(Nx(i), Ny(i));
    tic
    x = Full_matrix\b_array;
    runtime_Full_matrix(i) = toc;
    storage_Full_matrix(i) = numel(Full_matrix) + length(b_array);
end

for i = 1:length(Nx)
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    Sparse_matrix = sparse(Matrix_A(Nx(i), Ny(i)));
    tic
    x = Sparse_matrix\b_array;
    runtime_Sparse_matrix(i) = toc;
    storage_Sparse_matrix(i) = numel(Sparse_matrix) + length(b_array);
end

Full_matrix = table(Nx_Ny, runtime_Full_matrix, storage_Full_matrix);
Sparse_matrix = table(Nx_Ny, runtime_Sparse_matrix, storage_Sparse_matrix);
Gauss_Seidel_matrix = table(Nx_Ny, runtime_GS, storage_GS);



Nx_Ny = [7;15;31;63;127];

Nx = [7,15,31,63,127];
Ny = [7,15,31,63,127];

error = zeros(5,1);
error_reduction = zeros(5,1);


total_error = 0;

for i = 1:length(Nx)
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    GS = Gauss_Seidel(Nx(i), Ny(i), b);
    for k = 2:(Nx(i)+1)
        for l = 2:(Ny(i)+1)
            total_error = total_error + (GS(k,l)-(sin(pi*xloc(k))*sin(pi*yloc(l))))^2;
        end
    end
    error(i) = sqrt(total_error/(Nx(i)*Ny(i)));
end

for i = 1:(length(error_reduction)-1)
    error_reduction(i) = error(i+1)/error(i);

Gauss_Seidel_error_matrix = table(Nx_Ny, error, error_reduction);
end 

%surf(xloc, yloc, GS)



%Gauss_Seidel_error = table(Nx_Ny, error, error_red);

Full_matrix
Sparse_matrix
Gauss_Seidel_matrix
Gauss_Seidel_error_matrix

function [b, b_array, xloc, yloc] = createB(Nx, Ny)

b = zeros(Nx, Ny);
length = Nx*Ny;
b_array = zeros(length, 1);
length_x = (Nx+2)*(Ny+2);
xloc = zeros(Nx+2, Ny+2);
yloc = zeros(Nx+2, Ny+2);

k = 1;

for i = 1:Nx
    for j = 1:Ny
        b(i, j) = -2*pi*pi*sin((pi*i)/(Nx + 1))*sin((pi*j)/(Ny + 1));
        b_array(k) = b(i,j);
        k = k+1;
    end
for f = 1:Nx+2
    for g = 1:Ny+2
        xloc(f,g) = (g-1)/(Ny+1);
        yloc(f,g) = (f-1)/(Nx+1);
    end
end
end 
end
