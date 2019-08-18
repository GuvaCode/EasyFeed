unit munit;
{ lite feed reader } 
{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  wayrss,
  fphttpclient,
  Codebot.System,
  Codebot.Graphics,
  Codebot.Graphics.Types,
  Codebot.Controls.Scrolling;
type

  { TfrmFeed }

  TfrmFeed = class(TForm)
    ImgCategory: TImageStrip;
    lstFeed: TDrawList;
    lstCategory: TDrawList;
    pnlCenter: TPanel;
    pnlLeft: TPanel;
    Splitter: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure lstCategoryDrawItem(Sender: TObject; Surface: ISurface;
      Index: Integer; Rect: TRectI; State: TDrawState);
  private
     FWayPic: TArrayList<IBitmap>;
     FWayList: TWayRssInfoList;
     procedure PictureLoadFromUrl(const APicture: IBitmap; const AUrl: String);
  public
     procedure AddRssUrl(RssUrl:string);
  end;

var
  frmFeed: TfrmFeed;

implementation

{$R *.lfm}

{ TfrmFeed }

procedure TfrmFeed.lstCategoryDrawItem(Sender: TObject; Surface: ISurface;
  Index: Integer; Rect: TRectI; State: TDrawState);
const
  Margin = -4;
 var
  Rss: IWayRssInfo;
  PicRect: TRectI;
  S: string;
  I: Integer;
  D: TRectI;
  R: TRectF;
  begin
   { If the item is selected, but it a nice gradiant outline and fill }
  if dsSelected in State then FillRectSelected(Surface, Rect, 2);
  { Retreive the current IFileDownload }
    Rss := FWayList[Index];
    S:=Rss.Title;
  {

  Since TDrawList is a themed control, Theme.Font contains a copy of its IFont }
  Surface.TextOut(Theme.Font, S, Rect, drCenter);
  { Draw the photo }

  //PicRect:=FWayPic[Index].ClientRect;


  //FWayPic[Index].Surface.CopyTo(Rect, Surface, PicRect);

  // FillRectColor(Surface,D,clBlue);

    R := TRectF.Create(32, 32);

    R.X := Rect.X + 4;
    R.Y := Rect.Y + R.Height/4;

    //Rect.Height - R.Height - 24;

    ImgCategory.Draw(Surface, Index, TRectI(R));


end;

procedure TfrmFeed.PictureLoadFromUrl(const APicture: IBitmap;
  const AUrl: String);
 var
   LMemoryStream: TMemoryStream;
 begin
   LMemoryStream := TMemoryStream.Create;
   try
     TFPHTTPClient.SimpleGet(AUrl, LMemoryStream);
     LMemoryStream.Position := 0;
     APicture.LoadFromStream(LMemoryStream);
   finally
     FreeAndNil(LMemoryStream);
   end;
 end;

procedure TfrmFeed.FormShow(Sender: TObject);
begin
  AddRssUrl('https://castle-engine.io/wp/feed/');
  AddRssUrl('https://castle-engine.io/wp/feed/');
end;

procedure TfrmFeed.AddRssUrl(RssUrl: string);
Var B: IBitmap;
begin
 FWayList.Length:=FWayList.Length+1;
 FWayList.Items[FWayList.Hi]:=AddRss(RssUrl);
 B := NewBitmap;
 PictureLoadFromUrl(B, FWayList.Item[FWayList.Hi].ImageUrl);
 ImgCategory.Add(B);
 lstCategory.Count:=FWayList.Length;
end;


end.

