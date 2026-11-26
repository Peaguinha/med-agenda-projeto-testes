# Casos de teste: MedAgenda (Entrega 2)

94 casos no modelo da seção 7.1 do enunciado. Fonte única: `_gerador/casos.js` (o documento da entrega e estes arquivos saem dela).

## Autenticação, contas e Meu perfil

### CT-001 · Login com credenciais válidas em cada perfil

| Campo | Conteúdo |
|---|---|
| Requisito | RF01 |
| Técnica | Partição de equivalência (classe válida, um representante por perfil) |
| Execução prevista | ADM, SEC, MED, PAC · UI + API · Jest e Playwright |
| Pré-condições | Dados iniciais restaurados (seed); nenhum usuário logado. |
| Passos / entrada | 1. Para cada uma das 9 contas ativas (seção 6.3 do plano), informar e-mail e senha corretos na tela de login.<br>2. Repetir via API: POST /api/auth/login com o mesmo par. |
| Resultado esperado | Acesso concedido e painel inicial do perfil correspondente exibido. API: 200 com token JWT e dados do usuário, **sem** o campo de senha (RNF02). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-002 · Login com senha incorreta é recusado

| Campo | Conteúdo |
|---|---|
| Requisito | RF01 · RNF07 |
| Técnica | Partição de equivalência (classe inválida: senha errada; e-mail inexistente) |
| Execução prevista | Anônimo · UI + API · Jest e Playwright |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Informar joana.lima@medagenda.dev com a senha Errada@2026.<br>2. Informar naoexiste@medagenda.dev com a senha Secretaria@2026. |
| Resultado esperado | Acesso negado nos dois casos com a mesma mensagem genérica em português (“E-mail ou senha inválidos”), sem revelar qual campo está errado. API: 401; nenhum token emitido. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-003 · Login com campos obrigatórios vazios

| Campo | Conteúdo |
|---|---|
| Requisito | RF01 · RNF01 · RNF07 |
| Técnica | Partição de equivalência (campo ausente) |
| Execução prevista | Anônimo · UI + API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Enviar o login com e-mail vazio e senha preenchida.<br>2. Enviar com e-mail preenchido e senha vazia.<br>3. Enviar corpo JSON vazio pela API. |
| Resultado esperado | Requisição recusada com mensagem em português próxima ao campo (“Informe e-mail e senha”). API: 400. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-004 · Conta desativada não consegue entrar

| Campo | Conteúdo |
|---|---|
| Requisito | RN04 · RF01 |
| Técnica | Tabela de decisão (credencial correta × conta inativa) |
| Execução prevista | Anônimo · UI + API · Jest, Playwright e BDD |
| Pré-condições | Dados iniciais restaurados (seed); conta pedro.santos@medagenda.dev desativada (situação inicial). |
| Passos / entrada | 1. Informar pedro.santos@medagenda.dev / Secretaria@2026 na tela de login.<br>2. Repetir via POST /api/auth/login. |
| Resultado esperado | Acesso negado com mensagem clara; nenhum token emitido (API 401 ou 403). A conta continua desativada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-005 · Login ignora maiúsculas e minúsculas no e-mail

| Campo | Conteúdo |
|---|---|
| Requisito | RN02 · RF01 |
| Técnica | Partição de equivalência (mesmo e-mail com caixa diferente) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. POST /api/auth/login com ADMIN@MEDAGENDA.DEV / Admin@2026.<br>2. Repetir com Admin@MedAgenda.dev. |
| Resultado esperado | Login aceito nas duas variações (o e-mail é único sem diferenciar maiúsculas de minúsculas). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-006 · Sair do sistema encerra a sessão

| Campo | Conteúdo |
|---|---|
| Requisito | RF01 |
| Técnica | Teste de fluxo (caso de uso) |
| Execução prevista | SEC · UI · Playwright |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Clicar em Sair.<br>2. Tentar acessar diretamente a URL de uma página interna (ex.: /consultas).<br>3. Usar o botão Voltar do navegador. |
| Resultado esperado | Volta à tela de login; páginas internas não são exibidas sem novo login; o token é removido do navegador. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-007 · Token ausente, adulterado ou expirado é recusado

| Campo | Conteúdo |
|---|---|
| Requisito | RNF02 · RNF01 |
| Técnica | Suposição de erro |
| Execução prevista | Anônimo e PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); token válido de ana.souza obtido no login. |
| Passos / entrada | 1. GET /api/consultas sem cabeçalho Authorization.<br>2. Repetir com o token alterado em um caractere da assinatura.<br>3. Decodificar o token e conferir os campos iat e exp. |
| Resultado esperado | Passos 1 e 2: 401 com mensagem em português e sem detalhes internos. Passo 3: validade de 8 horas (exp − iat = 28.800 s). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-008 · Administrador cria conta de secretária

| Campo | Conteúdo |
|---|---|
| Requisito | RF02 · RN01 |
| Técnica | Partição de equivalência (dados válidos) |
| Execução prevista | ADM · UI + API · Playwright (fluxo E2E 4) e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Em Usuários, criar conta: nome Rita Teste, e-mail rita.teste+<timestamp>@medagenda.dev, perfil Secretária, senha Senha@2026.<br>2. Sair e entrar com a nova conta. |
| Resultado esperado | Conta criada (API 201) sem retorno de senha; login da nova conta funciona e abre o painel da recepção. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-009 · Quem pode criar contas e de qual perfil

| Campo | Conteúdo |
|---|---|
| Requisito | RN01 · MP-01 |
| Técnica | Tabela de decisão (perfil de quem cria × perfil criado) |
| Execução prevista | ADM, SEC, MED, PAC · API · Jest (orientado a dados) |
| Pré-condições | Dados iniciais restaurados (seed); tokens dos 4 perfis. |
| Passos / entrada | 1. Com o token de cada perfil, enviar POST /api/usuarios para criar conta de MÉDICO, SECRETÁRIA, PACIENTE (vinculada a ficha sem conta) e ADMIN, com dados válidos.<br>2. Registrar o código de cada uma das 16 combinações. |
| Resultado esperado | Admin: médico, secretária e paciente → 201; admin → recusado (400/422, não existe segundo administrador). Secretária, médico e paciente: todas as combinações → 403 e nenhuma conta criada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-010 · Conta de paciente exige ficha e cada ficha tem no máximo uma conta

| Campo | Conteúdo |
|---|---|
| Requisito | RN01 |
| Técnica | Tabela de decisão (ficha informada × ficha já tem conta) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; ficha de Roberto Farias (sem conta). |
| Passos / entrada | 1. Criar conta PACIENTE sem pacienteId.<br>2. Criar conta PACIENTE para a ficha de Roberto Farias.<br>3. Criar outra conta PACIENTE para a mesma ficha, com outro e-mail.<br>4. Criar conta para a ficha de Ana Beatriz Souza (já tem conta). |
| Resultado esperado | Passo 1: 400. Passo 2: 201. Passos 3 e 4: 409 (ficha já tem conta). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-011 · E-mail repetido com caixa diferente é recusado

| Campo | Conteúdo |
|---|---|
| Requisito | RN02 · RNF01 |
| Técnica | Partição de equivalência (e-mail existente, variação de caixa) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Criar conta de secretária com o e-mail Joana.Lima@MedAgenda.dev.<br>2. Editar a conta criada no CT de criação para o e-mail JOANA.LIMA@medagenda.dev. |
| Resultado esperado | Ambos recusados com 409 “E-mail já cadastrado”; nenhuma conta duplicada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-012 · Política de senha na criação de conta (valores-limite)

