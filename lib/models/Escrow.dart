/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Escrow type in your schema. */
class Escrow extends amplify_core.Model {
  static const classType = const _EscrowModelType();
  final String id;
  final String? _business;
  final String? _manufacturer;
  final String? _product;
  final String? _quantity;
  final String? _notes;
  final String? _amount;
  final String? _status;
  final String? _referenceid;
  final String? _businessNumber;
  final String? _manufacturerNumber;
  final String? _businessName;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  EscrowModelIdentifier get modelIdentifier {
      return EscrowModelIdentifier(
        id: id
      );
  }
  
  String get business {
    try {
      return _business!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get manufacturer {
    try {
      return _manufacturer!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get product {
    try {
      return _product!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get quantity {
    try {
      return _quantity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get notes {
    try {
      return _notes!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get amount {
    try {
      return _amount!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get status {
    try {
      return _status!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get referenceid {
    try {
      return _referenceid!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get businessNumber {
    try {
      return _businessNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get manufacturerNumber {
    try {
      return _manufacturerNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get businessName {
    try {
      return _businessName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Escrow._internal({required this.id, required business, required manufacturer, required product, required quantity, required notes, required amount, required status, required referenceid, required businessNumber, required manufacturerNumber, required businessName, createdAt, updatedAt}): _business = business, _manufacturer = manufacturer, _product = product, _quantity = quantity, _notes = notes, _amount = amount, _status = status, _referenceid = referenceid, _businessNumber = businessNumber, _manufacturerNumber = manufacturerNumber, _businessName = businessName, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Escrow({String? id, required String business, required String manufacturer, required String product, required String quantity, required String notes, required String amount, required String status, required String referenceid, required String businessNumber, required String manufacturerNumber, required String businessName}) {
    return Escrow._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      business: business,
      manufacturer: manufacturer,
      product: product,
      quantity: quantity,
      notes: notes,
      amount: amount,
      status: status,
      referenceid: referenceid,
      businessNumber: businessNumber,
      manufacturerNumber: manufacturerNumber,
      businessName: businessName);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Escrow &&
      id == other.id &&
      _business == other._business &&
      _manufacturer == other._manufacturer &&
      _product == other._product &&
      _quantity == other._quantity &&
      _notes == other._notes &&
      _amount == other._amount &&
      _status == other._status &&
      _referenceid == other._referenceid &&
      _businessNumber == other._businessNumber &&
      _manufacturerNumber == other._manufacturerNumber &&
      _businessName == other._businessName;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Escrow {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("business=" + "$_business" + ", ");
    buffer.write("manufacturer=" + "$_manufacturer" + ", ");
    buffer.write("product=" + "$_product" + ", ");
    buffer.write("quantity=" + "$_quantity" + ", ");
    buffer.write("notes=" + "$_notes" + ", ");
    buffer.write("amount=" + "$_amount" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("referenceid=" + "$_referenceid" + ", ");
    buffer.write("businessNumber=" + "$_businessNumber" + ", ");
    buffer.write("manufacturerNumber=" + "$_manufacturerNumber" + ", ");
    buffer.write("businessName=" + "$_businessName" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Escrow copyWith({String? business, String? manufacturer, String? product, String? quantity, String? notes, String? amount, String? status, String? referenceid, String? businessNumber, String? manufacturerNumber, String? businessName}) {
    return Escrow._internal(
      id: id,
      business: business ?? this.business,
      manufacturer: manufacturer ?? this.manufacturer,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      referenceid: referenceid ?? this.referenceid,
      businessNumber: businessNumber ?? this.businessNumber,
      manufacturerNumber: manufacturerNumber ?? this.manufacturerNumber,
      businessName: businessName ?? this.businessName);
  }
  
  Escrow copyWithModelFieldValues({
    ModelFieldValue<String>? business,
    ModelFieldValue<String>? manufacturer,
    ModelFieldValue<String>? product,
    ModelFieldValue<String>? quantity,
    ModelFieldValue<String>? notes,
    ModelFieldValue<String>? amount,
    ModelFieldValue<String>? status,
    ModelFieldValue<String>? referenceid,
    ModelFieldValue<String>? businessNumber,
    ModelFieldValue<String>? manufacturerNumber,
    ModelFieldValue<String>? businessName
  }) {
    return Escrow._internal(
      id: id,
      business: business == null ? this.business : business.value,
      manufacturer: manufacturer == null ? this.manufacturer : manufacturer.value,
      product: product == null ? this.product : product.value,
      quantity: quantity == null ? this.quantity : quantity.value,
      notes: notes == null ? this.notes : notes.value,
      amount: amount == null ? this.amount : amount.value,
      status: status == null ? this.status : status.value,
      referenceid: referenceid == null ? this.referenceid : referenceid.value,
      businessNumber: businessNumber == null ? this.businessNumber : businessNumber.value,
      manufacturerNumber: manufacturerNumber == null ? this.manufacturerNumber : manufacturerNumber.value,
      businessName: businessName == null ? this.businessName : businessName.value
    );
  }
  
  Escrow.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _business = json['business'],
      _manufacturer = json['manufacturer'],
      _product = json['product'],
      _quantity = json['quantity'],
      _notes = json['notes'],
      _amount = json['amount'],
      _status = json['status'],
      _referenceid = json['referenceid'],
      _businessNumber = json['businessNumber'],
      _manufacturerNumber = json['manufacturerNumber'],
      _businessName = json['businessName'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'business': _business, 'manufacturer': _manufacturer, 'product': _product, 'quantity': _quantity, 'notes': _notes, 'amount': _amount, 'status': _status, 'referenceid': _referenceid, 'businessNumber': _businessNumber, 'manufacturerNumber': _manufacturerNumber, 'businessName': _businessName, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'business': _business,
    'manufacturer': _manufacturer,
    'product': _product,
    'quantity': _quantity,
    'notes': _notes,
    'amount': _amount,
    'status': _status,
    'referenceid': _referenceid,
    'businessNumber': _businessNumber,
    'manufacturerNumber': _manufacturerNumber,
    'businessName': _businessName,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<EscrowModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<EscrowModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final BUSINESS = amplify_core.QueryField(fieldName: "business");
  static final MANUFACTURER = amplify_core.QueryField(fieldName: "manufacturer");
  static final PRODUCT = amplify_core.QueryField(fieldName: "product");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final NOTES = amplify_core.QueryField(fieldName: "notes");
  static final AMOUNT = amplify_core.QueryField(fieldName: "amount");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static final REFERENCEID = amplify_core.QueryField(fieldName: "referenceid");
  static final BUSINESSNUMBER = amplify_core.QueryField(fieldName: "businessNumber");
  static final MANUFACTURERNUMBER = amplify_core.QueryField(fieldName: "manufacturerNumber");
  static final BUSINESSNAME = amplify_core.QueryField(fieldName: "businessName");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Escrow";
    modelSchemaDefinition.pluralName = "Escrows";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.BUSINESS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.MANUFACTURER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.PRODUCT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.QUANTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.NOTES,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.AMOUNT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.STATUS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.REFERENCEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.BUSINESSNUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.MANUFACTURERNUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Escrow.BUSINESSNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _EscrowModelType extends amplify_core.ModelType<Escrow> {
  const _EscrowModelType();
  
  @override
  Escrow fromJson(Map<String, dynamic> jsonData) {
    return Escrow.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Escrow';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Escrow] in your schema.
 */
class EscrowModelIdentifier implements amplify_core.ModelIdentifier<Escrow> {
  final String id;

  /** Create an instance of EscrowModelIdentifier using [id] the primary key. */
  const EscrowModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'EscrowModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is EscrowModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}