
function [A] = Matrix_A(Nx, Ny)

lengthX = Nx*Ny;

hx = 1/(Nx + 1);
hy = 1/(Ny + 1);

A = zeros(lengthX, lengthX);

for i = 1:lengthX
    for j = 1:lengthX
        if i == j
            A(i,j) = -(2/(hx^2) + 2/(hy^2));
            if (mod((i+1), Nx) ~= 1)
                A(i+1,j) = (1/(hx^2));
            end
            if (mod((i-1), Nx) ~= 0)
                A(i-1,j) = (1/(hx^2));
            end
            if i - Nx > 0
                A((i-Nx),j) = (1/(hy^2));
            end
            if i + Nx <= lengthX
                A((i+Nx),j) = (1/(hy^2));
            end
        end
    end
    
end

end
