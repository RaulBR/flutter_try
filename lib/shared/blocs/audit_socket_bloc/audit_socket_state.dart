part of 'audit_socket_bloc.dart';

abstract class AuditSocketState extends Equatable {
  final int auditCount;
  final int distributeAuditCount;
  const AuditSocketState({this.distributeAuditCount, this.auditCount});

  @override
  List<Object> get props => [auditCount, distributeAuditCount];
}

class AuditSocketInitial extends AuditSocketState {}

class AuditCountState extends AuditSocketState {
  final int auditCount;
  AuditCountState({this.auditCount});
}

class AuditDistributionCountState extends AuditSocketState {
  final int count;
  AuditDistributionCountState({this.count});
}

class HasAuditSate extends AuditSocketState {}
