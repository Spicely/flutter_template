import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'BASE_URL_DEV')
  static const String baseUrlDev = _Env.baseUrlDev;
}
