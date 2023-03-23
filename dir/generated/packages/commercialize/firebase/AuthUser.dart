import 'package:firebase_auth/firebase_auth.dart';
import 'package:commercialize/model/AppUser.dart';

class AuthUser {
  static final AuthUser _authSingleton = AuthUser._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  factory AuthUser() {
    return _authSingleton;
  }

  AuthUser._internal();

  FirebaseAuth get firebaseAuth => _firebaseAuth;



  Future<String> login(AppUser user) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );
      return "";
    }on FirebaseAuthException catch (e){
      if(e.code == "invalid-email"){
        return "Endereço de email invalido";
      }else if(e.code == "user-not-found"){
        return "Usuário não encontrado";
      }else if(e.code == 'network-request-failed'){
        return "Sem conexão com a Internet";
      }else if(e.code == "wrong-password"){
        return "Senha incorreta";
      }else if(e.code == 'too-many-requests'){
        return "Muitas tentativas de login tente mais tarde";
      }else{
        return e.code;
      }
    }
  }

  Future<String> registerUser(AppUser user) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );
      return "";
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'Senha muito fraca';
      } else if (e.code == 'email-already-in-use') {
        return 'Email já cadastrado';
      } else if (e.code == 'invalid-email') {
        return 'Email inválido';
      }else if(e.code == 'network-request-failed') {
        return "Sem conexão com a Internet";
      }else {
        return 'Erro desconhecido';
      }
    }
  }

  Future<String> signOut() async {
    try{
      await _firebaseAuth.signOut();
      return "";
    }catch(e){
      return "Falha ao realizar o logout";
    }
  }

  Future<AppUser?> get userLogged async {
    try{
      User? currentUser =  _firebaseAuth.currentUser;
      if(currentUser!= null){
        return AppUser(uId: currentUser.uid ,email: currentUser.email);
      }
    }catch(e){
      print(e);
      return null;
    }
    return null;

  }

}