import 'package:chat_app/core/shared_widgets/util.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/validator.dart';

class ServiceInjector {
  AuthServices authServices = AuthServices();
  Validator validator = Validator();
  Util util = Util();
}

ServiceInjector si = ServiceInjector();
