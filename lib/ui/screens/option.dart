import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/bloc/authenticaion/bloc.dart';
import 'package:sendapp/bloc/login/login_bloc.dart';
import 'package:sendapp/bloc/register/bloc.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/custom_widget/circular_switch.dart';
import 'package:sendapp/ui/screens/otp_screen.dart';
import 'package:sendapp/ui/screens/register_screen.dart';
import 'package:sendapp/ui/screens/settings_screen.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/ui/widgets/reusable_card.dart';
import 'package:sendapp/ui/widgets/reusable_setting_card.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:sendapp/utils/validators.dart';

import 'account_screen.dart';
import 'login_Screen.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, AuthenticationState state) {
          if (state is Uninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Authenticated) {
//            print(state.user);
            return SettingScreen(user:state.user);
          } else if (state is Unauthenticated) {
            return BlocProvider(create: (context)=>LoginBloc(userRepository:RepositoryProvider.of<UserRepo>(context)),
            child: LoginScreen(userRepo:RepositoryProvider.of<UserRepo>(context),authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),),
            );
          } /*else if (state is Registration){
            Navigator.push(context, MaterialPageRoute());
            return BlocProvider(
              create: (context)=>RegisterBloc(repo: RepositoryProvider.of<UserRepo>(context)),
              child: RegisterScreen(),
            );
          }*/
          return null;
        });
  }
}
