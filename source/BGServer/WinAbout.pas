unit WinAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  Tfrm_About = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    img1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateWinAbout;

implementation

{$R *.dfm}
procedure CreateWinAbout;
var
  frm_About: Tfrm_About;
begin
  frm_About:=Tfrm_About.Create(Application);
  frm_About.ShowModal;
  frm_About.Free;
end;
end.
