import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/chain_page.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/helpers.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';

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
        backgroundColor: StyleConstants.primaryColor,
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

  bool _testnetOnly = false;

  SignClient? _web3App;

  SessionData? _activeSession;
  List<SessionData> _allSessions = [];
  List<PairingInfo> _allPairings = [];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    _web3App = await SignClient.createInstance(
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
    if (_allSessions.isNotEmpty) {
      _activeSession = _allSessions.first;
    }
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
    if (_initializing) {
      return const Center(
        child: CircularProgressIndicator(
          color: StyleConstants.primaryColor,
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          // color: StyleConstants.primaryColor,
          padding: const EdgeInsets.all(
            StyleConstants.linear8,
          ),
          constraints: const BoxConstraints(
            maxWidth: StyleConstants.maxWidth,
          ),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: StyleConstants.linear48,
              ),
              const Text(
                StringConstants.appTitle,
                style: StyleConstants.titleText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: StyleConstants.linear48,
              ),
              const Text(
                StringConstants.selectChains,
                style: StyleConstants.subtitleText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: StyleConstants.linear24,
              ),
              SizedBox(
                height: StyleConstants.linear48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConstants.testnetsOnly,
                      style: StyleConstants.buttonText,
                    ),
                    Switch(
                      value: _testnetOnly,
                      onChanged: (value) {
                        setState(() {
                          _testnetOnly = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              ChainPage(
                testnetOnly: _testnetOnly,
                onConnect: _onConnect,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onConnect(
    List<ChainMetadata> chains,
  ) async {
    // Use the chain metadata to build the required namespaces:
    // Get the methods, get the events
    final Map<String, RequiredNamespace> requiredNamespaces = {};
    for (final chain in chains) {
      requiredNamespaces[chain.chainId] = RequiredNamespace(
        methods: getChainMethods(chain.type),
        events: getChainEvents(chain.type),
      );
    }
    print(requiredNamespaces.keys);
    print(requiredNamespaces.values.first.toJson());

    // Send off a connect
    final ConnectResponse res = await _web3App!.connect(
      requiredNamespaces: requiredNamespaces,
    );
    // print(res.uri!.toString());
    await _showQrCode(res);
  }

  Future<void> _showQrCode(
    ConnectResponse response,
  ) async {
    print('got here');
    // Show the QR code
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            StringConstants.scanQrCode,
            style: StyleConstants.titleText,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 300,
            height: 350,
            child: Center(
              child: Column(
                children: [
                  QrImage(
                    data: response.uri!.toString(),
                  ),
                  const SizedBox(
                    height: StyleConstants.linear16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(
                          text: response.uri!.toString(),
                        ),
                      );
                    },
                    child: const Text(
                      'Copy URL to Clipboard',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
