// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompleteCollection on Isar {
  IsarCollection<Complete> get completes => this.collection();
}

const CompleteSchema = CollectionSchema(
  name: r'Complete',
  id: 7523497361042817977,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.dateTime,
    ),
    r'scheduleId': PropertySchema(
      id: 1,
      name: r'scheduleId',
      type: IsarType.long,
    ),
    r'visionId': PropertySchema(
      id: 2,
      name: r'visionId',
      type: IsarType.long,
    )
  },
  estimateSize: _completeEstimateSize,
  serialize: _completeSerialize,
  deserialize: _completeDeserialize,
  deserializeProp: _completeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _completeGetId,
  getLinks: _completeGetLinks,
  attach: _completeAttach,
  version: '3.1.0+1',
);

int _completeEstimateSize(
  Complete object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _completeSerialize(
  Complete object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completed);
  writer.writeLong(offsets[1], object.scheduleId);
  writer.writeLong(offsets[2], object.visionId);
}

Complete _completeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Complete();
  object.completed = reader.readDateTime(offsets[0]);
  object.id = id;
  object.scheduleId = reader.readLong(offsets[1]);
  object.visionId = reader.readLong(offsets[2]);
  return object;
}

P _completeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _completeGetId(Complete object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _completeGetLinks(Complete object) {
  return [];
}

void _completeAttach(IsarCollection<dynamic> col, Id id, Complete object) {
  object.id = id;
}

extension CompleteQueryWhereSort on QueryBuilder<Complete, Complete, QWhere> {
  QueryBuilder<Complete, Complete, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompleteQueryWhere on QueryBuilder<Complete, Complete, QWhereClause> {
  QueryBuilder<Complete, Complete, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Complete, Complete, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Complete, Complete, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Complete, Complete, QAfterWhereClause> idBetween(
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
}

extension CompleteQueryFilter
    on QueryBuilder<Complete, Complete, QFilterCondition> {
  QueryBuilder<Complete, Complete, QAfterFilterCondition> completedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> completedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> completedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> completedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Complete, Complete, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Complete, Complete, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Complete, Complete, QAfterFilterCondition> scheduleIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> scheduleIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> scheduleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> scheduleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> visionIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visionId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> visionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visionId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> visionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visionId',
        value: value,
      ));
    });
  }

  QueryBuilder<Complete, Complete, QAfterFilterCondition> visionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompleteQueryObject
    on QueryBuilder<Complete, Complete, QFilterCondition> {}

extension CompleteQueryLinks
    on QueryBuilder<Complete, Complete, QFilterCondition> {}

extension CompleteQuerySortBy on QueryBuilder<Complete, Complete, QSortBy> {
  QueryBuilder<Complete, Complete, QAfterSortBy> sortByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> sortByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> sortByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> sortByScheduleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.desc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> sortByVisionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visionId', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> sortByVisionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visionId', Sort.desc);
    });
  }
}

extension CompleteQuerySortThenBy
    on QueryBuilder<Complete, Complete, QSortThenBy> {
  QueryBuilder<Complete, Complete, QAfterSortBy> thenByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByScheduleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.desc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByVisionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visionId', Sort.asc);
    });
  }

  QueryBuilder<Complete, Complete, QAfterSortBy> thenByVisionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visionId', Sort.desc);
    });
  }
}

extension CompleteQueryWhereDistinct
    on QueryBuilder<Complete, Complete, QDistinct> {
  QueryBuilder<Complete, Complete, QDistinct> distinctByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completed');
    });
  }

  QueryBuilder<Complete, Complete, QDistinct> distinctByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleId');
    });
  }

  QueryBuilder<Complete, Complete, QDistinct> distinctByVisionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visionId');
    });
  }
}

extension CompleteQueryProperty
    on QueryBuilder<Complete, Complete, QQueryProperty> {
  QueryBuilder<Complete, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Complete, DateTime, QQueryOperations> completedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completed');
    });
  }

  QueryBuilder<Complete, int, QQueryOperations> scheduleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleId');
    });
  }

  QueryBuilder<Complete, int, QQueryOperations> visionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visionId');
    });
  }
}
