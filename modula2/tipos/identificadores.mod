MODULE Identificadores;

FROM InOut IMPORT WriteInt, WriteLn;

CONST
  Limite = 10; (* Amarração de valor em tempo de compilação *)

VAR
  contador: INTEGER; (* Tipo obrigatoriamente explícito *)

BEGIN
  contador := Limite + 5;
  WriteInt(contador, 0);
  WriteLn;
END Identificadores.
