unit munit;
{ lite feed reader } 
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Codebot.Controls.Scrolling;

type

  { TfrmFeed }

  TfrmFeed = class(TForm)
    lstFeed: TDrawList;
    lstCategory: TDrawList;
    pnlCenter: TPanel;
    pnlLeft: TPanel;
    Splitter: TSplitter;
  private

  public

  end;

var
  frmFeed: TfrmFeed;

implementation

{$R *.lfm}

end.

