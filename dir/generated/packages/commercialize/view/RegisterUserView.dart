import 'dart:io';

import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:commercialize/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({Key? key}) : super(key: key);

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {

  File? _profilePicture;
  late final AuthenticationViewModel _authViewModel;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _authViewModel = Provider.of<AuthenticationViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            AppStrings.registerUserLabel
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){_selectProfilePicture(context);},
                    child: CircleAvatar(
                        radius: 120,
                        backgroundImage: (_profilePicture == null)
                            ? null
                            : FileImage(_profilePicture!),
                        child: (_profilePicture != null)
                            ?null
                            :const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                          size: 150,
                        )
                    ),
                  ),
                  // Icon(
                  //   Icons.person_add_alt_1,
                  //   size: MediaQuery.of(context).size.width * 0.2,
                  //   color: AppColors.primaryColor,
                  // ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                          labelText: AppStrings.username,
                          controller: _userNameController,
                          icon: const Icon(Icons.person)
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        labelText: AppStrings.emailLabel,
                        controller: _emailController,
                        icon: const Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        labelText: AppStrings.passwordLabel,
                        controller: _passwordController,
                        icon: const Icon(Icons.lock),
                        isPassword: true,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: TextButton(
                      onPressed: _registerUser,
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.fromLTRB(
                              32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(32))
                      ),
                      child: Text(
                        AppStrings.registerButton.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  Future _selectProfilePicture(BuildContext buildContext) async {
    return showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Seleciona uma Foto de Perfil"),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.green,size: 40,),
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  var foto = await picker.pickImage(source: ImageSource.camera);
                  if(foto !=null){
                    Navigator.of(context).pop();
                    setState(() {
                      _profilePicture = File(foto.path);
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.photo, color: Colors.green,size: 40,),
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    var foto = await picker.pickImage(source: ImageSource.gallery);
                    if(foto !=null){
                      Navigator.of(context).pop();
                      setState(() {
                        _profilePicture = File(foto.path);
                      });

                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  Future _registerUser() async {
    AppUser user = AppUser(
        name: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text
    );
    await _authViewModel.registerUser(user);
    Navigator.pop(context);
  }
}
