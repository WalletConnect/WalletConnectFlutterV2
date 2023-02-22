import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Connect v2 Flutter dApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initializing = true;

  Web3App? _web3App;

  SessionData? _activeSession;
  List<SessionData> _allSessions = [];
  List<PairingInfo> _allPairings = [];

  ChainMetadata? _selectedChain;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    _web3App = await Web3App.createInstance(
      core: Core(
        projectId: Constants.projectId,
      ),
      metadata: const PairingMetadata(
        name: 'Example Dapp',
        description: 'Example Dapp',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );

    // Get the sessions and pairings, active session is just the first one
    _allSessions = _web3App!.sessions.getAll();
    _activeSession = _allSessions.first;
    _allPairings = _web3App!.pairings
        .getAll()
        .where(
          (e) => e.active,
        )
        .toList();

    setState(() {
      _initializing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        child: ListView(
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
