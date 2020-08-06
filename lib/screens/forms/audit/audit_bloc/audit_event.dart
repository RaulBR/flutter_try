import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/area_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';

abstract class AuditEvent {
  String id;
  Audit audit;
  Aspect aspect;
  AspectPhoto aspectPhoto;
  AuditRequest auditRequest;
  AuditEvent({this.audit});
}

class GetMyAudits extends AuditEvent {}

class GetMyAudit extends AuditEvent {}

class GetMyTasks extends AuditEvent {}

class UpdateForm extends AuditEvent {
  final Audit audit;
  UpdateForm({this.audit});
}

class SetAudit extends AuditEvent {
  final Audit audit;
  SetAudit({this.audit});
}

class EditAudit extends AuditEvent {
  final Audit audit;
  EditAudit({this.audit});
}

class DeleteAudit extends AuditEvent {
  String id;
  DeleteAudit({this.id});
}

class SetAspect extends AuditEvent {
  List<Aspect> aspects;
  SetAspect({this.aspects});
}

class SetAuditAspect extends AuditEvent {
  AuditRequest auditRequest;
  SetAuditAspect({this.auditRequest});
}

class GetAuditResponsible extends AuditEvent {
  final Aspect aspect;

  GetAuditResponsible({this.aspect});
}
