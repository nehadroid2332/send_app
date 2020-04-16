import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/user_repo.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo _userRepository;

  AuthenticationBloc({@required UserRepo userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }else if (event is NotRegistered){
      yield Registration();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final currentUser = await _userRepository.getSavedUser();
        print(currentUser);
        yield Authenticated(currentUser);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final currentUser = await _userRepository.getSavedUser();
    yield Authenticated(currentUser);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
