MODULE Primitivos;

FROM InOut IMPORT WriteInt, WriteCard, WriteString, WriteLn, Write;
FROM RealInOut IMPORT WriteReal;

VAR
  saldo: INTEGER;
  quantidade: CARDINAL;
  preco: REAL;
  ativo: BOOLEAN;
  letra: CHAR;
  total: REAL;

BEGIN
  saldo := -15;
  quantidade := 4;
  preco := 12.5;
  ativo := TRUE;
  letra := 'G';

  (* Conversao obrigatoriamente explicita entre CARDINAL e REAL *)
  total := FLOAT(quantidade) * preco;

  WriteString("Saldo (INTEGER): "); WriteInt(saldo, 0); WriteLn;
  WriteString("Quantidade (CARDINAL): "); WriteCard(quantidade, 0); WriteLn;
  WriteString("Total (REAL): "); WriteReal(total, 10); WriteLn;
  WriteString("Letra (CHAR): "); Write(letra); WriteLn;

  IF ativo THEN
    WriteString("Status: Ativo"); WriteLn;
  END;
END Primitivos.
