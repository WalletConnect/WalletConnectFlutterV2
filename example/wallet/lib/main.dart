import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/models/page_data.dart';
import 'package:walletconnect_flutter_v2_wallet/pages/apps_page.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';

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
        scaffoldBackgroundColor: StyleConstants.backgroundColor,
        bottomAppBarColor: StyleConstants.backgroundColor,
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: StyleConstants.backgroundColor,
          unselectedLabelTextStyle: StyleConstants.bodyLightGray,
          unselectedIconTheme: IconThemeData(
            color: StyleConstants.lightGray,
          ),
        ),
        canvasColor: StyleConstants.backgroundColor,
        backgroundColor: StyleConstants.backgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget with GetItStatefulWidgetMixin {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with GetItStateMixin {
  bool _initializing = true;

  Web3Wallet? _web3Wallet;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  // SessionData? _selectedSession;
  // List<SessionData> _allSessions = [];
  // List<PairingInfo> _allPairings = [];

  @override
  void initState() {
    initialize();

    // _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);

    super.initState();
  }

  @override
  void dispose() {
    // _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);

    super.dispose();
  }

  Future<void> initialize() async {
    // try {
    _web3Wallet = await Web3Wallet.createInstance(
      projectId: Constants.projectId,
      metadata: const PairingMetadata(
        name: 'Example Wallet',
        description: 'Example Wallet',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );

    setState(() {
      _pageDatas = [
        PageData(
          page: AppsPage(web3Wallet: _web3Wallet!),
          title: StringConstants.connectPageTitle,
          icon: Icons.home,
        ),
        PageData(
          page: const Center(
            child: Text(
              'Notifications (Not Implemented)',
              style: StyleConstants.bodyText,
            ),
          ),
          title: StringConstants.pairingsPageTitle,
          icon: Icons.notifications,
        ),
        // PageData(
        //   page: SessionsPage(web3App: _web3App!),
        //   title: StringConstants.sessionsPageTitle,
        //   icon: Icons.confirmation_number_outlined,
        // ),
        // PageData(
        //   page: AuthPage(web3App: _web3App!),
        //   title: StringConstants.authPageTitle,
        //   icon: Icons.lock,
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
      appBar: AppBar(
        title: Text(_pageDatas[_selectedIndex].title),
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
      // backgroundColor: StyleConstants.backgroundColor,
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
