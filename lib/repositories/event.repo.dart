import 'dart:convert';
import 'package:hcslzapp/models/event.dart';
import 'package:http/http.dart';
import '../common/settings.dart';
import 'package:hcslzapp/http/http.exception.dart';

const String _eventUrl = '/event';

class EventRepo {
  Future<String> findAll() async {
    final Response response =
        await client.get(Uri.parse(mainUrl + _eventUrl + "/list")).timeout(
              Duration(seconds: 10),
            );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw HttpException(getMessage(response.statusCode));
    }
  }

  Future<Event> save(Event event) async {
    final String encodedJson = jsonEncode(
      event.toJson(),
    );
    final Response response = await client
        .post(
          Uri.parse(mainUrl + _eventUrl + "/save"),
          headers: {
            'Content-type': 'application/json',
          },
          body: encodedJson,
        )
        .timeout(
          Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return Event.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw HttpException(getMessage(response.statusCode));
    }
  }

  Future<Event> update(Event event) async {
    final String encodedJson = jsonEncode(
      event.toJson(),
    );
    final Response response = await client
        .put(
          Uri.parse(mainUrl + _eventUrl + "/" + event.id.toString()),
          headers: {
            'Content-type': 'application/json',
          },
          body: encodedJson,
        )
        .timeout(
          Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return Event.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw HttpException(getMessage(response.statusCode));
    }
  }

  Future<Response> deleteById(Event event) async {
    final String encodedJson = jsonEncode(
      event.toJson(),
    );
    final Response response = await client.delete(
      Uri.parse(mainUrl + _eventUrl + "/" + event.id.toString()),
      headers: {
        'Content-type': 'application/json',
      },
    ).timeout(
      Duration(seconds: 10),
    );
    if (response.statusCode == 204) {
      return response;
    } else {
      throw HttpException(getMessage(response.statusCode));
    }
  }
}
