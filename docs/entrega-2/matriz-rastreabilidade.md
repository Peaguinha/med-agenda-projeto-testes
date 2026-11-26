# Matriz de rastreabilidade (Entrega 2)

| Requisito | Descrição | Casos | BDD / sessões |
|---|---|---|---|
| RF01 | Entrar com e-mail e senha e sair | CT-001, CT-002, CT-003, CT-004, CT-005, CT-006 | — |
| RF02 | Admin gerencia contas e senhas | CT-008, CT-013, CT-015, CT-016 | — |
| RF03 | Recepção cadastra, busca e edita fichas | CT-019, CT-024, CT-025 | — |
| RF04 | Médicos ativos e horários livres | CT-026, CT-027, CT-028 | — |
| RF05 | Recepção agenda (livre ou encaixe) | CT-029, CT-030 | — |
| RF06 | Paciente agenda pelo portal | CT-035 | — |
| RF07 | Confirmar, faltar e cancelar com motivo | CT-043, CT-047, CT-049, CT-052 | — |
| RF08 | Atendimento e prontuário | CT-043, CT-048, CT-053 | — |
| RF09 | PDFs: comprovante, receita, atestado | CT-057, CT-058 | Sessão 2 |
| RF10 | Painel inicial por perfil | CT-061 | — |
| RF11 | Notificações e contador do sino | CT-042, CT-062 | — |
| RF12 | Lembretes das próximas 24 h | CT-063 | — |
| RF13 | Assistente virtual | CT-065, CT-067, CT-068, CT-090 | Sessão 1 |
| RF14 | Meu perfil e troca de senha | CT-014, CT-017, CT-018 | — |
| RF15 | Relatórios de consultas e financeiro | CT-069, CT-071, CT-073, CT-074 | Sessão 2 |
| RN01 | Único admin; criação de contas; conta × ficha | CT-008, CT-009, CT-010 | — |
| RN02 | E-mail único sem diferenciar caixa | CT-005, CT-011 | — |
| RN03 | Política de senha | CT-012, CT-013, CT-014 | — |
| RN04 | Conta desativada não entra; admin não se desativa | CT-004, CT-015 | BDD rn04_conta_desativada |
| RN05 | Validação da ficha do paciente | CT-017, CT-019, CT-020, CT-021, CT-022, CT-023, CT-025 | — |
| RN06 | Validação dos dados do médico | CT-016, CT-027 | — |
| RN07 | Agenda do médico, futuro e sem sobreposição | CT-027, CT-029, CT-030, CT-031, CT-032, CT-033, CT-034, CT-041, CT-049 | — |
| RN08 | Antecedência de 2 h no portal | CT-036 | BDD rn08_antecedencia_no_portal |
| RN09 | Máximo de 3 consultas futuras | CT-037, CT-038 | BDD rn09_limite_consultas_futuras |
| RN10 | Primeira consulta × retorno gratuito | CT-039, CT-040 | BDD rn10_primeira_consulta_e_retorno |
| RN11 | Ciclo de vida da consulta | CT-043, CT-044, CT-045, CT-046, CT-047, CT-048 | — |
| RN12 | Cancelamento do paciente até 24 h | CT-050, CT-051 | BDD rn12_cancelamento_pelo_paciente |
| RN13 | Prontuário pelo médico da consulta; atestado 0–15 | CT-053, CT-054, CT-055, CT-056, CT-079 | — |
| RN14 | Disponibilidade e conteúdo dos PDFs | CT-057, CT-058, CT-059, CT-060, CT-092, CT-093 | Sessão 2 |
| RN15 | Notificações e lembrete único | CT-042, CT-052, CT-062, CT-063, CT-064 | — |
| RN16 | Relatório de consultas e taxas | CT-069, CT-070, CT-074, CT-094 | Sessão 2 |
| RN17 | Relatório financeiro e período de 1 ano | CT-071, CT-072, CT-073, CT-094 | Sessão 2 |
| RN18 | Assistente: sem diagnóstico; urgência → SAMU | CT-065, CT-066, CT-067, CT-089, CT-091 | BDD rn18_urgencia_no_assistente · Sessão 1 |
| RN19 | Datas em Brasília e valores em reais | CT-029, CT-039, CT-057, CT-058, CT-073, CT-074, CT-088, CT-092 | Sessão 2 |
| RNF01 | Códigos HTTP padronizados | CT-003, CT-007, CT-011, CT-021, CT-028, CT-033, CT-045, CT-068, CT-080 | Sessão 1 |
| RNF02 | Segurança e privacidade (LGPD) | CT-007, CT-079, CT-081 | Sessão 2 |
| RNF03 | Desempenho (50 usuários, p95 < 800 ms) | CT-082 | — |
| RNF04 | Acessibilidade WCAG 2.1 AA | CT-083, CT-084 | — |
| RNF05 | Compatibilidade de navegador e tela | CT-085 | — |
| RNF06 | Ações repetidas não duplicam | CT-041, CT-086 | — |
| RNF07 | Mensagens de erro claras | CT-002, CT-003, CT-017, CT-087, CT-090, CT-093 | Sessão 1 |
| MP-01 | Criar contas | CT-009, CT-076, CT-077 | — |
| MP-02 | Editar, ativar/desativar contas e redefinir senhas | CT-015, CT-076 | — |
| MP-03 | Cadastrar e editar fichas | CT-025, CT-076 | — |
| MP-04 | Ver fichas de pacientes | CT-076, CT-078 | — |
| MP-05 | Ver consultas | CT-051, CT-076 | — |
| MP-06 | Agendar consulta | CT-035, CT-076, CT-077 | — |
| MP-07 | Confirmar consulta e registrar falta | CT-047, CT-076, CT-077 | — |
| MP-08 | Cancelar consulta | CT-049, CT-051, CT-076 | — |
| MP-09 | Iniciar/finalizar atendimento e prontuário | CT-055, CT-076, CT-077 | — |
| MP-10 | Ver prontuário | CT-076, CT-079 | Sessão 2 |
| MP-11 | Baixar comprovante, receita e atestado | CT-060, CT-076 | Sessão 2 |
| MP-12 | Relatório de consultas | CT-075, CT-076 | Sessão 2 |
| MP-13 | Relatório financeiro | CT-075, CT-076, CT-077 | Sessão 2 |
| MP-14 | Alterar o próprio nome, telefone e senha | CT-014, CT-017, CT-076 | — |
| MP-15 | Alterar valor, duração, agenda e CRM do médico | CT-018, CT-076 | — |
| MP-16 | Notificações e assistente virtual | CT-064, CT-076 | — |
