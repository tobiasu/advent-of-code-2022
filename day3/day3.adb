with Ada.Assertions;
with Ada.Integer_Text_Io;
with Ada.Text_Io;

procedure Day3 is
   use Ada.Text_Io;
   use Ada.Integer_Text_Io;

   type Map_Arr is array(Positive range 1..52) of Boolean;
   for Map_Arr'Component_Size use 1;

   function To_Idx(C: Character) return Positive is
   begin
      if C in 'a'..'z' then
         return Character'Pos(C)-96;
      end if;
      return Character'Pos(C)-38;
   end To_Idx;

   procedure Find_Collision(A, B: String; Sum: in out Natural) is
      Mark: Map_Arr := (others => False);
   begin
      for C of A loop
         Mark(To_Idx(C)) := True;
      end loop;

      for C of B loop
         if Mark(To_Idx(C)) then
               Sum := Sum + To_Idx(C);
            return;
         end if;
      end loop;
   end Find_Collision;

   procedure Find_Collision_Three(A, B, C: String; Sum: in out Natural) is
      MarkA: Map_Arr := (others => False);
      MarkB: Map_Arr := (others => False);
   begin
      for I of A loop
         MarkA(To_Idx(I)) := True;
      end loop;

      for I of B loop
         MarkB(To_Idx(I)) := True;
      end loop;

      for I of C loop
         declare
            Idx: constant Positive := To_Idx(I);
         begin
            if MarkA(Idx) and MarkB(Idx) then
               Sum := Sum + Idx;
               return;
            end if;
         end;
      end loop;
   end Find_Collision_Three;

   Input: File_Type;
   Sum: Natural := 0;
   Group_Cnt: Natural := 0;
   A, B: String(1..256);
   A_Last, B_Last: Positive;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      declare
         Line: constant String := Get_Line(Input);
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

   Sum := 0;
   Reset(Input);
   while not End_Of_File(Input) loop
      declare
         Line: constant String := Get_Line(Input);
      begin
         case Group_Cnt is
            when 0 =>
               A(Line'Range) := Line;
               A_Last := Line'Last;
            when 1 =>
               B(Line'Range) := Line;
               B_Last := Line'Last;
            when 2 =>
               null;
            when others =>
               raise Ada.Assertions.Assertion_Error;
         end case;

         Group_Cnt := Group_Cnt + 1;
         if Group_Cnt rem 3 = 0 then
            Group_Cnt := 0;
            Find_Collision_Three(
               A(A'First..A_Last),
               B(B'First..B_Last),
               Line, Sum);
         end if;
      end;
   end loop;
   Close(Input);

   Put("Threeway Sum:");
   Put(Sum);
   New_Line;
end;
