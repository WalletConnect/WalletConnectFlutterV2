import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/page_data.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/connect_page.dart';
import 'package:walletconnect_flutter_v2_dapp/pages/pairings_page.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:flutter/material.dart';
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
      title: StringConstants.appTitle,
      theme: ThemeData(
        backgroundColor: StyleConstants.primaryColor,
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

  // SessionData? _selectedSession;
  // List<SessionData> _allSessions = [];
  // List<PairingInfo> _allPairings = [];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    // try {
    print(Constants.projectId);
    _web3App = await Web3App.createInstance(
      projectId: Constants.projectId,
      metadata: const PairingMetadata(
        name: 'Example Dapp',
        description: 'Example Dapp',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );

    // Get the sessions and pairings, active session is just the first one
    // _allSessions = _web3App!.sessions.getAll();
    // if (_allSessions.isNotEmpty) {
    //   _activeSession = _allSessions.first;
    // }
    // _allPairings = _web3App!.pairings
    //     .getAll()
    //     .where(
    //       (e) => e.active,
    //     )
    //     .toList();

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
          icon: Icons.connect_without_contact_sharp,
        ),
        // PageData(
        //   page: const Text('Settings'),
        //   title: StringConstants.connectPageTitle,
        //   icon: Icons.settings,
        // ),
      ];

      _initializing = false;
    });
    // } on WalletConnectError catch (e) {
    //   print(e.message);
    // }
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
}
