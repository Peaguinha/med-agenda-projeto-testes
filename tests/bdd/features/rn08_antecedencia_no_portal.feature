# language: pt
@RN08 @agendamento @janela
Funcionalidade: Antecedência mínima no portal do paciente (RN08)
  Como paciente
  Só posso agendar pelo portal com pelo menos 2 horas de antecedência
  Enquanto a recepção não tem essa restrição

  Contexto:
    Dado que os dados iniciais foram restaurados
    E que algum médico atende daqui a 2 horas

  Esquema do Cenário: Paciente agenda para daqui a <antecedencia>
    Dado que estou logado como "luiza.costa@email.dev"
    Quando eu agendar uma consulta que começa daqui a <antecedencia>
    Então o agendamento deve ser <resultado>

    Exemplos:
      | antecedencia | resultado |
      | 1h59min      | recusado  |
      | 2h00min      | aceito    |
      | 2h01min      | aceito    |

  Cenário: Recepção faz encaixe para daqui a 30 minutos
    Dado que estou logado como "joana.lima@medagenda.dev"
    Quando eu agendar uma consulta para "Thiago Barbosa" que começa daqui a 30 minutos
    Então o agendamento deve ser aceito
