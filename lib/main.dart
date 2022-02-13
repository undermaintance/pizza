
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'theme/config.dart';
import 'theme/custom_theme.dart';

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
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }
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
        _sauce = Sauce.hot;
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
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: Scaffold(
        body: Column(
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
              height: 23,
            ),
            const Text("Калькулятор пиццы",
                textAlign: TextAlign.center,style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
            const SizedBox(height: 9),
            const Text("Выберите параметры:",
                textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),),
            const SizedBox(height: 10),
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
                colorOn: Colors.white,
                colorOff: Colors.white,
                buttonColor: Colors.blue,
                background: Colors.black12
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Размер:  ${size.round()}  см",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),),
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
            const SizedBox(height: 10),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Соус:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            RadioListTile<Sauce>(
              title:
                  const Text('Острый', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              value: Sauce.hot,
              groupValue: _sauce,
              onChanged: _onSauceChange,
            ),
            RadioListTile<Sauce>(
              title: const Text('Кисло-сладкий',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              value: Sauce.sweet,
              groupValue: _sauce,
              onChanged: _onSauceChange,
            ),
            RadioListTile<Sauce>(
              title:
                  const Text('Сырный', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              value: Sauce.cheese,
              groupValue: _sauce,
              onChanged: _onSauceChange,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 56,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        height: 34,
                        width: 36,
                        child: Image.asset('assets/img.png'),
                      ),
                    ),
                    const Text('Дополнительный сыр', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    Switch(
                      activeColor: Colors.yellowAccent,
                      inactiveThumbColor: Colors.black45,
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
              child: const Text('Стоимость:',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
            ),
            SizedBox(
              width: 300,
              height: 56,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_calculate()} руб.',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text ('Темная тема'),
                IconButton(
                  icon: const Icon(Icons.dark_mode),
                  color: Theme.of(context).colorScheme.secondary,
                  tooltip: 'Темная тема',
                  onPressed: () => currentTheme.toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
