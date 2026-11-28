MODULE Escopo;

FROM InOut IMPORT WriteInt, WriteString, WriteLn;

VAR
  x: INTEGER; (* Escopo de módulo *)

PROCEDURE MostrarGlobal;
BEGIN
  (* Por ser escopo estático, acessa o 'x' do módulo, não o de quem chamou *)
  WriteString("Em MostrarGlobal, x = ");
  WriteInt(x, 0);
  WriteLn;
END MostrarGlobal;

PROCEDURE Externa;
VAR
  x: INTEGER; (* Sombreamento: oculta o 'x' do módulo dentro de Externa *)

  PROCEDURE Interna;
  BEGIN
    (* Acessa o 'x' do escopo léxico imediatamente envolvente (Externa) *)
    WriteString("Em Interna, x = ");
    WriteInt(x, 0);
    WriteLn;
  END Interna;

BEGIN
  x := 20;
  Interna;       (* Imprime 20 *)
  MostrarGlobal; (* Imprime 10, comprovando escopo estático *)
END Externa;

BEGIN
  x := 10;
  Externa;
  WriteString("No modulo principal, x = ");
  WriteInt(x, 0); (* Imprime 10 *)
  WriteLn;
END Escopo.
