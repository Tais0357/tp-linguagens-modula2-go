MODULE Representacao;

FROM InOut IMPORT WriteInt, WriteCard, WriteString, WriteLn;
FROM SYSTEM IMPORT TSIZE;

BEGIN
  WriteString("Tamanho de INTEGER (bytes): ");
  WriteCard(TSIZE(INTEGER), 0);
  WriteLn;

  WriteString("MIN(INTEGER): ");
  WriteInt(MIN(INTEGER), 0);
  WriteLn;

  WriteString("MAX(INTEGER): ");
  WriteInt(MAX(INTEGER), 0);
  WriteLn;

  WriteString("MAX(CARDINAL): ");
  WriteCard(MAX(CARDINAL), 0);
  WriteLn;
END Representacao.
