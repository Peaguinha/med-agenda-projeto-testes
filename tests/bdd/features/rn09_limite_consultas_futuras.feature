# language: pt
@RN09 @agendamento
Funcionalidade: Limite de consultas futuras por paciente (RN09)
  Para que nenhum paciente bloqueie a agenda da clínica
  Como recepção da Clínica MedAgenda
  Quero que cada paciente tenha no máximo 3 consultas futuras ativas

  Contexto:
    Dado que os dados iniciais foram restaurados
    E que estou logado como "joana.lima@medagenda.dev"
    E que existe uma ficha de paciente nova, sem consultas

  Esquema do Cenário: Agendar com <agendadas> agendadas e <confirmadas> confirmadas já existentes
    Dado que o paciente tem <agendadas> consultas futuras agendadas
    E que o paciente tem <confirmadas> consultas futuras confirmadas
    Quando eu agendar mais uma consulta futura em horário livre para o paciente
    Então o agendamento deve ser <resultado>
    E a resposta da API deve ter o código <codigo>

    Exemplos: abaixo e no limite
      | agendadas | confirmadas | resultado | codigo |
      | 0         | 0           | aceito    | 201    |
      | 2         | 0           | aceito    | 201    |
      | 1         | 1           | aceito    | 201    |

    Exemplos: acima do limite
      | agendadas | confirmadas | resultado | codigo |
      | 3         | 0           | recusado  | 422    |
      | 2         | 1           | recusado  | 422    |
      | 0         | 3           | recusado  | 422    |

  Cenário: Cancelar uma consulta libera nova vaga
    Dado que o paciente tem 3 consultas futuras agendadas
    Quando eu cancelar uma delas informando o motivo "Paciente pediu para remarcar"
    E eu agendar mais uma consulta futura em horário livre para o paciente
    Então o agendamento deve ser aceito
