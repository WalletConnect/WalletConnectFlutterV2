import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

class SessionProposalEvent extends EventArgs {
  int id;
  ProposalData params;
  VerifyContext? verifyContext;

  SessionProposalEvent(
    this.id,
    this.params, [
    this.verifyContext,
  ]);

  Map<String, dynamic> toJson() => {
        'id': id,
        'params': params.toJson(),
        'verifyContext': verifyContext?.toJson(),
      };

  @override
  String toString() {
    return 'SessionProposalEvent(${jsonEncode(toJson())})';
  }
}

class SessionProposalErrorEvent extends EventArgs {
  int id;
  Map<String, RequiredNamespace> requiredNamespaces;
  Map<String, Namespace> namespaces;
  WalletConnectError error;

  SessionProposalErrorEvent(
    this.id,
    this.requiredNamespaces,
    this.namespaces,
    this.error,
  );

  @override
  String toString() {
    return 'SessionProposalErrorEvent(id: $id, requiredNamespaces: $requiredNamespaces, namespaces: $namespaces, error: $error)';
  }
}

class SessionConnect extends EventArgs {
  SessionData session;

  SessionConnect(
    this.session,
  );

  @override
  String toString() {
    return 'SessionConnect(session: $session)';
  }
}

class SessionUpdate extends EventArgs {
  int id;
  String topic;
  Map<String, Namespace> namespaces;

  SessionUpdate(
    this.id,
    this.topic,
    this.namespaces,
  );

  @override
  String toString() {
    return 'SessionUpdate(id: $id, topic: $topic, namespaces: $namespaces)';
  }
}

class SessionExtend extends EventArgs {
  int id;
  String topic;

  SessionExtend(this.id, this.topic);

  @override
  String toString() {
    return 'SessionExtend(id: $id, topic: $topic)';
  }
}

class SessionPing extends EventArgs {
  int id;
  String topic;

  SessionPing(this.id, this.topic);

  @override
  String toString() {
    return 'SessionPing(id: $id, topic: $topic)';
  }
}

class SessionDelete extends EventArgs {
  String topic;
  int? id;

  SessionDelete(
    this.topic, {
    this.id,
  });

  @override
  String toString() {
    return 'SessionDelete(topic: $topic, id: $id)';
  }
}

class SessionExpire extends EventArgs {
  final String topic;

  SessionExpire(this.topic);

  @override
  String toString() {
    return 'SessionExpire(topic: $topic)';
  }
}

class SessionRequestEvent extends EventArgs {
  int id;
  String topic;
  String method;
  String chainId;
  dynamic params;

  SessionRequestEvent(
    this.id,
    this.topic,
    this.method,
    this.chainId,
    this.params,
  );

  factory SessionRequestEvent.fromSessionRequest(
    SessionRequest request,
  ) {
    return SessionRequestEvent(
      request.id,
      request.topic,
      request.method,
      request.chainId,
      request.params,
    );
  }

  @override
  String toString() {
    return 'SessionRequestEvent(id: $id, topic: $topic, method: $method, chainId: $chainId, params: $params)';
  }
}

class SessionEvent extends EventArgs {
  int id;
  String topic;
  String name;
  String chainId;
  dynamic data;

  SessionEvent(
    this.id,
    this.topic,
    this.name,
    this.chainId,
    this.data,
  );

  @override
  String toString() {
    return 'SessionEvent(id: $id, topic: $topic, name: $name, chainId: $chainId, data: $data)';
  }
}

class ProposalExpire extends EventArgs {
  final int id;

  ProposalExpire(this.id);

  @override
  String toString() {
    return 'ProposalExpire(id: $id)';
  }
}
