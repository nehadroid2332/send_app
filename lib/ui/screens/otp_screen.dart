import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sendapp/bloc/authenticaion/bloc.dart';
import 'package:sendapp/bloc/register/bloc.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/screens/register_screen.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/utils/constants.dart';
import '../../bloc/login/bloc.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final UserRepo userRepo;
  final LoginBloc bloc;
  final AuthenticationBloc authBloc;

  const OtpScreen(
      {Key key, this.mobileNumber, this.userRepo, this.bloc, this.authBloc})
      : assert(mobileNumber != null),
        super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _pinEditingController = TextEditingController();
  bool isCodeSent = false;
  String _verificationId;
  UserModel userModel;
  LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = widget.bloc;
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Enter OTP",
          style: kTextBodyH1,
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener(
        bloc: _loginBloc,
        listener: (BuildContext context, LoginState state) {
          print(state);
          if (state is LoginFail) {
            print(state.reason);
            setState(() {
              isCodeSent = false;
            });
            showToast(state.reason, Colors.red);
          }
          if (state is LoginLoading) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Login.."),
                  CircularProgressIndicator()
                ],
              )));
          }
          if (state is LogedIn) {
            _ifSuccess();
//             BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          }
        },
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: PinInputTextField(
                    controller: _pinEditingController,
                    autoFocus: true,
                    onSubmit: (pin) {
                      if (pin.length == 6) {
                        _onFormSubmitted();
                      } else {
                        showToast("Invalid OTP", Colors.red);
                      }
                    },
                    decoration: BoxLooseDecoration(gapSpace: 6),
                    pinLength: 6,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: ReusableButton(
                    text: "Continue",
                    ico: Icons.arrow_forward,
                    onPress: () {
                      print(_pinEditingController.text.length);
                      if (_pinEditingController.text.length == 6) {
                        print("inside if button");
                        _onFormSubmitted();
                      } else {
                        showToast("Invalid OTP", Colors.red);
                      }
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithPhonePressed(
          smsCode: _pinEditingController.text,
          verificationCode: _verificationId),
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          print(value.user);
          widget.userRepo.saveUser(
              UserModel(phone: value.user.phoneNumber, id: value.user.uid));
          _ifSuccess();
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        print(error);
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(authException);
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _ifSuccess() async {
    try {
      var user = await widget.userRepo.getSavedUser();
      var verifiedUser =
          await widget.userRepo.verifyCurrentUser(phoneNumber: user.phone);
      Navigator.pop(context);
      widget.authBloc.add(LoggedIn());
    } catch (e) {
      //navigate to register screen
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                RegisterBloc(repo: widget.userRepo, authBloc: widget.authBloc),
            child: RegisterScreen(),
          ),
        ),
      );
    }
  }
}
