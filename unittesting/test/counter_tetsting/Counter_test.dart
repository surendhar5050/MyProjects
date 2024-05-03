import 'package:counterapp_unittesting/counter_app/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //pretest
  late Counter counter;
  setUp(() => {counter = Counter()});

  // setUpAll(() => null);

  //testing
  group("group testing of counter object", () {
    test("check intinal value is Zero 0", () {
      final val = counter.getcount;

      expect(val, 0);
    });

    test("when the function is trigger value is increment", () {
      counter.increment();
      final val = counter.getcount;
      expect(val, 1);
    });
    test("when the function is trigger value is decrement", () {
      counter.decrement();
      final val = counter.getcount;

      expect(val,-1);
    });

    test("when the function is trigger value is 0", () {
      counter.reset();
      final val = counter.getcount;

      expect(val, 0);
    });
  });

  //post test

  // tearDown(() => null);

  // tearDownAll(() => null);
}
