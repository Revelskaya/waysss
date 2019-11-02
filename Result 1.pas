uses GraphABC;


var
  prq:integer;
  ans:string;//ответ на первый вопрос
  kl:integer;//масштаб
  namefileint:integer;//для нумерации задач
  namefilestr:string;//для нумерации задач
  rfrm:integer;//количество используемых нами шаблонов
  rwayl:integer;//количество кусочков в генерируемом пути
  x1,y1,q,n,a1,b1:integer;
  task:integer;//количество задач, генерируемых по введённым данным
  numbf:array [1..10] of integer; //массив с номерами шаблонов
  frm:array of integer;//массив с используемыми нами шаблонами
var ak:integer; //номер задачки
    keyt,par:text; 
 var p: Picture := new Picture(1200, 1000);

//поле
procedure field; 
begin
  pen.Width:= 1;
  GraphABC.SetPenColor(GraphABC.RGB(179, 179, 179));
  for var z:=1 to 43 do
  begin
    p.line(z*kl,0,z*kl,35*kl);
  end;
  for var v:=1 to 35 do
  begin
    p.line(0, v*kl, 43*kl,v*kl);
  end;
  
  setPenColor(clblack);
end;

// рисует шаблон A
procedure A(x1,y1:integer);
 begin
   p.line(x1,y1,x1,y1+3*kl);
   p.line(x1,y1+3*kl,x1+2*kl,y1+3*kl);
   a1:=x1+2*kl;
   b1:=y1+3*kl;
 end;


// рисует шаблон B
procedure B(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl, x1+2*kl,y1+2*kl);
  p.line(x1+2*kl,y1+2*kl,x1+2*kl,y1);
  a1:=x1+2*kl;
end;


// рисует шаблон C
procedure C(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl,x1+2*kl,y1+2*kl);
  a1:=x1+2*kl;
  b1:=y1+2*kl;
end;


// рисует шаблон D
procedure D(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+3*kl,y1-kl);
  p.line(x1+3*kl,y1-kl,x1+3*kl,y1-2*kl);
  p.line(x1+3*kl,y1-2*kl,x1+4*kl,y1-2*kl);
  a1:=x1+4*kl;
  b1:=y1-2*kl;
end;


// рисует шаблон E
procedure E(x1,y1:integer);
begin
  p.line(x1,y1,x1+kl,y1);
  p.line(x1+kl,y1,x1+kl,y1-kl);
  p.line(x1+kl,y1-kl,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+2*kl,y1-2*kl);
  p.line(x1+2*kl,y1-2*kl,x1+3*kl,y1-2*kl);
  a1:=x1+3*kl;
  b1:=y1-2*kl;
end;


// рисует шаблон F
procedure F(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl,x1+kl,y1+2*kl);
  a1:=x1+kl;
  b1:=y1+2*kl;
end;

// рисует шаблон G
procedure G(x1,y1:integer);
begin
  p.line(x1,y1,x1+kl,y1);
  p.line(x1+kl,y1,x1+kl,y1-kl);
  p.line(x1+kl,y1-kl,x1+2*kl,y1-kl);
  a1:=x1+2*kl;
  b1:=y1-kl;
end;

// рисует шаблон H
procedure H(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+4*kl,y1-kl);
  p.line(x1+4*kl,y1-kl,x1+4*kl,y1);
  p.line(x1+4*kl,y1,x1+6*kl,y1);
  a1:=x1+6*kl;
end;

// рисует шаблон I
procedure I(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+4*kl,y1-kl);
  a1:=x1+4*kl;
  b1:=y1-kl;
end;

// рисует шаблон J
procedure J(x1,y1:integer);
begin
  p.line(x1,y1,x1+4*kl,y1);
  a1:=x1+4*kl;
end;
  
// начальный вывод шаблонов 
procedure forms;
begin
  A(3*kl,kl);
  B(6*kl,2*kl);
  C(10*kl,2*kl);
  D(13*kl,4*kl);
  E(17*kl,4*kl);
  F(21*kl,2*kl);
  G(23*kl,4*kl);
  H(26*kl,4*kl);
  I(33*kl,4*kl);
  J(38*kl,4*kl);
end;

//выбор шаблонов, которые мы будем использовать в дальнейшем
procedure testform;
var l:integer;
begin
  setlength(frm,rfrm+1);
  l:=random(1,10);
  for var k:=1 to 10 do
  begin
    if l=numbf[k] then testform;
  end;
  for var k:=1 to 10 do
  begin
    if l=k then numbf[k]:=l;
  end;
  n:=n+1;
  if n<rfrm then testform;
end;

//поиск выбранных нами шаблонов и перенесение их в специальный для них массив
procedure findf;
begin
  for var x:=1 to rfrm do
  begin
    for var t:=1 to 10 do
    begin
      if numbf[t]>0 then 
      begin
        frm[x]:=numbf[t];
        numbf[t]:=0;
        break;
      end;
    end;
  end;
end;


