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

  IWayRssInfo = interface
  ['{D7780BF9-33FB-4886-8C40-A0EF5B30165B}']
  function GetCategory: string;
  function GetNewsCount: integer;
  function GetReadCount: integer;
  function GetURI: string;
  procedure SetReadCount(AValue: integer);
  property URI:           string  read GetURI;
 // property Name           string  read GetName;
  property Category:      string  read GetCategory;
  property NewsCount:     integer read GetNewsCount;
  property ReadCount:     integer read GetReadCount write SetReadCount;
  end;

  type
  TWayRssInfoList = TArrayList<IWayRssInfo>;


implementation
 uses EasyRSS;
type

  { TWayRssInfo }

  TWayRssInfo = class(TInterfacedObject, IWayRssInfo)
  private
  FURI:String;
  FCategory:String;
  FNewsCount:Integer;
  FReadCount:Integer;
  public
  constructor Create(URI: String);
  function GetCategory: string;
  function GetNewsCount: integer;
  function GetReadCount: integer;
  function GetURI: string;
  procedure SetReadCount(AValue: integer);
  end;

{ TWayRssInfo }

constructor TWayRssInfo.Create(URI: String);
var
  item: TRSSItem;
  Rss: TRSSReader;
begin
   rss := TRSSReader.Create;
  try
    Rss.LoadFromHttp(URI);
    FNewsCount            :=Rss.Count;
    FCategory             :=Rss.Category;
    FURI                  :=URI;
  //  Rss.Title:=;
  {  for item in rss.Items do
    begin



      WriteLn('<b>Title:</b> ', item.Title);
      WriteLn('<b>Description:</b> ', item.Description);
      Write('<hr>');
    end; }
  finally
    rss.Free;
  end;
end;

function TWayRssInfo.GetCategory: string;
begin
  result:=FCategory;
end;

function TWayRssInfo.GetNewsCount: integer;
begin
  result:=FNewsCount;
end;

function TWayRssInfo.GetReadCount: integer;
begin
  result:=FReadCount;
end;

function TWayRssInfo.GetURI: string;
begin
  result:=FURI;
end;

procedure TWayRssInfo.SetReadCount(AValue: integer);
begin
  //
end;

end.

