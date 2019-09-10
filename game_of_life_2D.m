% Game of life
tic

% random world
random = 1; % if set to zero load a 2d matrix named "starting_world"
domain_size = [64 64]; % row,column

% draw in real time?
draw_world = 1;

% number of world replicates
n_world_replica = 1;

gen=zeros(n_world_replica,1);

% Prepare figures
f1 = figure('Position',[10 250 500 500]);
f2 = figure('Position',[800 250 500 500]);

for(n=1:n_world_replica)
    % Initial status
    if random == 1
        world = randi([0 1], domain_size(2), domain_size(1));
    else
        world = starting_world;
    end
    old_world = world;

    % clear borders
    world(:,1) = 0;
    world(1,:) = 0;
    world(:,end) = 0;
    world(end,:) = 0;

    if draw_world==1
        figure(f1);
        pcolor(world);
        colormap gray
        axis square
        title(sprintf('Replica %f of %f', n, n_world_replica))
    end

    % main cycle
    gen(n)=1;
    while(1)
        new_world = world;
        if ~mod(gen,2) % even generation
            if old_world == new_world
                break
            end
            old_world = world;
        end
        for row=2:size(world, 1)-1
            for column=2:size(world, 2)-1 
                if world(row,column)==1 % LIVE CELL
                    %neighborhood status
                    neighborhood = sum(sum(world(row-1:row+1,column-1:column+1)))-1;
                    if neighborhood < 2 % death by underpopulation
                        new_world(row,column)=0;
                    end
                    if neighborhood >= 2 && neighborhood <= 3% survive
                        new_world(row,column)=1;
                    end
                    if neighborhood > 3 % death by overpopulation
                        new_world(row,column)=0;
                    end
                else %world(x,y)==0 % DEAD CELL
                    %neighborhood status
                    neighborhood = sum(sum(world(row-1:row+1,column-1:column+1)));
                    if neighborhood == 3 % reproduction
                        new_world(row,column)=1;
                    end
                end

            end
        end
        world = new_world;    
        if draw_world==1
            pause(0.01)
            figure(f1);
            pcolor(world);
            axis square
            title(sprintf('Replica %i of %i - Gen %i', n, n_world_replica, gen(n)))
        end

        % Generation statistics
        gen(n) = gen(n) + 1;
    end
    figure(f2);
    hist(gen);
    title('Stability distribution')
    xlabel('Generation')
    ylabel('Counts')
    %axis square
end
toc