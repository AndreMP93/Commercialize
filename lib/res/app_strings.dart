class AppStrings{
  static const appName = "Commercialize";

  //String for Login and Register screens
  static const username = "Nome de Usuario";
  static const emailLabel = "Email";
  static const passwordLabel = "Senha";
  static const loginButton = "Entrar";
  static const registerButton = "Cadastrar";
  static const saveButton = "Salvar";
  static const createAnAccountLabel = "Crie um conta";
  static const registerUserLabel = "Cadastrar Usuário";

  //Home menu itens
  static const filterDefault = "Todos";
  static const profileMenuItem = "Perfil";
  static const advertsMenuItem = "Meus Anúncios";
  static const loginMenuItem = "Entrar";
  static const logoutMenuItem = "Sair";

  //Error messages
  static const passwordError = "Senha invalida, sua senha deve ter no mínimo 6 caracters.";
  static const emailError = "Endereço de email invalido.";
  static const userNameError = "Nome de usuario invalido.";
  static const errorNetworkRequestFailed = "Sem conexão a internet";
  static const errorGettingAdData = "Falha ao tentar recuperar dados do Anúncio";
  static const errorGettingUserData = "Falha ao tentar recuperar dados do Usuário";

  //error messages for user registration
  static const registerUserError = "Falha ao cadastrar o usuário! Tente novamente mais tarde.";
  static const registerErrorWeakPassword = "Temnte colocar uma senha que possua letra e números";
  static const registerErrorEmailAlreadyUse = "Já exite um usuário com esse endereço de email.";
  static const updateDataUserError = "Falhao ao atualizar os dados do usário!";
  static const registerAdError = "Falha ao cadastrar o seu Anúncio! Tente novamente mais tarde.";

  //error messages for user login
  static const loginError = "Flha ao acessar a conta do usuário!";
  static const loginErrorInvalidEmail = "Endereço de email invalido";
  static const loginErrorUserNotFound = "Usuário não encontrado";
  static const loginErrorNetworkRequestFailed = "Sem conexão a internet";
  static const loginErrorWrongPassword = "Senha incorreta.";
  static const loginErrorTooManyRequests = "Muitas tentativas de login, tente novamente mais tarde";

  //error messages for logout
  static const logoutUserError = "Falha ao desconectar o usuário da sua conta";

  //My Ads Screen
  static const myAdsTitle = "Meus Anúncios";
  static const adDetails = "Detalhes do Anúncio";

  //Create Ad Screen
  static const newAdTitle = "Novo Anúncio";
  static const newAdNoImage = "Por favor selecio uma imagem para o seu anúncio";
  static const alertDialogRemoveImageTitle = "Você quer remover essa image?";
  static const alertDialogPositiveButton = "Sim";
  static const alertDialogNegativeButton = "Não";
  static const stateDropDown = "Estados";
  static const categoryDropDown = "Categorias";
  static const productsName = "Produto";
  static const productPrice = "Preço";
  static const productDescription = "Descrição";
  static const phoneText = "Telefone";
  static const categoryText = "Categoria";
  static const stateText = "Estado";
  static const requiredField = "Campo Obrigatorio";
  static const maxCharacters = "Máximo de 500 caracteres.";

  //Edit Data Product
  static const cancelButton = "Cancelar";
  static const editTitle = "Digite um novo Titulo";
  static const editPrice = "Digite um novo Preço";
  static const editPhone = "Informe um telefone para contato";
  static const editDescription = "Falhe um pouco mais sobre o seu produto";

}