part of '../exporter.dart';

class NumStringMapper extends FieldValueMapper<num,String> {
  NumStringMapper():super(
    toClientType: (String? text)=> text != null ? num.tryParse(text) : null,
    toFieldType: (num? value)=>value?.toString(),
  );
}