| Campo | Conteúdo |
|---|---|
| Requisito | RN03 |
| Técnica | Análise de valor-limite (7/8 caracteres) e partição (falta de classe de caractere) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Criar contas com as senhas: Abcdef1 (7), Abcdefg1 (8), abcdefg1 (sem maiúscula), ABCDEFG1 (sem minúscula), Abcdefgh (sem número). |
| Resultado esperado | Apenas Abcdefg1 é aceita (201). As demais: 400 com a regra explicada em português. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-013 · Redefinição de senha pelo administrador

| Campo | Conteúdo |
|---|---|
| Requisito | RN03 · RF02 |
| Técnica | Partição de equivalência (senha fraca × forte) |
| Execução prevista | ADM · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; conta de secretária criada no teste. |
| Passos / entrada | 1. Redefinir a senha para abc12345.<br>2. Redefinir para Nova@2026.<br>3. Entrar com a senha antiga e depois com Nova@2026. |
| Resultado esperado | Passo 1: 400. Passo 2: sucesso (204). Passo 3: senha antiga recusada (401), nova aceita. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-014 · Troca da própria senha exige senha atual e senha forte

| Campo | Conteúdo |
|---|---|
| Requisito | RN03 · RF14 · MP-14 |
| Técnica | Tabela de decisão (senha atual correta × nova senha forte) |
| Execução prevista | PAC · API + UI · Jest e Playwright |
| Pré-condições | Dados iniciais restaurados (seed); conta de paciente criada no teste e logada. |
| Passos / entrada | 1. Trocar senha informando senha atual errada e nova Forte@2026.<br>2. Informar senha atual correta e nova 12345678.<br>3. Informar senha atual correta e nova abc.<br>4. Informar senha atual correta e nova Forte@2026. |
| Resultado esperado | Passo 1: recusado (senha atual incorreta). Passos 2 e 3: recusados (400, política de senha). Passo 4: aceito; login seguinte só funciona com a nova senha. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-015 · Ativar e desativar contas; admin não desativa a si mesmo

| Campo | Conteúdo |
|---|---|
| Requisito | RN04 · RF02 · MP-02 |
| Técnica | Transição de estados (ativa ↔ inativa) |
| Execução prevista | ADM · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; conta de secretária criada no teste. |
| Passos / entrada | 1. Desativar a própria conta do administrador.<br>2. Desativar a conta de secretária do teste e tentar login com ela.<br>3. Reativar a conta e tentar login novamente. |
| Resultado esperado | Passo 1: 422, conta continua ativa. Passo 2: desativação aceita e login recusado. Passo 3: login volta a funcionar. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-016 · Validação dos dados do médico (CRM, valor, duração, agenda)

| Campo | Conteúdo |
|---|---|
| Requisito | RN06 · RF02 |
| Técnica | Partição de equivalência e valor-limite |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Criar médico com duração 15, 20, 30, 40 e 60 (uma conta por valor).<br>2. Criar médico com duração 10, 25, 45 e 90.<br>3. Valor da consulta 0,00 e depois 0,01.<br>4. CRM “CRM/PB 12345” × “CRM PB 12345” × “12345”.<br>5. Agenda vazia; bloco com início 14:00 e fim 12:00. |
| Resultado esperado | Aceitos: durações 15/20/30/40/60, valor 0,01, CRM no formato CRM/UF número. Recusados com 400: durações 10/25/45/90, valor 0,00, CRM fora do formato, agenda vazia e bloco com fim antes do início. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-017 · Meu perfil: alterar nome e telefone

| Campo | Conteúdo |
|---|---|
| Requisito | RF14 · MP-14 · RN05 · RNF07 |
| Técnica | Partição de equivalência (telefone válido × inválido) |
| Execução prevista | Todos os perfis · UI + API · Jest e Playwright |
| Pré-condições | Dados iniciais restaurados (seed); logado com cada perfil. |
| Passos / entrada | 1. Alterar o telefone para (83) 98888-1234 e salvar.<br>2. Alterar o telefone para 8398888 e salvar.<br>3. Alterar o nome para “Al” (2 caracteres). |
| Resultado esperado | Passo 1: salvo e exibido. Passos 2 e 3: recusados (400) com mensagem em português junto ao campo. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-018 · Médico não altera o próprio valor, duração, agenda ou CRM

| Campo | Conteúdo |
|---|---|
| Requisito | MP-15 · RF14 |
| Técnica | Suposição de erro (campo proibido enviado direto à API) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como helena.costa. |
| Passos / entrada | 1. PUT /api/perfil com {"valorConsulta": 1, "duracaoConsulta": 60, "crm": "CRM/PB 99999"}.<br>2. Consultar GET /api/medicos. |
| Resultado esperado | Alteração recusada (403) ou ignorada: Dra. Helena continua com R$ 200,00, 30 min e CRM/PB 10234. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Fichas de pacientes

### CT-019 · Cadastrar ficha de paciente válida

| Campo | Conteúdo |
|---|---|
| Requisito | RF03 · RN05 |
| Técnica | Partição de equivalência (todos os campos válidos) |
| Execução prevista | SEC · UI + API · Playwright e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Cadastrar: nome Paciente Teste Silva, CPF válido gerado no teste, nascimento 01/01/2000, telefone (83) 99999-0000, convênio em branco.<br>2. Buscar pelo nome. |
| Resultado esperado | Ficha criada (201) com convênio “Particular” por padrão e encontrada na busca. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-020 · Tamanho do nome do paciente (valores-limite)

| Campo | Conteúdo |
|---|---|
| Requisito | RN05 |
| Técnica | Análise de valor-limite (2, 3, 120 e 121 caracteres) |
| Execução prevista | SEC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Cadastrar fichas com nomes de 2, 3, 120 e 121 caracteres (demais campos válidos, CPFs distintos). |
| Resultado esperado | 3 e 120 caracteres: 201. 2 e 121: 400 com mensagem sobre o tamanho do nome. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-021 · CPF com dígito verificador errado, repetido ou já cadastrado

| Campo | Conteúdo |
|---|---|
| Requisito | RN05 · RNF01 |
| Técnica | Partição de equivalência e suposição de erro |
| Execução prevista | SEC · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Cadastrar com CPF 123.456.789-00 (dígitos verificadores errados).<br>2. Cadastrar com 111.111.111-11.<br>3. Cadastrar com o CPF da ficha de Ana Beatriz Souza.<br>4. Cadastrar com CPF válido sem máscara (11 dígitos). |
| Resultado esperado | Passos 1 e 2: 400 “CPF inválido”. Passo 3: 409 (CPF já cadastrado). Passo 4: 201, CPF guardado com máscara. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-022 · Data de nascimento (valores-limite em torno de hoje)

| Campo | Conteúdo |
|---|---|
| Requisito | RN05 |
| Técnica | Análise de valor-limite (hoje × amanhã) e partição (ausente, inválida) |
| Execução prevista | SEC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Cadastrar com nascimento = hoje.<br>2. Cadastrar com nascimento = amanhã.<br>3. Cadastrar sem nascimento.<br>4. Cadastrar com 2026-02-30. |
| Resultado esperado | Hoje: 201. Amanhã, ausente e data inexistente: 400. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-023 · Formato do telefone do paciente

| Campo | Conteúdo |
|---|---|
| Requisito | RN05 |
| Técnica | Partição de equivalência |
| Execução prevista | SEC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Cadastrar com (83) 99999-9999.<br>2. Cadastrar com 99999-9999 (sem DDD).<br>3. Cadastrar com (83) 9999A-9999. |
| Resultado esperado | Primeiro aceito (201); os demais recusados (400) com a mensagem do formato (83) 99999-9999. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-024 · Buscar paciente por nome ou CPF

