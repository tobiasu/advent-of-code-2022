with Ada.Text_Io;
with Ada.Integer_Text_Io;
with Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Day7 is
   use Ada.Text_Io;
   use Ada.Integer_Text_Io;

   package Vectors_Natural is new Ada.Containers.Vectors(Positive, Natural);
   package Vectors_Natural_Sort is new Vectors_Natural.Generic_Sorting;
   Sizes: Vectors_Natural.Vector;

   Sum: Natural := 0;


   function Traverse(Input: in out File_Type) return Natural is
      use Ada.Strings.Fixed;
      Total: Natural := 0;
   begin

      while not End_Of_File(Input) loop
         declare
            Line: constant String := Get_Line(Input);
         begin
            if Line = "$ cd /" then
               Total := 0;
            elsif Line = "$ cd .." then
               exit;
            elsif Line'Length > 5
               and then Line(Line'First..Line'First+4) = "$ cd " then
               Total := Total + Traverse(Input);
            elsif Line(Line'First) in '1'..'9' then
               Total := Total + Integer'Value(Line(Line'First..Index(Line, " ")-1));
            end if;
         end;
      end loop;

      Sizes.Append(Total);

      if Total <= 100000 then
         Sum := Sum + Total;
      end if;

      return Total;
   end Traverse;


   Input: File_Type;
   Used_Space: Natural := 0;
   Total_Space: constant Natural := 70000000;
   Required_Space: constant Natural := 30000000;
   Free_Space, Min_Free: Natural;
begin
   Open(Input, In_File, "input.txt");
   Used_Space := Traverse(Input);
   Close(Input);

   Put("Total sum is: ");
   Put(Sum, 0);
   New_Line;
   Put("Total used space: ");
   Put(Used_Space, 0);
   New_Line;

   Free_Space := Total_Space - Used_Space;
   Put("Current free space: ");
   Put(Free_Space, 0);
   New_Line;

   Min_Free := Required_Space - Free_Space;
   Put("Need to free at least: ");
   Put(Min_Free, 0);
   New_Line;

   Vectors_Natural_Sort.Sort(Sizes);

   for Min of Sizes loop
      if Min >= Min_Free then
         Put("Smallest directory that can be freed is: ");
         Put(Min);
         New_Line;

         exit;

      end if;
   end loop;
end Day7;
