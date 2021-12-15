class OnBoardingModel {
  String image;
  String title;
  String description;

  OnBoardingModel({this.image, this.title, this.description});
}

List<OnBoardingModel> pages = [
  OnBoardingModel(
      description:
          "Be a part of the vision to bring smile on someone else’s face by donating food.",
      title: 'Welcome to Helping Hand',
      image: 'assets/images/screen1.png'),
  OnBoardingModel(
      description:
          'Donate from your comfort zone and choose the service that best suits you.',
      title: 'Donate Food Effortlessly',
      image: 'assets/images/screen2.png'),
  OnBoardingModel(
      description:
          'Access the list of all donations on your fingertips and choose according to your needs',
      title: 'Find Donors Anywhere',
      image: 'assets/images/screen3.png')
];