| Campo | Conteúdo |
|---|---|
| Requisito | RF03 |
| Técnica | Partição de equivalência (por nome parcial, por CPF com e sem máscara, sem resultado) |
| Execução prevista | SEC · UI + API · Playwright e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Buscar “souza”.<br>2. Buscar o CPF de Ana com máscara e depois só os dígitos.<br>3. Buscar “zzzz”. |
| Resultado esperado | Passos 1 e 2: retorna Ana Beatriz Souza. Passo 3: lista vazia com aviso de nenhum resultado. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-025 · Editar ficha de paciente

| Campo | Conteúdo |
|---|---|
| Requisito | RF03 · RN05 · MP-03 |
| Técnica | Partição de equivalência |
| Execução prevista | SEC · UI + API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); ficha criada no teste. |
| Passos / entrada | 1. Alterar o convênio para Bem Estar Saúde e o telefone para (83) 98765-4321.<br>2. Alterar o CPF para o CPF de outro paciente. |
| Resultado esperado | Passo 1: alterações salvas. Passo 2: 409, CPF continua o original. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Médicos e horários livres

### CT-026 · Listar somente médicos ativos

| Campo | Conteúdo |
|---|---|
| Requisito | RF04 |
| Técnica | Partição de equivalência (ativo × inativo) |
| Execução prevista | PAC e SEC · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); médico criado e desativado pelo admin no teste. |
| Passos / entrada | 1. GET /api/medicos como paciente.<br>2. Abrir Agendar consulta e ver a lista de médicos. |
| Resultado esperado | Aparecem os 3 médicos do seed com especialidade; o médico desativado não aparece. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-027 · Horários livres respeitam agenda, duração e ocupação

| Campo | Conteúdo |
|---|---|
| Requisito | RF04 · RN07 · RN06 |
| Técnica | Partição de equivalência por dia da semana e valor-limite do bloco |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); datas calculadas: a próxima segunda e a próxima terça a partir de amanhã. |
| Passos / entrada | 1. Horários de Dra. Helena na próxima segunda.<br>2. Horários de Dr. Ricardo na próxima terça.<br>3. Horários de Dr. Ricardo na próxima segunda e no próximo domingo.<br>4. Horários de Dra. Helena hoje. |
| Resultado esperado | Helena: inícios de 08:00 a 11:30 e de 14:00 a 17:30 a cada 30 min, sem os já ocupados. Ricardo (terça): 08:00 a 16:20 a cada 40 min. Segunda e domingo de Ricardo: lista vazia. Hoje: nenhum horário já passado. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-028 · Parâmetros inválidos na consulta de horários

| Campo | Conteúdo |
|---|---|
| Requisito | RNF01 · RF04 |
| Técnica | Suposição de erro |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. GET /api/medicos/<id Helena>/horarios?data=26-11-2026.<br>2. GET /api/medicos/abc/horarios?data=<data válida>.<br>3. GET com id inexistente bem formado. |
| Resultado esperado | Passo 1: 400 “Informe data=AAAA-MM-DD”. Passos 2 e 3: 404 “Médico não encontrado”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Agendamento

### CT-029 · Recepção agenda consulta em horário livre

| Campo | Conteúdo |
|---|---|
| Requisito | RF05 · RN07 · RN19 |
| Técnica | Teste de fluxo (caso de uso principal) |
| Execução prevista | SEC · UI + API · Playwright (fluxo E2E 2) e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Agendar consulta: paciente Roberto Farias, Dra. Helena Costa, próximo dia útil, primeiro horário livre, tipo Primeira consulta, motivo “Dor nas costas”. |
| Resultado esperado | Consulta criada (201) com situação Agendada, valor R$ 200,00 e data no formato dd/mm/aaaa hh:mm; o horário some da lista de livres. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-030 · Recepção faz encaixe com horário digitado

| Campo | Conteúdo |
|---|---|
| Requisito | RF05 · RN07 |
| Técnica | Partição de equivalência (encaixe válido dentro do bloco) |
| Execução prevista | SEC · UI + API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); Dra. Helena sem consultas entre 10:00 e 11:00 no dia escolhido. |
| Passos / entrada | 1. Agendar encaixe às 10:15 para Thiago Barbosa com Dra. Helena (término 10:45). |
| Resultado esperado | Consulta criada (201) das 10:15 às 10:45. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-031 · Agendamento em dia em que o médico não atende é recusado

| Campo | Conteúdo |
|---|---|
| Requisito | RN07 |
| Técnica | Partição de equivalência (dia fora da agenda) |
| Execução prevista | SEC · UI + API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Agendar consulta: paciente Roberto Farias; Dr. Ricardo Alves (atende ter e qui).<br>2. Data: a próxima segunda-feira; encaixe às 09:00.<br>3. Confirmar agendamento. |
| Resultado esperado | Recusado com a mensagem “Horário fora da agenda do médico” (API 422); nenhuma consulta criada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-032 · Limites do bloco de atendimento

| Campo | Conteúdo |
|---|---|
| Requisito | RN07 |
| Técnica | Análise de valor-limite (bloco 08:00–12:00, consulta de 30 min) |
| Execução prevista | SEC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); dia útil futuro sem consultas da Dra. Helena pela manhã. |
| Passos / entrada | 1. Encaixes para Dra. Helena às 07:59, 08:00, 11:30, 11:31 e 12:00 (pacientes distintos). |
| Resultado esperado | 08:00 e 11:30 (término 12:00): 201. 07:59, 11:31 (término 12:01) e 12:00: 422 “Horário fora da agenda do médico”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-033 · Sobreposição total, parcial e adjacente de horários

| Campo | Conteúdo |
|---|---|
| Requisito | RN07 · RNF01 |
| Técnica | Tabela de decisão (relação entre a nova consulta e a existente) |
| Execução prevista | SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); consulta ativa da Dra. Helena das 09:00 às 09:30 num dia útil futuro. |
| Passos / entrada | 1. Encaixe às 09:00 (mesmo início).<br>2. Encaixe às 09:15 (sobreposição parcial ao fim).<br>3. Encaixe às 08:45 (sobreposição parcial ao início).<br>4. Encaixe às 09:30 e às 08:30 (adjacentes).<br>5. Cancelar a consulta das 09:00 e agendar de novo às 09:00. |
| Resultado esperado | Passos 1 a 3: 409 “Horário já ocupado”. Passo 4: 201 nos dois. Passo 5: 201 (horário cancelado volta a ficar livre). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-034 · Agendamento em data e hora passadas é recusado

| Campo | Conteúdo |
|---|---|
| Requisito | RN07 |
| Técnica | Partição de equivalência (passado × futuro) |
| Execução prevista | SEC e PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Como secretária, encaixe para Dra. Helena ontem às 10:00 (se ontem foi dia útil; senão, o último dia útil).<br>2. Como paciente (luiza.costa), o mesmo pelo portal. |
| Resultado esperado | Ambos recusados com 422; nenhuma consulta criada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-035 · Paciente agenda consulta para si pelo portal

| Campo | Conteúdo |
|---|---|
| Requisito | RF06 · MP-06 |
| Técnica | Teste de fluxo e suposição de erro (pacienteId de outra pessoa) |
| Execução prevista | PAC · UI + API · Playwright (fluxo E2E 1) e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como luiza.costa. |
| Passos / entrada | 1. Agendar com Dra. Helena em horário livre daqui a 3 dias úteis.<br>2. Via API, enviar o agendamento informando o pacienteId de Carlos Eduardo Lima. |
| Resultado esperado | Passo 1: 201, consulta em nome de Luíza. Passo 2: a consulta é criada para a própria Luíza ou recusada; nunca para Carlos. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-036 · Antecedência mínima de 2 horas no portal

