uses graphABC;

Type 
  Form=record
    Name: char;
    sizex: integer;
    sizey: integer;
    path: array of integer;
    choice: boolean;
  end;
  
  
const pwdth=3;  

var n:integer;//счетчик в testform
var ans:string;//ответ на первый вопрос
    a1,b1:integer;
var s:string; 
    mas:array of string; 
    forms:array of form; 
    m,i,k:integer; 
    wayt:text;
    x,y:integer; //координаты
    xfield,yfield:integer;
    frm:array of integer;//массив с используемыми нами шаблонами
    rfrm:integer;//количество используемых нами шаблонов
    rwayl:integer;//количество кусочков в генерируемом пути
    keyt:text;
    ak:integer;//номер задачки
    q,prq:integer;//в проверке
    par:text; 
    task:integer;//количество задач, генерируемых по введённым данным
    kl:integer;//масштаб
var p: Picture := new Picture(1280, 1024);

procedure recin;
begin
 assign(wayt,'waytext.txt');
 reset(wayt);
 while EOF(wayt)=false do
 begin
   readln(wayt,s);
   i:=i+1;
 end;
 close(wayt);
 setlength(forms,i);
 assign(wayt,'waytext.txt');
 reset(wayt);
 while EOF(wayt)=false do
 begin
  readln(wayt,s);
  mas:=s.Split('(',';',')');
  setlength(forms[k].path,round((length(mas)-1)/3*2));
  m:=0;
  for var n:=0 to length(mas)-1 do
  begin
     if mas[n] <> '' then
    begin
      forms[k].path[m]:=strtoint(mas[n]);
      m:=m+1;
    end;
  end;
  for var n1:=0 to length(forms[k].path)-1 do
      begin
        if (n1 mod 2)=0 then
        begin
          forms[k].sizex:=forms[k].sizex+forms[k].path[n1];
        end
        else
        begin
          forms[k].sizey:=forms[k].sizey+forms[k].path[n1]
        end;
      end;
  if forms[k].sizex<0 then forms[k].sizex:=forms[k].sizex*(-1);
 forms[k].Name:=chr(65+k);
 k := k+1;
 end;
 close(wayt);
end;


procedure field; 
begin
  pen.Width:= 1;
  GraphABC.SetPenColor(GraphABC.RGB(179, 179, 179));
  xfield:=0;
  yfield:=0;
  for var n1:=0 to length(forms)-1 do
  begin
    xfield:=xfield+forms[n1].sizex+1;
  end;
  xfield:=xfield+3;
  for var n1:=0 to length(forms)-1 do
  begin
    if forms[n1].sizey<0 then
    begin
      if forms[n1].sizey*(-1)>yfield then yfield:=forms[n1].sizey*(-1);
    end
    else
    begin
      if forms[n1].sizey>yfield then yfield:=forms[n1].sizey;
    end;
  end;
  yfield:=yfield*11+1;
  for var z:=1 to xfield do
  begin
    p.line(z*kl,0,z*kl,yfield*kl);
  end;
  for var v:=1 to yfield do
  begin
    p.line(0, v*kl, xfield*kl,v*kl);
  end;
  setPenColor(clblack);
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
    p.TextOut(xfield*kl,place,str); 
    place:=place+20;
  end;
  close(trw);
end;
  

procedure drawrec(x1,y1,kdr:integer);
  begin
    x1:=x1*kl;
    y1:=y1*kl;
    GraphABC.SetPenWidth(pwdth);
    for var n1:=0 to round(forms[kdr].path.Length/2)-1 do
    begin
      var cur := n1*2;
      p.Line(x1,y1,x1+forms[kdr].path[cur]*kl,y1-forms[kdr].path[cur+1]*kl);
      x1:=x1+forms[kdr].path[cur]*kl;
      y1:=y1-forms[kdr].path[cur+1]*kl;
    end;
    x:=round(x1/kl);
    y:=round(y1/kl);
  end;

