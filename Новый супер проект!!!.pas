Type 
  Form=record
    Name: char;
    sizex: integer;
    sizey: integer;
    path: array of integer;
  end;
  

var s:string; 
    mas:array of string; 
    forms:array of form; 
    n,m,i,k:integer; 
    wayt:text;
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
  writeln(mas);
  setlength(forms[k].path,round((length(mas)-1)/3*2));
  m:=0;
  for n:=0 to length(mas)-1 do
  begin
     if mas[n] <> '' then
    begin
      forms[k].path[m]:=strtoint(mas[n]);
      m:=m+1;
    end;
  end;
 writeln(forms[k].path); 
 k := k+1;
 end;
 close(wayt);
end.

