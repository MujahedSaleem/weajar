String getCarType(int seats) {
  switch (seats) {
    case 5:
      return 'Hatchback';
    case 4:
      return 'Coupe';
    case 3:
      return 'SUV';
    case 2:
      return 'Sedan';
    case 1:
      return 'Cross over';
  }
}
