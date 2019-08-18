unit wayrss;
{
This is part of EasyFeed.
unit rssway
}
{$mode Delphi}{$H+}

interface

uses
 SysUtils, EasyRSS,
 Codebot.System;

 type
  { IWayRssInfo }
  IWayRssInfo = interface ['{4C46E053-1C4A-430C-A8B3-E3A4DDD46129}']

  function GetDescription: string;
  function GetImageUrl:    string;
  function GetTitle:       string;
  function GetURL:         string;
  property URL:            string  read GetURL;
  property Title:          string  read GetTitle;
  property ImageUrl:       string  read GetImageUrl;
  property Description:    string  read GetDescription;

  end;

  function AddRss(RssUrl: String) : IWayRssInfo;

  type
  TWayRssInfoList = TArrayList<IWayRssInfo>;


implementation

 type

  { TWayRssInfo }
  TWayRssInfo = class(TInterfacedObject, IWayRssInfo)
  private
  FURL:                    string;
  FTitle:                  string;
  FImageUrl:               string;
  FDescription:            string;
  public
  constructor Create(URL: string);
  function GetImageUrl:    string;
  function GetTitle:       string;
  function GetURL:         string;
  function GetDescription: string;
 end;

 function AddRss(RssUrl: String): IWayRssInfo;
 begin
   Result := TWayRssInfo.Create(RssUrl);
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
    FDescription:=Rss.Content;
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

  function TWayRssInfo.GetDescription: string;
  begin
    Result:=FDescription;
  end;

end.

