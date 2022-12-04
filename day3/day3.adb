with Ada.Text_Io;
with Ada.Integer_Text_Io;

procedure Day3 is
   use Ada.Text_Io;
   use Ada.Integer_Text_Io;

   type Char_Map is array(Character) of Boolean;

   procedure Find_Collision(A, B: String; Sum: in out Natural) is
      Mark: Char_Map := (others => False);
   begin
      for C of A loop
         Mark(C) := True;
      end loop;

      for C of B loop
         if Mark(C) then
            if C in 'a'..'z' then
               Sum := Sum + Character'Pos(C)-96;
            else
               Sum := Sum + Character'Pos(C)-38;
            end if;
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
