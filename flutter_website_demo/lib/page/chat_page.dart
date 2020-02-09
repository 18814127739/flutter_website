import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import 'chat_message.dart';
import '../provider/websocket_provider.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  // 文本编辑控制器
  final TextEditingController textEditingController = TextEditingController();
  // 输入框获取焦点 
  FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleSubmit(String text) {
    // 判断输出框内容是否为空
    if(text.length == 0 || text == '') {
      return;
    }
    // 发送公共聊天消息
    Provider.of<WebSocketProvider>(context).sendMessage('chat_public', text);
    // 发送完后清空输入框信息
    textEditingController.clear();
  }

  // 消息输入框组件
  Widget TextComposerWidget() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                // 提示内容
                decoration: InputDecoration.collapsed(hintText: '请输入消息'),
                // 文本编辑控制器
                controller: textEditingController,
                onSubmitted: handleSubmit,
                focusNode: textFocusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => handleSubmit(textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 根据索引创建一个带动画的消息组件
  Widget messageItem(BuildContext context, int index) {
    // 获取一条聊天消息
    var item = Provider.of<WebSocketProvider>(context).messages[index];
    // 创建消息动画控制器
    var animate = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // 创建一个消息组件
    ChatMessage message = ChatMessage(
      item['userName'].toString(),
      item['msg'].toString(),
      formatDate(DateTime.now(), [HH, ':', nn, ':', ss]),
    );
    // 读取自己的userid, 判断服务端转发过来的消息是否为自己发送的消息
    String tempId = Provider.of<WebSocketProvider>(context).userId;
    if(tempId == item['userId']) {
      message.isMe = true;
    } else {
      message.isMe = false;
    }
    // 若index等于0则执行动画, 也就是最新消息执行动画
    if(index == 0) {
      // 开始动画
      animate.forward();
      // 大小变化动画组件
      return SizeTransition(
        // 指定非线性动画类型
        sizeFactor: CurvedAnimation(parent: animate, curve: Curves.easeInOut),
        axisAlignment: 0,
        // 指定为当前消息组件
        child: message,
      );
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Consumer<WebSocketProvider>(
          builder: (BuildContext context, WebSocketProvider websocketProvider, Widget child) {
            var messages = websocketProvider.messages;
            return Flexible(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: messageItem,
                padding: EdgeInsets.all(8),
                // 列表元素从下往上渲染
                reverse: true,
              ),
            );
          },
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: TextComposerWidget(),
        )
      ],
    );
  }
}