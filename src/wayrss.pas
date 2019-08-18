unit wayrss;
{
This is part of EasyFeed.
unit rssway
}
{$mode Delphi}{$H+}

interface

uses
 SysUtils,
 Codebot.System;

 type

  { IWayRssInfo }

  IWayRssInfo = interface ['{4C46E053-1C4A-430C-A8B3-E3A4DDD46129}']
  function GetImageUrl:    string;
  function GetTitle:       string;
  function GetURL:         string;
  property URL:            string  read GetURL;
  property Title:          string  read GetTitle;
  property ImageUrl:       string  read GetImageUrl;
  end;

  type
  TWayRssInfoList = TArrayList<IWayRssInfo>;


implementation
 uses EasyRSS;
 type

  { TWayRssInfo }
  TWayRssInfo = class(TInterfacedObject, IWayRssInfo)
  private
  FURL:                    string;
  FTitle:                  string;
  FImageUrl:               string;
  public
  constructor Create(URL: string);
  function GetImageUrl:    string;
  function GetTitle:       string;
  function GetURL:         string;
 end;

 { TWayRssInfo }

  constructor TWayRssInfo.Create(URL: string);
  var
  Rss: TRSSReader;
  begin
   Rss := TRSSReader.Create;
   try
    Rss.LoadFromHttp(URL);
    FURL:=URL;
    FTitle:=Rss.Title;
    FImageUrl:=Rss.Image.Url;
   finally
    rss.Free;
   end;
  end;

  function TWayRssInfo.GetImageUrl: string;
  begin
  Result:=FImageUrl;
  end;

  function TWayRssInfo.GetTitle: string;
  begin
  Result:=FTitle;
  end;

  function TWayRssInfo.GetURL: string;
  begin
  Result:=FURL;
  end;



{
constructor TWayRssInfo.Create(URI: String);
var
  Rss: TRSSReader;
begin
   rss := TRSSReader.Create;
  try
    Rss.LoadFromHttp(URI);
    FNewsCount            :=Rss.Count;
    FCategory             :=Rss.Category;
    FURI                  :=URI;

  finally
    rss.Free;
  end;
end;  }


end.

