program MyServer;

uses
  Vcl.Forms,
  Server in 'Server.pas' {HServer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THServer, HServer);
  Application.Run;
end.
