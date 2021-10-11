{ Unité d'auto-complétion des contrôles de saisie texte, par Bacterius pour DelphiFr.

Paramètres de la fonction AutoComplete :
 - Options contient les données qui peuvent être utilisées pour l'auto-complétion : le système
   de fichiers, l'historique internet, les fichiers récents ... Si cet ensemble est vide, il n'y
   a pas d'auto-complétion.
 - Append indique si le texte auto-complété doit être directement ajouté au contrôle texte et
   sélectionné.

La fonction renvoie True si tout s'est bien passé, False dans le cas contraire.

Remarques : si vous voulez utiliser SHAutoComplete en-dehors de cette unité, pensez à mettre
ComObj dans la clause uses : en effet, cette unité appelle CoInitialize à son démarrage, sans quoi
SHAutoComplete échouera toujours.

}

unit UAutoComplete;

interface

uses ComObj;

type
 Longword = Cardinal;

 TCompleteOptionsElements = (coeFileSystem, coeURLHistory, coeRecent);
 TCompleteOptions = set of TCompleteOptionsElements;

 TCompleteParams = record
  Options: TCompleteOptions;
  Append: Boolean;
 end;

function AutoComplete(Handle: Longword; Params: TCompleteParams): Boolean;

implementation

function SHAutoComplete(hwndEdit, dwFlags: Longword): Longword; stdcall; external 'shlwapi.dll';

const
 SHACF_AUTOAPPEND_FORCE_OFF  = $80000000;
 SHACF_AUTOAPPEND_FORCE_ON   = $40000000;
 SHACF_FILESYSTEM            = $00000001;
 SHACF_URLHISTORY            = $00000002;
 SHACF_URLMRU                = $00000004;
 SHACF_NOAUTOCOMPLETE        = $00000008;

 AppendConsts: array [Boolean] of Longword = (SHACF_AUTOAPPEND_FORCE_OFF, SHACF_AUTOAPPEND_FORCE_ON);

function CompleteOptionsToFlags(Value: TCompleteOptions): Longword;
begin
 if Value = [] then Result := SHACF_NOAUTOCOMPLETE else
  begin
   Result := 0;
   if coeFileSystem in Value then Result := Result or SHACF_FILESYSTEM;
   if coeURLHistory in Value then Result := Result or SHACF_URLHISTORY;
   if coeRecent in Value then Result := Result or SHACF_URLMRU;
  end;
end;

function AutoComplete(Handle: Longword; Params: TCompleteParams): Boolean;
begin
 with Params do Result := (SHAutoComplete(Handle, CompleteOptionsToFlags(Options) or AppendConsts[Append]) = 0);
end;

end.
