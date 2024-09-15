class Connection {
  String? IPv4;
  int? port;

  Connection({
    this.IPv4,
    this.port
  });

  Connection.fromJson(Map<String, dynamic> json) {
    IPv4 = json['IPv4'] as String;
    port = json['port'] as int;
  }


  Map<String, dynamic> toJson() {
    return {
      'IPv4': IPv4,
      'port': port,
    };
  }
}
