with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Assertions;
with Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Day1 is


   function String_To_Integer(S: String; Base: Integer := 10) return Integer is
      use Ada.Text_IO;
      use Ada.Assertions;
      use Ada.Strings;
      Res: Natural := 0;
      Mult: Natural := 1;
      N: Natural;
      Start: Positive;
      Signedness: Integer;
   begin
      if S'Length <= 0 then
         raise Assertion_Error
            with "can't convert string of length zero";
      end if;

      case S(S'First) is
         when '-' =>
            Start := S'First + 1;
            Signedness := -1;
         when '+' =>
            Start := S'First + 1;
            Signedness := 1;
         when others =>
            Start := S'First;
            Signedness := 1;
      end case;

      if S'Last < Start then
         raise Assertion_Error
            with "can't convert string of length zero";
      end if;

      for C: Character of reverse S(Start..S'Last) loop
         if C in '0'..'9' then
               N := Character'Pos(C) - Character'Pos('0');
         elsif C in 'a'..'f' then
               N := Character'Pos(C) - Character'Pos('a') + 10;
         elsif C in 'A'..'F' then
               N := Character'Pos(C) - Character'Pos('A') + 10;
         else
               raise Assertion_Error
                  with "digit '" & C & "' not recognized";
         end if;

         if N >= Base then
               raise Assertion_Error
                  with "digit '" & C & "' too large for base " & Fixed.Trim(Base'Img, Both);
         end if;

         Res := Res + N * Mult;
         Mult := Mult * Base;
      end loop;
      return Res * Signedness;
   end;


   use Ada.Text_IO;
   use Ada.Integer_Text_IO;

   function High_To_Low(Left, Right: Natural) return Boolean is
   begin
      return Left > Right;
   end High_To_Low;

   subtype Elf_Idx is Positive;
   package Elf_Vec is new Ada.Containers.Vectors(Elf_Idx, Natural);
   package Elf_Vec_Sorting is new Elf_Vec.Generic_Sorting(
      "<" =>  High_To_Low);

   Input: File_Type;
   Buffer: String(1..256);
   Buffer_Len: Natural;
   Calorie: Natural := 0;
   Elf: Elf_Idx := Elf_Idx'First;
   Vector: Elf_Vec.Vector;

begin

   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      Get_Line(Input, Buffer, Buffer_Len);

      if Buffer_Len > 0 then
         Calorie := Calorie + String_To_Integer(Buffer(Buffer'First..Buffer_Len));
      end if;

      if (Buffer_Len = 0 or End_Of_File(Input)) and Calorie > 0 then
         Elf_Vec.Insert(Vector, Elf, Calorie);
         Calorie := 0;
         Elf := Elf + 1;
      end if;

   end loop;
   Close(Input);

   Elf_Vec_Sorting.Sort(Vector);

   Put("Highest calorie count: ");
   Put(Elf_Vec.Element(Vector, Elf_Idx'First));
   New_Line;

   Calorie := 0;
   for Elf in Elf_Vec.First_Index(Vector)..Elf_Vec.First_Index(Vector)+2 loop
      Calorie := Calorie + Elf_Vec.Element(Vector, Elf);
   end loop;

   Put("Top three calorie count: ");
   Put(Calorie);
   New_Line;

end Day1;
