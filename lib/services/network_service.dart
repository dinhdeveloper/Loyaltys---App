import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:remindbless/main.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isConnected = true;

  void start(BuildContext context) {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final hasConnection =
          results.contains(ConnectivityResult.mobile) ||
              results.contains(ConnectivityResult.wifi);

      if (hasConnection != _isConnected) {
        _isConnected = hasConnection;

        showNetworkSnackBar(
          isConnected: hasConnection,
        );
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}

void showNetworkSnackBar({
  required bool isConnected,
}) {

  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black45,
      elevation: 0,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Row(
        children: [
          Icon(
            isConnected ? Icons.wifi : Icons.wifi_off,
            color: isConnected ? Colors.greenAccent : Colors.redAccent,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isConnected
                  ? 'Đã kết nối thành công'
                  : 'Mất kết nối internet',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
