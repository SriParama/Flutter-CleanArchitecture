import 'dart:convert';

DashboardEntity dashboardEntityFromJson(String str) =>
    DashboardEntity.fromJson(json.decode(str));

String dashboardEntityToJson(DashboardEntity data) =>
    json.encode(data.toJson());

class DashboardEntity {
  dynamic webDashboard;
  dynamic appDashBoard;
  dynamic routerArr;
  List<SegmentArr>? segmentArr;
  String? status;
  String? errMsg;

  DashboardEntity({
    this.webDashboard,
    this.appDashBoard,
    this.routerArr,
    this.segmentArr,
    this.status,
    this.errMsg,
  });

  factory DashboardEntity.fromJson(Map<String, dynamic> json) =>
      DashboardEntity(
        webDashboard: json["webDashboard"],
        appDashBoard: json["appDashBoard"],
        routerArr: json["routerArr"],
        segmentArr: json["segmentArr"] == null
            ? []
            : List<SegmentArr>.from(
                json["segmentArr"]!.map((x) => SegmentArr.fromJson(x))),
        status: json["status"],
        errMsg: json["errMsg"],
      );

  Map<String, dynamic> toJson() => {
        "webDashboard": webDashboard,
        "appDashBoard": appDashBoard,
        "routerArr": routerArr,
        "segmentArr": segmentArr == null
            ? []
            : List<dynamic>.from(segmentArr!.map((x) => x.toJson())),
        "status": status,
        "errMsg": errMsg,
      };
}

class SegmentArr {
  int? id;
  String? name;
  String? fullname;
  String? path;
  int? taskId;
  String? image;
  String? color;
  String? status;
  String? source;
  String? darkThemeImage;

  SegmentArr({
    this.id,
    this.name,
    this.fullname,
    this.path,
    this.taskId,
    this.image,
    this.color,
    this.status,
    this.source,
    this.darkThemeImage,
  });

  factory SegmentArr.fromJson(Map<String, dynamic> json) => SegmentArr(
        id: json["id"],
        name: json["name"],
        fullname: json["fullname"],
        path: json["path"],
        taskId: json["taskId"],
        image: json["image"],
        color: json["color"],
        status: json["status"],
        source: json["source"],
        darkThemeImage: json["darkThemeImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fullname": fullname,
        "path": path,
        "taskId": taskId,
        "image": image,
        "color": color,
        "status": status,
        "source": source,
        "darkThemeImage": darkThemeImage,
      };
}
