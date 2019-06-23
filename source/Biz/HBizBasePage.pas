unit HBizBasePage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBizBasePage = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure loadSelf(var pForm: TBizBasePage; parentForm: TWinControl; AlignParent: TAlign);
  end;

var
  BizBasePage: TBizBasePage;

implementation

{$R *.dfm}

{ TTBizBasePage }

class procedure TBizBasePage.loadSelf(var pForm: TBizBasePage; parentForm: TWinControl; AlignParent: TAlign);
begin
  //�ͷ����ô���
  if Assigned(pForm) then
    pForm.Free;
  //�����´���
  pForm := Create(parentForm);
  with pForm as Self do
  begin
    BorderStyle := bsNone;
    Parent := parentForm;
    if AlignParent = alNone then
    begin
      //���崰����ʾ������λ��
      Left := (parentForm.ClientWidth - Width) div 2;
      Top := (parentForm.ClientHeight - Height) div 2 + 10;
    end
    else
      Align := alclient;
    Show;
  end;
end;

end.

