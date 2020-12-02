import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_service.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/check_box.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/datepiker.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsFormWidget extends StatelessWidget {
  final Aspect aspect;
  final String title;
  final int order;
  final bool isEditable;
  final Function hasChanges;
  final Function navigate;
  ActionsFormWidget(
      {this.title,
      this.order,
      this.hasChanges,
      this.aspect,
      this.navigate,
      this.isEditable});

  @override
  Widget build(BuildContext context) {
    String label = Labels.backToAspects;
    AuditAction _action = AuditAction();
    _action = aspect.action ?? _action;
    String getName() {
      if (_action != null) {
        if (_action.responsable != null) {
          return '${_action.responsable.firstName} ${_action.responsable.lastName}';
        }
      }
      return '';
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AuditFormWraper(
              title: title == null ? null : title,
              order: order == null ? null : order,
              children: [
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) => EhsSearchListPicker(
                    isEditable: isEditable,
                    list: AspectService()
                        .handleResponsableForAspect(context, state),
                    label: Labels.responsabile,
                    selected: (data) {
                      _action.responsable =
                          BlocProvider.of<EmployeeBloc>(context)
                              .getEmployee(data.id);
                      hasChanges(_action);
                    },
                    tapped: () {
                      BlocProvider.of<EmployeeBloc>(context).getEmployees();
                    },
                    preselected: getName(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: EhsCheckBox(
                    isEditable: isEditable,
                    label: Labels.imidiateActtion,
                    value: _action.imidiatAcction ?? false,
                    setValue: (value) {
                      _action.imidiatAcction = value;
                      hasChanges(_action);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 12),
                  child: DatePiker(
                      isEditable: isEditable,
                      label: Labels.limitDate,
                      inputDate:
                          (_action == null ? null : _action.limitDate) ?? null,
                      getDate: (data) {
                        _action.limitDate = data.toString();
                        hasChanges(_action);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                OpenTextAreaWidget(
                  isEditable: isEditable,
                  label: _action.comment == null
                      ? Labels.addComment
                      : Labels.comment,
                  text: _action.comment,
                  onEdit: (text) {
                    _action.comment = text;
                    hasChanges(_action);
                  },
                ),
              ],
            ),
            NavigateToNextPage(
              label: label,
              onPressed: () => navigate(),
            ),
          ],
        ),
      ),
    );
  }
}
