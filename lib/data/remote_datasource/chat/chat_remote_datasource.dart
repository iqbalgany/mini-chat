import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_chat/data/models/message_model.dart';

class ChatRemoteDatasource {
  // get instance of firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    final currentEmail = _auth.currentUser?.email ?? 'Kosong';
    log('Email yang sedang login : $currentEmail');

    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final currentUserID = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email;
    final timestamp = Timestamp.now();

    // create new message
    MessageModel newMessage = MessageModel(
      senderID: currentUserEmail!,
      senderEmail: currentUserID,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
