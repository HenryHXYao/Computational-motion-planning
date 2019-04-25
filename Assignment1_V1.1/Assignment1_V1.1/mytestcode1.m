clc
clear

input_map = false(10);

% Add an obstacle
input_map (1:5, 6) = true;

start_coords = [6, 2];
dest_coords  = [8, 9];

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0; ...
	0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distanceFromStart = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distanceFromStart(start_node) = 0;

% image(1.5, 1.5, map);
% grid on;
% axis image;
% drawnow;

% keep track of number of nodes expanded 
numExpanded = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distanceFromStart(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;    
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current);
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
    
    for k = i-1:2:i+1
        if k <1 ||  k >nrows || map(k,j) ==2 || map(k,j) ==3 || map(k,j) ==5
            continue
        else
            if distanceFromStart(k,j) > distanceFromStart(current) + 1                
                distanceFromStart(k,j) = distanceFromStart(current) + 1;
                parent(k,j) = current;
                map(k,j) = 4;       
            end                                  
        end                                
    end
    
    for k = j-1:2:j+1
        if k <1 ||  k >ncols  || map(i,k) ==2 || map(i,k) ==3 || map(i,k) ==5
            continue
        else
            if distanceFromStart(i,k) > distanceFromStart(current) + 1                
                distanceFromStart(i,k) = distanceFromStart(current) + 1;
                parent(i,k) = current;
                map(i,k) = 4;       
            end                                  
        end                                
    end    
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    
    % Update map
    map(current) = 3;         % mark current node as visited      
    distanceFromStart(current) = Inf; % remove this node from further consideration     

    %*********************************************************************

end

%% Construct route from start to dest by following the parent links
if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
    
        % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end