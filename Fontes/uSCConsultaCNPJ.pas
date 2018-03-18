{******************************************************************************}
{ Projeto: Suicide Coder Consulta CNPJ                                         }
{                                                                              }
{ Direitos Autorais Reservados (c) 2018 Suicide Coder                          }
{                                                                              }
{  Você pode obter a última versão desse arquivo em:                           }
{               https://github.com/suicidecoder/ConsultaCNPJ                   }
{                                                                              }
{  Alguns trechos de código deste projeto foram extraidas do Projeto ACBr:     }
{               http://www.sourceforge.net/projects/acbr                       }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 3 da Licença, ou (a seu critério)   }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENSE)                                 }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Suicide Coder -  codersuicide@gmail.com                                      }
{                                                                              }
{******************************************************************************}

unit uSCConsultaCNPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw_TLB, MSHTML,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdCookieManager, IdURI, Vcl.ExtCtrls;

type
  TFSCConsultaCNPJResposta = record
    Sucesso            : Boolean;
    Erro               ,
    CNPJ               ,
    EmpresaTipo        ,
    RazaoSocial        ,
    Fantasia           ,
    CNAE1              ,
    Endereco           ,
    Numero             ,
    Complemento        ,
    CEP                ,
    Bairro             ,
    Cidade             ,
    UF                 ,
    Situacao           ,
    NaturezaJuridica   ,
    EndEletronico      ,
    Telefone           ,
    EFR                ,
    MotivoSituacaoCad  : string;
    DataSituacao       ,
    Abertura           : TDateTime;

    procedure Clear;
  end;

  TFSCConsultaCNPJ = class(TForm)
    Button1: TButton;
    Button2: TButton;
    IdHTTP: TIdHTTP;
    Button3: TButton;
    IdCookieManager: TIdCookieManager;
    TimerInicializar: TTimer;
    TimerExibirWebBrowser: TTimer;
    panelStatus: TPanel;
    panelWebBrowser: TPanel;
    WebBrowser: TWebBrowser;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TimerInicializarTimer(Sender: TObject);
    procedure TimerExibirWebBrowserTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
  private
    FTentativas : Integer;
    FResposta : TFSCConsultaCNPJResposta;
    FCNPJ : string;

    function GetElementById(const Doc: IDispatch; const Id: string): IDispatch;
    function getCookies : TStringList;
    function LerCampo(Texto: TStringList; NomeCampo: String): String;
    procedure TratarRetorno(aRetorno : string);
  public
    class function ConsultarCNPJ(aCNPJ : string) : TFSCConsultaCNPJResposta;
  end;

implementation

{$R *.dfm}

uses ACBrUtil;


procedure TFSCConsultaCNPJ.Button2Click(Sender: TObject);
var
  Elem: IHTMLElement;
  lCookie,
  Post: TStringList;
  retorno : String;
  URI: TIdURI;
begin
  Elem := GetElementById(WebBrowser.Document, 'g-recaptcha-response') as IHTMLElement;
  if not Assigned(Elem) then
    Exit;
  ShowMessage(
    'Tag name = <' + Elem.tagName + '>'#10 +
    'Tag id = ' + Elem.id + #10 +
    'Tag innerHTML = "' + Elem.innerHTML + '"'
  );

  lCookie := getCookies;
  URI := TIdURI.Create('http://www.receita.fazenda.gov.br/');
  IdCookieManager.AddServerCookie(lCookie.Text,URI);

  Post:= TStringList.Create();
  Post.Add('origem=comprovante&');
  Post.Add('cnpj='+FCNPJ+'&');
  Post.Add('g-recaptcha-response='+Trim(Elem.innerHTML)+'&');
  Post.Add('submit1=Consultar&');
  Post.Add('search_type=cnpj');

  retorno := IdHTTP.Post('http://www.receita.fazenda.gov.br/PessoaJuridica/CNPJ/cnpjreva/valida_recaptcha.asp',
                          post);
  Showmessage(retorno);

end;

procedure TFSCConsultaCNPJ.Button3Click(Sender: TObject);
var
  Elem: IHTMLElement;
begin
  Elem := GetElementById(WebBrowser.Document, 'principal') as IHTMLElement;
  if not Assigned(Elem) then
    Exit;
  ShowMessage( Elem.innerHTML );
end;

procedure TFSCConsultaCNPJ.FormCreate(Sender: TObject);
begin
  FTentativas                  := 0;
  FResposta.Clear;
end;

procedure TFSCConsultaCNPJ.FormShow(Sender: TObject);
begin
  TimerInicializar.Enabled := True;
end;

function TFSCConsultaCNPJ.GetElementById(const Doc: IDispatch; const Id: string): IDispatch;
var
  Document: IHTMLDocument2;     // IHTMLDocument2 interface of Doc
  Body: IHTMLElement2;          // document body element
  Tags: IHTMLElementCollection; // all tags in document body
  Tag: IHTMLElement;            // a tag in document body
  I: Integer;                   // loops thru tags in document body
begin
  Result := nil;
  // Check for valid document: require IHTMLDocument2 interface to it
  if not Supports(Doc, IHTMLDocument2, Document) then
    raise Exception.Create('Invalid HTML document');
  // Check for valid body element: require IHTMLElement2 interface to it
  if not Supports(Document.body, IHTMLElement2, Body) then
    raise Exception.Create('Can''t find <body> element');
  // Get all tags in body element ('*' => any tag name)
  Tags := Body.getElementsByTagName('*');
  // Scan through all tags in body
  for I := 0 to Pred(Tags.length) do
  begin
    // Get reference to a tag
    Tag := Tags.item(I, EmptyParam) as IHTMLElement;
    // Check tag's id and return it if id matches
    if AnsiSameText(Tag.id, Id) then
    begin
      Result := Tag;
      Break;
    end;
  end;
end;

procedure TFSCConsultaCNPJ.TimerExibirWebBrowserTimer(Sender: TObject);
var
  lOk : Boolean;
  lElem: IHTMLElement;
begin
  lOk := False;
  try
  try
    TimerExibirWebBrowser.Enabled := False;
    Inc(FTentativas);
    GetElementById(WebBrowser.Document,'g-recaptcha-response');
    panelStatus.Visible := False;
    panelWebBrowser.Align := alClient;

    lElem := GetElementById(WebBrowser.Document,'cnpj') as IHTMLElement;
    lElem.setAttribute('value',FCNPJ,0);
    lElem.setAttribute('readonly','readonly',0);
    lElem.setAttribute('OnKeyUp','',0);
    lOk := True;
  except
    if FTentativas >= 10 then
      panelStatus.Caption := 'Não foi possível carregar a página de consulta. Tente novamente';
  end;
  finally
    TimerExibirWebBrowser.Enabled := (not lOk) and (FTentativas < 10);
  end;
end;

procedure TFSCConsultaCNPJ.TimerInicializarTimer(Sender: TObject);
begin
  TimerInicializar.Enabled := False;
  WebBrowser.Navigate('http://www.receita.fazenda.gov.br/PessoaJuridica/CNPJ/cnpjreva/cnpjreva_solicitacao2.asp');
  TimerExibirWebBrowser.Enabled := True;
end;

procedure TFSCConsultaCNPJ.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  Elem : IHTMLElement;
begin
  try
    Elem := GetElementById(WebBrowser.Document, 'principal') as IHTMLElement;
    if not Assigned(Elem) then
      Exit;

    panelStatus.Visible := True;
    panelWebBrowser.Visible := False;
  except
  end;
  try
    TratarRetorno(Elem.innerHTML);
    FResposta.Sucesso := True;
    FResposta.Erro    := '';
  except
    on e : Exception do
    begin
      FResposta.Clear;
      FResposta.Erro := 'Erro ao recuperar dados: '+e.Message;
    end;
  end;
  ModalResult := mrOk;
end;

function TFSCConsultaCNPJ.getCookies : TStringList;
var
  Document: IHTMLDocument2;
  Body: IHTMLElement2;
begin
  Result := nil;
  if not Supports(WebBrowser.Document, IHTMLDocument2, Document) then
    raise Exception.Create('HTML invalido');
  if not Supports(Document.body, IHTMLElement2, Body) then
    raise Exception.Create('Documento sem BODY');
  result := TStringList.Create;
  result.Text := Document.cookie;
end;

procedure TFSCConsultaCNPJ.TratarRetorno(aRetorno : string);
var
  Resposta : TStringList;
begin
  Resposta := TStringList.Create;
  try
    Resposta.Text := StripHTML(aRetorno);
    RemoveEmptyLines( Resposta );

    FResposta.CNPJ         := LerCampo(Resposta,'NÚMERO DE INSCRIÇÃO');
    if FResposta.CNPJ <> '' then
      FResposta.EmpresaTipo  := LerCampo(Resposta,FResposta.CNPJ);
    FResposta.Abertura     := StringToDateTimeDef(LerCampo(Resposta,'DATA DE ABERTURA'),0);
    FResposta.RazaoSocial  := LerCampo(Resposta,'NOME EMPRESARIAL');
    FResposta.Fantasia     := LerCampo(Resposta,'TÍTULO DO ESTABELECIMENTO (NOME DE FANTASIA)');
    FResposta.CNAE1        := LerCampo(Resposta,'CÓDIGO E DESCRIÇÃO DA ATIVIDADE ECONÔMICA PRINCIPAL');
    FResposta.Endereco     := LerCampo(Resposta,'LOGRADOURO');
    FResposta.Numero       := LerCampo(Resposta,'NÚMERO');
    FResposta.Complemento  := LerCampo(Resposta,'COMPLEMENTO');
    FResposta.CEP          := OnlyNumber( LerCampo(Resposta,'CEP') ) ;
    if FResposta.CEP <> '' then
      FResposta.CEP        := copy(FResposta.CEP,1,5)+'-'+copy(FResposta.CEP,6,3) ;
    FResposta.Bairro       := LerCampo(Resposta,'BAIRRO/DISTRITO');
    FResposta.Cidade       := LerCampo(Resposta,'MUNICÍPIO');
    FResposta.UF           := LerCampo(Resposta,'UF');
    FResposta.Situacao     := LerCampo(Resposta,'SITUAÇÃO CADASTRAL');
    FResposta.DataSituacao := StringToDateTimeDef(LerCampo(Resposta,'DATA DA SITUAÇÃO CADASTRAL'),0);
    FResposta.NaturezaJuridica := LerCampo(Resposta,'CÓDIGO E DESCRIÇÃO DA NATUREZA JURÍDICA');
    FResposta.EndEletronico:= LerCampo(Resposta, 'ENDEREÇO ELETRÔNICO');
    if Trim(FResposta.EndEletronico) = 'TELEFONE' then
      FResposta.EndEletronico := '';
    FResposta.Telefone     := LerCampo(Resposta, 'TELEFONE');
    FResposta.EFR          := LerCampo(Resposta, 'ENTE FEDERATIVO RESPONSÁVEL (EFR)');
    FResposta.MotivoSituacaoCad := LerCampo(Resposta, 'MOTIVO DE SITUAÇÃO CADASTRAL');
  finally
    Resposta.Free;
  end ;

  FResposta.RazaoSocial := RemoverEspacosDuplos(FResposta.RazaoSocial);
  FResposta.Fantasia    := RemoverEspacosDuplos(FResposta.Fantasia);
  FResposta.Endereco    := RemoverEspacosDuplos(FResposta.Endereco);
  FResposta.Numero      := RemoverEspacosDuplos(FResposta.Numero);
  FResposta.Complemento := RemoverEspacosDuplos(FResposta.Complemento);
  FResposta.Bairro      := RemoverEspacosDuplos(FResposta.Bairro);
  FResposta.Cidade      := RemoverEspacosDuplos(FResposta.Cidade);
end;

function TFSCConsultaCNPJ.LerCampo(Texto: TStringList; NomeCampo: String): String;
var
  i : integer;
  linha: String;
begin
  NomeCampo := ACBrStr(NomeCampo);
  Result := '';
  for i := 0 to Texto.Count-1 do
  begin
    linha := Trim(Texto[i]);
    if linha = NomeCampo then
    begin
      Result := StringReplace(Trim(Texto[i+1]),'&nbsp;',' ',[rfReplaceAll]);
      Texto.Delete(I);
      break;
    end;
  end
end;

procedure TFSCConsultaCNPJResposta.Clear;
begin
  Sucesso            := False;
  CNPJ               := '';
  EmpresaTipo        := '';
  Abertura           := 0;
  RazaoSocial        := '';
  Fantasia           := '';
  CNAE1              := '';
  Endereco           := '';
  Numero             := '';
  Complemento        := '';
  CEP                := '';
  Bairro             := '';
  Cidade             := '';
  UF                 := '';
  Situacao           := '';
  DataSituacao       := 0;
  NaturezaJuridica   := '';
  EndEletronico      := '';
  Telefone           := '';
  EFR                := '';
  MotivoSituacaoCad  := '';
  Erro               := '';
end;

class function TFSCConsultaCNPJ.ConsultarCNPJ(aCNPJ : string) : TFSCConsultaCNPJResposta;
var
  lForm : TFSCConsultaCNPJ;
  lResult : Integer;
begin
  try
    lForm := TFSCConsultaCNPJ.Create(nil);

    lForm.FCNPJ := aCNPJ;

    lResult := lForm.ShowModal;

    Result := lForm.FResposta;

    if lResult <> mrOk then
    begin
      Result.Clear;
      Result.Erro := 'Consulta cancelada pelo usuário';
    end;
  finally
    FreeAndNil(lForm);
  end;
end;

end.