| Campo | Conteúdo |
|---|---|
| Requisito | RN08 |
| Técnica | Análise de valor-limite (1h59 / 2h00 / 2h01) |
| Execução prevista | PAC e SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); janela de execução (seção 6.5 do plano): “agora + 2 h” dentro da agenda de um médico. |
| Passos / entrada | 1. Como luiza.costa, agendar para agora + 1 h 59 min.<br>2. Agendar para agora + 2 h 00 min (± 1 min).<br>3. Agendar para agora + 2 h 01 min.<br>4. Como secretária, encaixe para agora + 30 min. |
| Resultado esperado | 1h59: 422 “Agende com pelo menos 2 horas de antecedência”. 2h00 e 2h01: 201. Recepção com 30 min: 201 (sem restrição). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-037 · Paciente com 3 consultas futuras não agenda a quarta

| Campo | Conteúdo |
|---|---|
| Requisito | RN09 |
| Técnica | Análise de valor-limite (3 → 4) com estados Agendada e Confirmada |
| Execução prevista | PAC e SEC · API + UI · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); ana.souza tem 3 consultas futuras (2 agendadas e 1 confirmada). |
| Passos / entrada | 1. Como ana.souza, agendar uma quarta consulta.<br>2. Como secretária, agendar uma quarta consulta para Ana.<br>3. Cancelar uma das consultas futuras de Ana e agendar de novo. |
| Resultado esperado | Passos 1 e 2: 422 “O paciente já tem 3 consultas futuras”. Passo 3: 201 (volta a 3 futuras). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-038 · Contagem do limite inclui consultas confirmadas

| Campo | Conteúdo |
|---|---|
| Requisito | RN09 |
| Técnica | Análise de valor-limite (2 → 3 → 4) e partição por situação |
| Execução prevista | SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); ficha nova criada no teste, sem consultas. |
| Passos / entrada | 1. Agendar 3 consultas futuras para a ficha nova.<br>2. Confirmar 2 delas.<br>3. Tentar a quarta. |
| Resultado esperado | As 3 primeiras: 201. A quarta: 422, mesmo com 2 confirmadas e 1 agendada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-039 · Primeira consulta × retorno: valor e regras

| Campo | Conteúdo |
|---|---|
| Requisito | RN10 · RN19 |
| Técnica | Tabela de decisão (tipo × consulta realizada anterior × mesmo médico × situação anterior) |
| Execução prevista | SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). Ana tem consulta REALIZADA com a Dra. Helena há cerca de 10 dias; Fernanda tem FALTA com a Dra. Helena há cerca de 20 dias. |
| Passos / entrada | 1. Primeira consulta de Carlos (Particular) com Dra. Helena.<br>2. Primeira consulta de Patrícia (Bem Estar Saúde) com Dra. Helena.<br>3. Retorno de Ana com Dra. Helena na próxima data livre.<br>4. Retorno de Ana com Dr. Ricardo.<br>5. Retorno de Fernanda com Dra. Helena.<br>6. Retorno de ficha nova (sem histórico) com Dra. Helena. |
| Resultado esperado | 1 e 2: 201 com valor R$ 200,00 e o convênio do paciente registrado. 3: 201 com valor R$ 0,00. 4, 5 e 6: 422 “Retorno exige consulta realizada com o mesmo médico nos últimos 30 dias”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-040 · Prazo de 30 dias do retorno (valores-limite)

| Campo | Conteúdo |
|---|---|
| Requisito | RN10 |
| Técnica | Análise de valor-limite (29/30/31 dias após a consulta realizada) |
| Execução prevista | SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); consulta realizada de referência lida via API (data R). |
| Passos / entrada | 1. Agendar retorno no último horário da agenda em até R + 30 dias.<br>2. Agendar retorno no primeiro horário após R + 30 dias. |
| Resultado esperado | Dentro do prazo: 201 com R$ 0,00. Fora do prazo: 422. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-041 · Duplo clique e reenvio não duplicam o agendamento

| Campo | Conteúdo |
|---|---|
| Requisito | RNF06 · RN07 |
| Técnica | Suposição de erro |
| Execução prevista | SEC · UI + API · Playwright e Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. No formulário de agendamento, dar duplo clique em Confirmar.<br>2. Após o envio, recarregar a página (F5) e aceitar reenviar.<br>3. Via API, enviar duas requisições idênticas em paralelo. |
| Resultado esperado | Apenas uma consulta criada em cada situação; a segunda requisição da API recebe 409. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-042 · Notificações ao agendar

| Campo | Conteúdo |
|---|---|
| Requisito | RN15 · RF11 |
| Técnica | Tabela de decisão (evento AGENDADA × destinatários) |
| Execução prevista | SEC, PAC e MED · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); contadores do sino de luiza.costa e da Dra. Helena anotados. |
| Passos / entrada | 1. Agendar consulta para Luíza com Dra. Helena.<br>2. Ver o sino de Luíza e da Dra. Helena.<br>3. Agendar para Roberto Farias (sem conta). |
| Resultado esperado | Luíza recebe “Consulta agendada” e a Dra. Helena “Nova consulta na agenda”; cada contador sobe 1 imediatamente. Paciente sem conta: agendamento funciona sem erro. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Ciclo de vida da consulta

### CT-043 · Caminho completo do ciclo de vida

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 · RF07 · RF08 |
| Técnica | Transição de estados (transições válidas) |
| Execução prevista | SEC e MED · UI + API · Playwright (fluxo E2E 3) e Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta de hoje da Dra. Helena em situação Confirmada (seed). |
| Passos / entrada | 1. Como helena.costa, Iniciar atendimento.<br>2. Registrar prontuário com diagnóstico.<br>3. Finalizar atendimento.<br>4. Para consulta Agendada futura, como secretária, Confirmar. |
| Resultado esperado | Confirmada → Em atendimento → Realizada; Agendada → Confirmada. Cada transição é refletida na tela e na API. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-044 · Transições inválidas entre estados não finais

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 |
| Técnica | Transição de estados (transições inválidas) |
| Execução prevista | SEC e MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Médico: iniciar uma consulta Agendada (não confirmada).<br>2. Médico: finalizar uma consulta Confirmada.<br>3. Secretária: confirmar uma consulta já Confirmada.<br>4. Secretária: registrar falta em consulta futura. |
| Resultado esperado | Todas recusadas com 422 e situação inalterada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-045 · Estados finais não mudam

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 · RNF01 |
| Técnica | Transição de estados (a partir de Realizada, Cancelada e Faltou) |
| Execução prevista | SEC e PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); uma consulta Realizada, uma Cancelada e uma Faltou do histórico. |
| Passos / entrada | 1. Para cada uma, tentar: confirmar, cancelar, registrar falta e iniciar atendimento. |
| Resultado esperado | Todas as 12 tentativas recusadas com 422; nenhuma muda de situação nem gera notificação. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-046 · Atendimento só pode começar no dia da consulta

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 |
| Técnica | Partição de equivalência (hoje × outro dia) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta Confirmada de Ana com Dr. Ricardo em dia futuro (seed). |
| Passos / entrada | 1. Como ricardo.alves, Iniciar atendimento dessa consulta. |
| Resultado esperado | Recusado com 422; a consulta continua Confirmada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-047 · Registrar falta só depois do horário

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 · RF07 · MP-07 |
| Técnica | Partição de equivalência (antes × depois do horário) |
| Execução prevista | SEC · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta ativa de hoje com horário já passado e outra ainda futura. |
| Passos / entrada | 1. Registrar falta na consulta cujo horário passou.<br>2. Registrar falta na consulta futura. |
| Resultado esperado | Primeira: situação Faltou. Segunda: 422 “Só é possível registrar falta depois do horário da consulta”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-048 · Finalizar exige prontuário com diagnóstico

