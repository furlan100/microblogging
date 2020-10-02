class PostsEditValidators {
  String valContent(String text) {
    if (text.length > 280) {
      return "Post deve ter menos de 280 caracteres ";
    } else if (text.isEmpty) {
      return "Informe o Conteúdo";
    }
    return null;
  }
}
