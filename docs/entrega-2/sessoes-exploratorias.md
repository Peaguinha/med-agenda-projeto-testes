# Sessões de teste exploratório (Entrega 2)

Foram realizadas duas sessões de teste exploratório baseado em sessão (SBTM), nas áreas sugeridas pelo enunciado. Cada sessão tem um charter (missão), timebox de 60 minutos, anotações cronológicas, achados e perguntas. As requisições foram feitas diretamente na API com um script de apoio que registra cada chamada (método, rota, perfil, código e resposta) e salva os PDFs gerados; esses registros são a evidência da sessão e estão no repositório. Os achados são **candidatos a defeito**: na Entrega final cada um será reexecutado pelo caso de teste correspondente e, se confirmado, registrado como issue no modelo da seção 8.

## Sessão 1: assistente virtual

| Campo | Registro |
|---|---|
| Charter | Explorar o assistente virtual com mensagens de paciente, secretária e médico, usando variações de escrita (maiúsculas, acentos, frases mistas), sinais de urgência e pedidos clínicos, para descobrir respostas inseguras, incorretas ou fora do escopo administrativo. |
| Área e requisitos | Assistente virtual (POST /api/chat, GET /api/chat). Requisitos: RN18, RF13, RNF01, RNF07. |
| Testador(es) | Pedro Henrique de Almeida Peixoto (execução via API com script de apoio). Revisão prevista: Washingtton Lucena Bandeira Filho. |
| Data, hora e duração | 26/11/2026 (quinta-feira). Requisições às 09:13; análise e anotações em seguida. Timebox planejado: 60 min. |
| Ambiente | MedAgenda 1.0.0 em Docker Desktop (Windows 11), API em http://localhost:3000/api, assistente em modo local (sem IA_API_KEY). |
| Dados e contas | Seed restaurado às 09:12 (198 consultas). Contas: ana.souza (paciente), joana.lima (secretária), helena.costa (médica), carlos.lima (paciente). 43 mensagens enviadas. |
| Distribuição do tempo (T/B/S) | Estimativa da equipe: preparação (oráculo e script) 20%, teste 50%, investigação de achados 30%. |
| Evidências | docs/entrega-2/evidencias/sessao-1-assistente/ (log-requisicoes.json, resumo.json) |

### Anotações

| # | O que foi feito | O que se observou |
|---|---|---|
| 1 | Oráculo: listar as consultas futuras ativas de Ana e ordenar por data. | Mais próxima: 30/11/2026 10:00 com Dra. Helena (Agendada); depois 01/12 09:20 (Dr. Ricardo, Confirmada) e 08/12 14:30 (Dra. Helena). |
| 2 | Saudação: “Oi” e “Olá”. | Resposta de boas-vindas com o primeiro nome. OK. |
| 3 | “Qual é a minha próxima consulta?” e “quando é minha consulta?”. | Responde **08/12/2026, 14:30 com Dra. Helena**, a consulta mais **distante**, não a mais próxima (30/11). Formato “08/12/2026, 14:30” com vírgula. |
| 4 | Urgência em minúsculas: “estou com dor no peito”, “sinto falta de ar”, “tive um desmaio”, “está com sangramento”, “ele teve uma convulsão”. | Todas recebem a orientação do SAMU (192). OK. |
| 5 | Mesmos sinais com maiúsculas ou sem acento: “DOR NO PEITO”, “Desmaio”, “Sangramento forte”, “Falta de ar desde cedo”, “CONVULSÃO”, “Convulsao”. | Todas recebem “Não entendi…”, **sem orientação de urgência**. “Estou com dor no peito” funciona (o termo está em minúsculas no meio da frase); o problema aparece quando o termo tem letra maiúscula ou não tem acento. |
| 6 | Erro de digitação com acento: “dor no peíto”. | “Não entendi…”, sem orientação de urgência. |
| 7 | Frases mistas: “Oi, estou com falta de ar”; “Estou com dor no peito, posso tomar algum remédio?”; “meu filho desmaiou”. | Urgência tem precedência sobre saudação e pedido de remédio. OK. |
| 8 | Pedidos clínicos: remédio para dor de cabeça, dipirona, febre, diagnóstico para tosse. | Recusa de diagnóstico/medicamento e orientação para agendar. OK. |
| 9 | “Qual antibiótico é bom para garganta?” | “Não entendi…”: não indica medicamento, mas também não dá a orientação de procurar um médico. |
| 10 | Temas administrativos: médicos, horário, plano de saúde, cancelar, agendar, atestado. | Respostas coerentes. OK. |
| 11 | “Tenho uma dúvida sobre o convênio” e “Tenho consulta com qual médico?”. | Recebem a resposta de “não posso avaliar sintomas…”: a palavra “tenho” é tratada como pedido clínico. |
| 12 | “que coisa” e “obrigada”. | “que coisa” recebe a saudação (contém “oi”); “obrigada” recebe “Não entendi”. |
| 13 | Secretária e médica perguntam pela “próxima consulta”. | Orientação para usar o menu Agenda. OK. |
| 14 | Secretária envia “DOR NO PEITO”; médica envia “o paciente está com falta de ar”. | Mesmo comportamento: maiúsculas falham, minúsculas funcionam. |
| 15 | Limites: mensagem vazia, só espaços, 500 e 501 caracteres. | Vazia e espaços: 400 “Escreva uma mensagem”. 500: 201. 501: 400 “Mensagem com no máximo 500 caracteres”. OK. |
| 16 | Histórico: GET /api/chat como Ana e como Carlos. | Ana vê as próprias mensagens (limite de 50); Carlos não vê nada de Ana. OK. |

