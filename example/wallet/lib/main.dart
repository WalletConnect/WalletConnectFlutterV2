import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/i_chain.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/kadena_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/page_data.dart';
import 'package:walletconnect_flutter_v2_wallet/pages/apps_page.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      theme: _buildDarkTheme(),
      home: MyHomePage(),
    );
  }

  ThemeData _buildDarkTheme() {
    final baseTheme = ThemeData.dark();
    final nearWhite = const Color(0xFFE0E0E0);

    return baseTheme.copyWith(
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: baseTheme.textTheme.apply(
        bodyColor: nearWhite,
        displayColor: nearWhite,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: nearWhite.withOpacity(0.5)),
        labelStyle: TextStyle(color: nearWhite),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: nearWhite.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: nearWhite),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: nearWhite),
        contentTextStyle: TextStyle(color: nearWhite),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline6: TextStyle(color: nearWhite),
        ),
        iconTheme: IconThemeData(color: nearWhite),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: nearWhite,
        unselectedItemColor: nearWhite.withOpacity(0.5),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.black,
        selectedIconTheme: IconThemeData(color: nearWhite),
        unselectedIconTheme: IconThemeData(color: nearWhite.withOpacity(0.5)),
        selectedLabelTextStyle: TextStyle(color: nearWhite),
        unselectedLabelTextStyle: TextStyle(color: nearWhite.withOpacity(0.5)),
      ),
      cardColor: Color(0xFF1A1A1A),
      cardTheme: CardTheme(
        color: Color(0xFF1A1A1A),
      ),
      dividerColor: nearWhite.withOpacity(0.2),
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
    GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService(context));
    GetIt.I.registerSingleton<IKeyService>(KeyService());

    final IWeb3WalletService web3WalletService = Web3WalletService();
    web3WalletService.create();
    GetIt.I.registerSingleton<IWeb3WalletService>(web3WalletService);

    for (final cId in KadenaChainId.values) {
      GetIt.I.registerSingleton<IChain>(
        KadenaService(chainId: cId),
        instanceName: cId.chain,
      );
    }

    await web3WalletService.init();

    setState(() {
      _pageDatas = [
        PageData(
          page: const AppsPage(),
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
    GetIt.I<IBottomSheetService>().setDefaultContext(context);

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
