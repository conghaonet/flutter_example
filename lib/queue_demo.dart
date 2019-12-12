import "dart:async";

/// https://segmentfault.com/a/1190000020398241?utm_source=tag-newest
/// Dart的异步队列不是我们平常想的那样，一边往队列里加task，一边运行，
/// 而是先往队列里添加task，所有task添加完毕，才会运行，
/// 所以 Future 的task就添加到 event queue ，而 scheduleMicrotask 添加到 microtask queue 。
///
/// 代码分析：
/// 1、main函数先执行，所以main start和main end先执行，没有任何问题；
/// 2、main函数执行过程中，会将一些任务分别加入到EventQueue和MicrotaskQueue中；
/// 3、task7通过scheduleMicrotask函数调用，所以它被最早加入到MicrotaskQueue，会被先执行；
/// 4、然后开始执行EventQueue，task1被添加到EventQueue中被执行；
/// 5、通过final future = Future(() => null);创建的future的then被添加到微任务中，微任务直接被优先执行，所以会执行task6；
/// 6、一次在EventQueue中添加task2、task3、task5被执行；
/// 7、task3的打印执行完后，调用scheduleMicrotask，那么在执行完这次的EventQueue后会执行，所以在task5后执行task4（注意：scheduleMicrotask的调用是作为task3的一部分代码，所以task4是要在task5之后执行的）
/// 8、task8、task9、task10一次添加到EventQueue被执行；

Future main(List<String> args) async {
  print("main start");

  Future(() => print("task1"));
  final future = Future(() => null);

  Future(() => print("task2")).then((_) {
    print("task3");
    scheduleMicrotask(() => print('task4'));
  }).then((_) => print("task5"));

  future.then((_) => print("task6"));
  scheduleMicrotask(() => print('task7'));

  Future(() => print('task8'))
      .then((_) => Future(() => print('task9')))
      .then((_) => print('task10'));

  print("main end");
}
