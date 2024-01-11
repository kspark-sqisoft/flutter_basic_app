import 'dart:math';

import 'package:flutter/material.dart';

class FoldingListScreen extends StatefulWidget {
  const FoldingListScreen({super.key});

  @override
  State<FoldingListScreen> createState() => _FoldingListScreenState();
}

class _FoldingListScreenState extends State<FoldingListScreen> {
  final List<Order> ordersList = [
    Order(
      id: '#${Random().nextInt(9999999)}',
      sender: User(
        firstname: 'John',
        lastname: 'Doe',
        evaluation: 3,
      ),
      product: Product(
        price: 59.99,
        image:
            'https://unsplash.com/photos/yjAFnkLtKY0/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MzB8fHByb2R1Y3R8ZW58MHx8fHwxNjU1NjcyNDkw&force=true&w=640',
        weight: 72,
      ),
      shippingCost: 30.0,
      sendingFrom: Address(
        street: 'Smoky Hollow Rd',
        number: 761,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11210,
      ),
      sendingTo: Address(
        street: 'Bohemia Ave',
        number: 46,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11237,
      ),
    ),
    //
    Order(
      id: '#${Random().nextInt(9999999)}',
      sender: User(
        firstname: 'John',
        lastname: 'Doe',
        evaluation: 3,
      ),
      product: Product(
        price: 59.99,
        image:
            'https://unsplash.com/photos/yjAFnkLtKY0/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MzB8fHByb2R1Y3R8ZW58MHx8fHwxNjU1NjcyNDkw&force=true&w=640',
        weight: 72,
      ),
      shippingCost: 30.0,
      sendingFrom: Address(
        street: 'Smoky Hollow Rd',
        number: 761,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11210,
      ),
      sendingTo: Address(
        street: 'Bohemia Ave',
        number: 46,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11237,
      ),
    ),
    //
    Order(
      id: '#${Random().nextInt(9999999)}',
      sender: User(
        firstname: 'John',
        lastname: 'Doe',
        evaluation: 3,
      ),
      product: Product(
        price: 59.99,
        image:
            'https://unsplash.com/photos/yjAFnkLtKY0/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MzB8fHByb2R1Y3R8ZW58MHx8fHwxNjU1NjcyNDkw&force=true&w=640',
        weight: 72,
      ),
      shippingCost: 30.0,
      sendingFrom: Address(
        street: 'Smoky Hollow Rd',
        number: 761,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11210,
      ),
      sendingTo: Address(
        street: 'Bohemia Ave',
        number: 46,
        city: 'Brooklyn',
        state: 'NY',
        zipCode: 11237,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folding List')),
      body: OrderList(orders: ordersList),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5.0,
          ),
          ...(orders.map((Order order) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: OrderEntry(order: order),
            );
          }).toList()),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}

class OrderEntry extends StatefulWidget {
  final Order order;

