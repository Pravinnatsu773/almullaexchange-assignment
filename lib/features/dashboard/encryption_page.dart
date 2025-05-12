import 'package:al_mullah_asignment/common/common_button.dart';
import 'package:al_mullah_asignment/constants/strings.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/encryption_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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
      padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: AppStrings.message.tr(),
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: AppStrings.secretKey.tr(),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: AppStrings.encrypt.tr(),
                    onTap: () {
                      final text = textController.text;
                      final key = keyController.text;
                      if (text.isNotEmpty && key.isNotEmpty) {
                        _encryptionCubit.encryptText(text, key);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CommonButton(
                    text: AppStrings.decrypt.tr(),
                    onTap: () {
                      final text = textController.text;
                      final key = keyController.text;
                      if (text.isNotEmpty && key.isNotEmpty) {
                        _encryptionCubit.decryptText(text, key);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Text(
              AppStrings.encryptedDecryptedMessage.tr(),
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
      ),
    );
  }
}