| Campo | Conteúdo |
|---|---|
| Requisito | RN11 · RF08 |
| Técnica | Tabela de decisão (prontuário ausente / sem diagnóstico / com diagnóstico) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta da Dra. Helena Em atendimento (iniciada no teste). |
| Passos / entrada | 1. Finalizar sem prontuário.<br>2. Registrar prontuário sem diagnóstico e finalizar.<br>3. Preencher o diagnóstico e finalizar. |
| Resultado esperado | Passos 1 e 2: 422 “Registre o prontuário com diagnóstico antes de finalizar”. Passo 3: Realizada. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-049 · Recepção cancela informando o motivo

| Campo | Conteúdo |
|---|---|
| Requisito | RF07 · RN07 · MP-08 |
| Técnica | Partição de equivalência (com × sem motivo) |
| Execução prevista | SEC · UI + API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); consulta Agendada futura. |
| Passos / entrada | 1. Cancelar sem informar motivo.<br>2. Cancelar com motivo “Paciente pediu para remarcar”.<br>3. Consultar horários livres do médico na data. |
| Resultado esperado | Passo 1: recusado (400), motivo é obrigatório. Passo 2: Cancelada com o motivo registrado. Passo 3: o horário voltou a ficar livre. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-050 · Prazo de 24 horas para o paciente cancelar

| Campo | Conteúdo |
|---|---|
| Requisito | RN12 |
| Técnica | Análise de valor-limite (24h01 / 24h00 / 23h59) |
| Execução prevista | PAC e SEC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); janela de execução (seção 6.5); consultas de luiza.costa criadas pela secretária a agora + 24h01, + 24h00 e + 23h59. |
| Passos / entrada | 1. Como luiza.costa, cancelar cada uma informando motivo.<br>2. Como secretária, cancelar a de 23h59. |
| Resultado esperado | 24h01 e 24h00: canceladas. 23h59: 422 “Cancelamento pelo paciente só é possível até 24 horas antes”. Secretária cancela a de 23h59. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-051 · Paciente não cancela nem vê consulta de outro paciente

| Campo | Conteúdo |
|---|---|
| Requisito | RN12 · MP-08 · MP-05 |
| Técnica | Suposição de erro (identificador de outra pessoa) |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como carlos.lima; id de uma consulta futura de Ana. |
| Passos / entrada | 1. GET /api/consultas/<id da consulta de Ana>.<br>2. PATCH /api/consultas/<id>/cancelar. |
| Resultado esperado | Ambos 403; a consulta de Ana continua ativa. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-052 · Notificações ao confirmar, cancelar e realizar

| Campo | Conteúdo |
|---|---|
| Requisito | RN15 · RF07 |
| Técnica | Tabela de decisão (evento × destinatário) |
| Execução prevista | SEC, PAC e MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta futura de Luíza com Dra. Helena criada no teste. |
| Passos / entrada | 1. Confirmar a consulta.<br>2. Cancelar a consulta.<br>3. Em outra consulta de hoje, finalizar o atendimento.<br>4. Ler as notificações de Luíza e da Dra. Helena após cada passo. |
| Resultado esperado | Confirmada: só a paciente é avisada. Cancelada: paciente e médica. Realizada: paciente avisada de que os documentos estão disponíveis. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Atendimento e prontuário

### CT-053 · Registrar prontuário completo durante o atendimento

| Campo | Conteúdo |
|---|---|
| Requisito | RF08 · RN13 |
| Técnica | Teste de fluxo (caso de uso) |
| Execução prevista | MED · UI + API · Playwright (fluxo E2E 3) e Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta de hoje da Dra. Helena Em atendimento. |
| Passos / entrada | 1. Preencher queixa, anamnese, diagnóstico, conduta, prescrição com 2 medicamentos (com posologia) e 2 dias de atestado.<br>2. Salvar e reabrir a consulta. |
| Resultado esperado | Todos os campos salvos e exibidos como registrados. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-054 · Dias de atestado de 0 a 15 (valores-limite)

| Campo | Conteúdo |
|---|---|
| Requisito | RN13 |
| Técnica | Análise de valor-limite (−1, 0, 15, 16) e partição (não inteiro) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta Em atendimento da Dra. Helena. |
| Passos / entrada | 1. Salvar prontuário com atestadoDias = −1, 0, 15, 16, 2.5 e “abc”. |
| Resultado esperado | 0 e 15: aceitos. −1, 16, 2.5 e “abc”: 400 “atestadoDias: de 0 a 15”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-055 · Só o médico da consulta registra o prontuário, e só durante o atendimento

| Campo | Conteúdo |
|---|---|
| Requisito | RN13 · MP-09 |
| Técnica | Tabela de decisão (médico dono × situação da consulta) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta da Dra. Helena Em atendimento; outra Confirmada. |
| Passos / entrada | 1. Como ricardo.alves, salvar prontuário na consulta Em atendimento da Dra. Helena.<br>2. Como helena.costa, salvar prontuário na consulta Confirmada (não iniciada).<br>3. Como secretária e como admin, enviar PUT do prontuário. |
| Resultado esperado | Passo 1: 403 e prontuário inalterado. Passo 2: 422. Passo 3: 403. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-056 · Prescrição é lista de medicamento com posologia

| Campo | Conteúdo |
|---|---|
| Requisito | RN13 |
| Técnica | Partição de equivalência (item completo × item sem posologia × lista vazia) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta Em atendimento da Dra. Helena. |
| Passos / entrada | 1. Salvar prescrição com 1 item completo.<br>2. Salvar com 1 item sem posologia.<br>3. Salvar com lista vazia. |
| Resultado esperado | Item completo e lista vazia aceitos (lista vazia = sem receita). Item sem posologia recusado (400) ou bloqueado pela interface. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Documentos em PDF

### CT-057 · Comprovante de agendamento em PDF

| Campo | Conteúdo |
|---|---|
| Requisito | RF09 · RN14 · RN19 |
| Técnica | Verificação de conteúdo de PDF |
| Execução prevista | PAC · API · Jest + pdf-parse |
| Pré-condições | Dados iniciais restaurados (seed); consulta futura de ana.souza com Dra. Helena (seed). |
| Passos / entrada | 1. Como ana.souza, baixar GET /api/consultas/<id>/comprovante.pdf.<br>2. Extrair o texto do PDF. |
| Resultado esperado | Content-Type application/pdf. Texto contém “Clínica MedAgenda”, “Comprovante de agendamento”, nome e CPF da paciente, data no formato dd/mm/aaaa hh:mm em Brasília, médica e “R$ 200,00”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-058 · Receita e atestado de consulta realizada

| Campo | Conteúdo |
|---|---|
| Requisito | RF09 · RN14 · RN19 |
| Técnica | Verificação de conteúdo de PDF |
| Execução prevista | PAC · API + UI · Playwright (fluxo E2E 3) e pdf-parse |
| Pré-condições | Dados iniciais restaurados (seed); consulta REALIZADA de Ana com Dra. Helena (cerca de 10 dias atrás) com prescrição de paracetamol e 2 dias de atestado. |
| Passos / entrada | 1. Baixar receita.pdf e atestado.pdf como ana.souza.<br>2. Extrair o texto. |
| Resultado esperado | Receita: cabeçalho da clínica, paciente, “Paracetamol 750 mg” e posologia, nome e “CRM/PB 10234” da médica. Atestado: paciente, “2 dia(s)”, data dd/mm/aaaa, nome e CRM da médica. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-059 · Documentos só existem quando há pré-condição

