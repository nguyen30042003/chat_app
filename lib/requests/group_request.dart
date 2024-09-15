class GroupRequest{
  String groupName;
  GroupRequest({required this.groupName});
  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
    };
  }
}