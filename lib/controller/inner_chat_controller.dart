import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:work_os/models/message_model.dart';
import 'package:path/path.dart';

class InnerChatController extends GetxController {
  late TextEditingController messageTextFormFiled;

  final FirebaseFirestore firebaseObject = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuthObject = FirebaseAuth.instance;

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecordering => _audioRecorder!.isRecording;

  Future _init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission is denied');
    }
    await _audioRecorder!.openRecorder();
    _isRecorderInitialised = true;
  }

  void _dispose() {
    if (!_isRecorderInitialised) return;
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future record() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.startRecorder(toFile: const Uuid().v4());
    update();
  }

  late File audioFile;
  late String recordUrl;
  bool isVoiceUploded = false;

  Future stop() async {
    if (!_isRecorderInitialised) return;

    final path = await _audioRecorder!.stopRecorder();
    isVoiceUploded = true;
    update();

    //Upload Audio
    audioFile = File(path.toString());

    String name = basename(audioFile.path);

    final Reference _storage =
        FirebaseStorage.instance.ref().child('recorders').child(name + '.mp3');
    await _storage.putFile(audioFile);
    recordUrl = await _storage.getDownloadURL();
    isVoiceUploded = false;
    update();
    log('================\nRecorder Name $name\n');
    log('(==================\n Recorder url $recordUrl\n');
  }

  void sendVoiceNote({required String sendTo}) async {
    await firebaseObject
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(sendTo)
        .collection('messages')
        .add(
          MessageModel(
            voiceLink: recordUrl,
            sendTo: sendTo,
            sendFrom: FirebaseAuth.instance.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toMap(),
        );
    await firebaseObject
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(sendTo)
        .set({
      'id': sendTo,
    });
    await firebaseObject
        .collection('chats')
        .doc(sendTo)
        .collection('chatWith')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(
          MessageModel(
            voiceLink: recordUrl,
            sendTo: sendTo,
            sendFrom: FirebaseAuth.instance.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toMap(),
        );
    await firebaseObject
        .collection('chats')
        .doc(sendTo)
        .collection('chatWith')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  void sendMessage({required String message, required String sendTo}) async {
    await firebaseObject
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(sendTo)
        .collection('messages')
        .add(
          MessageModel(
            messageContent: message,
            sendTo: sendTo,
            sendFrom: FirebaseAuth.instance.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toMap(),
        );
    await firebaseObject
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(sendTo)
        .set({
      'id': sendTo,
    });

    await firebaseObject
        .collection('chats')
        .doc(sendTo)
        .collection('chatWith')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(
          MessageModel(
            messageContent: message,
            sendTo: sendTo,
            sendFrom: FirebaseAuth.instance.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toMap(),
        );
    await firebaseObject
        .collection('chats')
        .doc(sendTo)
        .collection('chatWith')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': FirebaseAuth.instance.currentUser!.uid,
    });

    messageTextFormFiled.clear();
  }

  static late String userId;
  static void initData({required String id}) {
    userId = id;
  }

  bool isOnline = false;
  Future isUserOnline() async {
    var date = await firebaseObject.collection('users').doc(userId).get();
    isOnline = date.data()!['IsOnline'];
    update();
  }

  @override
  void onInit() {
    messageTextFormFiled = TextEditingController();
    isUserOnline();
    _init();
    super.onInit();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }
}
