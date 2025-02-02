import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/bloc/login/login_event.dart';
import 'package:ehsfocus/bloc/login/login_state.dart';
import 'package:ehsfocus/services/http/http_login.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/services/repository/repo_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final httpService = HttpLoginService();
  final _localStorageService = LocalStorageService();
  User _logedInUser = User();
  final RepoService _repoService = RepoService();
  User _user = User();
  LoginBloc() : super(LoginInitial()) {
    if (_localStorageService.getToken() != null) {
      amILogendIn();
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    dynamic data;
    yield UserLoginError(error: User());
    switch (event.runtimeType) {
      case CheckSinginEvent:
        String token = await _localStorageService.getToken();
        if (token == null) {
          return;
        }
        yield AppLoadingState();
        try {
          data = await httpService.isMe();
          _logedInUser = data;
          await _localStorageService.setRole(data.role);
          await _storeDataLocaly(_logedInUser);
          yield AuthorizedState(user: data);
        } catch (e) {
          yield LoginError(error: 'eroare la login');
          break;
        }

        break;

      case SignInEvent:
        yield LoadingState();
        try {
          data = await httpService.login(event.user);
          _logedInUser = data;
          await _storeDataLocaly(_logedInUser);
          _repoService.clearAllHives();
          yield AuthorizedState(user: data);
        } catch (e) {
          yield UserFormState(event.user ?? User());
          yield LoginError(error: 'eroare la login');
        }
        break;

      case SignUpEvent:
        try {
          data = await httpService.signUp(_user);
          if (data is String) {
            yield LoginError(error: data);
          }
          _logedInUser = data;
          await _storeDataLocaly(data);
          yield AuthorizedState(user: data);
        } catch (e) {
          yield UserLoginError(error: User.fromJson(e));
          print(e);
        }
        break;

      case SignOutEvent:
        data = await httpService.signOut();
        await _localStorageService.removeToken();
        await _localStorageService.removeRole();
        await _repoService.clearAllHives();
        // yield LogoutState(null);
        break;

      default:
        yield AuthorizedState(user: null);
    }
  }

  void onLogIn(User user) {
    // if (user == null) {
    //   return;
    // }
    add(SignInEvent(user: user));
  }

  void onSignUp() {
    if (_user == null) {
      return;
    }
    add(SignUpEvent());
  }

  void amILogendIn() {
    add(CheckSinginEvent());
  }

  getUserRole() {
    return _logedInUser.role;
  }

  void onLogout() {
    add(SignOutEvent());
  }

  _storeDataLocaly(data) async {
    await _localStorageService.setToken(data.token);
    await _localStorageService.setRole(data.role);
    await _localStorageService.setUserEmail(data.email);
  }

  void onSetEmail(value) {
    _user.email = value;
  }

  void onSetPassWoard(value) {
    _user.password = value;
  }

  void onSetSecondPassWoard(value) {
    _user.password2 = value;
  }
}
