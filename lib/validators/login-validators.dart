import 'dart:async';

class LoginValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@") || email.length > 0) {
      sink.add(email);
    } else {
      sink.addError("Informe um E-mail Válido");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 5) {
        sink.add(password);
      } else {
        sink.addError("Senha deve ter no minímo 5 caracteres");
      }
    },
  );
}
