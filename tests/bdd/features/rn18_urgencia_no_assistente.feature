# language: pt
@RN18 @assistente
Funcionalidade: Orientação de urgência no assistente virtual (RN18)
  Para proteger o paciente em situação de emergência
  Como paciente
  Quero ser orientado a ligar para o SAMU sempre que relatar um sinal de urgência

  Contexto:
    Dado que os dados iniciais foram restaurados
    E que estou logado como "ana.souza@email.dev"

  Esquema do Cenário: Mensagem com sinal de urgência "<mensagem>"
    Quando eu enviar ao assistente a mensagem "<mensagem>"
    Então a resposta deve orientar a ligar para o SAMU (192)
    E a resposta não deve sugerir diagnóstico nem medicamento

    Exemplos: variações de escrita
      | mensagem                 |
      | estou com dor no peito   |
      | DOR NO PEITO             |
      | Dor No Peito desde ontem |
      | sinto falta de ar        |
      | tive um desmaio agora    |
      | está com sangramento     |
      | ele teve uma convulsão   |
      | CONVULSÃO                |
      | convulsao                |

  Cenário: Pedido de remédio não recebe indicação de medicamento
    Quando eu enviar ao assistente a mensagem "Que remédio posso tomar para dor de cabeça?"
    Então a resposta não deve sugerir diagnóstico nem medicamento
    E a resposta deve orientar a agendar uma consulta
