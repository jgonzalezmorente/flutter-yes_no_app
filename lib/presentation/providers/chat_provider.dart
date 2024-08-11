import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollControler = ScrollController();
  final GetYesNoAnswer  getYesNoAnswer = GetYesNoAnswer();


  List<Message> messageList = [
    // Message(text: 'Ya regresaste del trabajo??', fromWho: FromWho.me),
    // Message(text: 'Hola amor!', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    //messageList.add(newMessage);
    messageList.insert(0, newMessage);
    if (text.endsWith('?')) {
      herReplay();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.insert(0, herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollControler.animateTo(
      0,//chatScrollControler.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeOut
    );
  }
}