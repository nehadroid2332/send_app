import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/bloc/login/login_bloc.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:sendapp/utils/validators.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  final UserRepo userRepo;
  final AuthenticationBloc authenticationBloc;

  const LoginScreen({Key key,@required this.userRepo,@required this.authenticationBloc}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: BlocListener(
        bloc: loginBloc,
        listener: (context, state) {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                validator: (val) {
                  return Validators.isValidPhone(val)
                      ? null
                      : "Enter Valid Phone";
                },
                decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  hintStyle: kTextBodyP,
                  fillColor: lighterGreyColor,
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
                text: "Login",
                ico: Icons.arrow_forward,
                onPress: () {
                  if (Validators.isValidPhone(_phoneController.text)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          mobileNumber: "+91" + _phoneController.text,
                          userRepo: widget.userRepo,
                          bloc: loginBloc,
                          authBloc:widget.authenticationBloc
                        ),
                      ),
                    );
                  } else {
                    _key.currentState
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please Enter Valid Number",
                            style: TextStyle(
                              color: whiteColor,
                            ),
                          ),
                          backgroundColor: greenColor,
                        ),
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
