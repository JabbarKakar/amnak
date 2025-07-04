bool validateNameEnAndAr(String? name) {
  name = name?.trimRight();
  final RegExp nameRegex =
      RegExp(r'^[\u0621-\u064Aa-zA-Z]+(?:\s[\u0621-\u064Aa-zA-Z]+)*$');
  if (name != null || name != '') {
    return nameRegex.hasMatch(name!);
  }
  return false;
}

bool isEmail(String? email) {
  final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (email != null || email != '') {
    return emailRegex.hasMatch(email!);
  }
  return false;
}

bool validateId(String? email) {
  final RegExp regExp = RegExp(r'^[0-9]{10}$');
  if (email != null || email != '') {
    return regExp.hasMatch(email!);
  }
  return false;
}

bool validatePhoneNumber(String? contactNumber) {
  // Add your function code here!
  final RegExp saudiArabiaMobileRegex = RegExp(r'^(5)[0-9]{8}$');
  if (contactNumber == null || contactNumber == '') {
    return false;
  } else {
    if (saudiArabiaMobileRegex.hasMatch(contactNumber)) {
      return true;
    } else {
      return false;
    }
  }
}

bool validateAddWalletAmount(String? amount) {
  // Add your function code here!
  if (amount == null || amount == '') {
    return false;
  }

  double doubleAmount = double.parse(amount);
  if (((doubleAmount) < 1.00) && ((doubleAmount) > 500.00)) {
    return true;
  } else {
    return false;
  }
}

bool isValidAmountAction(String? amount) {
  RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');

  if (amount == null || amount.isEmpty) {
    return false;
  }

  return regex.hasMatch(amount);
}
