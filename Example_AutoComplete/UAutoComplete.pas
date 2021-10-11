{ Unit� d'auto-compl�tion des contr�les de saisie texte, par Bacterius pour DelphiFr.

Param�tres de la fonction AutoComplete :
 - Options contient les donn�es qui peuvent �tre utilis�es pour l'auto-compl�tion : le syst�me
   de fichiers, l'historique internet, les fichiers r�cents ... Si cet ensemble est vide, il n'y
   a pas d'auto-compl�tion.
 - Append indique si le texte auto-compl�t� doit �tre directement ajout� au contr�le texte et
   s�lectionn�.

La fonction renvoie True si tout s'est bien pass�, False dans le cas contraire.

Remarques : si vous voulez utiliser SHAutoComplete en-dehors de cette unit�, pensez � mettre
ComObj dans la clause uses : en effet, cette unit� appelle CoInitialize � son d�marrage, sans quoi
SHAutoComplete �chouera toujours.

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
