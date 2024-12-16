# Auth
Projeto flutter de autenticação de usuario

Integrante: Ana Paula Lenckulh

# Funcionalidades
Tela de Login: 
- Login de usuario via nome de usuario e senha;
- Login de usuario via provedor do google;
- Acesso a tela de registro em caso de não possuir login;

Tela de Registro:
- Registro de usuario apartir das informações necessárias;
- Acesso a tela de login em caso de possuir registro;

Tela Home:
- Botão para logout da conta;
- Botão para acessar a página de login, caso não esteja logado;
-  Criação de livros;
-  Edição de livros;
-  Visualização de livros;

# Dependencias
Os depositos ultilizados para o funcionamento do app incluem:
flutter_svg: ^1.0.3 - Para o uso de svg's no app.
phosphor_flutter: ^1.1.1 - Para o uso da biblioteca de icones PhosphorIcons.
intl: ^0.19.0 - Para a formatação de tempo relativa sensível ao idioma.
http: ^1.2.2 - Para fazer as requisições.
google_sign_in: ^6.2.2 - Para realizar o login via o provedor do google.

As dependencias abaixo são para o uso do firestore:
cloud_firestore: ^5.5.0
firebase_core: ^3.8.0
firebase_auth: ^5.3.3

# Tratamento de erros
Os erros tratados pelo provedor são realizados apartir do FirebaseAuthException, que verifica se o e-mail é existente e se a senha possui acima de 6 caracteres.

# Configuração
Para o uso do aplicativo é necessário a versão flutter ser 3.24.0 ou acima, desta forma a versão do Dart também deve ser acima de 3.5.0.
