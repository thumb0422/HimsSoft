program HimsSoft;

uses
  Vcl.Forms,
  HCustomer in 'HCustomer.pas',
  HCustomerSetting in 'HCustomerSetting.pas' {hsCustomerSetting},
  MainPage in 'MainPage.pas' {FMainPage},
  HBizBasePage in 'HBizBasePage.pas' {BizBasePage},
  HForm1 in 'HForm1.pas' {Form1},
  HForm2 in 'HForm2.pas' {Form2},
  HRoom1 in 'HRoom1.pas' {RoomPage},
  HBedView in 'HBedView.pas',
  HMenu in 'HMenu.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainPage, FMainPage);
  Application.Run;
end.
