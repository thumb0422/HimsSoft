unit SysCommDefine;

interface

uses
  SvcMgr, SysUtils, Messages, Windows, Classes, DateUtils, Forms, StdCtrls,
  ComCtrls, ScktComp, ShellAPI, WinSvc, Registry;

const
//****************************** 每个项目中需要修改的内容 ********************
  {服务的显示名称}
  _SysServerDisplayName = 'HimsServer';
  {服务名称}
  _SysServerName = 'HimsServer';
  {服务的说明}
  _SysServerReadme = 'HimsSoftServer';
  {系统的主标题}
  _SysServerMainTitle = 'HimsSoft'; //系统主标题
  {系统的副标题}
  _SysServerSubtitle = ''; //副标题
  {系统的唯一标识,用来防止同一个程序启动多份}
  _SysServerMutexID = '7653C505-D510-49D3-A271-1950C14E7206'; //系统唯一标识

const
  {图标}
  WM_MIDASICON = WM_USER + 2;
  {初始化}
  UI_INITIALIZE = WM_USER + 4;
  {窗体显示}
  WM_ShowWinSysServer = WM_USER + 6;
  {系统的状态变化，不同于服务本身的启动停止状态变化}
  WM_DMServerState = WM_USER + 8;
  {图标变化状态}
  WM_DMServerICONState = WM_USER + 10;
  {日志记录变化}
  WM_LogChange = WM_USER + 12;
  {数据有变化，给数据监测窗体发送}
  WM_DataMonitorChange = WM_USER + 14;

  {系统启动状态}
  CO_DMServerState_Run = 1;
  {系统停止状态}
  CO_DMServerState_Stop = 0;
  {系统正在启动过程中}
  CO_DMServerState_Runing = 101;
  {系统正在停止过程中}
  CO_DMServerState_Stoping = 100;
  {其它未知状态}
  CO_DMServerState_Wait = 1000;
  KEY_USERSYSSERVER = '\Software\UserSysServer\';
  KEY_IE = 'SOFTWARE\Microsoft\Internet Explorer';

resourcestring
  SServiceOnly = '系统只能运行在  NT 3.51 版本以上。';
  SErrClose = '确定要退出系统吗？';
  SAlreadyRunning = '当前程序已经运行。';

implementation

end.

