import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_recommender/src/home/models/country.dart';
import 'package:movie_recommender/src/home/repository/repository.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_rounded), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('No hay valor en el query');
    }
    final repository = Repository();

    return FutureBuilder(
      future: repository.getCountryByName(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showCountries(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: Text('Sugerencias'),
    );
  }

  Widget _showCountries(List<Country> countries) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        Country country = countries[index];
        return ListTile(
          leading: (country.flag != null)
              ? SvgPicture.network(
                  country.flag,
                  width: 40,
                )
              : '',
          title: Text(country.name),
          subtitle: Text(country.capital),
          trailing: Text(country.alpha3Code),
          onTap: () {
            this.close(context, country.name);
          },
        );
      },
    );
  }
}
