part of './wx_manager.dart';

class GenerateSignVo {
  String? appId;
  String? nonceStr;
  String? packageValue;
  String? partnerId;
  String? prepayId;
  String? sing;
  String? timeStamp;

  GenerateSignVo({
    this.appId,
    this.nonceStr,
    this.packageValue,
    this.partnerId,
    this.prepayId,
    this.sing,
    this.timeStamp,
  });

  GenerateSignVo.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    nonceStr = json['nonceStr'];
    packageValue = json['packageValue'];
    partnerId = json['partnerId'];
    prepayId = json['prepayId'];
    sing = json['sing'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['appId'] = appId;
    data['nonceStr'] = nonceStr;
    data['packageValue'] = packageValue;
    data['partnerId'] = partnerId;
    data['prepayId'] = prepayId;
    data['sing'] = sing;
    data['timeStamp'] = timeStamp;
    return data;
  }
}
