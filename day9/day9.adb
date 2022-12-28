with Ada.Text_Io;
use Ada.Text_Io;

procedure Day9 is
   Invalid_Input_Error: exception;

   type Position is
      record
         X, Y: Integer := 0;
      end record;

   function "+" (A,B: Position) return Position is
   begin
      return (A.X+B.X, A.Y+B.Y);
   end;

   function "*" (A: Position, M: Integer) return Position is
   begin
      return (A.X*M, A.Y*M);
   end;

   N: constant Position := (0, 1);
   S: constant Position := (0, -1);
   W: constant Position := (-1, 0);
   O: constant Position := (1, 0);
   NW: constant Position := N+W;
   NO: constant Position := N+O;
   SW: constant Position := S+W;
   SO: constant Position := S+O;

   procedure Move_Tail(Head: Position; Tail: in out Position) is
   begin
      if Tail.X in Head.X-1..Head.X+1 and
         Tail.Y in Head.Y-1..Head.Y+1 then
         return;
      end if;


   end;

   procedure Move(Cmd: String; Head, Tail: in out Position) is
      How_Much: constant Integer := Integer'Value(Cmd(Cmd'First+2..Cmd'Last));
   begin
      for I in 1..How_Much loop
         case Cmd(Cmd'First) is
            when 'R' =>
               Head.X := Head.X + 1;
            when 'L' =>
               Head.X := Head.X - 1;
            when 'U' =>
               Head.Y := Head.Y + 1;
            when 'D' =>
               Head.Y := Head.Y - 1;
            when others =>
               raise Invalid_Input_Error;
         end case;
         Move_Tail(Head, Tail);
      end loop;
   end;

   Input: File_Type;
   Head: Position;
   Tail: Position;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_Line(Input) loop
      Move(Get_Line(Input), Head, Tail);
   end loop;
end;
