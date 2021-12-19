import 'dart:math';

class AppUtils {
  static int getRandomCardNumber() {
    Random random = new Random();
    int randomNumber = random.nextInt(79);

    return randomNumber;
  }
}
