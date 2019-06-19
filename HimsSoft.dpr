program HimsSoft;

uses
  Vcl.Forms,
  MainPage in 'MainPage.pas' {Form1},
  HCustomer in 'HCustomer.pas',
  HCustomerSetting in 'HCustomerSetting.pas' {hsCustomerSetting};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
