class Group {
  int? id;
  String? groupName;
  DateTime? timeCreate;

  Group({
    this.id,
    this.groupName,
    this.timeCreate,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int?,
      groupName: json['groupName'] as String?,
      timeCreate: json['timeCreate'] != null ? DateTime.parse(json['timeCreate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'timeCreate': timeCreate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Group{id: $id, groupName: $groupName, timeCreate: $timeCreate}';
  }
}