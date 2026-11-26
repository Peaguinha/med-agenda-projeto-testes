# language: pt
@RN04 @acesso
Funcionalidade: Conta desativada não acessa o sistema (RN04)
  Como administrador
  Quero que contas desativadas não consigam entrar
  Para que ex-funcionários não acessem dados de pacientes

  Contexto:
    Dado que os dados iniciais foram restaurados

  Cenário: Ex-funcionário com conta desativada tenta entrar
    Quando eu tentar entrar com "pedro.santos@medagenda.dev" e a senha "Secretaria@2026"
    Então o acesso deve ser negado
    E nenhum token de sessão deve ser emitido

  Cenário: Administrador não pode desativar a própria conta
    Dado que estou logado como "admin@medagenda.dev"
    Quando eu tentar desativar a minha própria conta
    Então a ação deve ser recusada com o código 422
    E a minha conta deve continuar ativa
