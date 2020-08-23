{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBizBasePage;

interface

uses
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms;

type
  TBizBasePage = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure loadSelf(parentForm: TWinControl; AlignParent: TAlign);
    destructor Destroy; override;
  end;

var
  BizBasePage: TBizBasePage;

implementation

{ TBizBasePage }

destructor TBizBasePage.Destroy;
begin

  inherited;
end;

class procedure TBizBasePage.loadSelf(parentForm: TWinControl; AlignParent: TAlign);
var pForm:TBizBasePage;
begin
  pForm := Create(parentForm);
  with pForm as Self do
  begin
    BorderStyle := bsNone;
    Parent := parentForm;
    Color := clWhite;
    if AlignParent = alNone then
    begin
      Left := (parentForm.ClientWidth - Width) div 2;
      Top := (parentForm.ClientHeight - Height) div 2 + 10;
    end
    else
      Align := alclient;
    Show;
  end;
end;

end.
