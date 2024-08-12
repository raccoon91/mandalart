// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskCollection on Isar {
  IsarCollection<Task> get tasks => this.collection();
}

const TaskSchema = CollectionSchema(
  name: r'Task',
  id: 2998003626758701373,
  properties: {
    r'allDay': PropertySchema(
      id: 0,
      name: r'allDay',
      type: IsarType.bool,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.long,
    ),
    r'delete': PropertySchema(
      id: 2,
      name: r'delete',
      type: IsarType.bool,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'detailedPlanId': PropertySchema(
      id: 4,
      name: r'detailedPlanId',
      type: IsarType.long,
    ),
    r'everyDay': PropertySchema(
      id: 5,
      name: r'everyDay',
      type: IsarType.bool,
    ),
    r'everyMonth': PropertySchema(
      id: 6,
      name: r'everyMonth',
      type: IsarType.long,
    ),
    r'everyWeek': PropertySchema(
      id: 7,
      name: r'everyWeek',
      type: IsarType.long,
    ),
    r'from': PropertySchema(
      id: 8,
      name: r'from',
      type: IsarType.dateTime,
    ),
    r'repeat': PropertySchema(
      id: 9,
      name: r'repeat',
      type: IsarType.string,
    ),
    r'style': PropertySchema(
      id: 10,
      name: r'style',
      type: IsarType.string,
    ),
    r'terminate': PropertySchema(
      id: 11,
      name: r'terminate',
      type: IsarType.dateTime,
    ),
    r'to': PropertySchema(
      id: 12,
      name: r'to',
      type: IsarType.dateTime,
    ),
    r'weekday': PropertySchema(
      id: 13,
      name: r'weekday',
      type: IsarType.bool,
    ),
    r'weekend': PropertySchema(
      id: 14,
      name: r'weekend',
      type: IsarType.bool,
    )
  },
  estimateSize: _taskEstimateSize,
  serialize: _taskSerialize,
  deserialize: _taskDeserialize,
  deserializeProp: _taskDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _taskGetId,
  getLinks: _taskGetLinks,
  attach: _taskAttach,
  version: '3.1.0+1',
);

int _taskEstimateSize(
  Task object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.repeat;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.style;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _taskSerialize(
  Task object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allDay);
  writer.writeLong(offsets[1], object.color);
  writer.writeBool(offsets[2], object.delete);
  writer.writeString(offsets[3], object.description);
  writer.writeLong(offsets[4], object.detailedPlanId);
  writer.writeBool(offsets[5], object.everyDay);
  writer.writeLong(offsets[6], object.everyMonth);
  writer.writeLong(offsets[7], object.everyWeek);
  writer.writeDateTime(offsets[8], object.from);
  writer.writeString(offsets[9], object.repeat);
  writer.writeString(offsets[10], object.style);
  writer.writeDateTime(offsets[11], object.terminate);
  writer.writeDateTime(offsets[12], object.to);
  writer.writeBool(offsets[13], object.weekday);
  writer.writeBool(offsets[14], object.weekend);
}

Task _taskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Task();
  object.allDay = reader.readBool(offsets[0]);
  object.color = reader.readLongOrNull(offsets[1]);
  object.delete = reader.readBool(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.detailedPlanId = reader.readLong(offsets[4]);
  object.everyDay = reader.readBool(offsets[5]);
  object.everyMonth = reader.readLongOrNull(offsets[6]);
  object.everyWeek = reader.readLongOrNull(offsets[7]);
  object.from = reader.readDateTime(offsets[8]);
  object.id = id;
  object.repeat = reader.readStringOrNull(offsets[9]);
  object.style = reader.readStringOrNull(offsets[10]);
  object.terminate = reader.readDateTimeOrNull(offsets[11]);
  object.to = reader.readDateTime(offsets[12]);
  object.weekday = reader.readBool(offsets[13]);
  object.weekend = reader.readBool(offsets[14]);
  return object;
}

P _taskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskGetId(Task object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskGetLinks(Task object) {
  return [];
}

void _taskAttach(IsarCollection<dynamic> col, Id id, Task object) {
  object.id = id;
}

extension TaskQueryWhereSort on QueryBuilder<Task, Task, QWhere> {
  QueryBuilder<Task, Task, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TaskQueryWhere on QueryBuilder<Task, Task, QWhereClause> {
  QueryBuilder<Task, Task, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Task, Task, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idBetween(
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

extension TaskQueryFilter on QueryBuilder<Task, Task, QFilterCondition> {
  QueryBuilder<Task, Task, QAfterFilterCondition> allDayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> colorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delete',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> detailedPlanIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detailedPlanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> detailedPlanIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detailedPlanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> detailedPlanIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detailedPlanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> detailedPlanIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detailedPlanId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyDayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'everyDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'everyMonth',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'everyMonth',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'everyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'everyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'everyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyMonthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'everyMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'everyWeek',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'everyWeek',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'everyWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'everyWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'everyWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> everyWeekBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'everyWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> fromEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> fromGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'from',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> fromLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'from',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> fromBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'from',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Task, Task, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Task, Task, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeat',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeat',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'repeat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeat',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> repeatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'repeat',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'style',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'style',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'style',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'style',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> styleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'style',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'terminate',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'terminate',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'terminate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'terminate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'terminate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> terminateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'terminate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> toEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'to',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> toGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'to',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> toLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'to',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> toBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'to',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> weekdayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekday',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> weekendEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekend',
        value: value,
      ));
    });
  }
}

