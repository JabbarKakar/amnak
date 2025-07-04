import 'package:amnak/export.dart';
import 'package:local_auth/local_auth.dart';

class Authenticate {
  static final LocalAuthentication _authentication = LocalAuthentication();

  static Future<void> authenticate({
    required VoidCallback onSuccess,
    required BuildContext context,
  }) async {
    try {
      final bool isAuthenticated = await _authentication.authenticate(
        localizedReason:
            'Please authenticate to login & attend the company working day',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      final res = await _authentication.getAvailableBiometrics();
      Logger().i(res);
      if (isAuthenticated) {
        onSuccess();
      }
    } catch (failure) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $failure'),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Please add your fingerprint or face id or pin code or password'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
