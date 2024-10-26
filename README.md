Projeto de Bootstrap de Cluster ECS

Este repositório contém uma coleção de scripts e configurações de infraestrutura como código (IaC) para provisionar e configurar um cluster ECS (Elastic Container Service) na AWS, utilizando o Terraform como ferramenta de provisionamento.
Visão Geral

Este projeto configura a infraestrutura básica necessária para executar um cluster ECS e implementar uma aplicação com pipeline de deploy e rollback, incluindo:

- VPC: Criação de uma VPC dedicada para o cluster ECS.
- Subnets: Configuração de subnets públicas e privadas em múltiplas zonas de disponibilidade para alta disponibilidade.
- Internet Gateway e NAT Gateway: Configuração para permitir a conectividade de saída dos containers em subnets privadas.
- Tabelas de Roteamento: Associadas a subnets públicas e privadas.
- Security Groups: Para controlar o acesso ao cluster.
- Cluster ECS: Instância básica do ECS configurada para uso com Fargate ou EC2.
- IAM Roles e Policies: Configurações de permissões para permitir que o ECS acesse os recursos necessários na AWS.
- Aplicação ECS: Configuração de uma aplicação no ECS com uma definição de tarefa e serviço.
- Pipeline de Deploy: Configuração de uma pipeline de deploy usando GitHub Actions ou AWS CodePipeline para automatizar a entrega contínua.
- Rollback: Instruções de rollback para reverter a versão da task definition em caso de falha no deploy.

Estrutura do Projeto

A estrutura do repositório é organizada da seguinte forma:



Pré-requisitos

Antes de iniciar, certifique-se de ter os seguintes itens instalados e configurados:

- Terraform >= 0.12
- AWS CLI com perfil configurado
- Conta AWS com permissões para criar recursos ECS, IAM, VPC e de rede

Configuração da Aplicação no ECS

A aplicação no ECS é configurada com uma definição de tarefa (task definition) que descreve o container e seu ambiente. Esta configuração pode incluir:

- Definições de containers: imagem, portas, variáveis de ambiente.
- Regras de auto-scaling.
- Configuração de rede (subnets, security groups).
- Service ECS: garante que a aplicação esteja sempre em execução com o número desejado de instâncias.

Considerações Finais

Este projeto fornece a base de infraestrutura para rodar workloads no ECS. Dependendo das necessidades da aplicação, outros recursos podem ser necessários, como balanceadores de carga, integração com RDS ou outros serviços gerenciados pela AWS.