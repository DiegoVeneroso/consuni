import 'package:consuni/app/core/ui/app_state.dart';
import 'package:consuni/app/modules/auth/register/register_controller.dart';
import 'package:consuni/app/modules/auth/register/steps/one_page.dart';
import 'package:consuni/app/modules/auth/register/steps/three_page.dart';
import 'package:consuni/app/modules/auth/register/steps/two_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends AppState<RegisterPage, RegisterController> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  var navKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPopNavRegister = navKey.currentState?.canPop() ?? false;
        if (canPopNavRegister) {
          navKey.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Navigator(
            initialRoute: '/one',
            key: navKey,
            onGenerateRoute: (settings) {
              var route = settings.name;
              Widget page;
              switch (route) {
                case '/one':
                  page = const OnePage();
                  break;
                case '/two':
                  page = TwoPage();
                  break;
                case '/three':
                  page = const ThreePage();
                  break;
                default:
                  return null;
              }
              return MaterialPageRoute(
                builder: (context) => page,
                settings: settings,
              );
            }),
      ),
    );
  }
}
