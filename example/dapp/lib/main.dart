import 'package:dapp/models/chain_metadata.dart';
import 'package:dapp/utils/constants.dart';
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
      title: 'Wallet Connect Demo',
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
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
        ],
      ),
    );
  }
}
