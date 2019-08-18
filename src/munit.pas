unit munit;
{ lite feed reader } 
{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  WayRss, EasyRSS,
  fphttpclient,
  Codebot.System,
  Codebot.Graphics,
  Codebot.Graphics.Types,
  Codebot.Controls.Scrolling;
type

  { TfrmFeed }

  TfrmFeed = class(TForm)
    ImageStrip: TImageStrip;
    ImgCategory: TImageStrip;
    lstFeed: TDrawList;
    lstCategory: TDrawList;
    pnlCenter: TPanel;
    pnlLeft: TPanel;
    Splitter: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstCategoryDrawItem(Sender: TObject; Surface: ISurface;
      Index: Integer; Rect: TRectI; State: TDrawState);
    procedure lstCategorySelectItem(Sender: TObject);
    procedure lstFeedDrawItem(Sender: TObject; Surface: ISurface;
      Index: Integer; Rect: TRectI; State: TDrawState);
  private
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
  Margin = 4;
 var
  Rss: IWayRssInfo;
  S: string;
  T: TRectF;
  R: TRectF;
  begin
   { If the item is selected, but it a nice gradiant outline and fill }
  if dsSelected in State then FillRectSelected(Surface, Rect, 2);
  { Retreive the current IFileDownload }
    Rss := FWayList[Index];
    S:=Rss.Title;

    R := TRectF.Create(32, 32);
    R.X := Rect.X + Margin;
    R.Y := Rect.Y + Margin;
    ImgCategory.Draw(Surface, Index, TRectI(R));

    T:=  TRectF.Create(R.X+36,Rect.Y,Rect.Width-R.Width-8,Rect.Height);
    Surface.TextOut(Theme.Font, S, T, drLeft);
  end;

procedure TfrmFeed.lstCategorySelectItem(Sender: TObject);
 var Rss: IWayRssInfo;
 begin
   Rss := FWayList[lstCategory.ItemIndex];
   caption:=Rss.GetRss.Elements[lstCategory.ItemIndex].Title;
   lstFeed.Count:=Rss.GetRss.Count;
end;

procedure TfrmFeed.lstFeedDrawItem(Sender: TObject; Surface: ISurface;
  Index: Integer; Rect: TRectI; State: TDrawState);
 var
   S: string;
   Rss: IWayRssInfo;
   i:integer;
begin
    Rss := FWayList[lstCategory.ItemIndex];
    S:=Rss.GetRss.Elements[Index].Title;

  if dsSelected in State then FillRectSelected(Surface, Rect, 2);
//S:=Rss.Items;

Surface.TextOut(Theme.Font, S, rect, drLeft);
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
  AddRssUrl('https://lazplanet.blogspot.com/feeds/posts/default?alt=rss');
  AddRssUrl('https://devlaz.ru/feed/');
  AddRssUrl('http://freepascal.ru/forum/feed.php?mode=forums');
end;

procedure TfrmFeed.FormCreate(Sender: TObject);
begin

end;

procedure TfrmFeed.FormDestroy(Sender: TObject);
begin

end;

procedure TfrmFeed.AddRssUrl(RssUrl: string);
Var B: IBitmap;
begin
 FWayList.Length:=FWayList.Length+1;
 FWayList.Items[FWayList.Hi]:=AddRss(RssUrl);
 B := NewBitmap;
 if FWayList.Item[FWayList.Hi].ImageUrl<> '' then
 begin
 PictureLoadFromUrl(B, FWayList.Item[FWayList.Hi].ImageUrl);
 B:=B.Resample(32,32);
 ImgCategory.Add(B);
 end
 else
 begin
 ImageStrip.CopyTo(B);
 B:=B.Resample(32,32);
 ImgCategory.Add(B);
 end;
 LstCategory.Count:=FWayList.Length;
end;


end.

