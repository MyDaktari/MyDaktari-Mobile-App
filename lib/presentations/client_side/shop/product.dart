class Product {
  final int id;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;
  final double rating; // 0 to 5

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });
}

List<Product> dummyProducts = [
  Product(
      id: 1,
      productName: 'Product A',
      price: 10.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      imageUrl:
          'https://images.pexels.com/photos/48604/pexels-photo-48604.jpeg?auto=compress&cs=tinysrgb&w=1600',
      rating: 3.6),
  Product(
      id: 2,
      productName: 'Product B',
      price: 19.99,
      imageUrl:
          'https://images.pexels.com/photos/3786120/pexels-photo-3786120.jpeg?auto=compress&cs=tinysrgb&w=1600',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 4.5),
  Product(
      id: 3,
      productName: 'Product C',
      price: 7.49,
      description: 'Lorem ipsum',
      rating: 5.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 4,
      productName: 'Product D',
      price: 24.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 4.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 5,
      productName: 'Product E',
      price: 12.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 3.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 6,
      productName: 'Product F',
      price: 9.99,
      rating: 2.0,
      imageUrl:
          'https://images.pexels.com/photos/3786120/pexels-photo-3786120.jpeg?auto=compress&cs=tinysrgb&w=1600',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam'),
  Product(
      id: 1,
      productName: 'Product A',
      price: 10.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      imageUrl:
          'https://images.pexels.com/photos/48604/pexels-photo-48604.jpeg?auto=compress&cs=tinysrgb&w=1600',
      rating: 3.6),
  Product(
      id: 2,
      productName: 'Product B',
      price: 19.99,
      imageUrl:
          'https://images.pexels.com/photos/3786120/pexels-photo-3786120.jpeg?auto=compress&cs=tinysrgb&w=1600',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 4.5),
  Product(
      id: 3,
      productName: 'Product C',
      price: 7.49,
      description: 'Lorem ipsum',
      rating: 5.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 4,
      productName: 'Product D',
      price: 24.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 4.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 5,
      productName: 'Product E',
      price: 12.99,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam',
      rating: 3.0,
      imageUrl:
          'https://images.pexels.com/photos/3845129/pexels-photo-3845129.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Product(
      id: 6,
      productName: 'Product F',
      price: 9.99,
      rating: 2.0,
      imageUrl:
          'https://images.pexels.com/photos/3786120/pexels-photo-3786120.jpeg?auto=compress&cs=tinysrgb&w=1600',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultrices aliquam, nunc nisl aliquet nunc, quis aliquam'),
];
