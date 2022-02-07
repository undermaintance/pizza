import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

void main() {
  runApp(const PizzaCalc());
}

class PizzaCalc extends StatefulWidget {
  const PizzaCalc({Key? key}) : super(key: key);

  @override
  _PizzaCalcState createState() => _PizzaCalcState();
}

enum Sauce { hot, sweet, cheese }

class _PizzaCalcState extends State<PizzaCalc> {
  bool _isSlim = false;
  double size = 25;
  int _cost = 300;
  Sauce? _sauce = Sauce.hot;
  bool _addCheese = false;

  int _calculate() {
    _cost = size.round() + 300;
    if (_addCheese == true) _cost += 35;
    if (_isSlim == true) _cost += 25;
    switch (_sauce) {
      case Sauce.hot:
        _cost += 35;
        break;
      case Sauce.sweet:
        _cost += 45;
        break;
      case Sauce.cheese:
        _cost += 30;
        break;
      case null:
        _sauce=Sauce.hot;
        break;
    }
    return _cost;
  }

  void _onSauceChange(Sauce? value) {
    setState(() {
      _sauce = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 232,
                  height: 123,
                  child: Image(
                    image: AssetImage('assets/pizza.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              const Text(
                "Калькулятор пиццы",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                "Выберите параметры:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 33),
              SizedBox(
                width: 300,
                child: SlidingSwitch(
                  value: false,
                  width: 300,
                  onChanged: (bool value) {
                    _isSlim = value;
                    setState(() {});
                  },
                  height: 34,
                  animationDuration: const Duration(milliseconds: 300),
                  onTap: () {},
                  onDoubleTap: () {},
                  onSwipe: () {},
                  textOff: "Обычное тесто",
                  textOn: "Тонкое тесто",
                  colorOn: const Color(0xFFFFFFFF),
                  colorOff: const Color(0xFFFFFFFF),
                  background: const Color(0xffE5E5E5),
                  buttonColor: const Color(0xff0079D0),
                  inactiveColor: const Color(0x40000000),
                ),
              ),
              const SizedBox(height: 45),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Размер:  $size  см",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: size,
                min: 25,
                max: 35,
                divisions: 2,
                label: '$size',
                onChanged: (value) {
                  size = value;
                  setState(() {});
                },
              ),
              const SizedBox(height: 13),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Соус:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              RadioListTile<Sauce>(
                title: const Text(
                  'Острый',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: Sauce.hot,
                groupValue: _sauce,
                onChanged: _onSauceChange,
                activeColor: const Color(0xFF5DB075),
              ),
              RadioListTile<Sauce>(
                title: const Text(
                  'Кисло-сладкий',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: Sauce.sweet,
                groupValue: _sauce,
                onChanged: _onSauceChange,
                activeColor: const Color(0xFF5DB075),
              ),
              RadioListTile<Sauce>(
                title: const Text(
                  'Сырный',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: Sauce.cheese,
                groupValue: _sauce,
                onChanged: _onSauceChange,
                activeColor: const Color(0xFF5DB075),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: 300,
                height: 56,
                child: Card(
                  elevation: 0,
                  color: const Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: SizedBox(
                          height: 34,
                          width: 36,
                          child: Image.asset('assets/img.png'),
                        ),
                      ),
                      const Text(
                        'Дополнительный сыр',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF263238),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Switch(
                        value: _addCheese,
                        onChanged: (bool value) {
                          setState(() {
                            _addCheese = value;
                            _calculate();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25),
                child: const Text('Стоимость:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 56,
                child: Card(
                  elevation: 0,
                  color: const Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_calculate()} руб.', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
