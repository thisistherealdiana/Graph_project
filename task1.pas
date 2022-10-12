{$mode TP}
uses
    ptcgraph;

const
    COLOR=65535;
    GREEN=3840;
    RED=61440;
    BLUE=255;
    YELLOW=65472;
    ORANGE=64900;
    PURPLE=63519;
    
  
type
    TF = function(x: real): real;

var
    x0,y0,x,y,x_left,y_left,x_right,y_right,n: integer;
    a,b,f_min,f_max,x1,y1,mx,my,num: real;
    gd,gm:smallint;
    i:byte;
    s: string;
    
function f1 (x : real) : real;
begin
    f1:= 3*(0.5/(x+1)+1);
end;

function f2 (x : real) : real;
begin
    f2:= 2.5*x-9.5;
end;

function f3 (x : real) : real;
begin
    f3:= 5/x; {x>0}
end;


procedure drawfunc (f :TF; i :word);
var 
    x1, y1 :real;
    x, y :integer;
begin
    x1 := a;
   {if f = f3 then
        x1 := 0;}
    while x1 <= b do
    begin
        y1 := f(x1);
        x := x0 + round(x1 * mx);
        y := y0 - round(y1 * my);
        if (y >= y_left) and (y <= y_right) then
            PutPixel(x, y, i);
        x1 := x1 + 0.001
    end
end;


begin
    gd:=0;
    InitGraph(gd,gm,'');
    x_left:=50; //координаты левой верхней границы
    y_left:=50;
    x_right:=GetMaxX-50; //коррдинаты правой нижней границы
    y_right:=GetMaxX-50;
    
    a := -15; b := 15;
    f_min := -15; f_max := 15;
    mx := (x_right - x_left) / (b - a); //масштаб по х
    my := (y_right - y_left) / (f_max - f_min); //масштаб по у
    //начало координат
    x0 := trunc(abs(a) * mx) + x_left;
    y0 := y_right - trunc(abs(f_min) * my);
    //оси
    SetColor(COLOR);
    line(x_left, y0, x_right + 10, y0);
    line(x0, y_left - 10, x0, y_right);
    SetColor(COLOR);
    SetTextStyle(0, 0, 1);
    OutTextXY(x_right + 20, y0 - 15, 'X');
    OutTextXY(x0 - 15, y_left - 35, 'Y');
    SetColor(COLOR);
    //штрихи на х
    n := round(b - a) + 1;
    for i := 1 to n do
    begin
        num := a + (i - 1);
        x := x_left + trunc(mx * (num - a));        
        Line(x, y0 - 3, x, y0 + 3);
        str(num:0:1, s);        
        if abs(num) > 0 then
            OutTextXY(x - TextWidth(s) div 2, y0 + 10, s)
    end;
    //штрихи на у 
    n := round(f_max - f_min) + 1;
    for i := 1 to n do
    begin
        num := f_Min + (i - 1);
        y := y_right - trunc(my * (num - f_min));        
        Line(x0 - 3, y, x0 + 3, y);
        str(num:0:0, s);        
        if abs(num) > 0 then
            OutTextXY(x0 + 10, y - TextHeight(s) div 2, s)
    end;
    
    x1 := 1.0;
    while x1 < 6.0 do
    begin
        y1 := 1.0;
        while y1 < 4.0 do
        begin
            if (y1 < f1(x1)) and (y1 > f2(x1)) and (y1 > f3(x1)) then
            begin
                x := x0 + round (x1 * mx);
                y := y0 - round (y1 * my);
                PutPixel (x, y, ORANGE)
            end;
            y1 := y1 + 0.01
        end;
        x1 := x1 + 0.01
    end;
    x1 := 1.377;
    y1 := f1(x1);
    x := x0 + round (x1 * mx) - 10;
    y := y0 - round (y1 * my) + 10;
    OutTextXY(x, y, 'x1');
    x1 := 4.257;
    y1 := f2(x1);
    x := x0 + round (x1 * mx) + 10;
    y := y0 - round (y1 * my) + 10;
    OutTextXY(x, y, 'x2');
    x1 := 5.098;
    y1 := f3(x1);
    x := x0 + round (x1 * mx);
    y := y0 - round (y1 * my) - 80;
    OutTextXY(x, y, 'x3');
    OutTextXY(x0 - 10, y0 + 10, '0');
    drawfunc (f1, GREEN);
    drawfunc (f2, RED);
    drawfunc (f3, BLUE);
    SetColor(GREEN);
    OutTextXY(GetMaxX - 250, 50, 'f1 = 3 * (0.5 / (x + 1) + 1)');
    SetColor(RED);
    OutTextXY(GetMaxX - 250, 70, 'f2 = 2.5 * x - 9.5');
    SetColor(BLUE);
    OutTextXY(GetMaxX - 250, 90, 'f3 = 5 / x');
    SetColor(YELLOW);
    OutTextXY(x_left + 10, 10, 'x1 = 1.377');
    OutTextXY(x_left + 10, 30, 'x2 = 4.257');
    OutTextXY(x_left + 10, 50, 'x3 = 5.098');
    OutTextXY(x_left + 10, 70, 'S = 5.087');
    SetColor(PURPLE);
    x1 := 1.377;
    y1 := f1(x1);
    x := x0 + round (x1 * mx)+70;
    y := y0 - round (y1 * my) + 50;
    OutTextXY(x,y,'S');
    readln
end.
