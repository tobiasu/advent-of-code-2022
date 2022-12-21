with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;

procedure Day8 is
   type Tree_Height is range 0..9;

   type Tree_Row is array (Positive range <>) of Tree_Height;
   type Tree_Row_Acc is access Tree_Row;
   type Tree_Column is array (Positive range <>) of Tree_Row_Acc;
   type Trees is access Tree_Column;

   type Direction is (Up, Down, Left, Right);


   procedure Free is new Ada.Unchecked_Deallocation(Tree_Column, Trees);


   function New_Tree_Line(Line: String) return Tree_Row_Acc is
      A: constant Tree_Row_Acc := new Tree_Row(1..Line'Length);
      Pos: Positive := A'First;
   begin
      for I in Line'Range loop
         A(Pos) := Tree_Height'Value(Line(I..I));
         Pos := Pos + 1;
      end loop;

      return A;
   end New_Tree_Line;


   function Next_C(C: Positive; D: Direction) return Positive is
   begin
      case D is 
         when Up =>
            return C - 1;
         when Down =>
            return C + 1;
         when others =>
            return C;
      end case;
   end;


   function Next_R(R: Positive; D: Direction) return Positive is
   begin
      case D is 
         when Left =>
            return R - 1;
         when Right =>
            return R + 1;
         when others =>
            return R;
      end case;
   end;


   function Is_Border(Field: Trees; C, R: Positive) return Boolean is
   begin
      if C in Field'First|Field'Last or
         R in Field(C)'First|Field(C)'Last then
         return True;
      end if;
      return False;
   end;


   function Is_Border(Field: Trees; C, R: Positive; D: Direction) return Boolean is
   begin
      if (D = Up and C = Field'First) or 
         (D = Down and C = Field'Last) or
         (D = Left and R = Field(C)'First) or
         (D = Right and R = Field(C)'Last) then
         return True;
      end if;
      return False;
   end;


   function Is_Visible(Field: Trees; C, R: Positive) return Boolean is
      Height: constant Tree_Height := Field(C)(R);

      function Check(Field: Trees; C, R: Positive; D: Direction) return Boolean is
      begin
         if Field(C)(R) >= Height then
            return False;
         end if;

         if Is_Border(Field, C, R) then
            return True;
         end if;

         return Check(Field, Next_C(C, D), Next_R(R, D), D);
      end Check;

   begin

      if Is_Border(Field, C, R) then
         return True;
      end if;

      for D in Direction loop
         if Check(Field, Next_C(C, D), Next_R(R, D), D) then
            return True;
         end if;
      end loop;

      return False;
   end Is_Visible;

   function Scenic_Score(Field: Trees; C, R: Positive) return Natural is
      Height: constant Tree_Height := Field(C)(R);

      function Viewing_Distance(Field: Trees; C, R: Positive; D: Direction) return Natural is
      begin
         if Field(C)(R) >= Height then
            return 1;
         end if;

         if Is_Border(Field, C, R, D) then
            return 1;
         end if;

         return 1 + Viewing_Distance(Field, Next_C(C, D), Next_R(R, D), D);
      end;

      Score: Natural := 1;

   begin

      for D in Direction loop
         if Is_Border(Field, C, R, D) then
            Score := 0;
         else
            Score := Score * Viewing_Distance(Field, Next_C(C, D), Next_R(R, D), D);
         end if;
      end loop;

      return Score;
   end;

   Input: File_Type;
   Line_Number: Positive := 1;
   Field: Trees := new Tree_Column(1..0);
   Trees_Visible: Natural := 0;
   Highest_Score: Natural := 0;
begin
   Open(Input, In_File, "input.txt");

   while not End_Of_File(Input) loop
      declare
         Line: constant String := Get_Line(Input);
         Field_Resize: constant Trees := new Tree_Column(1..Field'Last+1);
      begin
         Field_Resize(Field'Range) := Field(Field'Range);
         Free(Field);
         Field := Field_Resize;
         Field(Line_Number) := New_Tree_Line(Line);
      end;
      Line_Number := Line_Number + 1;
   end loop;

   Close(Input);

   for C in Field'Range loop
      for R in Field(C)'Range loop
         if Is_Visible(Field, C, R) then
            Trees_Visible := Trees_Visible + 1;
            Put(Integer(Field(C)(R)), 0);
         else
            Put('.');
            null;
         end if;

         Highest_Score := Natural'Max(Highest_Score, Scenic_Score(Field, C, R));
      end loop;
      New_Line;
   end loop;

   Put("Trees visible: ");
   Put(Trees_Visible, 0);
   New_Line;
   Put("Highest score: ");
   Put(Highest_Score, 0);
   New_Line;

end Day8;
