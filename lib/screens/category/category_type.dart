import 'dart:async';

import 'package:ehsfocus/bloc/category/category_state.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/bloc/category/category_bloc.dart';
import 'package:ehsfocus/models/form_metadata.dart/form_footer_model.dart';
import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';
import 'package:ehsfocus/services/popup_service/snakbar.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_page_wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTypeMentenanceForm extends StatelessWidget {
  final CategorySertvice _categorySertvice = CategorySertvice();
  @override
  Widget build(BuildContext context) {
    CategoryType category = CategoryType();
    String error;
    Timer _debounce;
    TextEditingController txt;
    return PageWrapper(
      add: () {
        _categorySertvice.openCategoryModal(context,
            add: (data) =>
                BlocProvider.of<CategoryBloc>(context).addCategory(data));
      },
      child: Column(
        children: <Widget>[
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryErrorState) {
                SnackBarSerice().showToast(context, state.error);
              }
            },
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is OneCategoryTypesState) {
                  category = state.categorie;
                  error = state.error;
                }
                return ClearableTextField(
                  label: Labels.aspectType,
                  inputValue: (category.type),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      BlocProvider.of<CategoryBloc>(context)
                          .setCategoryType(value);
                      _debounce.cancel();
                    });
                  },
                  error: error,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          InputContainer(
            child: TextField(
              controller: txt,
              decoration: textInputDecoration.copyWith(
                  labelText: Labels.category, suffixIcon: Icon(Icons.search)),
              onChanged: (data) {
                BlocProvider.of<CategoryBloc>(context).setCategoryType(data);
              },
            ),
          ),
          SizedBox(height: 20),
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
            if (state is OneCategoryTypesState) {
              category = state.categorie;
            }
            return Flexible(
              child: ListView.builder(
                itemCount: category.categories == null
                    ? 0
                    : category.categories.length,
                itemBuilder: (context, index) {
                  return GennericListElement(
                    title: category.categories[index].category,
                    deleted: () async {
                      if (await EhsGennericPopup().showPupup(context,
                          messageTitle: category.categories[index].category)) {
                        BlocProvider.of<CategoryBloc>(context)
                            .deleteCategory(category.categories[index]);
                      }
                    },
                    isSelected: () {
                      _categorySertvice.openCategoryModal(context,
                          selected: category.categories[index].category,
                          add: (data) => BlocProvider.of<CategoryBloc>(context)
                              .editCategory(index, data));
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
      footerActions: [
        FormFooterModel(Labels.delete),
        FormFooterModel(Labels.save)
      ],
      footerAction: (data) {
        if (data == Labels.save) {
          BlocProvider.of<CategoryBloc>(context).saveCategoryType(category);
          Navigator.pop(context);
        }
      },
    );
  }
}
