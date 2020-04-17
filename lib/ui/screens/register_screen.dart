import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_event.dart';
import 'package:sendapp/bloc/register/register_bloc.dart';
import 'package:sendapp/bloc/register/register_event.dart';
import 'package:sendapp/bloc/register/register_state.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:sendapp/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: lighterGreyColor,
      appBar: AppBar(
        title: Text(
          "Registration",
          style: kTextBodyH1,
        ),
        centerTitle: true,
        backgroundColor: lighterGreyColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener(
        bloc: BlocProvider.of<RegisterBloc>(context),
        listener: (ctx, state) {
          if (state is UserRegistering) {
            //show loader
            _key.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Register.."),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              );
          } else if (state is UserRegistered) {
            BlocProvider.of<AuthenticationBloc>(context)..add(LoggedIn());
          } else if (state is UserRegisterFail) {
            //fail msg
            _key.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("${state.reason}"),
                ],
              )));
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<RegisterBloc>(context),
          builder: (ctx, state) {
            return Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          return val.length > 3 ? null : "Enter Valid Phone";
                        },
                        decoration: InputDecoration(
                          hintText: "Enter First Name",
                          hintStyle: kTextBodyP,
                          fillColor: lightGreyColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          return val.length > 3 ? null : "Enter last Name";
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Last Name",
                          hintStyle: kTextBodyP,
                          fillColor: lightGreyColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          return Validators.isValidEmail(val)
                              ? null
                              : "Enter Email";
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: kTextBodyP,
                          fillColor: lightGreyColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: ReusableButton(
                        text: "Register",
                        ico: Icons.arrow_forward,
                        onPress: () {
                          _handleFormSubmit();
                        },
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }

  void _handleFormSubmit() {
    try {
      if (_formkey.currentState.validate()) {
        print("validate");
        BlocProvider.of<RegisterBloc>(context).add(ButtonPressed(
          name: _nameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
