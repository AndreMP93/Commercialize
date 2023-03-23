import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';

class FieldValidation{
  static String validationLoginFields(AppUser user) {
    String menssagemErro = "";
    if (user.email != null && user.email!.contains("@")) {
      if (user.password != null && user.password!.isEmpty) {
        return menssagemErro;
      }
      menssagemErro +=
      "${AppStrings.passwordError}\n";
      return menssagemErro;
    } else {
      menssagemErro = "${AppStrings.emailError}\n$menssagemErro";
      return menssagemErro;
    }

  }

  static String validationRegistrationFields(AppUser user) {
    String menssagemErro = "";
    if (user.name != null && user.name!.isNotEmpty) {
      if (user.email != null && user.email!.contains("@")) {
        if (user.password!.isNotEmpty && user.password!.length > 5) {
          return menssagemErro;
        }
        menssagemErro +=
        "${AppStrings.passwordError}\n";
        return menssagemErro;
      } else {
        menssagemErro = "${AppStrings.emailLabel}\n$menssagemErro";
        return menssagemErro;
      }
    }
    menssagemErro = "${AppStrings.userNameError}\n$menssagemErro";
    return menssagemErro;
  }
}