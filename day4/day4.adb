with Ada.Text_Io;
with Ada.Integer_Text_Io;
with Ada.Strings.Fixed;

procedure Day4 is
   use Ada.Text_Io;
   use Ada.Integer_Text_Io;
   use Ada.Strings.Fixed;

   type Section_Rec is
      record
         From, To: Natural;
      end record;


   procedure Check_Range_Contains(First, Second: Section_Rec; Sum: in out Natural) is
   begin
      if (First.From <= Second.From and First.To >= Second.To) or
         (First.From >= Second.From and First.To <= Second.To)
      then
         Sum := Sum + 1;
      end if;
   end Check_Range_Contains;


   procedure Check_Range_Overlap(First, Second: Section_Rec; Sum: in out Natural) is
      function In_Range(S: Section_Rec; Inside: Natural) return Boolean is
      begin
         return Inside in S.From..S.To;
      end In_Range;
   begin
      -- surely there is a more elegant solution...
      if In_Range(First, Second.From) or In_Range(First, Second.To) or
         In_Range(Second, First.From) or In_Range(Second, First.To) then
         Sum := Sum + 1;
      end if;
   end Check_Range_Overlap;


   Input: File_Type;
   Sum_Contains, Sum_Overlap: Natural := 0;
begin
   Open(Input, In_File, "input.txt");
   while not End_Of_File(Input) loop
      declare
         Line: constant String := Get_Line(Input);
         First, Second: Section_Rec;
         Start, Ende: Natural;
      begin
         if Line'Length /= 0 then
            Start := Line'First;
            Ende := Index(Line, "-", Start) - 1;
            First.From := Natural'Value(Line(Start..Ende));

            Start := Ende + 2;
            Ende := Index(Line, ",", Start) - 1;
            First.To := Natural'Value(Line(Start..Ende));

            Start := Ende + 2;
            Ende := Index(Line, "-", Start) - 1;
            Second.From := Natural'Value(Line(Start..Ende));

            Start := Ende + 2;
            Ende := Line'Last;
            Second.To := Natural'Value(Line(Start..Ende));

            Check_Range_Contains(First, Second, Sum_Contains);
            Check_Range_Overlap(First, Second, Sum_Overlap);
         end if;
      end;
   end loop;
   Close(Input);
   Put("Sum of contained ranges:");
   Put(Sum_Contains);
   New_Line;
   Put("Sum of overlapping ranges:");
   Put(Sum_Overlap);
   New_Line;
end Day4;
