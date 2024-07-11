import 'package:flutter/material.dart';

class AboutTheApplication extends StatelessWidget {
  const AboutTheApplication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Сёзлюк',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )
        ),
        const SizedBox(height: 10.0),
        const Text(
          'В приложении используются следующие словари:\nКарачаево-балкарско - русский словарь: около 30000 слов/Карачаево-Черкесский н.-и. инс-т ист., филол. и экономики; С.А. Гочияева, Х.И. Суюнчев; Под ред. Э.Р. Тенишева и Х.И. Суюнчева. - М.: Рус. яз., 1989. - 892 с.',
          style: TextStyle(
            fontSize: 18,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        const Image(
          image: AssetImage('assets/images/kbrtitle.png'),
          height: 210,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Русско - карачаево-балкарский словарь: около 35000 слов. Под ред. Х.И. Суюнчева и И.Х. Урусбиева. М. Сов. Энциклопедия, 1965. 744 стр. (Карачаево-Черкесский научно-исследовательский институт языка, литературы и истории).',
          style: TextStyle(
            fontSize: 18,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        const Image(
          image: AssetImage('assets/images/rkbtitle.png'),
          height: 210,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}