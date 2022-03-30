
import 'package:geolocator/geolocator.dart';


class GeolocationService {
  Position? _position;
  LocationPermission? _permission;
  bool _isLocationServiceEnabled = false;

  Future<List> getLocation() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied)
      {
        _permission = await Geolocator.requestPermission();
      }
    else
      {
        _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (_isLocationServiceEnabled)
          {
            _position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            //placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
            //place = placemarks![0];
            //address = '${place?.street}, ${place?.postalCode}, ${place?.country}';
            return [_position!.latitude, _position!.longitude];
          }
      }
      return [0.0, 0.0];
  }
}