| Campo | Conteúdo |
|---|---|
| Requisito | RN14 |
| Técnica | Tabela de decisão (tipo × situação × prescrição/atestado) |
| Execução prevista | PAC e ADM · API + UI · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta realizada sem prescrição e sem atestado (histórico); consulta agendada. |
| Passos / entrada | 1. Baixar receita e atestado da consulta realizada sem prescrição/atestado.<br>2. Baixar receita e atestado da consulta agendada.<br>3. Baixar comprovante das duas.<br>4. Conferir os botões na interface. |
| Resultado esperado | Receita/atestado indisponíveis (404 ou 422, botões ocultos). Comprovante disponível nas duas. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-060 · Quem pode baixar documentos

| Campo | Conteúdo |
|---|---|
| Requisito | MP-11 · RN14 |
| Técnica | Tabela de decisão (perfil × dono da consulta) |
| Execução prevista | Todos · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta realizada de Ana com Dra. Helena. |
| Passos / entrada | 1. Baixar comprovante, receita e atestado como: admin, joana.lima, helena.costa, ricardo.alves, ana.souza e carlos.lima. |
| Resultado esperado | Admin, Dra. Helena e Ana: 200. Secretária, Dr. Ricardo e Carlos: 403. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Painéis, notificações e lembretes

### CT-061 · Painel inicial de cada perfil

| Campo | Conteúdo |
|---|---|
| Requisito | RF10 |
| Técnica | Partição por perfil |
| Execução prevista | Todos · UI + API · Playwright |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Entrar com admin, joana.lima, helena.costa e ana.souza e observar o painel. |
| Resultado esperado | Admin: indicadores (usuários, pacientes, consultas de hoje, receita do mês). Secretária: agenda do dia e consultas a confirmar nas próximas 48 h. Médico: pacientes do dia. Paciente: próximas consultas e histórico. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-062 · Marcar uma e todas as notificações como lidas

| Campo | Conteúdo |
|---|---|
| Requisito | RF11 · RN15 |
| Técnica | Valor-limite (14 não lidas, acima de qualquer página de 10) |
| Execução prevista | PAC · UI + API · Jest e Playwright |
| Pré-condições | Dados iniciais restaurados (seed); ana.souza tem 14 notificações não lidas. |
| Passos / entrada | 1. Marcar uma notificação como lida e ver o sino.<br>2. Clicar em “Marcar todas como lidas”.<br>3. GET /api/notificacoes/contagem. |
| Resultado esperado | Passo 1: contador cai de 14 para 13. Passos 2 e 3: todas lidas e contador 0 imediatamente. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-063 · Lembrete único, só para consultas ativas nas próximas 24 h

| Campo | Conteúdo |
|---|---|
| Requisito | RF12 · RN15 |
| Técnica | Tabela de decisão (ativa × cancelada; dentro × fora de 24 h) e repetição |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); seed cria, nas próximas 24 h, uma consulta Confirmada de carlos.lima e uma Cancelada de fernanda.rocha com a Dra. Helena. |
| Passos / entrada | 1. Aguardar 6 minutos após o seed e ler as notificações de Carlos e Fernanda.<br>2. Aguardar mais 6 minutos e ler de novo. |
| Resultado esperado | Carlos recebe exatamente 1 lembrete da consulta; Fernanda não recebe lembrete da consulta cancelada; nenhum lembrete repetido na segunda leitura. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-064 · Cada usuário vê só as próprias notificações

| Campo | Conteúdo |
|---|---|
| Requisito | MP-16 · RN15 |
| Técnica | Suposição de erro |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); id de uma notificação de ana.souza. |
| Passos / entrada | 1. Como carlos.lima, PATCH /api/notificacoes/<id da Ana>/lida.<br>2. GET /api/notificacoes como Carlos. |
| Resultado esperado | Passo 1: 404 e a notificação de Ana continua não lida. Passo 2: só notificações de Carlos. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Assistente virtual

### CT-065 · Sinais de urgência recebem orientação do SAMU (192)

| Campo | Conteúdo |
|---|---|
| Requisito | RN18 · RF13 |
| Técnica | Suposição de erro (maiúsculas, acentos e variações) |
| Execução prevista | PAC · API + UI · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como ana.souza. |
| Passos / entrada | 1. Enviar ao assistente: “estou com dor no peito”, “DOR NO PEITO”, “Sinto falta de ar”, “tive um desmaio”, “está com sangramento”, “ele teve uma convulsão”, “CONVULSÃO”, “convulsao”. |
| Resultado esperado | Todas as mensagens recebem a orientação de ligar para o SAMU (192), independentemente de maiúsculas, minúsculas ou acentos. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-066 · Assistente não sugere diagnóstico nem medicamento

| Campo | Conteúdo |
|---|---|
| Requisito | RN18 |
| Técnica | Partição de equivalência (pedido clínico) |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como luiza.costa. |
| Passos / entrada | 1. Perguntar: “Que remédio posso tomar para dor de cabeça?”, “Tenho febre, o que pode ser?” e “Qual o diagnóstico para tosse?”. |
| Resultado esperado | Nenhuma resposta cita diagnóstico ou medicamento; todas orientam a agendar consulta (e procurar urgência se os sintomas forem graves). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-067 · Assistente informa a próxima consulta correta

| Campo | Conteúdo |
|---|---|
| Requisito | RN18 · RF13 |
| Técnica | Oráculo (consulta ativa mais próxima calculada pela API) |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); ana.souza tem 3 consultas futuras ativas. |
| Passos / entrada | 1. Perguntar “Qual é a minha próxima consulta?”.<br>2. Comparar com a consulta ativa de menor data em GET /api/consultas. |
| Resultado esperado | A resposta informa a data e o médico da consulta ativa **mais próxima** (a da Dra. Helena em cerca de 3 dias), no formato dd/mm/aaaa hh:mm. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-068 · Assistente responde temas administrativos e valida a mensagem

| Campo | Conteúdo |
|---|---|
| Requisito | RF13 · RNF01 |
| Técnica | Partição de equivalência e valor-limite (0, 500 e 501 caracteres) |
| Execução prevista | SEC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária). |
| Passos / entrada | 1. Perguntar sobre horários de funcionamento, médicos, convênios e documentos.<br>2. Enviar mensagem vazia.<br>3. Enviar 500 e 501 caracteres. |
| Resultado esperado | Respostas coerentes com o tema. Vazia e 501 caracteres: 400. 500 caracteres: 201. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Relatórios

### CT-069 · Relatório de consultas confere com o oráculo

| Campo | Conteúdo |
|---|---|
| Requisito | RF15 · RN16 |
| Técnica | Oráculo independente (recontagem a partir da listagem) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; período: os 30 dias anteriores a hoje. |
| Passos / entrada | 1. GET /api/relatorios/consultas para o período.<br>2. Recontar por situação e por médico a partir de GET /api/consultas.<br>3. Calcular as taxas pela regra. |
| Resultado esperado | Totais por situação e por médico iguais ao oráculo. Taxa de faltas = faltas ÷ (realizadas + faltas). Taxa de cancelamento = canceladas ÷ total. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-070 · Período inclui o dia inicial e o final

| Campo | Conteúdo |
|---|---|
| Requisito | RN16 |
| Técnica | Análise de valor-limite (período de um único dia; fim antes do início) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; um dia passado com consultas conhecidas (lidas via API). |
| Passos / entrada | 1. Relatório com início = fim = esse dia.<br>2. Relatório com fim um dia antes do início. |
| Resultado esperado | Passo 1: inclui todas as consultas do dia (total igual ao oráculo). Passo 2: 400. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-071 · Relatório financeiro: receita, atendimentos e ticket médio

