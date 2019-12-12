import 'dart:isolate';

void main(List<String> args) async {
  // 创建管道
  ReceivePort receivePort = ReceivePort();

  // 创建新的Isolate
  Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);

  // 监听管道消息
  receivePort.listen((data) {
    print('>>>>Data：$data');
    if((data as String).contains('!')) {
      // 不再使用时，我们会关闭管道
      receivePort.close();
    }
  }, onDone: () {
    print('>>>>onDone');
    // 需要将isolate杀死
    isolate?.kill(priority: Isolate.immediate);
  });
}

void foo(SendPort sendPort) {
//  sleep(Duration(seconds: 3));
  sendPort.send("Hello World");
  sendPort.send("Hello World!!");
}
