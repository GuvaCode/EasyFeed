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
  function GetRss: TRSSReader;
  function GetTitle:       string;
  function GetURL:         string;
  property URL:            string  read GetURL;
  property Title:          string  read GetTitle;
  property ImageUrl:       string  read GetImageUrl;
  property Description:    string  read GetDescription;
  property Rss: TRSSReader read GetRss;// write SetRss;
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
  FRSSReader:              TRSSReader;
  public
  constructor Create(URL: string);
  function GetImageUrl:    string;
  function GetTitle:       string;
  function GetURL:         string;
  function GetDescription: string;
  function GetRss: TRSSReader;
 end;

 function AddRss(RssUrl: String): IWayRssInfo;
 begin
   Result := TWayRssInfo.Create(RssUrl);
 end;

 { TWayRssInfo }

  constructor TWayRssInfo.Create(URL: string);
  begin
    FRSSReader:= TRSSReader.Create;
   try
    FRSSReader.LoadFromHttp(URL);
    FURL:=URL;
    FTitle:=FRSSReader.Title;
    FImageUrl:=FRSSReader.Image.Url;
    FDescription:=FRSSReader.Content;
   finally
    //Rss.Free;
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

 function TWayRssInfo.GetRss: TRSSReader;
  begin
    result:=FRSSReader;
  end;


end.