extension TaskQueryObject on QueryBuilder<Task, Task, QFilterCondition> {}

extension TaskQueryLinks on QueryBuilder<Task, Task, QFilterCondition> {}

extension TaskQuerySortBy on QueryBuilder<Task, Task, QSortBy> {
  QueryBuilder<Task, Task, QAfterSortBy> sortByAllDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allDay', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByAllDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allDay', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delete', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delete', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDetailedPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detailedPlanId', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDetailedPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detailedPlanId', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyDay', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyDay', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyMonth', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyMonth', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyWeek', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEveryWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyWeek', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByTerminate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terminate', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByTerminateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terminate', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByWeekdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByWeekend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekend', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByWeekendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekend', Sort.desc);
    });
  }
}

extension TaskQuerySortThenBy on QueryBuilder<Task, Task, QSortThenBy> {
  QueryBuilder<Task, Task, QAfterSortBy> thenByAllDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allDay', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByAllDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allDay', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delete', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delete', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDetailedPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detailedPlanId', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDetailedPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detailedPlanId', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyDay', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyDay', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyMonth', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyMonth', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyWeek', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEveryWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'everyWeek', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByTerminate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terminate', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByTerminateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terminate', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'to', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByWeekdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByWeekend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekend', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByWeekendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekend', Sort.desc);
    });
  }
}

extension TaskQueryWhereDistinct on QueryBuilder<Task, Task, QDistinct> {
  QueryBuilder<Task, Task, QDistinct> distinctByAllDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allDay');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'delete');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByDetailedPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detailedPlanId');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByEveryDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'everyDay');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByEveryMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'everyMonth');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByEveryWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'everyWeek');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByRepeat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByStyle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByTerminate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'terminate');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'to');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekday');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByWeekend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekend');
    });
  }
}

extension TaskQueryProperty on QueryBuilder<Task, Task, QQueryProperty> {
  QueryBuilder<Task, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> allDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allDay');
    });
  }

  QueryBuilder<Task, int?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> deleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'delete');
    });
  }

  QueryBuilder<Task, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Task, int, QQueryOperations> detailedPlanIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detailedPlanId');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> everyDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'everyDay');
    });
  }

  QueryBuilder<Task, int?, QQueryOperations> everyMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'everyMonth');
    });
  }

  QueryBuilder<Task, int?, QQueryOperations> everyWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'everyWeek');
    });
  }

  QueryBuilder<Task, DateTime, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<Task, String?, QQueryOperations> repeatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeat');
    });
  }

  QueryBuilder<Task, String?, QQueryOperations> styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<Task, DateTime?, QQueryOperations> terminateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'terminate');
    });
  }

  QueryBuilder<Task, DateTime, QQueryOperations> toProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'to');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> weekdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekday');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> weekendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekend');
    });
  }
}
