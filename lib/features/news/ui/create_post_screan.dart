import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/fluxiq_button_widget.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../provider/vm/publish_news_viewmodel_provider.dart';
import '../state/publish_state.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(publishingNewsProvider);
    final size = MediaQuery.of(context).size;

    ref.listen<PublishNewsState>(publishingNewsProvider, (prev, next) {
      if (next.status == PublishNewsStatus.success) {
        FluxIQSnackBar.showSuccess(context, next.successMessage!);
        ref.read(publishingNewsProvider.notifier).reset();

        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) Navigator.of(context).pop();
        });
      } else if (next.status == PublishNewsStatus.failure) {
        FluxIQSnackBar.showError(context, next.errorMessage !);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF8E24AA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.image),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 8),

            if (_imageController.text.trim().isNotEmpty)
              SizedBox(
                height: size.height * 0.25,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _imageController.text.trim(),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items:  AppConstants.publishCategories.map((cat) => DropdownMenuItem(
                  value: cat, child: Text(cat))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            const SizedBox(height: 24),
            FluxIQButton(
              label: 'Publish',
              isLoading: state.status == PublishNewsStatus.publishing,
              onPressed: () {
                ref.read(publishingNewsProvider.notifier).publish(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  imageUrl: _imageController.text,
                  category: _selectedCategory!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
