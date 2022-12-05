with Ada.Text_Io;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed;

procedure Day5 is
   use Ada.Text_Io;

   procedure Extract_Instruction(L: String; Move, From, To: out Positive) is
      use Ada.Strings.Fixed;
      Spos, Epos: Positive;
   begin
      Spos := Index(L, " ", L'First) + 1;
      Epos := Index(L, " ", Spos) - 1;
      Move := Positive'Value(L(Spos..Epos));

      Spos := Index(L, " ", Epos + 2) + 1;
      Epos := Index(L, " ", Spos) - 1;
      From := Positive'Value(L(Spos..Epos));

      Spos := Index(L, " ", Epos + 2) + 1;
      Epos := L'Last;
      To := Positive'Value(L(Spos..Epos));
   end Extract_Instruction;


   procedure Sort_Stacks(Filename: String; First: Boolean) is
      package Stack_Container is new Ada.Containers.Vectors(Positive, Character);
      use Stack_Container;

      package Stack_Holder_Container is new Ada.Containers.Vectors(Positive, Stack_Container.Vector);
      use Stack_Holder_Container;

      Input: File_Type;
      Crate_Pos, Position: Positive;
      Stacks: Stack_Holder_Container.Vector;
      Move, From, To: Positive;
   begin
      Open(Input, In_File, Filename);
      while not End_Of_File(Input) loop
         declare
            Line: constant String := Get_Line(Input);
         begin
            if Line'Length > 0 and then Line(1) /= 'm' then
               Crate_Pos := Line'First + 1;

               while Crate_Pos < Line'Length loop
                  Position := (Crate_Pos + 2) / 4;

                  exit when Line(Crate_Pos) = '1';


                  if Last_Index(Stacks) < Position then
                     Set_Length(Stacks, Ada.Containers.Count_Type(Position));
                  end if;

                  if Line(Crate_Pos) in 'A'..'Z' then
                     Prepend(Reference(Stacks, Position), Line(Crate_Pos));
                  end if;

                  Crate_Pos := Crate_Pos + 4;

               end loop;


            elsif Line'Length > 0 and then Line(1) = 'm' then
               Extract_Instruction(Line, Move, From, To);

               if First then

                  for M in 1..Move loop
                     declare
                        Crate: constant Character :=
                           Last_Element(Constant_Reference(Stacks, From));
                     begin
                        Delete_Last(Reference(Stacks, From));
                        Append(Reference(Stacks, To), Crate);
                     end;
                  end loop;

               else
                  declare
                     Idx: constant Positive := 
                        Last_Index(Constant_Reference(Stacks, From)) + 1 - Move;
                     Crate: Character;
                  begin

                     for M in 1..Move loop
                        Crate := Element(Constant_Reference(Stacks, From), Idx);
                        Delete(Reference(Stacks, From), Idx);
                        Append(Reference(Stacks, To), Crate);
                     end loop;

                  end;
               end if;

            end if;
         end;
      end loop;
      Close(Input);

      for I in First_Index(Stacks)..Last_Index(Stacks) loop
         Put(Last_Element(Constant_Reference(Stacks, I)));
      end loop;
      New_Line;
   end Sort_Stacks;


begin
   Sort_Stacks("input.txt", True);
   Sort_Stacks("input.txt", False);
end Day5;