### Achados

| ID | Achado | Requisito | Severidade proposta | Próximo passo |
|---|---|---|---|---|
| A1.1 | Sinais de urgência com letra maiúscula ou sem acento (“DOR NO PEITO”, “Desmaio”, “CONVULSÃO”, “Convulsao”, “Sangramento forte”, “dor no peíto”) não recebem a orientação do SAMU (192). | RN18 | Crítica | Confirmar com o CT de urgência e o BDD rn18; registrar DEF. |
| A1.2 | “Próxima consulta” informa a consulta ativa mais distante (08/12) em vez da mais próxima (30/11). | RN18 | Alta | Confirmar com o CT da próxima consulta; registrar DEF. |
| A1.3 | Mensagens administrativas iniciadas por “Tenho” recebem a recusa clínica; “que coisa” recebe saudação. | RF13 · RNF07 | Baixa | Novo caso derivado (intenção). |
| A1.4 | Pergunta sobre antibiótico recebe “Não entendi” sem orientar a procurar um médico. | RN18 | Baixa | Novo caso derivado. |

### Perguntas

- RN18 vale também quando quem escreve é a secretária ou o médico? A equipe assumiu que sim (a regra não restringe o perfil).
- Erros de digitação (“peíto”) estão cobertos por “independentemente de acentos”? A equipe assumiu que sim para acentos e caixa, e registrou o erro de digitação só como observação.

## Sessão 2: relatórios e PDFs

| Campo | Registro |
|---|---|
| Charter | Explorar os relatórios de consultas e financeiro (tela e PDF) e os documentos clínicos em PDF, comparando cada número com um oráculo calculado a partir da listagem de consultas, para descobrir divergências de cálculo, de período, de formato e de permissão. |
| Área e requisitos | GET /api/relatorios/consultas[.pdf], /relatorios/financeiro[.pdf], /consultas/:id/{comprovante,receita,atestado}.pdf. Requisitos: RF09, RF15, RN14, RN16, RN17, RN19, MP-10 a MP-13, RNF02. |
| Testador(es) | Pedro Henrique de Almeida Peixoto (execução via API com script de apoio). Revisão prevista: Washingtton Lucena Bandeira Filho. |
| Data, hora e duração | 26/11/2026 (quinta-feira). Rodada 1 às 09:13 e rodada 2 às 09:14; análise e anotações em seguida. Timebox planejado: 60 min. |
| Ambiente | Mesmo ambiente da sessão 1. PDFs lidos com pdf-parse. |
| Dados e contas | Seed restaurado às 09:12. Período principal: 27/10/2026 a 25/11/2026 (30 dias até ontem). Contas: admin, joana.lima, helena.costa, ricardo.alves, ana.souza, carlos.lima. |
| Distribuição do tempo (T/B/S) | Estimativa da equipe: preparação (oráculo) 30%, teste 40%, investigação de achados 30%. |
| Evidências | docs/entrega-2/evidencias/sessao-2-relatorios-pdfs/ (log-requisicoes.json, log-requisicoes-rodada-2.json, resumos e PDFs gerados) |

### Anotações

