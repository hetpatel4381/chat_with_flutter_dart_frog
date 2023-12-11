import 'dart:async';
import 'dart:html';

import 'package:api/src/repositories/message_repositories.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String chatRoomId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, chatRoomId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  // return Response(body: 'Welcome to Dart Frog!');
}

FutureOr<Response> _get(RequestContext context, String chatRoomId) {
  //Use the message repository.  like - api/repositories/message.dart.
  final messageRepository = context.read<MessageRepository>();

  try {
    //create a list of messages and return them inside the response.
    final messages = messageRepository.fetchMessage(chatRoomId);
    return Response.json(
      body: {'messages': messages},
    );
  } catch (err) {
    return Response.json(
      body: {'error': err.toString()},
      statusCode: HttpStatus.internalServerError,
    );
  }
  // return Response(body: "Welcome to Dart Frog");
}
