with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure Day1 is

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
         Calorie := Calorie + Natural'Value(Buffer(Buffer'First..Buffer_Len));
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
