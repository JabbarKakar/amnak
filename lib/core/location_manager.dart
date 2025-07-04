import 'package:amnak/core/utils/utils.dart';
import 'package:geolocator/geolocator.dart';

const double kMyShopLocationLat = 24.60902494467467;
const double kMyShopLocationLon = 46.74921567116385;

Future<bool> getDistance(double addressLat, double addressLong) async {
  double distanceInM = Geolocator.distanceBetween(
      kMyShopLocationLat, kMyShopLocationLon, addressLat, addressLong);
  if (distanceInM > 200) {
    showFailSnack(message: 'you are out of company');
    return false;
  } else {
    showSuccessSnack(message: 'you are in company');
    return true;
  }
}

Future<Position?> getLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showFailSnack(message: "من فضلك قم بتفعيل خدمه الموقع");
    return null;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showFailSnack(message: "من فضلك قم بتفعيل خدمه الموقع");
      return null;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    showFailSnack(message: "لا يمكنك استخدام التطبيق بدون تفعيل خدمه الموقع");
    return null;
  }
  return await Geolocator.getCurrentPosition();
}

Future attendEmployee() async {
  var myLocation = await getLocationPermission();
  if (myLocation != null) {
    bool isAttended =
        await getDistance(myLocation.latitude, myLocation.longitude);
    if (isAttended) {
      // send to api
    }
  }
}
