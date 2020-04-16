import 'package:location/location.dart';

Location location = Location();
bool _serviceEnabled;
PermissionStatus _permissionGranted;

Future<bool> checkServiceEnable()async{
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return false;
    }
  }
  return true;
}
Future<bool> checkPermission()async{
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}