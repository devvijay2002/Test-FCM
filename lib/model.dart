
class MetaModel {
  final String timeStamp;
  final String platform;
  final String appVersion;
  final String osVersion;
  final String latLan;
  final String deviceId;
  final String userAgent;
  final String? deviceName;

  const MetaModel({
    required this.appVersion,
    required this.deviceId,
    required this.latLan,
    required this.osVersion,
    required this.platform,
    required this.timeStamp,
    this.userAgent = 'mobileAPP',
    this.deviceName = 'NA',
  });

  factory MetaModel.fromJson({required Map<String, dynamic> json}) {
    return MetaModel(
      appVersion: json['appVersion'],
      deviceId: json['deviceId'],
      latLan: json['latLan'],
      osVersion: json['osVersion'],
      platform: json['platform'],
      timeStamp: json['timeStamp'],
      deviceName: json['deviceName'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['timeStamp'] = timeStamp;
    json['platform'] = platform;
    json['appVersion'] = appVersion;
    json['osVersion'] = osVersion;
    json['latLan'] = latLan;
    json['deviceId'] = deviceId;
    json['userAgent'] = userAgent;
    json['deviceName'] = deviceName ?? 'NA';
    return json;
  }

  @override
  List<Object?> get props => [timeStamp];
}

