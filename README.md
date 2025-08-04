# BuscaCEP

BuscaCEP é uma aplicação Delphi para consulta de endereços e CEPs, integrando banco de dados local e WebServices (ViaCEP), com interface gráfica intuitiva.

## Principais Práticas Utilizadas

### Clean Code
O código segue princípios de legibilidade, clareza e simplicidade. Métodos possuem responsabilidades bem definidas, nomes autoexplicativos e baixo acoplamento.

### Programação Orientada a Objetos (POO)
O projeto é estruturado em classes e objetos, como [`TCep`](src/Model/uCEPModel.pas), [`TCEPController`](src/Controller/uCEPController.pas) e [`TCepComponente`](src/Component/uCepComponente.Component.pas), promovendo encapsulamento, herança e polimorfismo.

### Serialização e Desserialização de Objetos JSON
Utiliza a biblioteca REST.JSON para serializar e desserializar objetos, facilitando a integração com APIs REST. Veja o uso em [`TCepComponente.ConsultaCEPWS`](src/Component/uCepComponente.Component.pas).

### Utilização de Interfaces
Interfaces são empregadas para abstrair contratos, como em [`ICepComponente`](src/Component/uCepComponente.Intf.pas), promovendo flexibilidade e testabilidade.

### Aplicação de Patterns
O projeto utiliza diversos padrões de projeto:
- **Singleton**: Exemplo em [`TConexaoController.getInstance`](src/Controller/uConexaoController.pas).
- **DAO (Data Access Object)**: Separação da lógica de acesso a dados em [`TDAOCep`](src/DAO/uDAOCep.pas).
- **Component**: Criação de componentes reutilizáveis, como [`TCepComponente`](src/Component/uCepComponente.Component.pas).

### Criação de Componentes
Componentes Delphi personalizados são criados para encapsular funcionalidades de consulta de CEP, facilitando a reutilização e manutenção.

## Estrutura do Projeto

- **src/Model**: Modelos de dados (ex: [`TCep`](src/Model/uCEPModel.pas))
- **src/Controller**: Lógica de controle e orquestração
- **src/Component**: Componentes e interfaces reutilizáveis
- **src/DAO**: Acesso a dados
- **src/View**: Interface gráfica (Forms, DataSources, Grids)

## Funcionalidades

- Consulta de CEP por endereço ou CEP
- Integração com banco de dados local e ViaCEP (JSON/XML)
- Interface amigável com validação de campos
- Exibição dos dados em grids e campos vinculados

## Como Executar

1. Abra o projeto `BuscaCEP.dpr` no Delphi.
2. Compile e execute.
3. Utilize a interface para consultar CEPs ou endereços.
