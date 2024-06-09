import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>> _controller = StreamController.broadcast();

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel!.stream.listen((data) {
      _controller.add(json.decode(data));
    }, onDone: () {
      // Handle connection close
    }, onError: (error) {
      // Handle error
    });
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  Stream<Map<String, dynamic>> get messages => _controller.stream;

  void dispose() {
    _controller.close();
    _channel?.sink.close();
  }
}
