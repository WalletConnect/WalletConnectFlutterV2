enum KadenaMethods {
  kadenaSign,
  kadenaQuicksign,
}

enum KadenaEvents {
  none,
}

class KadenaData {
  static final Map<KadenaMethods, String> methods = {
    KadenaMethods.kadenaSign: 'kadena_sign',
    KadenaMethods.kadenaQuicksign: 'kadena_quicksign'
  };

  static final Map<KadenaEvents, String> events = {};
}
