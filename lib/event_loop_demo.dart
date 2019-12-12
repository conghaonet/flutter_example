import 'dart:async';

/// https://www.codercto.com/a/49600.html
/// https://juejin.im/post/5c338bdb6fb9a04a01647eb9
/// Dart的异步队列不是我们平常想的那样，一边往队列里加task，一边运行，
/// 而是先往队列里添加task，所有task添加完毕，才会运行，
/// 所以 Future 的task就添加到 event queue ，而 scheduleMicrotask 添加到 microtask queue 。
void main() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtask #1 of 3'));

  Future.delayed(Duration(seconds: 1), () => print('future #1 of 4 (delayed)'));

  Future(() => print('future #2 of 4')).then((_) => print('future #2a')).then((_) {
    print('future #2b');
    scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
  }).then((_) => print('future #2c'));

  scheduleMicrotask(() => print('microtask #2 of 3'));

  Future(() => print('future #3 of 4'))
      .then((_) => Future(() => print('future #3a (a new future)')))
      .then((_) => print('future #3b'));

  Future(() => print('future #4 of 4')).then((_) {
    Future(() => print('future #4a'));
  }).then((_) => print('future #4b'));

  scheduleMicrotask(() => print('microtask #3 of 3'));

  print('main #2 of 2');
}
