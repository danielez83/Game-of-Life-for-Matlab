% Click outside of the matrix to complete
starting_world = zeros(64, 64);
starting_world(starting_world==0) = 1;

%figure(f1);
pcolor(starting_world);
colormap gray
while (1)
    [x,y] = ginput(1);
    if (x>size(starting_world,1) || y>size(starting_world,1))||(x<0 || y<0)
        break;
    end
    if starting_world(floor(y),floor(x)) == 0
        starting_world(floor(y),floor(x)) = 1;
    else
        starting_world(floor(y),floor(x)) = 0;
    end
    pcolor(starting_world);
end
starting_world(starting_world==1) = 2;
starting_world(starting_world==0) = 1;
starting_world(starting_world==2) = 0;
clearvars -except starting_world;