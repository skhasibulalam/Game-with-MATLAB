function spacezone()
space.world_horizontal=10;
space.world_vertical=20;
space.playing=1;
space.score=0;
space.world_box=figure();
hold on;
enemy_x=randi([0 space.world_horizontal], 1, 1);
space.enemy_body=plot(0, 0, 'rv', 'MarkerSize', 10, 'LineWidth', 5);
space.ship_body=plot(0, 0,'b^', 'MarkerSize', 15, 'LineWidth', 2);
space.missile_body=plot(0, 0, 'k.', 'MarkerSize', 15);

space.ship_part=[space.world_horizontal/2 1];
space.missile_part=[space.ship_part(1,1) space.ship_part(1,2);...
                  space.ship_part(1,1)-1 space.ship_part(1,2)-2;...
                  space.ship_part(1,1)+1 space.ship_part(1,2)-4;...
                  space.ship_part(1,1)-2 space.ship_part(1,2)-6;...
                  space.ship_part(1,1)+2 space.ship_part(1,2)-8;...
                  space.ship_part(1,1)-3 space.ship_part(1,2)-10;...
                  space.ship_part(1,1)+3 space.ship_part(1,2)-12;...
                  space.ship_part(1,1)-4 space.ship_part(1,2)-14;...
                  space.ship_part(1,1)+4 space.ship_part(1,2)-16;...
                  space.ship_part(1,1)-5 space.ship_part(1,2)-18;...
                  space.ship_part(1,1)+5 space.ship_part(1,2)-20];
space.enemy_part=[enemy_x space.world_vertical;...
                enemy_x space.world_vertical-1;...
                enemy_x space.world_vertical-2];
guidata(space.world_box, space);
world_box_initialization(space);
main_game (space);
end

function main_game (space)
while true
    space=guidata(space.world_box);
    space=ship_missile(space);
    body_initialization (space);
    space=enemy_downward_movement (space);
    space=ship_missile(space);
    
    guidata (space.world_box, space);
    pause (0.2);
    if space.playing==0
        msgbox(sprintf('Good bye, your score is %d', space.score), 'Game Over')
        break
    end
end
close all;
end

function world_box_initialization (space)
set (gcf, 'keypressfcn', @(src,eventdata)keyboard_input(src,eventdata));
xlim ([0, space.world_horizontal]);
ylim ([0, space.world_vertical]);
title ('Space Impact');
end

function body_initialization (space)
set (space.enemy_body, 'XData', space.enemy_part (:,1));
set (space.enemy_body, 'YData', space.enemy_part (:,2));
set (space.ship_body, 'XData', space.ship_part (1,1));
set (space.ship_body, 'YData', space.ship_part (1,2));
set (space.missile_body, 'XData', space.missile_part(:,1));
set (space.missile_body, 'YData', space.missile_part(:,2));
end

function space=enemy_downward_movement (space)
space.enemy_part (1:end,2)=space.enemy_part(1:end,2) - 1;
space=check_wall (space);
space=check_missile_collision(space);
end

