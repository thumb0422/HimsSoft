program HimsSoft;

uses
  Vcl.Forms,
  HCustomer in 'HCustomer.pas',
  HCustomerSetting in 'HCustomerSetting.pas' {hsCustomerSetting},
  MainPage in 'MainPage.pas' {FMainPage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainPage, FMainPage);
  Application.Run;
end.
