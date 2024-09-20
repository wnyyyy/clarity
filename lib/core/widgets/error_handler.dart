import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorHandler({this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Oops! Algo deu errado aqui...",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (message != null) Text(message!),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Tentar novamente'),
            ),
        ],
      ),
    );
  }
}
