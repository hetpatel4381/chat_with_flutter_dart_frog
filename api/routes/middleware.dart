import 'package:api/src/repositories/message_repositories.dart';
import 'package:dart_frog/dart_frog.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<MessageRepository>((_) => messageRepository),
      );
}
