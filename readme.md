# Suicide Coder Consulta CNPJ
O Suicide Coder Consulta CNPJ é um componente de software escrito em Delphi para permitir a consulta de dados cadastrais de empresas pelo CNPJ na Receita Federal do Brasil.
O componente é inspirado no projeto ACBr e utiliza trechos de código do mesmo. O projeto ACBr se encontra em: http://acbr.sourceforge.io/.
O diferencial deste componente para o do ACBr é que este suporta a nova tela de consulta de CNPJ da Receita com validação de captcha do Google reCaptcha.

# Como utilizar
- Baixe o Código Fonte
- Consulte o código do projeto TesteConsultaCNPJ.dproj
- Abra e compile o projeto TesteConsultaCNPJ.dproj no Delphi (testado no Delphi Tokyo e Seattle)

# Prints
- Tela de Consulta: https://prnt.sc/isvojp
- Resultado da Consulta https://prnt.sc/isvovc

# Problemas conhecidos
Se você receber um erro como mostrado neste print (https://prnt.sc/isvnze), verifique manualmente e adicione ao registro do Windows as entradas do arquivo "ADICIONAR AO REGISTRO.reg".
Este erro ocorre em função da dependêcia do Internet Explorer 8 ou superior.
Esta dependência é sinalizada através dos registros referidos acima e o erro ocorrerá caso os mesmos não sejam adicionados corretamente, ainda que o terminal possua versão recente o suficiente do Internet Explorer.
A procedure "EscreverChavesRegistro" na classe TFTesteConsultaCNPJ na unit uTesteConsultaCNPJ já adiciona automaticamente as chaves necessárias ao registro portanto, se você ainda vê o erro, é provável que seu Internet Explorer ou Windows precise ser atualizado.

# Para compilar
- Este projeto foi compilado no Delphi nas versões Tokyo e Seattle. Testado no Windows 10 64bits.
- Informações sobre a utilização em outro ambiente são bem-vindas. Fique à vontade para contatar o autor

# Autor
Este componente foi escrito por Suicide Coder numa rede, em um canto de roça, num lugar de uma improbabilidade incalculável.
O autor pode ser contatado em codersuicide@gmail.com
