class DartDefines {
  static const String projectId = String.fromEnvironment(
    'PROJECT_ID',
  );
  //
  static const eip155PrivateKey = String.fromEnvironment(
    'EIP155_PRIVATE_KEY',
    defaultValue:
        '5754463bdfbd6e081ca1d6df965927feb1066a0df86d010ac4125eb4bc4c0082',
  );
  static const eip155Address = String.fromEnvironment(
    'EIP155_ADDRESS',
    defaultValue: '0xf3c95b1a8cabf3d5151912377aeadd84aa41c27c',
  );
  //
  static const kadenaSecretKey = String.fromEnvironment(
    'KADENA_SECRET_KEY',
    defaultValue:
        '6576379e67666438c8a8e637b101d343153fed0f96c1cfa07aa45e4ccb8e5a4f',
  );
  static const kadenaAddress = String.fromEnvironment(
    'KADENA_ADDRESS',
    defaultValue:
        '3a527a1af7713cde04a4ce8b6c95b3806b7582f2423d740fc16eaa5b7a235d42',
  );
  //
  static const solanaSecretKey = String.fromEnvironment(
    'SOLANA_SECRET_KEY',
    defaultValue:
        '131,20,187,127,47,75,38,64,75,207,232,11,76,181,166,166,222,165,180,209,240,41,18,94,141,56,106,154,178,179,142,70,202,6,166,179,56,40,83,93,128,50,92,94,242,45,153,178,30,4,157,189,157,159,152,246,221,138,106,213,155,193,247,233',
  );
  static const solanaAddress = String.fromEnvironment(
    'SOLANA_ADDRESS',
    defaultValue: 'EbdEmCpKGvEwfwV4ACmVYHFRkwvXdogJhMZeEekDFVVJ',
  );
  //
  static const polkadotMnemonic = String.fromEnvironment(
    'POLKADOT_MNEMONIC',
    defaultValue:
        'shove trumpet draw priority either tonight million worry dust vivid twelve solid',
  );
  static const polkadotAddress = String.fromEnvironment(
    'POLKADOT_ADDRESS',
    defaultValue: '7UUBfttjb1P1m4KSCxC5UTS8xui6EszQsaJNQ6qztLLnNTz',
  );
}
