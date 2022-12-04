with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Assertions;

procedure Day2 is

   type Play_Type is (Rock, Paper, Scissors);
   type Result_Type is (Lose, Draw, Win);

   Total_Score: Natural := 0;
   Total_Score_Two: Natural := 0;

   function Char_To_Play(C: Character) return Play_Type is
   begin
      case C is
         when 'A'|'X' => return Rock;
         when 'B'|'Y' => return Paper;
         when 'C'|'Z' => return Scissors;
         when others =>
            raise Ada.Assertions.Assertion_Error with
               "invalid character";
      end case;
   end Char_To_Play;

   function Char_To_Result(C: Character) return Result_Type is
   begin
      case C is
         when 'X' => return Lose;
         when 'Y' => return Draw;
         when 'Z' => return Win;
         when others =>
            raise Ada.Assertions.Assertion_Error with
               "invalid character";
      end case;
   end Char_To_Result;

   procedure One_Round(Opponent, Player: Play_Type; Total: in out Natural) is
      Score: Natural := Play_Type'Pos(Player) + 1;
   begin
      case Opponent is
         when Rock =>
            case Player is
               when Rock => Score := Score + 3;
               when Paper => Score := Score + 6;
               when Scissors => null;
            end case;
         when Paper =>
            case Player is
               when Rock => null;
               when Paper => Score := Score + 3;
               when Scissors => Score := Score + 6;
            end case;
         when Scissors =>
            case Player is
               when Rock => Score := Score + 6;
               when Paper => null;
               when Scissors => Score := Score + 3;
            end case;
      end case;

      Total := Total + Score;

   end One_Round;


   procedure One_Round_Two(Opponent: Play_Type; Result: Result_Type; Total: in out Natural) is
      Player: Play_Type;
   begin
      case Result is
         when Lose =>
            case Opponent is
               when Rock => Player := Scissors;
               when Paper => Player := Rock;
               when Scissors => Player := Paper;
            end case;
         when Draw =>
            Player := Opponent;
         when Win =>
            case Opponent is
               when Rock => Player := Paper;
               when Paper => Player := Scissors;
               when Scissors => Player := Rock;
            end case;
      end case;
      One_Round(Opponent, Player, Total);
   end One_Round_Two;


   use Ada.Text_IO;
   use Ada.Integer_Text_IO;

   Input: File_Type;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      declare
         Line: constant String := Get_Line(Input);
      begin
         if Line'Length = 3 then
            One_Round(
               Char_To_Play(Line(Line'First)),
               Char_To_Play(Line(Line'Last)),
               Total_Score);
            One_Round_Two(
               Char_To_Play(Line(Line'First)),
               Char_To_Result(Line(Line'Last)),
               Total_Score_Two);
         end if;
      end;
   end loop;
   Close(Input);
   Put("Total score:");
   Put(Total_Score);
   New_Line;
   Put("Total score part two:");
   Put(Total_Score_Two);
   New_Line;
end Day2;
