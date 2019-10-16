var prq,q:integer; //защита от повторений
begin
 prq:=1;
 for var i:=1 to 10 do
 begin
   repeat
   q:=random(1,5);
   until q<>prq;
   prq:=q;
   write(q,' ');
 end;
 
end.