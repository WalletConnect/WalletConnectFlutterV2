import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/session_item.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/session_widget.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({
    super.key,
    required this.web3App,
  });

  final Web3App web3App;

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage> {
  Map<String, SessionData> _activeSessions = {};
  String _selectedSession = '';

  @override
  void initState() {
    _activeSessions = widget.web3App.getActiveSessions();
    widget.web3App.onSessionDelete.subscribe(_onSessionDelete);
    widget.web3App.onSessionExpire.subscribe(_onSessionExpire);
    super.initState();
  }

  @override
  void dispose() {
    widget.web3App.onSessionDelete.unsubscribe(_onSessionDelete);
    widget.web3App.onSessionExpire.unsubscribe(_onSessionExpire);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<SessionData> sessions = _activeSessions.values.toList();

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 200,
            minWidth: 150,
          ),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: StyleConstants.grayColor,
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            top: StyleConstants.linear8,
            bottom: StyleConstants.linear8,
          ),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return SessionItem(
                key: ValueKey(sessions[index].topic),
                session: sessions[index],
                onTap: () {
                  setState(() {
                    _selectedSession = sessions[index].topic;
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: sessions.length,
          ),
        ),
        Expanded(
          child: Container(
            // color: StyleConstants.primaryColor,
            padding: const EdgeInsets.all(
              StyleConstants.linear8,
            ),
            child: _buildSessionView(),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionView() {
    if (_selectedSession == '') {
      return const Center(
        child: Text(
          StringConstants.noSessionSelected,
          style: StyleConstants.titleText,
        ),
      );
    }

    final SessionData session = _activeSessions[_selectedSession]!;

    return SessionWidget(
      web3App: widget.web3App,
      session: session,
    );
  }

  void _onSessionDelete(SessionDelete? event) {
    setState(() {
      if (event!.topic == _selectedSession) {
        _selectedSession = '';
      }
      _activeSessions = widget.web3App.getActiveSessions();
    });
  }

  void _onSessionExpire(SessionExpire? event) {
    setState(() {
      if (event!.topic == _selectedSession) {
        _selectedSession = '';
      }
      _activeSessions = widget.web3App.getActiveSessions();
    });
  }
}
