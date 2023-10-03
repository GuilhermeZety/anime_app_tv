// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestResult extends Equatable {
  final int statusCode;
  final dynamic data;
  final Map<String, dynamic> headers;
  final bool success;
  final String message;

  const RequestResult({
    required this.statusCode,
    required this.data,
    required this.headers,
    required this.success,
    required this.message,
  });

  RequestResult copyWith({
    int? statusCode,
    dynamic data,
    Map<String, dynamic>? headers,
    bool? success,
    String? message,
  }) {
    return RequestResult(
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      headers: headers ?? this.headers,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'data': data,
      'headers': headers,
      'success': success,
      'message': message,
    };
  }

  factory RequestResult.fromMap(Map<String, dynamic> map) {
    return RequestResult(
      statusCode: map['statusCode'] as int? ?? 0,
      data: map['data'] as dynamic,
      headers: map['headers'] as Map<String, dynamic>? ?? {},
      success: map['success'] as bool? ?? false,
      message: map['message'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestResult.fromJson(String source) => RequestResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      statusCode,
      data,
      headers,
      success,
      message,
    ];
  }
}
