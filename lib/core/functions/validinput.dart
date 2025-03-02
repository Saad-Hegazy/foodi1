import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "45".tr; // "Input cannot be empty"
  }

  // Check length restrictions
  if (val.length < min) {
    return "46".tr + "$min"; // "Input is too short"
  }
  if (val.length > max) {
    return "47".tr + " $max"; // "Input is too long"
  }

  // Check for special characters like <, >, /
  if (val.contains(RegExp(r'[<>/]+'))) {
    return '196'.tr; // "Input contains invalid characters"
  }

  // Specific type-based validation
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "42".tr; // "Invalid username"
    }
  }

  if (type == "search") {
    if(val=="</>"){
      return '196'.tr;
    }
    // If needed, you can adjust this to a more specific search format later
    final searchRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!searchRegex.hasMatch(val)) {
      return '196'.tr; // "Search term contains invalid characters"
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "43".tr; // "Invalid email format"
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "44".tr; // "Invalid phone number"
    }
  }

  return null; // Valid input
}
