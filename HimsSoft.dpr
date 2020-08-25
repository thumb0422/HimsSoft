program HimsSoft;

uses
  Vcl.Forms,
  MainPage in 'MainPage.pas' {FMainPage},
  HBasePage in 'source\BaseForm\HBasePage.pas',
  HBedSetPage in 'source\Biz\HBedSetPage.pas' {BedSetPage},
  HBedView in 'source\Biz\HBedView.pas',
  HCBMLinkAddPage in 'source\Biz\HCBMLinkAddPage.pas' {CBMLinkAddPage},
  HCBMLinkPage in 'source\Biz\HCBMLinkPage.pas' {HCBMLinkPage},
  HCustomer in 'source\Biz\HCustomer.pas',
  HCustomerSetPage in 'source\Biz\HCustomerSetPage.pas' {CustomerSetPage},
  HDataDetailView in 'source\Biz\HDataDetailView.pas',
  HMechineSetPage in 'source\Biz\HMechineSetPage.pas' {MechineSetPage},
  HMenu in 'source\Biz\HMenu.pas',
  HRoom1 in 'source\Biz\HRoom1.pas' {RoomPage},
  HSecuritySetPage in 'source\Biz\HSecuritySetPage.pas' {SecuritySetPage},
  HSettingPage in 'source\Biz\HSettingPage.pas' {SettingPage},
  HCate in 'source\DeviceComm\Communicate\HCate.pas',
  HCom32 in 'source\DeviceComm\Communicate\HCom32.pas',
  HDeviceDo in 'source\DeviceComm\Communicate\HDeviceDo.pas',
  HNet in 'source\DeviceComm\Communicate\HNet.pas',
  HDeviceDefine in 'source\DeviceComm\Const\HDeviceDefine.pas',
  HDeviceTool in 'source\DeviceComm\Const\HDeviceTool.pas',
  HBellco in 'source\DeviceComm\DevicePrase\HBellco.pas',
  HBraun in 'source\DeviceComm\DevicePrase\HBraun.pas',
  HDeviceInfo in 'source\DeviceComm\DevicePrase\HDeviceInfo.pas',
  HFresenius in 'source\DeviceComm\DevicePrase\HFresenius.pas',
  HGambro in 'source\DeviceComm\DevicePrase\HGambro.pas',
  HJason in 'source\DeviceComm\DevicePrase\HJason.pas',
  HNikkiso in 'source\DeviceComm\DevicePrase\HNikkiso.pas',
  HToray in 'source\DeviceComm\DevicePrase\HToray.pas',
  HHistoryDataPage in 'source\Report\HHistoryDataPage.pas' {HistoryDataPage},
  SQLite3 in 'source\Utility\plugin\SQLite3.pas',
  SQLiteTable3 in 'source\Utility\plugin\SQLiteTable3.pas',
  superdate in 'source\Utility\plugin\superdate.pas',
  superobject in 'source\Utility\plugin\superobject.pas',
  supertimezone in 'source\Utility\plugin\supertimezone.pas',
  supertypes in 'source\Utility\plugin\supertypes.pas',
  superxmlparser in 'source\Utility\plugin\superxmlparser.pas',
  HDBManager in 'source\Utility\HDBManager.pas',
  HLog in 'source\Utility\HLog.pas',
  HTool in 'source\Utility\HTool.pas',
  HDataModel in 'source\DeviceComm\DeviceInfo\HDataModel.pas',
  HDataNotify in 'source\DeviceComm\DeviceInfo\HDataNotify.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainPage, FMainPage);
  Application.CreateForm(TBedSetPage, BedSetPage);
  Application.CreateForm(TCBMLinkAddPage, CBMLinkAddPage);
  Application.CreateForm(TCustomerSetPage, CustomerSetPage);
  Application.CreateForm(TMechineSetPage, MechineSetPage);
  Application.CreateForm(TRoomPage, RoomPage);
  Application.CreateForm(TSecuritySetPage, SecuritySetPage);
  Application.CreateForm(TSettingPage, SettingPage);
  Application.CreateForm(THistoryDataPage, HistoryDataPage);
  Application.Run;
end.
