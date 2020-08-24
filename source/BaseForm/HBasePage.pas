{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2020 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBasePage;

interface

uses
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms;

Type
  TBasePage = class(TForm)
  public
    { Public declarations }
    class procedure loadSelf(parentForm: TWinControl; AlignParent: TAlign);
    destructor Destroy; override;
  end;

implementation

{ TBasePage }

destructor TBasePage.Destroy;
begin

  inherited;
end;

class procedure TBasePage.loadSelf(parentForm: TWinControl;
  AlignParent: TAlign);
var
  pForm: TBasePage;
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
