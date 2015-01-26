%% 定义单位长度以及输出格式
u := 1cm;
outputtemplate := "%j%c.eps";

beginfig(1);
draw (0,0) -- (4u,0) -- (2u,2u) -- (0,0)
withpen pencircle scaled .8pt;
%更改笔的
pickup pencircle scaled .8pt;
draw (5u,0) -- (9u,0) -- (7u,2u)--cycle;
pickup pencircle scaled 2pt;
drawdot (10u,0);
drawdot (14u,0);
drawdot (12u,2u);
endfig;

beginfig(2)
    pair A, B, C;
    A:=(0,0); B:=(1cm,0); C:=(0,1cm);
    draw A--B--C--cycle;
endfig;

beginfig(4)
  pair A, B, C;
  A:=(0,0); B:=(1cm,0); C:=(0,1cm);
  draw A--B--C--cycle;
  draw 1/2[A,B] -- C;
  draw 1/2[B,C] -- A;
  draw 1/2[C,A] -- B;
  draw 1/3 A + 1/3 B + 1/3 C
       withpen pencircle scaled 2bp withcolor red;
endfig;
bye
