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
