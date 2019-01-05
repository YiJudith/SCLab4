function graph_04(pic_num, xloc, yloc, z, pic_title)
    figure1 = figure(pic_num * 2 - 1);
    surf(xloc, yloc, z);
    Title = strcat('The graph of ', pic_title, ' with Nx=Ny= ', sprintf('%.d',length(xloc)-2) ,' by surface');
    set(figure1,'Name',Title, 'NumberTitle','off');
    title(Title,'Fontsize',15);
    set(gca,'Fontsize',15, 'XLim',[0,1], 'YLim', [0,1]);
    grid on;
    figure2 = figure(pic_num * 2);
    contour(xloc, yloc, z, 'ShowText','on');
    Title = strcat('The graph of ', pic_title, ' with Nx=Ny= ', sprintf('%.d',length(xloc)-2) ,' by contour');
    set(figure2,'Name',Title,'NumberTitle','off');
    title(Title,'Fontsize',15);
    set(gca,'Fontsize',15, 'XLim',[0,1], 'YLim', [0,1]);
    grid on;
end
