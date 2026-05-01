import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/core/listeners/publish_state_listener.dart';
import 'package:fluxiq/features/news/screens/create_news/widgets/create_news_app_bar.dart';
import 'package:fluxiq/features/news/screens/create_news/widgets/create_news_category_dropdown.dart';
import 'package:fluxiq/features/news/screens/create_news/widgets/create_news_description_field.dart';
import 'package:fluxiq/features/news/screens/create_news/widgets/create_news_image_field.dart';
import 'package:fluxiq/features/news/screens/create_news/widgets/create_news_title_field.dart';

import '../../../../core/widgets/fluxiq_button_widget.dart';
import '../../provider/vm/publish_news_viewmodel_provider.dart';
import '../../state/publish_state.dart';

class CreateNewsScreen extends ConsumerStatefulWidget {
  const CreateNewsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateNewsScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreateNewsScreen> {
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

    return PublishStateListener(
      child: Scaffold(
        appBar: const CreateNewsAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CreateNewsTitleField(controller: _titleController),
              const SizedBox(height: 16),
              CreateNewsDescriptionField(controller: _descriptionController),
              const SizedBox(height: 16),
              CreateNewsImageField(controller: _imageController),
              const SizedBox(height: 16),
              CreateNewsCategoryDropdown(
                selectedCategory: _selectedCategory,
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
      ),
    );
  }
}