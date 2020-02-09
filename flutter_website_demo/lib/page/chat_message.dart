import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  // 判断是否自己发出的消息
  bool isMe = false;
  String userName;
  String message;
  String createAt;
  ChatMessage(this.userName, this.message, this.createAt);

  Widget messageInfo(context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(createAt, style: Theme.of(context).textTheme.subhead),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(message),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isMe) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            // 垂直排列显示消息时间和内容
            messageInfo(context),
            // 我的头像
            Container(
              margin: EdgeInsets.only(left: 16),
              child: CircleAvatar(
                child: Text('Me'),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              child: Text(userName),
            ),
          ),
          messageInfo(context),
        ],
      ),
    );
  }
}