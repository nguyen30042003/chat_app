import 'package:chat_project/models/group.dart'; // Đã có lớp Group

class PageMessage {
  List<Message>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  PageMessage({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  factory PageMessage.fromJson(Map<String, dynamic> json) {
    return PageMessage(
      content: (json['content'] as List<dynamic>?)
          ?.map((item) => Message.fromJson(item as Map<String, dynamic>))
          .toList(),
      pageable: json['pageable'] != null
          ? Pageable.fromJson(json['pageable'] as Map<String, dynamic>)
          : null,
      last: json['last'] as bool?,
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      sort: json['sort'] != null
          ? Sort.fromJson(json['sort'] as Map<String, dynamic>)
          : null,
      first: json['first'] as bool?,
      numberOfElements: json['numberOfElements'] as int?,
      empty: json['empty'] as bool?,
    );
  }

  @override
  String toString() {
    return 'PageMessage{content: $content, pageable: $pageable, last: $last, totalPages: $totalPages, totalElements: $totalElements, size: $size, number: $number, sort: $sort, first: $first, numberOfElements: $numberOfElements, empty: $empty}';
  }
}

class Message {
  int id;
  String creationDateTime;
  String userName;
  String message;
  GroupChat groupChat;

  Message({
    required this.id,
    required this.creationDateTime,
    required this.userName,
    required this.message,
    required this.groupChat,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      creationDateTime: json['creationDateTime'] as String,
      userName: json['userName'] as String,
      message: json['message'] as String,
      groupChat: GroupChat.fromJson(json['groupChat'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Message{id: $id, creationDateTime: $creationDateTime, userName: $userName, message: $message, groupChat: $groupChat}';
  }
}

class GroupChat {
  int id;
  String groupName;
  String timeCreate;

  GroupChat({
    required this.id,
    required this.groupName,
    required this.timeCreate,
  });

  factory GroupChat.fromJson(Map<String, dynamic> json) {
    return GroupChat(
      id: json['id'] as int,
      groupName: json['groupName'] as String,
      timeCreate: json['timeCreate'] as String,
    );
  }

  @override
  String toString() {
    return 'GroupChat{id: $id, groupName: $groupName, timeCreate: $timeCreate}';
  }
}
class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
      offset: json['offset'] as int,
      paged: json['paged'] as bool,
      unpaged: json['unpaged'] as bool,
    );
  }

  @override
  String toString() {
    return 'Pageable{pageNumber: $pageNumber, pageSize: $pageSize, sort: $sort, offset: $offset, paged: $paged, unpaged: $unpaged}';
  }
}

class Sort {
  bool empty;
  bool sorted;
  bool unsorted;

  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json['empty'] as bool,
      sorted: json['sorted'] as bool,
      unsorted: json['unsorted'] as bool,
    );
  }

  @override
  String toString() {
    return 'Sort{empty: $empty, sorted: $sorted, unsorted: $unsorted}';
  }
}