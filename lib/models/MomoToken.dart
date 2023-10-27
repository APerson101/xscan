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


/** This is an auto generated class representing the MomoToken type in your schema. */
class MomoToken extends amplify_core.Model {
  static const classType = const _MomoTokenModelType();
  final String id;
  final String? _auth;
  final String? _expires;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MomoTokenModelIdentifier get modelIdentifier {
      return MomoTokenModelIdentifier(
        id: id
      );
  }
  
  String get auth {
    try {
      return _auth!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get expires {
    try {
      return _expires!;
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
  
  const MomoToken._internal({required this.id, required auth, required expires, createdAt, updatedAt}): _auth = auth, _expires = expires, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MomoToken({String? id, required String auth, required String expires}) {
    return MomoToken._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      auth: auth,
      expires: expires);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MomoToken &&
      id == other.id &&
      _auth == other._auth &&
      _expires == other._expires;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MomoToken {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("auth=" + "$_auth" + ", ");
    buffer.write("expires=" + "$_expires" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MomoToken copyWith({String? auth, String? expires}) {
    return MomoToken._internal(
      id: id,
      auth: auth ?? this.auth,
      expires: expires ?? this.expires);
  }
  
  MomoToken copyWithModelFieldValues({
    ModelFieldValue<String>? auth,
    ModelFieldValue<String>? expires
  }) {
    return MomoToken._internal(
      id: id,
      auth: auth == null ? this.auth : auth.value,
      expires: expires == null ? this.expires : expires.value
    );
  }
  
  MomoToken.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _auth = json['auth'],
      _expires = json['expires'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'auth': _auth, 'expires': _expires, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'auth': _auth,
    'expires': _expires,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<MomoTokenModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<MomoTokenModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final AUTH = amplify_core.QueryField(fieldName: "auth");
  static final EXPIRES = amplify_core.QueryField(fieldName: "expires");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MomoToken";
    modelSchemaDefinition.pluralName = "MomoTokens";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: MomoToken.AUTH,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: MomoToken.EXPIRES,
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

class _MomoTokenModelType extends amplify_core.ModelType<MomoToken> {
  const _MomoTokenModelType();
  
  @override
  MomoToken fromJson(Map<String, dynamic> jsonData) {
    return MomoToken.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'MomoToken';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [MomoToken] in your schema.
 */
class MomoTokenModelIdentifier implements amplify_core.ModelIdentifier<MomoToken> {
  final String id;

  /** Create an instance of MomoTokenModelIdentifier using [id] the primary key. */
  const MomoTokenModelIdentifier({
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
  String toString() => 'MomoTokenModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is MomoTokenModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}