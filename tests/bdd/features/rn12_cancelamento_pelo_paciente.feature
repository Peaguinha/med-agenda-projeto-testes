# language: pt
@RN12 @cancelamento @janela
Funcionalidade: Prazo de cancelamento pelo paciente (RN12)
  Para que a clínica consiga reaproveitar horários cancelados
  Como paciente
  Só posso cancelar minha consulta até 24 horas antes do horário

  Contexto:
    Dado que os dados iniciais foram restaurados

  Esquema do Cenário: Paciente cancela com <antecedencia> de antecedência
    Dado que a recepção agendou para "luiza.costa@email.dev" uma consulta que começa daqui a <antecedencia>
    E que estou logado como "luiza.costa@email.dev"
    Quando eu cancelar a consulta informando o motivo "Imprevisto"
    Então o cancelamento deve ser <resultado>
    E a consulta deve ficar com a situação "<situacao>"

    Exemplos:
      | antecedencia | resultado | situacao  |
      | 48 horas     | aceito    | Cancelada |
      | 24h01min     | aceito    | Cancelada |
      | 24h00min     | aceito    | Cancelada |
      | 23h59min     | recusado  | Agendada  |
      | 12 horas     | recusado  | Agendada  |

  Cenário: Recepção cancela dentro das 24 horas
    Dado que a recepção agendou para "luiza.costa@email.dev" uma consulta que começa daqui a 23h59min
    E que estou logado como "joana.lima@medagenda.dev"
    Quando eu cancelar a consulta informando o motivo "Paciente ligou"
    Então o cancelamento deve ser aceito
