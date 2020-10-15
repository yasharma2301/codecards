class ContestsAPIModel {
  int id;
  int duration;
  String end;
  String event;
  String href;
  String icon;
  String name;
  String start;

  ContestsAPIModel(
      {this.id,
        this.duration,
        this.end,
        this.event,
        this.href,
        this.icon,
        this.name,
        this.start});

  ContestsAPIModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    end = json['end'];
    event = json['event'];
    href = json['href'];
    icon = json['icon'];
    name = json['name'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['end'] = this.end;
    data['event'] = this.event;
    data['href'] = this.href;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['start'] = this.start;
    return data;
  }
}
