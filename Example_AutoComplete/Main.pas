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
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  MainForm: TMainForm;
  Params: TCompleteParams;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
 { Juste pour �viter les scintillements }
 DoubleBuffered := True;
 OptionsBox.DoubleBuffered := True;
 { On met les options par d�faut }
 with Params do
  begin
   Options := [coeFileSystem];
   Append := True;
  end;
 { On applique au d�marrage l'auto-compl�tion }
 if not AutoComplete(EditControl.Handle, Params) then raise Exception.Create('Erreur lors de la d�finition de l''auto-compl�tion.');
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
 { On quitte }
 Close;
end;

function ElementFromTag(Value: Integer): TCompleteOptionsElements;
begin
 { Associe � chaque tag (1 � 3) son �l�ment appropri� }
 case Value of
  1: Result := coeFileSystem;
  2: Result := coeURLHistory;
  3: Result := coeRecent;
  else Result := coeFileSystem;
 end;
end;

procedure TMainForm.OptionChange(Sender: TObject);
begin
 { Appel� par chaque clic sur n'importe-quelle bo�te � cocher }
 if Sender is TCheckBox then
  with TCheckBox(Sender), Params do
   begin
    { On change ce qui doit �tre chang� }
    if (Tag in [1..3]) then if Checked then Include(Options, ElementFromTag(Tag)) else Exclude(Options, ElementFromTag(Tag));
    if Tag = 4 then Append := Checked;
    { On applique l'auto-compl�tion }
    if not AutoComplete(EditControl.Handle, Params) then raise Exception.Create('Erreur lors de la d�finition de l''auto-compl�tion.');
   end;
end;

end.
