import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrdersController extends AuthController {
static OrdersController instance = Get.find();

  final String baseUrl = "https://backend.energychleen.ng/api";

}