// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfigModelCollection on Isar {
  IsarCollection<ConfigModel> get configModels => this.collection();
}

const ConfigModelSchema = CollectionSchema(
  name: r'ConfigModel',
  id: -752269032857087123,
  properties: {
    r'isAgreement': PropertySchema(
      id: 0,
      name: r'isAgreement',
      type: IsarType.bool,
    )
  },
  estimateSize: _configModelEstimateSize,
  serialize: _configModelSerialize,
  deserialize: _configModelDeserialize,
  deserializeProp: _configModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'isAgreement': IndexSchema(
      id: 8695480296393103403,
      name: r'isAgreement',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isAgreement',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _configModelGetId,
  getLinks: _configModelGetLinks,
  attach: _configModelAttach,
  version: '3.1.8',
);

int _configModelEstimateSize(
  ConfigModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _configModelSerialize(
  ConfigModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isAgreement);
}

ConfigModel _configModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConfigModel(
    isAgreement: reader.readBoolOrNull(offsets[0]) ?? false,
  );
  return object;
}

P _configModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _configModelGetId(ConfigModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configModelGetLinks(ConfigModel object) {
  return [];
}

void _configModelAttach(
    IsarCollection<dynamic> col, Id id, ConfigModel object) {}

extension ConfigModelQueryWhereSort
    on QueryBuilder<ConfigModel, ConfigModel, QWhere> {
  QueryBuilder<ConfigModel, ConfigModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhere> anyIsAgreement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isAgreement'),
      );
    });
  }
}

extension ConfigModelQueryWhere
    on QueryBuilder<ConfigModel, ConfigModel, QWhereClause> {
  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause> isAgreementEqualTo(
      bool isAgreement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isAgreement',
        value: [isAgreement],
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterWhereClause>
      isAgreementNotEqualTo(bool isAgreement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isAgreement',
              lower: [],
              upper: [isAgreement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isAgreement',
              lower: [isAgreement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isAgreement',
              lower: [isAgreement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isAgreement',
              lower: [],
              upper: [isAgreement],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ConfigModelQueryFilter
    on QueryBuilder<ConfigModel, ConfigModel, QFilterCondition> {
  QueryBuilder<ConfigModel, ConfigModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterFilterCondition>
      isAgreementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAgreement',
        value: value,
      ));
    });
  }
}

extension ConfigModelQueryObject
    on QueryBuilder<ConfigModel, ConfigModel, QFilterCondition> {}

extension ConfigModelQueryLinks
    on QueryBuilder<ConfigModel, ConfigModel, QFilterCondition> {}

extension ConfigModelQuerySortBy
    on QueryBuilder<ConfigModel, ConfigModel, QSortBy> {
  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> sortByIsAgreement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAgreement', Sort.asc);
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> sortByIsAgreementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAgreement', Sort.desc);
    });
  }
}

extension ConfigModelQuerySortThenBy
    on QueryBuilder<ConfigModel, ConfigModel, QSortThenBy> {
  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> thenByIsAgreement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAgreement', Sort.asc);
    });
  }

  QueryBuilder<ConfigModel, ConfigModel, QAfterSortBy> thenByIsAgreementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAgreement', Sort.desc);
    });
  }
}

extension ConfigModelQueryWhereDistinct
    on QueryBuilder<ConfigModel, ConfigModel, QDistinct> {
  QueryBuilder<ConfigModel, ConfigModel, QDistinct> distinctByIsAgreement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAgreement');
    });
  }
}

extension ConfigModelQueryProperty
    on QueryBuilder<ConfigModel, ConfigModel, QQueryProperty> {
  QueryBuilder<ConfigModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ConfigModel, bool, QQueryOperations> isAgreementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAgreement');
    });
  }
}
