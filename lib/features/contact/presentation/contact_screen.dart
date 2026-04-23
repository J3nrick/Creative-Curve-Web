import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/contact/application/contact_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _briefController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _briefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ContactFormState formState = ref.watch(contactFormControllerProvider);
    final ContactFormController controller = ref.read(contactFormControllerProvider.notifier);

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 30, 28, 12),
            child: Text('Contact', style: Theme.of(context).textTheme.displayMedium),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email.';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _briefController,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Project Brief'),
                    validator: (String? value) {
                      if (value == null || value.trim().length < 10) {
                        return 'Please provide at least 10 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: formState.status == ContactSubmissionStatus.sending
                        ? null
                        : () async {
                            final bool valid = _formKey.currentState?.validate() ?? false;
                            if (!valid) {
                              return;
                            }

                            await controller.submit(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              details: _briefController.text.trim(),
                            );
                          },
                    child: Text(
                      formState.status == ContactSubmissionStatus.sending
                          ? 'Sending...'
                          : 'Send Message',
                    ),
                  ),
                  if (formState.status == ContactSubmissionStatus.success && formState.message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        formState.message!,
                        style: const TextStyle(color: AppColors.electricBlue),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
