class Validators {
  //nome
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome é obrigatório.';
    }
    return null;
  }

  //sobrenome
  static String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'O sobrenome é obrigatório.';
    }
    return null;
  }

  //email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O e-mail é obrigatório.';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Informe um e-mail válido.';
    }
    return null;
  }

  //senha
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  //confirmar senha
  static String? validateConfirmPassword(String password, String confirmPw) {
    if (password != confirmPw) {
      return 'As senhas não coincidem.';
    }
    return null;
  }

  static String? validateAge(DateTime? birthDate) {
    if (birthDate == null) {
      return 'Data de nascimento é obrigatória.';
    }
    final age = DateTime.now().year - birthDate.year;
    if (age < 18) {
      return 'Você deve ter mais de 18 anos.';
    }
    return null; // Nenhum erro
  }
}
