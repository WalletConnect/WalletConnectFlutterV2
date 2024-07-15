import 'dart:convert';
import 'dart:developer';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/models/page_data.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/auth_page.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/connect_page.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/pairings_page.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/sessions_page.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/helpers.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/dart_defines.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/event_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initializing = true;

  Web3App? _web3App;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    _web3App = Web3App(
      core: Core(
        projectId: DartDefines.projectId,
      ),
      metadata: const PairingMetadata(
        name: 'Sample dApp Flutter',
        description: 'WalletConnect\'s sample dapp with Flutter',
        url: 'https://walletconnect.com/',
        icons: [
          'https://images.prismic.io/wallet-connect/65785a56531ac2845a260732_WalletConnect-App-Logo-1024X1024.png'
        ],
        redirect: Redirect(
          native: 'wcflutterdapp://',
          universal: 'https://walletconnect.com',
        ),
      ),
    );

    _web3App!.core.addLogListener(_logListener);

    // Register event handlers
    _web3App!.core.relayClient.onRelayClientError.subscribe(
      _relayClientError,
    );
    _web3App!.core.relayClient.onRelayClientConnect.subscribe(_setState);
    _web3App!.core.relayClient.onRelayClientDisconnect.subscribe(_setState);
    _web3App!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayMessage,
    );

    _web3App!.onSessionPing.subscribe(_onSessionPing);
    _web3App!.onSessionEvent.subscribe(_onSessionEvent);
    _web3App!.onSessionUpdate.subscribe(_onSessionUpdate);
    _web3App!.onSessionConnect.subscribe(_onSessionConnect);
    _web3App!.onSessionAuthResponse.subscribe(_onSessionAuthResponse);

    await _web3App!.init();

    // Loop through all the chain data
    for (final ChainMetadata chain in ChainData.allChains) {
      // Loop through the events for that chain
      for (final event in getChainEvents(chain.type)) {
        _web3App!.registerEventHandler(
          chainId: chain.chainId,
          event: event,
        );
      }
    }

    setState(() {
      _pageDatas = [
        PageData(
          page: ConnectPage(web3App: _web3App!),
          title: StringConstants.connectPageTitle,
          icon: Icons.home,
        ),
        PageData(
          page: PairingsPage(web3App: _web3App!),
          title: StringConstants.pairingsPageTitle,
          icon: Icons.vertical_align_center_rounded,
        ),
        PageData(
          page: SessionsPage(web3App: _web3App!),
          title: StringConstants.sessionsPageTitle,
          icon: Icons.workspaces_filled,
        ),
        PageData(
          page: AuthPage(web3App: _web3App!),
          title: StringConstants.authPageTitle,
          icon: Icons.lock,
        ),
      ];

      _initializing = false;
    });
  }

  void _onSessionConnect(SessionConnect? event) {
    log('[SampleDapp] _onSessionConnect $event');
  }

  void _onSessionAuthResponse(SessionAuthResponse? response) {
    log('[SampleDapp] _onSessionAuthResponse $response');
  }

  void _setState(dynamic args) => setState(() {});

  void _relayClientError(ErrorEvent? event) {
    debugPrint('[SampleDapp] _relayClientError ${event?.error}');
    _setState('');
  }

  @override
  void dispose() {
    // Unregister event handlers
    _web3App!.core.removeLogListener(_logListener);

    _web3App!.core.relayClient.onRelayClientError.unsubscribe(
      _relayClientError,
    );
    _web3App!.core.relayClient.onRelayClientConnect.unsubscribe(_setState);
    _web3App!.core.relayClient.onRelayClientDisconnect.unsubscribe(_setState);
    _web3App!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayMessage,
    );

    _web3App!.onSessionPing.unsubscribe(_onSessionPing);
    _web3App!.onSessionEvent.unsubscribe(_onSessionEvent);
    _web3App!.onSessionUpdate.unsubscribe(_onSessionUpdate);
    _web3App!.onSessionConnect.subscribe(_onSessionConnect);
    _web3App!.onSessionAuthResponse.subscribe(_onSessionAuthResponse);

    super.dispose();
  }

  void _logListener(LogEvent event) {
    if (event.level == Level.debug) {
      // TODO send to mixpanel
      log('[Mixpanel] ${event.message}');
    } else {
      debugPrint('[Logger] ${event.level.name}: ${event.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Center(
        child: CircularProgressIndicator(
          color: StyleConstants.primaryColor,
        ),
      );
    }

    final List<Widget> navRail = [];
    if (MediaQuery.of(context).size.width >= Constants.smallScreen) {
      navRail.add(_buildNavigationRail());
    }
    navRail.add(
      Expanded(
        child: _pageDatas[_selectedIndex].page,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 6.0,
            backgroundColor: _web3App!.core.relayClient.isConnected
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      bottomNavigationBar:
          MediaQuery.of(context).size.width < Constants.smallScreen
              ? _buildBottomNavBar()
              : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: navRail,
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.indigoAccent,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      // called when one tab is selected
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      // bottom tab items
      items: _pageDatas
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.title,
            ),
          )
          .toList(),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.selected,
      destinations: _pageDatas
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.title),
            ),
          )
          .toList(),
    );
  }

  void _onSessionPing(SessionPing? args) {
    debugPrint('[SampleDapp] _onSessionPing $args');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventWidget(
          title: StringConstants.receivedPing,
          content: 'Topic: ${args!.topic}',
        );
      },
    );
  }

  void _onSessionEvent(SessionEvent? args) {
    debugPrint('[SampleDapp] _onSessionEvent $args');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventWidget(
          title: StringConstants.receivedEvent,
          content:
              'Topic: ${args!.topic}\nEvent Name: ${args.name}\nEvent Data: ${args.data}',
        );
      },
    );
  }

  void _onSessionUpdate(SessionUpdate? args) {
    debugPrint('[SampleDapp] _onSessionUpdate $args');
  }

  void _onRelayMessage(MessageEvent? args) async {
    if (args != null) {
      try {
        final payloadString = await _web3App!.core.crypto.decode(
          args.topic,
          args.message,
        );
        final data = jsonDecode(payloadString ?? '{}') as Map<String, dynamic>;
        debugPrint('[SampleDapp] _onRelayMessage data $data');
      } catch (e) {
        debugPrint('[SampleDapp] _onRelayMessage error $e');
      }
    }
  }
}
