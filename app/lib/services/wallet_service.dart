import 'package:flutter/foundation.dart';

class WalletService extends ChangeNotifier {
  // Stellar account management and transaction signing.
  // Full implementation in subsequent commits.

  Future<String> getBalance(String publicKey) async {
    throw UnimplementedError();
  }

  Future<void> sendPayment({
    required String destination,
    required String amount,
    String asset = 'native',
  }) async {
    throw UnimplementedError();
  }
}