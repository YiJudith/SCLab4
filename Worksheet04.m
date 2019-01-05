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
    graph_04(i + 2 * Nx(i), xloc, yloc, GS , ' Gauss Seidel');
    storage_GS(i) = numel(GS) + numel(b);
end

for i = 1:length(Nx)
    solution_matrix = zeros(Nx(i) + 2, Ny(i) + 2);
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    Full_matrix = Matrix_A(Nx(i), Ny(i));
    tic
    x = Full_matrix\b_array;
    runtime_Full_matrix(i) = toc;
    for j = 1:Nx(i)
        for k = 1:Ny(i)
            solution_matrix(j + 1, k + 1) = x((j - 1) * Ny(i) + k);
        end
    end
    graph_04(i, xloc, yloc, solution_matrix , ' Full Matrix');
    storage_Full_matrix(i) = numel(Full_matrix) + length(b_array);
end

for i = 1:length(Nx)
    solution_matrix = zeros(Nx(i) + 2, Ny(i) + 2);
    [b, b_array, xloc, yloc] = createB(Nx(i), Ny(i));
    Sparse_matrix = sparse(Matrix_A(Nx(i), Ny(i)));
    tic
    x = Sparse_matrix\b_array;
    runtime_Sparse_matrix(i) = toc;
    for j = 1:Nx(i)
        for k = 1:Ny(i)
            solution_matrix(j + 1, k + 1) = x((j - 1) * Ny(i) + k);
        end
    end
    graph_04(i + Nx(i), xloc, yloc, solution_matrix , ' Sparse Matrix');
    storage_Sparse_matrix(i) = length(Sparse_matrix) + length(b_array);
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

%contour(xloc,yloc,GS)

%Gauss_Seidel_error = table(Nx_Ny, error, error_red);

Full_matrix
Sparse_matrix
Gauss_Seidel_matrix
Gauss_Seidel_error_matrix

