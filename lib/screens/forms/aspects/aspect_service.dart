import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';

class AspectService {
  List<GenericListObject> handleCategorysStateChange(context, state) {
    if (state is CategorysTypesState) {
      return state.categoryes
          .map((d) => GenericListObject(id: d.id, title: d.type))
          .toList();
    }
    if (state is CategorysState) {
      return state.categoryes
          .map((e) => GenericListObject(id: e.id, title: e.category))
          .toList();
    }
    return [];
  }

  List<GenericListObject> handleResponsableForAspect(context, state) {
    if (state is EmployeesValueState) {
      return state.employees == null
          ? []
          : state.employees
              .map((e) => GenericListObject(
                  id: e.id, title: '${e.firstName} ${e.lastName}'))
              .toList();
    }
    return [];
  }
}