procedure startform;
var yy:integer;
  begin
    y:=0;
    x:=3;
    for var n2:=0 to length(forms)-1 do
      begin
        if forms[n2].sizey<0 then 
          begin
          if forms[n2].sizey*(-1)>y then y:=forms[n2].sizey*(-1);
          end
        else
          begin
          if forms[n2].sizey>y then y:=forms[n2].sizey;
          end;
      end;
    y:=y+1;
    yy:=y;
    for var n2:=0 to forms.Length-1 do
    begin
      font.size:=13; 
      p.TextOut(x*kl,y*kl,forms[n2].Name);
      if forms[n2].sizey>0 then 
      begin
        drawrec(x,y,n2);
      end
      else
      begin
        drawrec(x,y+forms[n2].sizey,n2);
      end;
      y:=yy;
      x:=x+1;
    end;
  end;


  
//выбор шаблонов, которые мы будем использовать 
procedure testform;
var l:integer;
begin
  setlength(frm,rfrm);
  l:=random(length(forms));//// в этой строке переполнение стека
  if forms[l].choice=true then testform
  else forms[l].choice:=true;
  n:=n+1;
  if n<rfrm then testform;
end;

//поиск выбранных нами шаблонов и перенесение их номеров в специальный для них массив
procedure findf;
begin
  for var n1:=0 to rfrm-1 do
  begin
    for var n2:=0 to length(forms)-1 do
    begin
      if forms[n2].choice=true then 
      begin
        frm[n1]:=n2;
        forms[n2].choice:=false;
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
  p.TextOut(kl,2*kl,inttostr(ak));
  ak:=ak+1;
end;

procedure check;//вечная проблема
begin
  repeat
    q:=random(0,rfrm-1);
  Until q<>prq;
  prq:=q;
end;


//рисование пути 
procedure drawf(x2,y2:integer);
begin
  x:=x2;
  y:=y2;
  prq:=1;
  key;
  for var z:=1 to rwayl do 
  begin
    check;
    for var r2:=0 to rfrm-1 do
    begin
      if q=r2 then 
      begin
        var xxx:=x;
        var yyy:=y;
        drawrec(x,y,frm[q]);
        
        if x>xfield then  //искусственное увеличение поля
        begin
          while x>xfield do
          begin
            pen.Width:= 1;
            GraphABC.SetPenColor(GraphABC.RGB(179, 179, 179));
            for var yfy:=1 to yfield do
            begin
              p.Line(xfield*kl,yfy*kl,(xfield+1)*kl,yfy*kl);
            end;
            p.Line((xfield+1)*kl,0,(xfield+1)*kl,yfield*kl);
            xfield:=xfield+1;
            setPenColor(clblack);
            drawrec(xxx,yyy,frm[q]);
          end;
        end;

        write(keyt,forms[frm[q]].name);
        break;
      end;
    end;
    end;
    close(keyt);
end;


procedure way(x1,y1:integer);
begin
  testform;
  findf;
  drawf(x1,y1);
end;


procedure parameter;
var st:string;
    i,pr:integer;
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
      1:task:=pr;
      2:kl:=pr;
      3:rfrm:=pr;
      4:rwayl:=pr;
      5:ak:=pr;
    end;
  end;
  close(par);
end;

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
  writeln('Сколько шаблонов вы хотите использовать?');
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
  window.Height:=1024;
  window.Width:=1280;
  recin;
  randomize; 
  writeln('Хотите ли вы использовать параметры из файла?');
  readln(ans);
  if ans='нет' then parameter2
  else parameter;
  assign(keyt,'keys.txt');
  rewrite(keyt);
  close(keyt);
  for var taskk:=1 to task do
  begin
    p.Clear;
    field;
    pen.width:=3;
    startform;
    a1:=1;
    b1:=yfield div 3;
    way(a1,b1);
    rules;
    p.Draw(0,0); 
    p.Save(inttostr(ak-1)+'.png');
  end;
end.
