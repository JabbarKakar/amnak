import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('MyController', () {
    late MyController myController;

    setUp(() {
      // Set up the controller before each test
      myController = MyController();
    });

    tearDown(() {
      // Clean up resources after each test
      myController.dispose();
    });

    test('Initial count should be 0', () {
      expect(myController.count, 0.obs);
    });

    test('Increment count should increase the count by 1', () {
      myController.increment();
      expect(myController.count, 1.obs);
    });

    test('Decrement count should decrease the count by 1', () {
      myController.decrement();
      expect(myController.count, (-1).obs);
    });
  });
}

class MyController extends GetxController {
  final count = 0.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    count.value--;
  }
}
