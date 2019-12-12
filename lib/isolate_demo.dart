import 'dart:isolate';

void main() async {
  // 创建管道
  ReceivePort receivePort = ReceivePort();

  // 创建新的Isolate
  Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);

  // 监听管道消息
  receivePort.listen((data) {
    print('Data：$data');

    // 不再使用时，我们会关闭管道
    receivePort.close();

    // 需要将isolate杀死
    isolate?.kill(priority: Isolate.immediate);
  });
}

void foo(SendPort sendPort) {
  sendPort.send("Hello World");
}
