program AutoComplete_Example;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  UAutoComplete in 'UAutoComplete.pas';

{$R *.res}
{$R WindowsXP.res}

begin
  Application.Initialize;
  Application.Title := 'Exemple AutoComplete';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
