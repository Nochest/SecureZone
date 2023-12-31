import 'dart:async';

class Debouncer<T> {
  Debouncer(
    this.duration,
    this.onValue,
    this._timer,
  );
  final Duration duration;
  void Function(T value) onValue;
  late T _value;
  Timer _timer;
  T get value => _value;
  set value(T val) {
    _value = val;
    _timer.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}
//TODO: VER QUE EL LATE NO SE CAIGA