| Campo | Conteúdo |
|---|---|
| Requisito | RF15 · RN17 |
| Técnica | Oráculo independente |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; período dos últimos 30 dias. |
| Passos / entrada | 1. GET /api/relatorios/financeiro.<br>2. Somar os valores só das consultas REALIZADAS do período e agrupar por médico e convênio. |
| Resultado esperado | Receita = soma das realizadas; atendimentos = quantidade de realizadas; ticket médio = receita ÷ atendimentos; quebras por médico e convênio iguais ao oráculo. Consultas canceladas, agendadas e faltas não entram. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-072 · Período máximo de 1 ano no financeiro

| Campo | Conteúdo |
|---|---|
| Requisito | RN17 |
| Técnica | Análise de valor-limite (1 ano × 1 ano + 1 dia) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Período 01/01/2026 a 31/12/2026.<br>2. Período 01/01/2026 a 01/01/2027. |
| Resultado esperado | Primeiro aceito (200). Segundo recusado (400 “Período máximo de 1 ano”). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-073 · PDF do financeiro apresenta os mesmos números da tela

| Campo | Conteúdo |
|---|---|
| Requisito | RN17 · RF15 · RN19 |
| Técnica | Verificação de conteúdo de PDF (comparação com a API) |
| Execução prevista | ADM · API + UI · pdf-parse e Playwright (fluxo E2E 5) |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; período dos últimos 30 dias. |
| Passos / entrada | 1. Exportar financeiro.pdf.<br>2. Comparar receita, atendimentos, ticket médio e quebras com o JSON da tela. |
| Resultado esperado | Mesmos números, em reais com duas casas (ex.: R$ 200,00). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-074 · PDF do relatório de consultas: totais e horários em Brasília

| Campo | Conteúdo |
|---|---|
| Requisito | RN16 · RN19 · RF15 |
| Técnica | Verificação de conteúdo de PDF |
| Execução prevista | ADM · API · pdf-parse |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin; período com consultas conhecidas. |
| Passos / entrada | 1. Exportar consultas.pdf.<br>2. Comparar totais com a API e os horários com os da tela. |
| Resultado esperado | Totais iguais aos da tela; datas e horas em Brasília (ex.: 08:00 aparece como 08:00, não 11:00). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-075 · Permissões dos relatórios

| Campo | Conteúdo |
|---|---|
| Requisito | MP-12 · MP-13 |
| Técnica | Tabela de decisão (perfil × relatório) |
| Execução prevista | Todos · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Relatório de consultas como admin, joana.lima, helena.costa (passando medicoId do Dr. Ricardo) e ana.souza.<br>2. Relatório financeiro com os mesmos perfis. |
| Resultado esperado | Consultas: admin e secretária veem todos; Dra. Helena vê só os seus (o medicoId de outro é ignorado ou recusado); paciente 403. Financeiro: só admin; demais 403. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Permissões e privacidade

### CT-076 · Matriz de permissões completa via API (64 combinações)

| Campo | Conteúdo |
|---|---|
| Requisito | MP-01 · MP-02 · MP-03 · MP-04 · MP-05 · MP-06 · MP-07 · MP-08 · MP-09 · MP-10 · MP-11 · MP-12 · MP-13 · MP-14 · MP-15 · MP-16 |
| Técnica | Tabela de decisão (perfil × ação; ver tabela 9.3) |
| Execução prevista | Todos · API · Jest (orientado a dados) |
| Pré-condições | Dados iniciais restaurados (seed); tokens dos 4 perfis; recursos de outro usuário preparados pela API. |
| Passos / entrada | 1. Para cada linha da tabela 9.3, executar a rota representativa com cada perfil.<br>2. Registrar o código HTTP de cada combinação. |
| Resultado esperado | Cada combinação responde conforme a tabela 9.3: permitido (2xx) ou 403, sem efeito colateral nas recusadas. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-077 · Interface mostra só as opções do perfil logado

| Campo | Conteúdo |
|---|---|
| Requisito | MP-01 · MP-06 · MP-07 · MP-09 · MP-13 |
| Técnica | Tabela de decisão (perfil × menu e botões) |
| Execução prevista | Todos · UI · Playwright |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Entrar com cada perfil e listar menus e botões disponíveis.<br>2. Abrir diretamente URLs de páginas de outros perfis (ex.: paciente em /usuarios). |
| Resultado esperado | Admin: Usuários e Relatórios (com financeiro). Secretária: Pacientes, Agendar, Relatórios sem financeiro. Médico: sem Usuários e sem Agendar. Paciente: só portal. URLs de outros perfis bloqueadas ou sem dados. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-078 · Médico vê apenas fichas dos próprios pacientes

| Campo | Conteúdo |
|---|---|
| Requisito | MP-04 |
| Técnica | Partição de equivalência (paciente do médico × de outro médico) |
| Execução prevista | MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como marina.duarte (pediatria). |
| Passos / entrada | 1. GET /api/pacientes.<br>2. GET /api/pacientes/<id de Miguel Duarte Neves>.<br>3. GET /api/pacientes/<id de Roberto Farias>. |
| Resultado esperado | Lista só pacientes atendidos pela Dra. Marina; Miguel: 200; Roberto: 403. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-079 · Prontuário não é exposto a quem não pode vê-lo

| Campo | Conteúdo |
|---|---|
| Requisito | MP-10 · RNF02 · RN13 |
| Técnica | Suposição de erro (todas as rotas que devolvem consulta) |
| Execução prevista | SEC, PAC, MED · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); consulta REALIZADA de Ana com Dra. Helena. |
| Passos / entrada | 1. Como joana.lima: GET /api/consultas/<id> e GET /api/consultas?pacienteId=<Ana>.<br>2. Como ricardo.alves: GET /api/consultas/<id>.<br>3. Como ana.souza e helena.costa: GET /api/consultas/<id>. |
| Resultado esperado | Secretária: nenhuma resposta contém o prontuário (queixa, diagnóstico, prescrição). Dr. Ricardo: 403. Ana e Dra. Helena: prontuário visível. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Requisitos não funcionais

### CT-080 · Códigos HTTP padronizados

| Campo | Conteúdo |
|---|---|
| Requisito | RNF01 |
| Técnica | Partição de equivalência por tipo de resposta |
| Execução prevista | Todos · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Criar ficha válida.<br>2. Criar ficha inválida.<br>3. Rota protegida sem token.<br>4. Secretária cria médico.<br>5. GET /api/consultas/abc e GET com id inexistente bem formado.<br>6. Agendar horário ocupado.<br>7. Cancelar consulta Realizada. |
| Resultado esperado | 201, 400, 401, 403, 404 (malformado e inexistente), 409 e 422, respectivamente. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-081 · Senhas nunca retornadas e erros sem detalhes internos

| Campo | Conteúdo |
|---|---|
| Requisito | RNF02 |
| Técnica | Suposição de erro e inspeção das respostas |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. GET /api/usuarios, GET /api/perfil e POST /api/auth/login: procurar campos de senha.<br>2. Enviar JSON malformado em POST /api/pacientes.<br>3. Enviar id com formato estranho em várias rotas. |
| Resultado esperado | Nenhuma resposta contém senha ou hash. Erros com mensagem genérica em português, sem stack trace, nomes de arquivos ou consultas ao banco. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-082 · Desempenho com 50 usuários simultâneos

| Campo | Conteúdo |
|---|---|
| Requisito | RNF03 |
| Técnica | Teste de carga com limites |
| Execução prevista | SEC e PAC · API · k6 |
| Pré-condições | Dados iniciais restaurados (seed); ambiente sem outras cargas; tokens obtidos no setup do k6. |
| Passos / entrada | 1. Executar o script k6: 50 usuários virtuais por 2 minutos (30 s de subida) chamando GET /api/medicos/:id/horarios e GET /api/consultas?data=hoje.<br>2. Repetir 3 vezes. |
| Resultado esperado | Nas 3 execuções: p95 < 800 ms em cada rota e taxa de erros < 1% (thresholds do k6 aprovados). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-083 · Acessibilidade automática nas 4 telas

