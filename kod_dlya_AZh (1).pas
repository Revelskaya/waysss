uses GraphABC;
const kl=15;

var
  namefileint:integer;//для нумерации задач
  namefilestr:string;//для нумерации задач
  rfrm:integer;//количество используемых нами шаблонов
  rwayl:integer;//количество кусочков в генерируемом пути
  x1,y1,q,n,a,b:integer;
  task:integer;//количество задач, генерируемых по введённым данным
  numbf:array [1..10] of integer; //массив с номерами шаблонов
  frm:array of integer;//массив с используемыми нами шаблонами
var ak:integer; //номер задачки
    keyt:text; //переменная, связанная с файлом с ответами
 var p: Picture := new Picture(1200, 1000);

//рисует поле
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
procedure Af(x1,y1:integer);
 begin
   p.line(x1,y1,x1,y1+3*kl);
   p.line(x1,y1+3*kl,x1+2*kl,y1+3*kl);
   a:=x1+2*kl;
   b:=y1+3*kl;
 end;


// рисует шаблон B
procedure Bf(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl, x1+2*kl,y1+2*kl);
  p.line(x1+2*kl,y1+2*kl,x1+2*kl,y1);
  a:=x1+2*kl;
end;


// рисует шаблон C
procedure C(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl,x1+2*kl,y1+2*kl);
  a:=x1+2*kl;
  b:=y1+2*kl;
end;


// рисует шаблон D
procedure D(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+3*kl,y1-kl);
  p.line(x1+3*kl,y1-kl,x1+3*kl,y1-2*kl);
  p.line(x1+3*kl,y1-2*kl,x1+4*kl,y1-2*kl);
  a:=x1+4*kl;
  b:=y1-2*kl;
end;


// рисует шаблон E
procedure E(x1,y1:integer);
begin
  p.line(x1,y1,x1+kl,y1);
  p.line(x1+kl,y1,x1+kl,y1-kl);
  p.line(x1+kl,y1-kl,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+2*kl,y1-2*kl);
  p.line(x1+2*kl,y1-2*kl,x1+3*kl,y1-2*kl);
  a:=x1+3*kl;
  b:=y1-2*kl;
end;


// рисует шаблон F
procedure F(x1,y1:integer);
begin
  p.line(x1,y1,x1,y1+2*kl);
  p.line(x1,y1+2*kl,x1+kl,y1+2*kl);
  a:=x1+kl;
  b:=y1+2*kl;
end;

// рисует шаблон G
procedure G(x1,y1:integer);
begin
  p.line(x1,y1,x1+kl,y1);
  p.line(x1+kl,y1,x1+kl,y1-kl);
  p.line(x1+kl,y1-kl,x1+2*kl,y1-kl);
  a:=x1+2*kl;
  b:=y1-kl;
end;

// рисует шаблон H
procedure H(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+4*kl,y1-kl);
  p.line(x1+4*kl,y1-kl,x1+4*kl,y1);
  p.line(x1+4*kl,y1,x1+6*kl,y1);
  a:=x1+6*kl;
end;

// рисует шаблон I
procedure I(x1,y1:integer);
begin
  p.line(x1,y1,x1+2*kl,y1);
  p.line(x1+2*kl,y1,x1+2*kl,y1-kl);
  p.line(x1+2*kl,y1-kl,x1+4*kl,y1-kl);
  a:=x1+4*kl;
  b:=y1-kl;
end;

// рисует шаблон J
procedure J(x1,y1:integer);
begin
  p.line(x1,y1,x1+4*kl,y1);
  a:=x1+4*kl;
end;
  
// начальный вывод шаблонов 
procedure forms;
begin
  Af(kl,kl);
  Bf(4*kl,2*kl);
  C(8*kl,2*kl);
  D(11*kl,4*kl);
  E(15*kl,4*kl);
  F(19*kl,2*kl);
  G(21*kl,4*kl);
  H(24*kl,4*kl);
  I(31*kl,4*kl);
  J(36*kl,4*kl);
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

//определение номера текущей задачки
procedure key;
var st:string;
    stst:string;
begin
  assign(keyt,'keys.txt');
  reset(keyt);
  while EOF(keyt) = false do
  begin
    readln(keyt,st);
  end;
  for var xx:=1 to 4 do
  begin
    if st[xx]='.' then
    begin
      break;
    end
    else stst:=stst+st[xx];
    ak:=strtoint(stst)+1;
  end;
  
end;


//рисование пути 
procedure drawf(x1,y1:integer);
begin
    key;
    close(keyt);
    append(keyt);
    writeln(keyt, '');
    write(keyt,ak,'. ');
    
  for var z:=1 to rwayl do 
  begin
    q:=random(1,rfrm);//вот тут есть проблема:рандом совсем не рандомный
    
    //=!КРОК вывожу значения для проверки
    //p.TextOut(10+20*z,300,IntToStr(q));
    
    for var krk := 1 to random(1,500) do writeln(); //магия!
    //=!
    
    for var r2:=1 to rfrm do
    begin
      if q=r2 then q:=frm[r2];
    end;
    
    for var s:=1 to rfrm do
    begin
      if q=frm[s] then
      begin
      case frm[s] of
      1:begin
        Af(a,b);
        write(keyt,'A');
        end;
      2:begin
        Bf(a,b);
        write(keyt,'B'); 
        end;
      3:begin
        C(a,b);
        write(keyt,'C');
        end;
      4:begin
        D(a,b);
        write(keyt,'D'); 
        end;
      5:begin
        E(a,b);
        write(keyt,'E'); 
        end;
      6:begin
        F(a,b);
        write(keyt,'F'); 
        end;
      7:begin
        G(a,b);
        write(keyt,'G');
        end;
      8:begin
        H(a,b);
        write(keyt,'H'); 
        end;
      9:begin
        I(a,b);
        write(keyt,'I'); 
        end;
      10:begin
        J(a,b);
        write(keyt,'J');
        end;
      end;
      end;
    end;
    end;
    
    close(keyt);
end;

//названия шаблонов
procedure namef;
begin
  font.Size:= 13; 
  p.TextOut(2*kl,5*kl,'A'); 
  p.TextOut(5*kl,5*kl,'B'); 
  p.TextOut(8*kl,5*kl,'C'); 
  p.TextOut(13*kl,5*kl,'D'); 
  p.TextOut(16*kl,5*kl,'E'); 
  p.TextOut(19*kl,5*kl,'F'); 
  p.TextOut(22*kl,5*kl,'G'); 
  p.TextOut(26*kl,5*kl,'H'); 
  p.TextOut(33*kl,5*kl,'I'); 
  p.TextOut(38*kl,5*kl,'J'); 
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
    p.TextOut(500,place,str); //===!КРОК исправил - сделал текст поближе
                              //по хорошему надо бы определять масштаб и 
                              //текст ставить по краю клеточек
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



begin

  randomize; // ===!КРОК перенёс рандомайз сюда - прочитать как он работает
  
  writeln('How many forms do you want to use?');
  readln(rfrm);
  writeln('How long way do you want?');
  readln(rwayl);
  writeln('How many tasks?');
  readln(task);
  namefilestr:='1';
  for var taskk:=1 to task do
  begin
    p.Clear;
    field;
    pen.width:=3;
    forms;
    namef;
    a:=kl;
    b:=18*kl;
    way(a,b);
    rules;
    p.Draw(0,0);    
    p.Save(namefilestr+'.png'); 
    namefileint := strtoint(namefilestr)+1;
    namefilestr:=inttostr(namefileint);
  end;
end.
   
