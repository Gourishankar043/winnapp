import 'package:flutter/material.dart';

import '../../core/components/buttons/primary_button.dart';
import '../../core/components/inputs/app_date_field.dart';
import '../../core/components/inputs/app_text_field.dart';
import '../../core/theme/app_spacing.dart';

class VisitForm extends StatefulWidget {
  final String submitLabel;
  final String? initialSiteName;
  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialNotes;
  final bool isLoading;
  final ValueChanged<VisitFormData> onSubmit;

  const VisitForm({
    super.key,
    required this.submitLabel,
    required this.onSubmit,
    this.initialSiteName,
    this.initialDate,
    this.initialLocation,
    this.initialNotes,
    this.isLoading = false,
  });

  @override
  State<VisitForm> createState() => _VisitFormState();
}

class _VisitFormState extends State<VisitForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _siteNameController;
  late final TextEditingController _dateController;
  late final TextEditingController _locationController;
  late final TextEditingController _notesController;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _siteNameController = TextEditingController(
      text: widget.initialSiteName ?? '',
    );

    _locationController = TextEditingController(
      text: widget.initialLocation ?? '',
    );

    _notesController = TextEditingController(
      text: widget.initialNotes ?? '',
    );

    _selectedDate = widget.initialDate;

    _dateController = TextEditingController(
      text: _formatDate(_selectedDate),
    );
  }

  @override
  void dispose() {
    _siteNameController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _siteNameController,
            label: 'Site name',
            hint: 'Enter site name',
            validator: _requiredValidator,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: AppSpacing.md),

          AppDateField(
            controller: _dateController,
            label: 'Date',
            validator: (_) {
              if (_selectedDate == null) {
                return 'Date is required';
              }

              return null;
            },
            onTap: _selectDate,
          ),

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: _locationController,
            label: 'Location',
            hint: 'Enter location',
            validator: _requiredValidator,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: _notesController,
            label: 'Notes',
            hint: 'Enter visit notes',
            validator: _requiredValidator,
            maxLines: 4,
            textInputAction: TextInputAction.done,
          ),

          const SizedBox(height: AppSpacing.lg),

          PrimaryButton(
            label: widget.submitLabel,
            onPressed: widget.isLoading ? null : _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
      _dateController.text = _formatDate(pickedDate);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }

    widget.onSubmit(
      VisitFormData(
        siteName: _siteNameController.text.trim(),
        date: _selectedDate!,
        location: _locationController.text.trim(),
        notes: _notesController.text.trim(),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${_monthName(date.month)} ${date.day}, ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }
}

class VisitFormData {
  final String siteName;
  final DateTime date;
  final String location;
  final String notes;

  const VisitFormData({
    required this.siteName,
    required this.date,
    required this.location,
    required this.notes,
  });
}