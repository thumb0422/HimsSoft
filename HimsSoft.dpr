program HimsSoft;

uses
  Vcl.Forms,
  HCustomer in 'HCustomer.pas',
  MainPage in 'MainPage.pas' {FMainPage},
  HBizBasePage in 'HBizBasePage.pas' {BizBasePage},
  HRoom1 in 'HRoom1.pas' {RoomPage},
  HBedView in 'HBedView.pas',
  HMenu in 'HMenu.pas',
  HDataDetailView in 'HDataDetailView.pas',
  HDataNotify in 'HDataNotify.pas',
  HSettingPage in 'HSettingPage.pas' {SettingPage},
  HBedSetPage in 'HBedSetPage.pas' {BedSetPage},
  HMechineSetPage in 'HMechineSetPage.pas' {MechineSetPage},
  HCustomerSetPage in 'HCustomerSetPage.pas' {CustomerSetPage},
  HCBMLinkPage in 'HCBMLinkPage.pas' {HCBMLinkPage},
  HCBMLinkAddPage in 'HCBMLinkAddPage.pas' {CBMLinkAddPage},
  HSecuritySetPage in 'HSecuritySetPage.pas' {SecuritySetPage},
  HHistoryDataPage in 'HHistoryDataPage.pas' {HistoryDataPage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainPage, FMainPage);
  Application.Run;
end.
