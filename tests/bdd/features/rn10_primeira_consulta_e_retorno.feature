# language: pt
@RN10 @valor
Funcionalidade: Primeira consulta e retorno gratuito (RN10)
  Para cobrar corretamente cada atendimento
  Como recepção
  Quero que o retorno seja gratuito apenas quando houver consulta realizada com o mesmo médico nos 30 dias anteriores

  Contexto:
    Dado que os dados iniciais foram restaurados
    E que estou logado como "joana.lima@medagenda.dev"

  Cenário: Primeira consulta cobra o valor do médico
    Quando eu agendar uma "PRIMEIRA" consulta para "Carlos Eduardo Lima" com "Dra. Helena Costa"
    Então o agendamento deve ser aceito
    E o valor da consulta deve ser "R$ 200,00"

  Esquema do Cenário: Retorno <dias> dias após uma consulta <situacao_anterior> com <medico_anterior>
    Dado que o paciente tem uma consulta "<situacao_anterior>" com "<medico_anterior>" há <dias> dias
    Quando eu agendar um "RETORNO" para o paciente com "Dra. Helena Costa"
    Então o agendamento deve ser <resultado>
    E o valor da consulta deve ser "<valor>"

    Exemplos:
      | dias | situacao_anterior | medico_anterior   | resultado | valor   |
      | 10   | REALIZADA         | Dra. Helena Costa | aceito    | R$ 0,00 |
      | 30   | REALIZADA         | Dra. Helena Costa | aceito    | R$ 0,00 |
      | 31   | REALIZADA         | Dra. Helena Costa | recusado  | -       |
      | 10   | REALIZADA         | Dr. Ricardo Alves | recusado  | -       |
      | 10   | CANCELADA         | Dra. Helena Costa | recusado  | -       |
      | 10   | FALTOU            | Dra. Helena Costa | recusado  | -       |
