import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_service.dart';
import 'bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => UserBloc(
            apiService:
                ApiService(baseUrl: 'https://jsonplaceholder.typicode.com')),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF22395d),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("asset/images.jpeg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(FetchUsers());
                },
                child: const Text('Fetch Users'),
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return const Text(
                      'Press the button to fetch users',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  } else if (state is UserLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is UserLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              elevation: 3,
                              child: ListTile(
                                title: Text(
                                  state.users[index]['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.users[index]['email']),
                                    Text(state.users[index]['address']['city']),
                                    Text(state.users[index]['address']
                                        ['zipcode']),
                                  ],
                                ),
                                leading: CircleAvatar(
                                    child: Text(
                                        state.users[index]['id'].toString())),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is UserError) {
                    return Text('Error: ${state.message}');
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
