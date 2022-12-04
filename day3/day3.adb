with Ada.Text_Io;
with Ada.Integer_Text_Io;

procedure Day3 is
   use Ada.Text_Io;
   use Ada.Integer_Text_Io;

   type Map_Arr is array(Positive range 1..52) of Integer;

   procedure Find_Collision(A, B: String; Sum: in out Natural) is
      Mark: Map_Arr := (others => 0);
      function To_Idx(C: Character) return Positive is
      begin
         if C in 'a'..'z' then
            return Character'Pos(C)-96;
         end if;
         return Character'Pos(C)-38;
      end To_Idx;
   begin

      for C of A loop
         Mark(To_Idx(C)) := 1;
      end loop;

      for C of B loop
         if Mark(To_Idx(C)) > 0 then
               Sum := Sum + To_Idx(C);
            return;
         end if;
      end loop;
   end Find_Collision;

   Input: File_Type;
   Sum: Natural := 0;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      declare
         Line: String := Get_Line(Input);
      begin
         Find_Collision(
            Line(Line'First..Line'Last/2),
            Line((Line'Last/2)+1..Line'Last),
            Sum);
      end;
   end loop;

   Put("Sum:");
   Put(Sum);
   New_Line;
end;