  const OrderEntry({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderEntry> createState() => _OrderEntryState();
}

class _OrderEntryState extends State<OrderEntry>
    with SingleTickerProviderStateMixin {
  double height = 180;
  late final AnimationController _controller;
  final Duration duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Widget _senderSection() {
    return OrderEntrySectionRow(
      height: 75,
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 2.5, left: 10.0, right: 10.0),
      children: [
        OrderEntrySection(
          title: 'Sender',
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset('assets/images/facebook/profile.jpg',
                      height: 40.0),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.order.sender.firstname} ${widget.order.sender.lastname}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            i < widget.order.sender.evaluation
                                ? Icons.star
                                : Icons.star_border,
                            color: i < widget.order.sender.evaluation
                                ? Colors.deepPurple
                                : Colors.black54,
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _addressSection() {
    return OrderEntrySectionRow(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
      children: [
        OrderEntrySection(
          title: 'From',
          children: [
            Text(
              '${widget.order.sendingFrom.number} ${widget.order.sendingFrom.street}',
            ),
            Text(
              '${widget.order.sendingFrom.city}, ${widget.order.sendingFrom.state} ${widget.order.sendingFrom.zipCode}',
            ),
          ],
        ),
        OrderEntrySection(
          title: 'To',
          children: [
            Text(
              '${widget.order.sendingTo.number} ${widget.order.sendingTo.street}',
            ),
            Text(
              '${widget.order.sendingTo.city}, ${widget.order.sendingTo.state} ${widget.order.sendingTo.zipCode}',
            ),
          ],
        ),
      ],
    );
  }

  Widget _deliverySection() {
    return const OrderEntrySectionRow(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
      children: [
        OrderEntrySection(
          title: 'Delivery Date',
          children: [
            Text(
              '6:30 pm',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('July 10, 2022'),
          ],
        ),
        OrderEntrySection(
          title: 'Request Deadline',
          children: [
            Text(
              '24 minutes',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _messageSection() {
    return Container(
      height: 75,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 2.5, bottom: 5.0, left: 10.0, right: 10.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
          ),
          child: Text(
            'Contact Sender'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnimation,
      child: AnimatedFoldingWidget(
        animation: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              1 / 3,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        behind: OrderEntryHeader(
          height: 180,
          order: widget.order,
        ),
        front: OrderEntrySummary(
          order: widget.order,
        ),
        next: Column(
          children: [
            _senderSection(),
            AnimatedFoldingWidget(
              animation: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(
                    1 / 3,
                    1 / 3 * 2,
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              behind: _addressSection(),
              front: Container(
                height: 75,
                color: Colors.white,
              ),
              next: AnimatedFoldingWidget(
                animation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(
                      1 / 3 * 2,
                      1.0,
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                behind: _deliverySection(),
                front: Container(
                  height: 75,
                  color: Colors.white,
                ),
                next: _messageSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderEntrySection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const OrderEntrySection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey.shade500,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class OrderEntrySectionRow extends StatelessWidget {
  final double height;
  final EdgeInsets padding;
  final List<Widget> children;

  const OrderEntrySectionRow({
    Key? key,
    required this.height,
    required this.children,
    this.padding = const EdgeInsets.all(10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Row(
          children: children,
        ),
      ),
    );
  }
}

class OrderEntrySummary extends StatelessWidget {
  final Order order;
  final Random _random = Random();

  OrderEntrySummary({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${order.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Today\n${_random.nextInt(13).toString().padLeft(2, '0')}:${_random.nextInt(60).toString().padLeft(2, '0')} ${_random.nextBool() ? 'pm' : 'am'}'
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.trip_origin,
                                          color: Colors.grey.shade600,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            '${order.sendingFrom.number} ${order.sendingFrom.street}, ${order.sendingFrom.city}, ${order.sendingFrom.state}',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.grey.shade600,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.trip_origin,
                                          color: Colors.grey.shade600,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            '${order.sendingTo.number} ${order.sendingTo.street}, ${order.sendingTo.city}, ${order.sendingTo.state}',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping\n\$${order.shippingCost.toStringAsFixed(2)}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                Text(
                                  'Weight\n${order.product.weight} lbs'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderEntryHeader extends StatelessWidget {
  final double height;
  final Order order;

  const OrderEntryHeader({
    Key? key,
    required this.order,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/samples/movies/Silo.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListItemDetailsHeaderBar(
                order: order,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          '\$${order.shippingCost.toStringAsFixed(2)}'
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Weight'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          '${order.product.weight} lbs'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListItemDetailsHeaderBar extends StatelessWidget {
  final Order order;

  const ListItemDetailsHeaderBar({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.deepPurple,
            child: InkWell(
              splashColor: Colors.deepPurpleAccent,
              onTap: () {
                // TODO: Add Functionality
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              order.id,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '\$${order.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedFoldingWidget extends StatelessWidget {
  final Animation animation;
  final Widget? behind;
  final Widget? front;
  final Widget? next;

  const AnimatedFoldingWidget({
    Key? key,
    required this.animation,
    this.behind,
    this.front,
    this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                behind!,
                Visibility(
                  visible: animation.value < 0.5,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(pi * animation.value),
                    alignment: FractionalOffset.bottomCenter,
                    child: front!,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: next != null && animation.value >= 0.5,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(pi + pi * animation.value),
                alignment: FractionalOffset.topCenter,
                child: next,
              ),
            ),
          ],
        );
      },
      animation: animation,
    );
  }
}

class Order {
  final String id;
  final User sender;
  final Product product;
  final double shippingCost;
  final Address sendingFrom;
  final Address sendingTo;

  Order({
    required this.id,
    required this.sender,
    required this.product,
    required this.shippingCost,
    required this.sendingFrom,
    required this.sendingTo,
  });
}

class Product {
  final double price;
  final String image;
  final double weight;

  Product({
    required this.price,
    required this.image,
    required this.weight,
  });
}

class Address {
  final int number;
  final String street;
  final String city;
  final String state;
  final int zipCode;

  Address({
    required this.number,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}

class User {
  final String firstname;
  final String lastname;
  final int evaluation;

  User({
    required this.firstname,
    required this.lastname,
    required this.evaluation,
  });
}
