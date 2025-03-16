class CanisterConfig {
  static const String _localHost = 'http://127.0.0.1:4943';
  static const String _localCanisterId = 'bkyz2-fmaaa-aaaaa-qaaaq-cai';

  static String get host {
    return _localHost;
  }

  static String get canisterId {
    return _localCanisterId;
  }
}
