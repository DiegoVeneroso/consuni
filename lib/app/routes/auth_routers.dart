import 'package:consuni_mobile/app/modules/auth/code_recovery/code_recovery_bindings.dart';
import 'package:consuni_mobile/app/modules/auth/code_recovery/code_recovery_page.dart';
import 'package:consuni_mobile/app/modules/auth/login/login_bindings.dart';
import 'package:consuni_mobile/app/modules/auth/login/login_page.dart';
import 'package:consuni_mobile/app/modules/auth/password_recovery/password_recovery_bindings.dart';
import 'package:consuni_mobile/app/modules/auth/password_recovery/password_recovery_page.dart';
import 'package:consuni_mobile/app/modules/auth/password_renew/password_renew_bindings.dart';
import 'package:consuni_mobile/app/modules/auth/password_renew/password_renew_controller.dart';
import 'package:consuni_mobile/app/modules/auth/password_renew/password_renew_page.dart';
import 'package:consuni_mobile/app/modules/auth/register/register_bindings.dart';
import 'package:consuni_mobile/app/modules/auth/register/register_page.dart';
import 'package:get/route_manager.dart';

class AuthRouters {
  AuthRouters._();

  static final routers = <GetPage>[
    GetPage(
      binding: LoginBindings(),
      name: '/auth/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/auth/register',
      binding: RegisterBindings(),
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: '/auth/password_recovery',
      binding: PasswordRecoveryBindings(),
      page: () => const PasswordRecoveryPage(),
    ),
    GetPage(
      name: '/auth/code_recovery',
      binding: CodeRecoveryBindings(),
      page: () => const CodeRecoveryPage(),
    ),
    GetPage(
      name: '/auth/password_renew',
      binding: PasswordRenewBindings(),
      page: () => const PasswordRenewPage(),
    ),
  ];
}
