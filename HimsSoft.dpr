program HimsSoft;

uses
  Vcl.Forms,
  HCustomer in 'HCustomer.pas',
  HCustomerSetting in 'HCustomerSetting.pas' {hsCustomerSetting},
  MainPage in 'MainPage.pas' {FMainPage},
  HBizBasePage in 'HBizBasePage.pas' {BizBasePage},
  HForm1 in 'HForm1.pas' {Form1},
  HForm2 in 'HForm2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainPage, FMainPage);
  Application.CreateForm(TBizBasePage, BizBasePage);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
