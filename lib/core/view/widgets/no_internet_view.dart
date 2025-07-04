import 'package:lottie/lottie.dart';

import '../../../export.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/no_internet.json',
              width: 200,
              repeat: false,
              onLoaded: (composition) {},
            ),
            const Text('no_internet_connection'),
          ],
        ),
      ),
    );
  }
}
