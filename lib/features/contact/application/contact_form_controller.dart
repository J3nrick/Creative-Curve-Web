import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_form_controller.g.dart';

enum ContactSubmissionStatus {
  idle,
  sending,
  success,
}

class ContactFormState {
  const ContactFormState({
    this.status = ContactSubmissionStatus.idle,
    this.message,
  });

  final ContactSubmissionStatus status;
  final String? message;

  ContactFormState copyWith({
    ContactSubmissionStatus? status,
    String? message,
  }) {
    return ContactFormState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

@riverpod
class ContactFormController extends _$ContactFormController {
  @override
  ContactFormState build() {
    return const ContactFormState();
  }

  Future<void> submit({
    required String name,
    required String email,
    required String details,
  }) async {
    state = const ContactFormState(status: ContactSubmissionStatus.sending);

    await Future<void>.delayed(const Duration(milliseconds: 1100));

    state = ContactFormState(
      status: ContactSubmissionStatus.success,
      message: 'Thanks $name, we will reach out at $email soon. Project brief received.',
    );
  }

  void reset() {
    state = const ContactFormState();
  }
}
