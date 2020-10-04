//import 'package:string_mask/string_mask.dart';

class Memory {
  String _value = '0';

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;

  String _operation;
  static const operations = const ['%', '÷', 'x', '-', '+', '='];
  bool _wipeValue = false;

  String _lastCommand;

  //AC
  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  _addDigit(String digit) {
    final isComma = digit == ',';
    final wipeValue = (_value == '0' && !isComma) || _wipeValue;
    final emptyValue = isComma ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;

    bool isNegativo = _value.contains('-'); //verifica se o numero é negativo

    if (isComma && _value.contains(',') && !wipeValue) {
      return;
    }

    _value = currentValue + digit;

    digit = isComma ? '.' : digit; //substitui pelo dot

    final value = currentValue.replaceAll(',', '.') + digit;

    _wipeValue = false;

    _buffer[_bufferIndex] = isNegativo 
    ? double.tryParse(value) * -1 ?? 0 :
      double.tryParse(value);
  }

  //inverte os valores entre positivo e negativo
  _invert() {
    final value = (double.tryParse(_value) * -1).toString();
    final string = value.endsWith('.0') ? value.split('.')[0] : value;
    _value = string;
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '='; //verifica igual

    if (_bufferIndex == 0 && !isEqualSign) {
      _operation = newOperation;
      _bufferIndex = 1; //passa para o segundo item
      //_wipeValue = true;
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0; //zera o segundo parametro
      _value = _buffer[0].toString();

      //retirar o .0 do double
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      _value = _value.replaceAll('.', ',');

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

    _wipeValue = true; //!isEqualSign;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return (_buffer[0] / 100) * _buffer[1]; //módulo
      case '÷':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

//testa se digitou 2 operações em seguida
//substituindo pela ultima operação
  _isReplaceOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  String get value => _value;

  void applyCommand(String command) {
    if (_isReplaceOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC' || command == 'C') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else if (command == '+/-' && _value != '0'){
      _invert();
    } else if (_value.length >= 11 && command != '+/-') {
      _value = _value;
    } else if(command != '+/-'){
      _addDigit(command);
    }

    _lastCommand = command;
  }
}
