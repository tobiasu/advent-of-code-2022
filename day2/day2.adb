with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Assertions;
with Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Day2 is

   type Play_Type is (Rock, Paper, Scissor);

   Total_Score: Natural := 0;

   function Char_To_Play(C: Character) return Play_Type is
   begin
      case C is
         when 'A'|'X' => return Rock;
         when 'B'|'Y' => return Paper;
         when 'C'|'Z' => return Scissor;
         when others =>
            raise Ada.Assertions.Assertion_Error with
               "invalid character";
      end case;
   end Char_To_Play;

   procedure One_Round(Opponent, Player: Play_Type) is
      Score: Natural := Play_Type'Pos(Player) + 1;
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
   begin
      case Opponent is
         when Rock =>
            case Player is
               when Rock => Score := Score + 3;
               when Paper => Score := Score + 6;
               when Scissor => null;
            end case;
         when Paper =>
            case Player is
               when Rock => null;
               when Paper => Score := Score + 3;
               when Scissor => Score := Score + 6;
            end case;
         when Scissor =>
            case Player is
               when Rock => Score := Score + 6;
               when Paper => null;
               when Scissor => Score := Score + 3;
            end case;
      end case;
      --Put(Score);
      --New_Line;

      Total_Score := Total_Score + Score;

   end One_Round;


   use Ada.Text_IO;
   use Ada.Integer_Text_IO;

   Input: File_Type;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      declare
         Line: String := Get_Line(Input);
      begin
         if Line'Length = 3 then
            One_Round(
               Char_To_Play(Line(Line'First)),
               Char_To_Play(Line(Line'Last)));
         end if;
      end;
   end loop;
   Close(Input);
   Put("Total score:");
   Put(Total_Score);
   New_Line;
end Day2;
