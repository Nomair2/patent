import 'package:get/get.dart';

validInput(String val, int min, String type, String password) {
  if (val.isEmpty) {
    return "This field cannot be empty";
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return "Invalid email ";
    }
  }
  if (type == "password") {
    if (val.length < min) {
      return "Password must be at least $min characters ";
    }
  }
  if (type == "phone") {
    if (val.length < min) {
      return "Phone must be at least  $min digits";
    }
  }
}
