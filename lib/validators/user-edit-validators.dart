class UserEditValidators {
  String valName(String text) {
    if (text.isEmpty) {
      return "Informe o Nome";
    }
    return null;
  }

  String valPassword(String text) {
    if (text.length < 5) {
      return "Senha deve mais de 5 digitos";
    } else if (text.isEmpty) {
      return "Informe a Senha";
    }
    return null;
  }

  String valUser(String text) {
    if (!text.contains("@")) {
      return "Informe um E-mail Válido";
    }
    return null;
  }
}