function space=check_missile_collision (space)
if space.enemy_part(1,1)==space.missile_part(1,1) && ((space.missile_part(1,2)==space.enemy_part(1,2))||(space.missile_part(1,2)==space.enemy_part(2,2))||(space.missile_part(1,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(2,1) && ((space.missile_part(2,2)==space.enemy_part(1,2))||(space.missile_part(2,2)==space.enemy_part(2,2))||(space.missile_part(2,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(3,1) && ((space.missile_part(3,2)==space.enemy_part(1,2))||(space.missile_part(3,2)==space.enemy_part(2,2))||(space.missile_part(3,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(4,1) && ((space.missile_part(4,2)==space.enemy_part(1,2))||(space.missile_part(4,2)==space.enemy_part(2,2))||(space.missile_part(4,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(5,1) && ((space.missile_part(5,2)==space.enemy_part(1,2))||(space.missile_part(5,2)==space.enemy_part(2,2))||(space.missile_part(5,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(6,1) && ((space.missile_part(6,2)==space.enemy_part(1,2))||(space.missile_part(6,2)==space.enemy_part(2,2))||(space.missile_part(6,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(7,1) && ((space.missile_part(7,2)==space.enemy_part(1,2))||(space.missile_part(7,2)==space.enemy_part(2,2))||(space.missile_part(7,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(8,1) && ((space.missile_part(8,2)==space.enemy_part(1,2))||(space.missile_part(8,2)==space.enemy_part(2,2))||(space.missile_part(8,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(9,1) && ((space.missile_part(9,2)==space.enemy_part(1,2))||(space.missile_part(9,2)==space.enemy_part(2,2))||(space.missile_part(9,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
elseif space.enemy_part(1,1)==space.missile_part(10,1) && ((space.missile_part(10,2)==space.enemy_part(1,2))||(space.missile_part(10,2)==space.enemy_part(2,2))||(space.missile_part(10,2)==space.enemy_part(3,2)))
    enemy_x=randi([0 space.world_horizontal], 1, 1);
    space.enemy_part=[enemy_x space.world_vertical; enemy_x space.world_vertical-1; enemy_x space.world_vertical-2];
    space.score=space.score+1;
end
end

function space=ship_missile (space)
space.missile_part(1:end,2)=space.missile_part(1:end,2)+2;

if space.missile_part(1,2)>space.world_vertical
    space.missile_part(1,1)=space.ship_part(1,1);
    space.missile_part(1,2)=space.ship_part(1,2);
elseif space.missile_part(2,2)>space.world_vertical
    space.missile_part(2,1)=space.ship_part(1,1);
    space.missile_part(2,2)=space.ship_part(1,2);
elseif space.missile_part(3,2)>space.world_vertical
    space.missile_part(3,1)=space.ship_part(1,1);
    space.missile_part(3,2)=space.ship_part(1,2);
elseif space.missile_part(4,2)>space.world_vertical
    space.missile_part(4,1)=space.ship_part(1,1);
    space.missile_part(4,2)=space.ship_part(1,2);
elseif space.missile_part(5,2)>space.world_vertical
    space.missile_part(5,1)=space.ship_part(1,1);
    space.missile_part(5,2)=space.ship_part(1,2);
elseif space.missile_part(6,2)>space.world_vertical
    space.missile_part(6,1)=space.ship_part(1,1);
    space.missile_part(6,2)=space.ship_part(1,2);
elseif space.missile_part(7,2)>space.world_vertical
    space.missile_part(7,1)=space.ship_part(1,1);
    space.missile_part(7,2)=space.ship_part(1,2);
elseif space.missile_part(8,2)>space.world_vertical
    space.missile_part(8,1)=space.ship_part(1,1);
    space.missile_part(8,2)=space.ship_part(1,2);
elseif space.missile_part(9,2)>space.world_vertical
    space.missile_part(9,1)=space.ship_part(1,1);
    space.missile_part(9,2)=space.ship_part(1,2);
elseif space.missile_part(10,2)>space.world_vertical
    space.missile_part(10,1)=space.ship_part(1,1);
    space.missile_part(10,2)=space.ship_part(1,2);
end
end

function space=ship_up_movement (space)
space.ship_part (1,2)=space.ship_part (1,2)+1;
space=check_wall (space);
end

function space=ship_down_movement (space)
space.ship_part (1,2)=space.ship_part (1,2)-1;
space=check_wall (space);
end

function space=ship_right_movement (space)
space.ship_part (1,1)=space.ship_part (1,1)+1;
space=check_wall (space);
end

function space=ship_left_movement (space)
space.ship_part (1,1)=space.ship_part (1,1)-1;
space=check_wall (space);
end

function space=check_wall (space)
if space.ship_part (1,2)>=space.world_vertical-2
    space.ship_part (1,2)=space.world_vertical-2;
elseif space.ship_part (1,2)<0
    space.ship_part (1,2)=0;
elseif space.ship_part (1,1)>=space.world_horizontal+1;
    space.ship_part (1,1)=space.world_horizontal;
elseif space.ship_part (1,1)<0;
    space.ship_part (1,1)=0;
end

if space.enemy_part (3,2)<=space.ship_part (1,2)
    space.playing=0;
end
end

function keyboard_input(yo,yoyo)
space=guidata(yo);
switch yoyo.Key
    case 'rightarrow'
        space=ship_right_movement(space);
    case 'leftarrow'
        space=ship_left_movement(space);
    case 'uparrow'
        space=ship_up_movement(space);
    case 'downarrow'
        space=ship_down_movement(space);
    case 'escape'
        space.playing=0;
    otherwise
end
guidata(space.world_box, space);
body_initialization(space);
end