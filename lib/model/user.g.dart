// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      status: fields[0] as bool,
      message: fields[1] as String,
      data: fields[2] as Data,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      name: fields[3] as String,
      email: fields[4] as String,
      role: fields[5] as String,
      permissions: (fields[6] as List)?.cast<Permissions>(),
      accessToken: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(5)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.role)
      ..writeByte(6)
      ..write(obj.permissions)
      ..writeByte(7)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PermissionsAdapter extends TypeAdapter<Permissions> {
  @override
  final int typeId = 3;

  @override
  Permissions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Permissions(
      id: fields[8] as int,
      name: fields[9] as String,
      displayName: fields[10] as String,
      description: fields[11] as String,
      createdAt: fields[12] as String,
      updatedAt: fields[13] as String,
      pivot: fields[14] as Pivot,
    );
  }

  @override
  void write(BinaryWriter writer, Permissions obj) {
    writer
      ..writeByte(7)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.displayName)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PivotAdapter extends TypeAdapter<Pivot> {
  @override
  final int typeId = 4;

  @override
  Pivot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pivot(
      userId: fields[15] as int,
      permissionId: fields[16] as int,
      userType: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pivot obj) {
    writer
      ..writeByte(3)
      ..writeByte(15)
      ..write(obj.userId)
      ..writeByte(16)
      ..write(obj.permissionId)
      ..writeByte(17)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PivotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
