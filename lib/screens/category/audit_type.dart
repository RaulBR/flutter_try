import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/category/category_type.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GenericListObject> _categoryesType = [];
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategorysTypesState) {
            print(state.categoryes);
            _categoryesType = state.categoryes
                .map((element) =>
                    GenericListObject(id: element.id, title: element.type))
                .toList();
          }

          return SearchPageWrapper(
            title: Labels.aspectType,
            addForm: CategoryTypeMentenanceForm(),
            listObjects: _categoryesType,
            selected: (data) {
              BlocProvider.of<CategoryBloc>(context).selectedType(data.id);
            },
            add: () {
              BlocProvider.of<CategoryBloc>(context).selectedType(null);
            },
            deleted: (data) async {
              if (await EhsGennericPopup()
                  .showPupup(context, what: data.title)) {
                BlocProvider.of<CategoryBloc>(context)
                    .deleteCategoryType(data.id);
              }
            },
            search: (data) {},
          );
        },
      ),
    );
  }
}
