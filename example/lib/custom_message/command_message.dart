import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'dart:convert' as json_lib show json;

// 自定义消息需要继承 RCIMIWUserCustomMessage
//
class RCIMDCommandMessage extends RCIMIWUserCustomMessage {
  String? name;
  String? data;
  // 1. 定义自己的构造方法,需要调用父类的 RCIMIWUserCustomMessage(RCIMIWConversationType type, String targetId)
  RCIMDCommandMessage(RCIMIWConversationType type, String targetId, this.name, this.data) : super(type, targetId);

  // 2. 需要继承父类的构造函数
  RCIMDCommandMessage.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  // 3. 需要实现父类的 decode/encode/messageObjectName
  @override
  void decode(String jsonStr) {
    Map map = json_lib.json.decode(jsonStr.toString());
    // 获取的 key 值要与原生传递的 key 值一样
    name = map['name'];
    name = map['data'];
  }

  @override
  String encode() {
    Map map = {};
    // 传递的 key 值要与原生传递的 key 值一样
    map['name'] = name;
    map['data'] = data;
    return json_lib.json.encode(map);
  }

  @override
  String messageObjectName() {
    return "RC:CmdMsg";
  }

  // 4. 需要实现父类的 toJson
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    // 此处 'content' 不可修改
    json['content'] = encode();
    return json;
  }
}
