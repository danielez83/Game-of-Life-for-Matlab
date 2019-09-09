% Game of life 3D in Matlab
% Rules: a living cell remains alive only when surrounded by 2 or 3 living neighbors, 
% otherwise it dies of loneliness or overcrowding. A dead cell comes to life 
% when it has exactly 3 living neighbors
tic

% Configuration
random = 1; % 1 for generating a random world
world = false(20, 20, 20); % x,y,z

if random~=0
    % generate random logical values (0 - 1)
    world = reshape(randi([0 1],1,numel(world)),...
            [size(world, 1) size(world, 2) size(world, 3)]);
    % clear boundaries
    world(1:size(world, 1), 1:size(world, 2), 1) = 0;
    world(1:size(world, 1), 1, 1:size(world, 3)) = 0;
    world(1, 1:size(world, 2), 1:size(world, 3)) = 0;
    world(1:size(world, 1), 1:size(world, 2), end) = 0;
    world(1:size(world, 1), end, 1:size(world, 3)) = 0;
    world(end, 1:size(world, 2), 1:size(world, 3)) = 0;
  
    world = logical(world); % Convert numeric values to logicals
    good_world = world; % save a copy of initial word
end

%% Render Initial World
for x=2:size(world, 1)-1
    for y=2:size(world, 2)-1
        for z=2:size(world, 3)-1
            if world(x,y,z)
                plotcube([1 1 1],[x  y  z],.8,[.3 .75 .93])
            end
        end
    end
end

xlabel('X')
ylabel('Y')
zlabel('Z')
view(3), axis vis3d
campos([100,100,100])
%%
for cycle=1:100
    pause(0.1);
    clf
    title(cycle)
    % Evolve
    world_buffer = world;
    for x=2:size(world, 1)-1
        for y=2:size(world, 2)-1
            for z=2:size(world, 3)-1          
                status = sum(sum(sum(world(x-1:x+1,y-1:y+1,z-1:z+1))));
                if world_buffer(x,y,z) % Check if living cell will survive               
                    if status >= 3 &&  status <= 4
                        world_buffer(x,y,z) = 1; % Survive
                    else
                        world_buffer(x,y,z) = 0; % Die
                    end
                else % Check if living cell will survive
                    if status == 3
                        world_buffer(x,y,z) = 1; % Cell is born
                    end
                end
            end
        end
    end
    world = world_buffer;

    for x=2:size(world, 1)-1
        for y=2:size(world, 2)-1
            for z=2:size(world, 3)-1
                if world(x,y,z)
                    plotcube([1 1 1],[x  y  z],.8,[.3 .75 .93])
                end
            end
        end
    end
    axis off
    view(3), axis vis3d
    campos([100,100,100])

end
toc
