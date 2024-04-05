class Counter {
  int _count = 0;

  int get getcount => _count;

  void increment() {
    _count++;
  }

  void decrement() {
    _count--;
  }

  void reset() {

    _count=0;
  }
}
