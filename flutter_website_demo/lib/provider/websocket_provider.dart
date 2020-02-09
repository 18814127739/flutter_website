import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import '../utils/random_string.dart';
import '../conf/configure.dart';

class WebSocketProvider with ChangeNotifier {
  String userId = '';
  String userName = '';
  List messages = [];
  // websocket对象
  IOWebSocketChannel channel;
  // 初始化
  init() async {
    // 使用随机数创建userid
    userId = randomNumeric(6);
    // 使用随机数创建userName
    userName = "u_" + randomNumeric(6);
    return await createWebsocket();
  }
  // 创建并连接socket服务器
  createWebsocket() async {
    // 连接socket服务器
    channel = await IOWebSocketChannel.connect('ws://${Config.IP}:${Config.PORT}');
    // 定义加入房间消息
    var message = {
      'type': 'joinRoom',
      'userId': userId,
      'userName': userName,
    };
    // json编码
    String text = json.encode(message).toString();
    // 发送消息至服务器
    channel.sink.add(text);
    // 监听服务器返回消息r
    channel.stream.listen(
      (data) => listenMessage(data),
      onError: onError,
      onDone: onDone,
    );
  }
  // 监听服务端返回消息
  listenMessage(data) {
    // json解码
    var message = jsonDecode(data);
    print('receive message: ${message}');
    if(message['type'] == 'chat_public') {
      // 插入消息至消息列表
      messages.insert(0, message);
    }
    // 通知聊天页面刷新
    notifyListeners();
  }
  // 发送消息
  sendMessage(type, data) {
    // 定义发送对象
    var message = {
      "type": 'chat_public',
      'userId': userId,
      'userName': userName,
      'msg': data,
    };
    String text = json.encode(message).toString();
    // 发送消息至服务器
    channel.sink.add(text);
  }
  // 监听消息错误时回调方法
  onError(error) {
    print('error:${error}');
  }
  // 当websocket断开时的回调方法, 此处可以做重连处理
  onDone() {
    print('WebSocket断开了');
  }
  // 前端主动关闭websocket处理
  closeWebSocket() {
    channel.sink.close();
    print('关闭websocket');
    notifyListeners();
  }
}