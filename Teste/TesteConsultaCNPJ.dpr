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

program TesteConsultaCNPJ;

uses
  Vcl.Forms,
  uSCConsultaCNPJ in '../Fontes/uSCConsultaCNPJ.pas' {FSCConsultaCNPJ},
  ACBrUtil in '../Fontes/ACBrUtil.pas',
  ACBrConsts in '../Fontes/ACBrConsts.pas',
  uTesteConsultaCNPJ in 'uTesteConsultaCNPJ.pas' {FTesteConsultaCNPJ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFTesteConsultaCNPJ, FTesteConsultaCNPJ);
  Application.Run;
end.
