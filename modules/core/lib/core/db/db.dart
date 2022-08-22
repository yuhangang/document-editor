// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:core/core/db/tables/city_db.dart';
import 'package:core/core/db/tables/continent_db.dart';
import 'package:core/core/db/tables/country_db.dart';
import 'package:flutter/foundation.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;

part 'db.g.dart';

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel', // optional
    databaseName: 'sampleORM.db',
    password: "Av0123",
    // put defined tables into the tables list.
    databaseTables: [continentTable, countryTable, cityTable],
    // You can define tables to generate add/edit view forms if you want to use Form Generator property
    // put defined sequences into the sequences list.
    bundledDatabasePath:
        null // 'assets/sample.db' // This value is optional. When bundledDatabasePath is empty then EntityBase creats a new database when initializing the database
    );