procedure key;
var st:string;
begin
  assign(keyt,'keys.txt');
  reset(keyt);
  readln(keyt,st);
  close(keyt);
  append(keyt);
  if length(st)<>0 then 
  begin
    writeln(keyt, '');
  end;
  write(keyt,ak,'. ');
  p.TextOut(kl,kl,inttostr(ak));
  ak:=ak+1;
    
  
  
end;

procedure check; //это процедура, предохраняющая от повторов 
begin
  repeat
    q:=random(1,rfrm);
  Until q<>prq;
  prq:=q;
end;


//рисование пути 
procedure drawf(x1,y1:integer);
begin
  prq:=1;
  key;
    
  for var z:=1 to rwayl do 
  begin
    check;
    for var r2:=1 to rfrm do
    begin
      if q=r2 then 
      begin
        q:=frm[r2];
        case frm[r2] of
        1:begin
          A(a1,b1);
          write(keyt,'A');
          end;
        2:begin
          B(a1,b1);
          write(keyt,'B'); 
          end;
        3:begin
          C(a1,b1);
          write(keyt,'C');
          end;
        4:begin
          D(a1,b1);
          write(keyt,'D'); 
          end;
        5:begin
          E(a1,b1);
          write(keyt,'E'); 
          end;
        6:begin
          F(a1,b1);
          write(keyt,'F'); 
          end;
        7:begin
          G(a1,b1);
          write(keyt,'G');
          end;
        8:begin
          H(a1,b1);
          write(keyt,'H'); 
          end;
        9:begin
          I(a1,b1);
          write(keyt,'I'); 
          end;
        10:begin
          J(a1,b1);
          write(keyt,'J');
          end;
        end;
      break;
      end;
    end;
    end;
    close(keyt);
end;


//названия шаблонов
procedure namef;
begin
  font.Size:= 13; 
  p.TextOut(3*kl,5*kl,'A'); 
  p.TextOut(7*kl,5*kl,'B'); 
  p.TextOut(10*kl,5*kl,'C'); 
  p.TextOut(15*kl,5*kl,'D'); 
  p.TextOut(18*kl,5*kl,'E'); 
  p.TextOut(21*kl,5*kl,'F'); 
  p.TextOut(24*kl,5*kl,'G'); 
  p.TextOut(28*kl,5*kl,'H'); 
  p.TextOut(35*kl,5*kl,'I'); 
  p.TextOut(40*kl,5*kl,'J'); 
end;


//вывод правил
procedure rules;
var trw:text;
    str:string;
    place:integer;
begin
  place:=kl;
  assign(trw,'file.txt');
  reset(trw);
  while EOF(trw)=false do
  begin
    readln(trw, str);
    font.Size:= 10; 
    p.TextOut(43*kl,place,str); 
    place:=place+20;
  end;
  close(trw);
end;

// совокупность процедур для вывода пути
procedure way(x1,y1:integer);
begin
  testform;
  findf;
  drawf(x1,y1);
end;

procedure parameter;
var st:string;
    i,i3,pr:integer;
begin
  assign(par,'Parameters.txt');
  reset(par);
  while EOF(par) = false do
  begin
    i:=i+1;
    readln(par,st);
    for var i2:=1 to length(st) do
    begin
      if st[i2]='=' then
      begin
        pr:=strtoint(copy(st,i2+1,length(st)-i2));
        break;
      end;
      
    end;
    case i of
      1:
      begin
      task:=pr;
      writeln(task);
      end;
      2:begin
      kl:=pr;
      writeln(kl);
      end;
      3:rfrm:=pr;
      4:rwayl:=pr;
      5:ak:=pr
    end;
  end;
  close(par);
end;
//запись в файл изменённых параметров
procedure parameter2;
var par2:text;
    str22:string;
begin
  assign(par2,'Parameters.txt');
  rewrite(par2);
  writeln('Сколько задач вы хотите сгенерировать?');
  readln(task);
  write(par2,'Количество задач=');
  writeln(par2,task);
  writeln('Какой масштаб вы хотите использовать?');
  readln(kl);
  write(par2,'Масштаб=');
  writeln(par2,kl);
  writeln('Сколько шаблонов из десяти вы хотите использовать?');
  readln(rfrm);
  write(par2,'Количество используемых шаблонов=');
  writeln(par2,rfrm);
  writeln('Путь какой длины вы хотите?');
  readln(rwayl);
  write(par2,'Длина пути=');
  writeln(par2,rwayl);
  writeln('С какого номера вы хотите начать отсчёт?');
  readln(ak);
  write(par2,'Начальный номер=');
  writeln(par2,ak);
  close(par2);
end;


begin

  randomize;
  writeln('Хотите ли вы использовать параметры из файла?');
  readln(ans);
  if ans='нет' then parameter2
  else parameter;
  assign(keyt,'keys.txt');
  rewrite(keyt);
  close(keyt);
  namefilestr:='1';
  for var taskk:=1 to task do
  begin
    p.Clear;
    field;
    pen.width:=3;
    forms;
    namef;
    a1:=kl;
    b1:=18*kl;
    way(a1,b1);
    rules;
    p.Draw(0,0);    
    p.Save(namefilestr+'.png'); 
    namefileint := strtoint(namefilestr)+1;
    namefilestr:=inttostr(namefileint);  
  end;
end.