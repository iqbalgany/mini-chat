// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  MessageModel copyWith({
    String? senderID,
    String? senderEmail,
    String? receiverID,
    String? message,
    Timestamp? timestamp,
  }) {
    return MessageModel(
      senderID: senderID ?? this.senderID,
      senderEmail: senderEmail ?? this.senderEmail,
      receiverID: receiverID ?? this.receiverID,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
