import 'package:local_auth/local_auth.dart';

final LocalAuthentication auth = LocalAuthentication();
isSupport() {
  return auth.isDeviceSupported();
}

isFingerSpringAvalable() {
  return auth.canCheckBiometrics;
}