| # | O que foi feito | O que se observou |
|---|---|---|
| 1 | Oráculo do período 27/10 a 25/11 a partir de GET /api/consultas (admin). | 89 consultas: 57 realizadas, 17 faltas, 15 canceladas. Taxa de faltas esperada 17 ÷ (57 + 17) = 23,0%; cancelamento 15 ÷ 89 = 16,9%. Receita esperada: R$ 14.300,00 em 57 atendimentos. |
| 2 | Relatório de consultas do mesmo período. | Total **85**, realizadas **53**: faltam as 4 consultas de 25/11 (último dia). Taxa de faltas **20,0%** = 17 ÷ 85 (dividida pelo total), diferente da regra mesmo com os números do próprio relatório (17 ÷ 70 = 24,3%). |
| 3 | Período de um único dia: 25/11 a 25/11. | Total **0**; o banco tem 4 consultas nesse dia. O dia final não entra no período. |
| 4 | Fim antes do início; data no formato 01/11/2026. | 400 nos dois. OK. |
| 5 | Relatório financeiro do período. | Receita **R$ 17.400,00** em **68 atendimentos**: 68 = 53 realizadas + 15 canceladas. Consultas canceladas entram na receita. |
| 6 | Período máximo: 01/01 a 31/12/2026; 01/01/2026 a 01/01/2027; a 02/01/2027. | Os três aceitos (200). Períodos de mais de 1 ano são aceitos. |
| 7 | PDF do financeiro × JSON da tela. | Mesmos números (R$ 17.400,00; 68; R$ 255,88), em reais com duas casas. Consistente, mas herda o erro da receita. |
| 8 | PDF do relatório de consultas de 24/11 a 25/11 × horários da tela. | Só aparecem as consultas de 24/11, com horários **3 h adiantados**: 11:30 → “14:30”, 12:00 → “15:00”, 14:00 → “17:00” (UTC em vez de Brasília). As de 25/11 não aparecem. |
| 9 | Receita de consulta realizada de Ana (28/09, ibuprofeno) como Ana. | PDF com cabeçalho da clínica, paciente, CPF, medicamento, posologia, nome e CRM/PB 10234 da médica. OK. |
| 10 | Receita da mesma consulta com cada perfil. | Admin, Dra. Helena e Ana: 200. Secretária, Dr. Ricardo e Carlos: 403. OK. |
| 11 | Atestado e comprovante de consulta realizada de 25/11 (3 dias de atestado, sem prescrição). | Receita: 404 “Consulta sem prescrição” (OK). Atestado com nome, CRM e “3 dia(s)”, mas o texto termina em “a partir de 25/11/2026,.” e a data aparece como “25/11/2026, 10:30”. Comprovante mostra “Situação: REALIZADA” (código interno). |
| 12 | Comprovante e receita de consulta futura de Ana. | Comprovante 200; receita 422 “Documento disponível após a consulta”. OK. |
| 13 | Detalhe da consulta realizada (GET /api/consultas/:id) como secretária, médica e paciente. | **A secretária recebe o prontuário completo** (queixa, diagnóstico, prescrição). Na listagem filtrada por paciente o prontuário não aparece. Dr. Ricardo recebe 403. OK para os demais. |
| 14 | Permissões dos relatórios. | Secretária: consultas 200 e financeiro 403; paciente 403; Dra. Helena pedindo o medicoId do Dr. Ricardo vê só a própria linha. OK. |

### Achados

| ID | Achado | Requisito | Severidade proposta | Próximo passo |
|---|---|---|---|---|
| A2.1 | Secretária vê o prontuário completo no detalhe da consulta (dado sensível; a matriz 3.1 nega). | MP-10 · RNF02 | Crítica | Confirmar com o CT de privacidade do prontuário; registrar DEF. |
| A2.2 | Receita do financeiro inclui consultas canceladas (68 “atendimentos” e R$ 17.400,00 no lugar das realizadas). | RN17 | Crítica | Confirmar com o CT do financeiro; registrar DEF. |
| A2.3 | O período dos relatórios exclui o dia final (um único dia retorna 0 consultas). | RN16 · RN17 | Alta | Confirmar com o CT de período inclusivo; registrar DEF. |
| A2.4 | Taxa de faltas calculada como faltas ÷ total, e não faltas ÷ (realizadas + faltas). | RN16 | Alta | Confirmar com o CT do oráculo; registrar DEF. |
| A2.5 | PDF do relatório de consultas imprime horários em UTC (3 h adiantados). | RN19 | Média | Confirmar com o CT do PDF de consultas; registrar DEF. |
| A2.6 | Financeiro aceita período maior que 1 ano (até 01/01 e 02/01 do ano seguinte). | RN17 | Média | Confirmar com o CT de período de 1 ano; registrar DEF. |
| A2.7 | Atestado termina em “a partir de 25/11/2026,.” e datas dos PDFs aparecem como “dd/mm/aaaa, hh:mm” (com vírgula). | RN19 · RN14 | Baixa | Novo caso derivado. |
| A2.8 | Comprovante exibe a situação como código interno (“REALIZADA”). | RNF07 · RN14 | Baixa | Novo caso derivado. |

### Perguntas

- A taxa de cancelamento usa como denominador o total do período (inclusive agendadas futuras)? A equipe seguiu a RN16 literal: canceladas ÷ total.
- O atestado conta os dias “a partir da data da consulta” mesmo quando emitido depois? A equipe assumiu que sim, por ser o que o documento declara.
