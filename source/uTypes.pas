unit uTypes;

interface

type
  TGlobalState = (gsPaused, gsFirstSearch, gsFileLoaded, gsPopupMenu, gsBookmark);

  TGlobalStates = set of TGlobalState;


  TProcSharedInfo = procedure(const aProcessId:Word; const aMensaje:string) of object;

implementation

end.
