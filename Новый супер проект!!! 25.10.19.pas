uses graphABC;

Type 
  Form=record
    Name: char;
    sizex: integer;
    sizey: integer;
    path: array of integer;
  end;
const pwdth=3;  
const kl=15;
var s:string; 
    mas:array of string; 
    forms:array of form; 
    m,i,k:integer; 
    wayt:text;
    x,y:integer;
var p: Picture := new Picture(GraphABC.Window.Width, GraphABC.Window.Height);

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
 // writeln(mas);
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
  if forms[k].sizey<0 then forms[k].sizey:=forms[k].sizey*(-1);
  if forms[k].sizex<0 then forms[k].sizex:=forms[k].sizex*(-1);
 forms[k].Name:=chr(65+k);
 //writeln(forms[k].path, ' ', forms[k].Name, ' ', forms[k].sizey, ' ', forms[k].sizex); 
 k := k+1;
 end;
 close(wayt);
end;


procedure field; 
var xfield,yfield:integer;
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
 // writeln(xfield);
  for var n1:=0 to length(forms)-1 do
  begin
    if forms[n1].sizey>yfield then yfield:=forms[n1].sizey;
  end;
  yfield:=yfield*11+1;
 // writeln(yfield);
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
  

procedure drawrec(x1,y1,kdr:integer);
  begin
    x1:=x1*kl;
    y1:=y1*kl;
    GraphABC.SetPenWidth(pwdth);
    for var n1:=0 to round(forms[kdr].path.Length/2)-1 do
    begin
      var cur := n1*2;
      GraphABC.Line(x1,y1,x1+forms[kdr].path[cur]*kl,y1-forms[kdr].path[cur+1]*kl);
      x1:=x1+forms[kdr].path[cur]*kl;
      y1:=y1-forms[kdr].path[cur+1]*kl;
    end;
    x:=round(x1/kl);
    y:=round(y1/kl);
  end;

procedure startform;
  begin
    x:=3;
    for var n2:=0 to length(forms)-1 do
      begin
        if forms[n2].sizey>y then y:=forms[n2].sizey;
      end;
    y:=y+1;
    for var n2:=0 to forms.Length-1 do
    begin
      drawrec(x,y-forms[n2].sizey,n2);
      font.size:=13; //почему-то это не работает
      p.TextOut(x,y,forms[n2].Name);//то есть это
      x:=x+1;
    end;
  end;
 
begin
  recin;
  field;
  p.Draw(0,0);    
  p.Save('1.png'); 
  //drawrec(1,4,2);
  startform;
end.