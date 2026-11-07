# MedAgenda: Plano de Testes e Validação

Projeto da disciplina **Teste de Software (2026.2)**, Ciências da Computação, UNIFACISA. Prof. Bruno Rafael Araújo Vasconcelos.

Somos a equipe de qualidade contratada pela Clínica MedAgenda para validar o sistema de agendamento e atendimento médico antes do uso com pacientes reais. O objetivo é entregar um plano de testes, casos de teste, uma suíte automatizada, o relatório de execução e um parecer de validação.

## Equipe

| Integrante | Matrícula |
|---|---|
| Pedro Henrique de Almeida Peixoto | 2413080023 |
| Washingtton Lucena Bandeira Filho | 2413080069 |

## Entregas

| Entrega | Data | Conteúdo | Situação |
|---|---|---|---|
| 1 | 19/11/2026 | Plano de testes | Em elaboração: [docs/Plano-de-Testes-MedAgenda-Entrega-1.docx](docs/Plano-de-Testes-MedAgenda-Entrega-1.docx) |
| 2 | 01/12/2026 | Casos de teste, Gherkin, sessões exploratórias, matriz de rastreabilidade | Não iniciada |
| Final | 15/12/2026 | Suíte no CI, defeitos, relatório com parecer, vídeo e apresentação | Não iniciada |

## Sobre o código do sistema

As pastas `api/` e `web/` e o arquivo `docker-compose.yml` são o **código original do MedAgenda, fornecido pelo professor, sem nenhuma alteração**: o objeto do trabalho é testar o sistema como foi entregue. O README original está em [docs/README-medagenda-original.md](docs/README-medagenda-original.md).

SHA-256 do `medagenda.zip` recebido: `DF93E0FDB0DEC95C4A13E081FA17575A436259EDBC4A6C9D4684E80CA4C9AC28`

## Como executar o sistema

Requisitos: Docker Desktop (ou Docker Engine com Compose) e Git. Use um caminho sem acentos e sem espaços.

```bash
docker compose up --build
```

| Serviço | Endereço |
|---|---|
| Interface web | http://localhost:8080 |
| API | http://localhost:3000/api |
| Saúde da API | http://localhost:3000/api/saude |
| MongoDB | mongodb://localhost:27017/medagenda |

Para voltar os dados ao estado inicial entre rodadas de teste:

```bash
docker compose exec api npm run seed
```

Contas de teste e demais comandos: veja o plano de testes (seção 6) e o README original.

## Estrutura do repositório

```
├── api/, web/, docker-compose.yml   código original do MedAgenda (sem alterações)
├── docs/                            plano de testes, casos, matriz, sessões, evidências
└── tests/                           suítes automatizadas (a partir da Entrega 2)
    ├── api/   e2e/   bdd/   carga/   a11y/   comum/
```

Ferramentas previstas: Jest + Supertest (API), Playwright com Page Objects (interface), pdf-parse (PDFs), Cucumber.js (BDD), k6 (desempenho), axe-core (acessibilidade) e GitHub Actions (CI).

## Dados

Usamos apenas os dados fictícios do sistema. Nenhum dado real de pessoas é cadastrado.
