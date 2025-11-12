part of '../exporter.dart';

class SameValueMapper<T> extends FieldValueMapper<T,T> {
  
  SameValueMapper():super(
    toClientType: (i) => i,
    toFieldType: (o) => o,
  );
}