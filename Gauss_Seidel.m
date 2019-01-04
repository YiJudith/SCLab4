
function GS_matrix = Gauss_Seidel(Nx, Ny, b)

a = 1.0;

lengthX = Nx*Ny;

hx = 1/(Nx + 1);
hy = 1/(Ny + 1);

GS_matrix = zeros(Nx + 2, Ny + 2);

R = 1;

R_tot = 0;

while R > 0.0001
    R_tot = 0;
    for n = 2:(Nx+1)
        for m =  2:(Ny+1)
            GS_matrix(n,m) = a*(-b(n-1,m-1) + (1/(hx^2))*(GS_matrix(n-1,m) + GS_matrix(n+1,m)) + ...
                (1/(hy^2))*(GS_matrix(n,m-1) + GS_matrix(n,m+1)))/(2/(hx^2) + 2/(hy^2));
        end
    end 
    for n = 2:(Nx+1)
        for m = 2:(Ny+1)
            R_tot = R_tot + (b(n-1, m-1) - (1/(hx^2))*(GS_matrix(n-1,m) + GS_matrix(n+1,m)) - ...
                (1/(hy^2))*(GS_matrix(n,m-1) + GS_matrix(n,m+1)) + (2/(hx^2) + 2/(hy^2))*GS_matrix(n,m))^2;
        end
    end
   
    R = sqrt((1/(Nx*Ny))*R_tot);
    
end
end


