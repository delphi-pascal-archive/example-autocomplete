unit Main;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, UAutoComplete, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    InfoLbl: TLabel;
    EditControl: TEdit;
    OptionsBox: TGroupBox;
    FileBox: TCheckBox;
    HistoryBox: TCheckBox;
    RecentBox: TCheckBox;
    QuitBtn: TButton;
    CreditsLbl: TLabel;
    SepBevel: TBevel;
    AppendBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure OptionChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MainForm: TMainForm;
  Params: TCompleteParams;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
 { Juste pour éviter les scintillements }
 DoubleBuffered := True;
 OptionsBox.DoubleBuffered := True;
 { On met les options par défaut }
 with Params do
  begin
   Options := [coeFileSystem];
   Append := True;
  end;
 { On applique au démarrage l'auto-complétion }
 if not AutoComplete(EditControl.Handle, Params) then raise Exception.Create('Erreur lors de la définition de l''auto-complétion.');
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
 { On quitte }
 Close;
end;

function ElementFromTag(Value: Integer): TCompleteOptionsElements;
begin
 { Associe à chaque tag (1 à 3) son élément approprié }
 case Value of
  1: Result := coeFileSystem;
  2: Result := coeURLHistory;
  3: Result := coeRecent;
  else Result := coeFileSystem;
 end;
end;

procedure TMainForm.OptionChange(Sender: TObject);
begin
 { Appelé par chaque clic sur n'importe-quelle boîte à cocher }
 if Sender is TCheckBox then
  with TCheckBox(Sender), Params do
   begin
    { On change ce qui doit être changé }
    if (Tag in [1..3]) then if Checked then Include(Options, ElementFromTag(Tag)) else Exclude(Options, ElementFromTag(Tag));
    if Tag = 4 then Append := Checked;
    { On applique l'auto-complétion }
    if not AutoComplete(EditControl.Handle, Params) then raise Exception.Create('Erreur lors de la définition de l''auto-complétion.');
   end;
end;

end.
