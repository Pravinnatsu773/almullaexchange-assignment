import 'package:al_mullah_asignment/features/dashboard/cubit/encryption_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EncryptionPage extends StatefulWidget {
  const EncryptionPage({super.key});

  @override
  State<EncryptionPage> createState() => _EncryptionPageState();
}

class _EncryptionPageState extends State<EncryptionPage> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  final _encryptionCubit = EncryptionCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField 1: Enter normal text or encrypted text
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Enter Text',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),

          TextField(
            controller: keyController,
            decoration: const InputDecoration(
              labelText: 'Enter Secret Key',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),

          // Encrypt Button
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final text = textController.text;
                    final key = keyController.text;
                    if (text.isNotEmpty && key.isNotEmpty) {
                      _encryptionCubit.encryptText(text, key);
                    }
                  },
                  child: const Text('Encrypt'),
                ),
              ),
              const SizedBox(width: 8),

              // Decrypt Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final text = textController.text;
                    final key = keyController.text;
                    if (text.isNotEmpty && key.isNotEmpty) {
                      _encryptionCubit.decryptText(text, key);
                    }
                  },
                  child: const Text('Decrypt'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Text(
            "Encrypted/Decrypted String",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Label showing the encrypted or decrypted string (copyable on long press)
          BlocBuilder<EncryptionCubit, EncryptionState>(
            bloc: _encryptionCubit,
            builder: (context, state) {
              return GestureDetector(
                onLongPress: () {
                  // Copy the result to clipboard when long pressed
                  Clipboard.setData(ClipboardData(text: state.result));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard!')),
                  );
                },
                child: SelectableText(
                  state.result,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
