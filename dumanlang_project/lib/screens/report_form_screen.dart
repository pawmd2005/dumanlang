import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _status = 'form';

  Future<void> _submitReport() async {
    if (_status == 'loading') return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _status = 'loading');

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final description = _descriptionController.text.toLowerCase();

    if (description.contains('empty')) {
      setState(() => _status = 'empty');
    } else if (description.contains('error')) {
      setState(() => _status = 'error');
    } else {
      setState(() => _status = 'success');
    }
  }

  void _showForm() {
    setState(() => _status = 'form');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Form')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _status == 'loading'
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Submitting your report. Please wait...'),
                  ],
                ),
              )
            : _status == 'success'
                ? _responseView(
                    icon: Icons.check_circle,
                    message: 'Your report was submitted successfully!',
                    buttonText: 'Submit Another Report',
                    onPressed: () {
                      _nameController.clear();
                      _descriptionController.clear();
                      _showForm();
                    },
                  )
                : _status == 'empty'
                    ? _responseView(
                        icon: Icons.inbox,
                        message: 'No report results were found.',
                        buttonText: 'Try Another Report',
                        onPressed: _showForm,
                      )
                    : _status == 'error'
                        ? _responseView(
                            icon: Icons.error,
                            message:
                                'Something went wrong while submitting your report.',
                            buttonText: 'Back to Form',
                            onPressed: _showForm,
                          )
                        : Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                const Text(
                                  'Submit a Report',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                  label: 'Full Name',
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                      return 'Please enter your name.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  label: 'Report Description',
                                  controller: _descriptionController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                      return 'Please enter a description.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppButton(
                                  text: 'Submit Report',
                                  onPressed: _status == 'loading'
                                      ? null
                                      : _submitReport,
                                ),
                              ],
                            ),
                          ),
      ),
    );
  }

  Widget _responseView({
    required IconData icon,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppButton(
            text: buttonText,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}