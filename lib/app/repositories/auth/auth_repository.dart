import 'package:consuni/app/models/userDrawer_model.dart';
import 'package:consuni/app/models/view_models/register_view_model.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String> recoveryPassword(String email);
  // Future<String> register(String name, String email, String password);
  Future<String> register(RegisterViewModel registerViewModel);
  Future<List?> getInstituicao();
  Future<List?> getClasse();
  Future<UserDrawerModel> getUserByToken();
  Future<String> validadeCode(String email, int code);
}
