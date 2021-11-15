class ErrorModel {
  bool? isCustomMessage;
  String? message;

  ErrorModel({this.isCustomMessage, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        isCustomMessage: json['isCustomMessage'] as bool?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'isCustomMessage': isCustomMessage,
        'message': message,
      };
}
