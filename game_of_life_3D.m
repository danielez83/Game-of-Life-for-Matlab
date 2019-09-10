% Game of life 3D in Matlab
% Rules: a living cell remains alive only when surrounded by 2 or 3 living neighbors, 
% otherwise it dies of loneliness or overcrowding. A dead cell comes to life 
% when it has exactly 3 living neighbors
tic

% Configuration
random = 0; % 1 for generating a random world
%world = false(30, 30, 30); % x,y,z
% load('world_1.mat')
jet_palette = jet(100);

if random~=1
    % generate random logical values (0 - 1)
    world = reshape(randi([0 1],1,numel(world)),...
            [size(world, 1) size(world, 2) size(world, 3)]);
    % clear boundaries
    world(1:size(world, 1), 1:size(world, 2), 1:3) = 0;
    world(1:size(world, 1), 1:3, 1:size(world, 3)) = 0;
    world(1:3, 1:size(world, 2), 1:size(world, 3)) = 0;
    world(1:size(world, 1), 1:size(world, 2), end-2:end) = 0;
    world(1:size(world, 1), end-2:end, 1:size(world, 3)) = 0;
    world(end-2:end, 1:size(world, 2), 1:size(world, 3)) = 0;
  
    world = logical(world); % Convert numeric values to logicals
    good_world = world; % save a copy of initial word
end

figure('Color','black') 
for cycle=1:20
    pause(0.1);
    clf
    title(cycle)
    % Evolve
    world_buffer = world;
    for x=4:size(world, 1)-3
        for y=4:size(world, 2)-3
            for z=4:size(world, 3)-3          
                if world_buffer(x,y,z) % Check if living cell will survive  
                    status = sum(sum(sum(world(x-1:x+1,y-1:y+1,z-1:z+1)))) - 1;
                    if status >= 3 &&  status <= 4
                        world_buffer(x,y,z) = 1; % Survive
                    else
                        world_buffer(x,y,z) = 0; % Die
                    end
                else % Check if living cell will survive
                    status = sum(sum(sum(world(x-1:x+1,y-1:y+1,z-1:z+1))));
                    if status == 3
                        world_buffer(x,y,z) = 1; % Cell is born
                    end
                end
            end
        end
    end
    world = world_buffer;
    
    col_index_array = zeros(size(world, 1)*size(world, 3)*size(world, 3),1);
    col_index_array_index = 1;
    for x=4:size(world, 1)-3
        for y=4:size(world, 2)-3
            for z=4:size(world, 3)-3
                if world(x,y,z)
                    col_index = sum(sum(sum(world(x-3:x+3,y-3:y+3,z-3:z+3))));
                    col_index_array(col_index_array_index) = col_index;
                    plotcube([1 1 1],[x  y  z],.95,jet_palette(col_index, :))
                    col_index_array_index = col_index_array_index + 1;
                end
            end
        end
    end
    axis off
    view(3)
    str = sprintf('Generation: %d\nPopulation: %d\nMax Density: %d', cycle, sum(sum(sum(world))), max(col_index_array));
    text(15,50, 20, str,'Color','red','FontSize',14)
end
toc
