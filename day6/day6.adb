with Ada.Text_Io;
with Ada.Integer_Text_Io;

procedure Day6 is
   use Ada.Text_Io, Ada.Integer_Text_Io;

   type Buffer_Arr is array (Positive range <>) of Character;

   function Start_Of(Buffer: in out Buffer_Arr; Length: in out Natural; C: Character) return Boolean is
      type Bit_Set is array (Character range 'a'..'z') of Boolean with
         Pack => True;
      Set: Bit_Set := (others => False);
   begin
      if Length < Buffer'Last then
         Length := Length + 1;
         Buffer(Length) := C;
      else
         Buffer(Buffer'First..Buffer'Last-1) := Buffer(Buffer'First+1..Buffer'Last);
         Buffer(Buffer'Last) := C;
      end if;

      if Length = Buffer'Last then
         for J of Buffer loop
            if Set(J) = True then
               return False;
            end if;
            Set(J) := True;
         end loop;
         return True;
      end if;
      return False;
   end Start_Of;


   Input: File_Type;
   C: Character;
   Pos: Natural := 0;
   Packet_Buffer: Buffer_Arr(1..4);
   Message_Buffer: Buffer_Arr(1..14);
   Length: Natural := Packet_Buffer'First - 1;

begin
   Open(Input, In_File, "input.txt");

   while not End_Of_File(Input) loop
      Get(Input, C);
      Pos := Pos + 1;

      if Start_Of(Packet_Buffer, Length, C) then
         Put("Found packet marker at:");
         Put(Pos);
         New_Line;
         exit;
      end if;
   end loop;

   Reset(Input);
   Pos := 0;
   Length := Message_Buffer'First - 1;

   while not End_Of_File(Input) loop
      Get(Input, C);
      Pos := Pos + 1;
      if Start_Of(Message_Buffer, Length, C) then
         Put("Found message marker at:");
         Put(Pos);
         New_Line;
         exit;
      end if;
   end loop;

   Close(Input);
end Day6;
