function hungryzone()
hungry.world_horizontal=20;
hungry.world_vertical=20;
hungry.playing=1;
hungry.score=0;
hungry.world_box=figure();
hold on;
food_x=randi([0 hungry.world_horizontal], 1, 1);
food_y=randi([0 hungry.world_vertical], 1, 1);
hungry.body=plot(0, 0, 'k.', 'MarkerSize', 15);
hungry.snake_head=plot(0, 0,'co', 'MarkerSize', 5, 'LineWidth', 4);
hungry.food=plot(0, 0, 'm*', 'MarkerSize', 10, 'LineWidth', 2);
hungry.food_coord=[food_x food_y];
hungry.snake_parts=[hungry.world_horizontal/2  hungry.world_vertical/2;...
                  hungry.world_horizontal/2-1 hungry.world_vertical/2;...
                  hungry.world_horizontal/2-2 hungry.world_vertical/2];
hungry.snake_direction='E';
guidata(hungry.world_box, hungry);
world_box_initialization(hungry);
main_hungry (hungry);
end

function main_hungry (hungry)
while true
    hungry=guidata(hungry.world_box);
    hungry=snake_forward_movement (hungry);
    
    body_initialization (hungry);
    guidata (hungry.world_box, hungry);
    pause (0.3);
    if hungry.playing==0
        set (hungry.body, 'Color', 'r');
        msgbox(sprintf('Good bye, your score is %d', hungry.score), 'Game Over')
        break
    end
end
close all;
end

function world_box_initialization (hungry)
set (gcf, 'keypressfcn', @(src,eventdata)keyboard_input(src,eventdata));
xlim ([0, hungry.world_horizontal]);
ylim ([0, hungry.world_vertical]);
title ('Hungry Snake');
end

function body_initialization (hungry)
set (hungry.body, 'XData', hungry.snake_parts (:,1));
set (hungry.body, 'YData', hungry.snake_parts (:,2));
set (hungry.snake_head, 'XData', hungry.snake_parts (1,1));
set (hungry.snake_head, 'YData', hungry.snake_parts (1,2));
set (hungry.food, 'XData', hungry.food_coord (1,1));
set (hungry.food, 'YData', hungry.food_coord (1,2));
end

function hungry=snake_forward_movement (hungry)
difference=hungry.snake_parts (1,:) - hungry.snake_parts (2,:);
hungry.snake_parts (2:end,:)=hungry.snake_parts (1:end-1,:);
hungry.snake_parts (1,:)=hungry.snake_parts (1,:)+difference;
hungry=check_food(hungry);
hungry=check_collision(hungry);
end

function hungry=check_food (hungry)
if hungry.snake_parts(1,1)==hungry.food_coord(1,1) && hungry.snake_parts(1,2)==hungry.food_coord(1,2)
    food_x=randi([0 hungry.world_horizontal], 1, 1);
    food_y=randi([0 hungry.world_vertical], 1, 1);
    hungry.food_coord=[food_x food_y];
    hungry.snake_parts(end+1,:)=hungry.snake_parts(end,:)+( hungry.snake_parts(end,:)-hungry.snake_parts(end-1,:));
    hungry.score=hungry.score+1;
end
end

function hungry=check_collision (hungry)
overlap=sum(hungry.snake_parts(2:end,1)==hungry.snake_parts(1,1) &...
            hungry.snake_parts(2:end,2)==hungry.snake_parts(1,2));
boundary=sum(hungry.snake_parts(1,1)==hungry.world_horizontal+1 |...
             hungry.snake_parts(1,1)==-1 |...
             hungry.snake_parts(1,2)==hungry.world_vertical+1 |...
             hungry.snake_parts(1,2)==-1);
if overlap>0 || boundary>0
    hungry.playing=0;
end
end

function hungry=snake_right_movement (hungry)
hungry.snake_parts(2:end,:)=hungry.snake_parts(1:end-1,:);
if hungry.snake_direction=='E'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1) hungry.snake_parts(1,2)-1];
    hungry.snake_direction='S';
elseif hungry.snake_direction=='S'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1)-1 hungry.snake_parts(1,2)];
    hungry.snake_direction='W';
elseif hungry.snake_direction=='W';
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1) hungry.snake_parts(1,2)+1];
    hungry.snake_direction='N';
elseif hungry.snake_direction=='N'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1)+1 hungry.snake_parts(1,2)];
    hungry.snake_direction='E';
end
hungry=check_food(hungry);
hungry=check_collision(hungry);
end

function hungry=snake_left_movement (hungry)
hungry.snake_parts(2:end,:)=hungry.snake_parts(1:end-1,:);

if hungry.snake_direction=='E'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1) hungry.snake_parts(1,2)+1];
    hungry.snake_direction='N';
elseif hungry.snake_direction=='S'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1)+1 hungry.snake_parts(1,2)];
    hungry.snake_direction='E';
elseif hungry.snake_direction=='W';
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1) hungry.snake_parts(1,2)-1];
    hungry.snake_direction='S';
elseif hungry.snake_direction=='N'
    hungry.snake_parts(1,:)=[hungry.snake_parts(1,1)-1 hungry.snake_parts(1,2)];
    hungry.snake_direction='W';
end
hungry=check_food(hungry);
hungry=check_collision(hungry);
end

function keyboard_input(yo,yoyo)
hungry=guidata(yo);
switch yoyo.Key
    case 'rightarrow'
        if hungry.snake_direction=='N'
            hungry=snake_right_movement(hungry);
        elseif hungry.snake_direction=='S'
            hungry=snake_left_movement(hungry);
        elseif hungry.snake_direction=='E'
            hungry=snake_forward_movement(hungry);
        end
    case 'leftarrow'
        if hungry.snake_direction=='N'
            hungry=snake_left_movement(hungry);
        elseif hungry.snake_direction=='S'
            hungry=snake_right_movement(hungry);
        elseif hungry.snake_direction=='W'
            hungry=snake_forward_movement(hungry);
        end
    case 'uparrow'
        if hungry.snake_direction=='N'
            hungry=snake_forward_movement(hungry);
        elseif hungry.snake_direction=='E'
            hungry=snake_left_movement(hungry);
        elseif hungry.snake_direction=='W'
            hungry=snake_right_movement(hungry);
        end
    case 'downarrow'
        if hungry.snake_direction=='S'
            hungry=snake_forward_movement(hungry);
        elseif hungry.snake_direction=='E'
            hungry=snake_right_movement(hungry);
        elseif hungry.snake_direction=='W'
            hungry=snake_left_movement(hungry);
        end
    case 'escape'
        hungry.playing=0;
    otherwise
end
guidata(hungry.world_box, hungry);
body_initialization(hungry);
end
