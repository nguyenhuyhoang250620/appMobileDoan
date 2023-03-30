import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/chat_group/chat_controller.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController()); 
   }

}