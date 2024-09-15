import 'group.dart';

class Relationship {
  int? id;
  String? name;
  Group? groupChat;

  Relationship({
    this.id,
    this.name,
    this.groupChat,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      id: json['id'] as int?,
      name: json['name'] as String?,
      groupChat: json['groupChat'] != null ? Group.fromJson(json['groupChat']) : null,
    );
  }

  @override
  String toString() {
    return 'Relationship{id: $id, name: $name, groupChat: $groupChat}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'groupChat': groupChat?.toJson(),
    };
  }
}