| Campo | Conteúdo |
|---|---|
| Requisito | RNF04 |
| Técnica | Análise automática (axe, WCAG 2.1 A/AA) |
| Execução prevista | PAC · UI · Playwright + axe |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Rodar o axe nas telas de login, agendar consulta, notificações e assistente virtual. |
| Resultado esperado | Nenhuma violação de impacto “serious” ou “critical”; todo campo e botão com nome acessível; contraste ≥ 4,5:1. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-084 · Uso completo só pelo teclado

| Campo | Conteúdo |
|---|---|
| Requisito | RNF04 |
| Técnica | Teste manual com roteiro |
| Execução prevista | PAC · UI · Manual |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Sem mouse: entrar, agendar uma consulta, abrir e marcar notificações como lidas e enviar uma mensagem ao assistente.<br>2. Observar ordem do foco e foco visível. |
| Resultado esperado | Todas as tarefas concluídas só com Tab, Shift+Tab, Enter, Espaço e Esc; foco sempre visível e em ordem lógica. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-085 · Compatibilidade: Chrome e Firefox, 1280 px e 390 px

| Campo | Conteúdo |
|---|---|
| Requisito | RNF05 |
| Técnica | Partição (navegador × largura) |
| Execução prevista | PAC e SEC · UI · Playwright (projetos chromium/firefox) |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Executar os fluxos E2E 1 e 2 nas 4 combinações. |
| Resultado esperado | Fluxos concluídos nas 4 combinações, sem rolagem horizontal, sem elementos sobrepostos e com botões alcançáveis. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-086 · Recarregar após confirmar ou cancelar não repete a operação

| Campo | Conteúdo |
|---|---|
| Requisito | RNF06 |
| Técnica | Suposição de erro |
| Execução prevista | SEC · UI · Playwright |
| Pré-condições | Dados iniciais restaurados (seed); logado como joana.lima (secretária); consulta Agendada futura. |
| Passos / entrada | 1. Confirmar a consulta e recarregar a página.<br>2. Cancelar outra consulta e recarregar. |
| Resultado esperado | Nenhuma operação repetida e nenhuma notificação duplicada ao paciente. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-087 · Mensagens de erro claras, em português e junto à ação

| Campo | Conteúdo |
|---|---|
| Requisito | RNF07 |
| Técnica | Inspeção (heurística de usabilidade) |
| Execução prevista | SEC e PAC · UI · Playwright e manual |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Provocar: CPF inválido no cadastro, login errado, agendamento sem escolher horário, cancelamento sem motivo. |
| Resultado esperado | Cada erro aparece em português, explicando o que corrigir, próximo do campo ou botão que o causou. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-088 · Datas e valores no padrão brasileiro na interface e nas notificações

| Campo | Conteúdo |
|---|---|
| Requisito | RN19 |
| Técnica | Inspeção de formato |
| Execução prevista | PAC e SEC · UI + API · Playwright |
| Pré-condições | Dados iniciais restaurados (seed). |
| Passos / entrada | 1. Conferir datas de consultas, notificações e painel; conferir valores na tela de agendamento e no comprovante. |
| Resultado esperado | Datas dd/mm/aaaa hh:mm no horário de Brasília; valores como R$ 200,00. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

## Derivados das sessões exploratórias

### CT-089 · Pedido de medicamento fora do vocabulário recebe orientação clínica segura

| Campo | Conteúdo |
|---|---|
| Requisito | RN18 |
| Técnica | Exploratório (derivado da sessão 1, achado A1.4) e suposição de erro |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como ana.souza. |
| Passos / entrada | 1. Enviar “Qual antibiótico é bom para garganta?”, “Que pomada uso na queimadura?” e “Preciso de um xarope”. |
| Resultado esperado | Nenhuma resposta indica medicamento; todas orientam a agendar consulta ou procurar atendimento (não apenas “Não entendi”). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-090 · Intenção administrativa é reconhecida mesmo com palavras ambíguas

| Campo | Conteúdo |
|---|---|
| Requisito | RF13 · RNF07 |
| Técnica | Exploratório (derivado da sessão 1, achado A1.3) e partição de equivalência |
| Execução prevista | PAC · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como ana.souza. |
| Passos / entrada | 1. Enviar “Tenho uma dúvida sobre o convênio”, “Tenho consulta com qual médico?” e “que coisa”. |
| Resultado esperado | Respostas sobre convênio e sobre a consulta/médicos, respectivamente; nenhuma recebe a recusa clínica nem a saudação fora de contexto. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-091 · Urgência tem precedência sobre saudação e pedido de remédio

| Campo | Conteúdo |
|---|---|
| Requisito | RN18 |
| Técnica | Exploratório (derivado da sessão 1) e tabela de decisão (urgência × outro tema na mesma frase) |
| Execução prevista | PAC · API · Jest e BDD |
| Pré-condições | Dados iniciais restaurados (seed); logado como ana.souza. |
| Passos / entrada | 1. Enviar “Oi, estou com falta de ar”, “Estou com dor no peito, posso tomar algum remédio?” e “DOR NO PEITO, posso tomar dipirona?”. |
| Resultado esperado | As três recebem a orientação do SAMU (192) e nenhuma indicação de medicamento. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-092 · Texto do atestado e formato das datas nos PDFs

| Campo | Conteúdo |
|---|---|
| Requisito | RN19 · RN14 |
| Técnica | Exploratório (derivado da sessão 2, achado A2.7) e verificação de conteúdo de PDF |
| Execução prevista | PAC · API · pdf-parse |
| Pré-condições | Dados iniciais restaurados (seed); consulta REALIZADA com atestado (seed). |
| Passos / entrada | 1. Baixar o atestado e o comprovante.<br>2. Conferir a frase do afastamento e o formato de todas as datas. |
| Resultado esperado | Frase “… a partir de dd/mm/aaaa.” sem pontuação duplicada; datas no formato dd/mm/aaaa hh:mm (RN19). |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-093 · Comprovante mostra situação e tipo em linguagem do usuário

| Campo | Conteúdo |
|---|---|
| Requisito | RNF07 · RN14 |
| Técnica | Exploratório (derivado da sessão 2, achado A2.8) e inspeção |
| Execução prevista | PAC · API · pdf-parse |
| Pré-condições | Dados iniciais restaurados (seed); consulta realizada e consulta agendada de ana.souza. |
| Passos / entrada | 1. Baixar o comprovante das duas consultas e ler a linha de situação. |
| Resultado esperado | Situação exibida como “Realizada” / “Agendada” (texto em português), não como código interno. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |

### CT-094 · Período acima de 1 ano é recusado também no relatório de consultas

| Campo | Conteúdo |
|---|---|
| Requisito | RN17 · RN16 |
| Técnica | Exploratório (derivado da sessão 2, achado A2.6) e valor-limite (1 ano, +1 dia, +2 dias) |
| Execução prevista | ADM · API · Jest |
| Pré-condições | Dados iniciais restaurados (seed); logado como admin. |
| Passos / entrada | 1. Financeiro e consultas com 01/01/2026 a 31/12/2026, a 01/01/2027 e a 02/01/2027. |
| Resultado esperado | Até 31/12/2026: 200. 01/01/2027 e 02/01/2027: 400 “Período máximo de 1 ano”. |
| Resultado obtido | _a preencher na execução_ |
| Situação | Não executado |
| Evidência | _a anexar_ |
