import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: Colors.indigo.shade500,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Сёзлюк',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Text(
                'В приложении используются следующие словари:\nКарачаево-балкарско - русский словарь: около 30000 слов/Карачаево-Черкесский н.-и. инс-т ист., филол. и экономики; С.А. Гочияева, Х.И. Суюнчев; Под ред. Э.Р. Тенишева и Х.И. Суюнчева. - М.: Рус. яз., 1989. - 892 с.',
                style: TextStyle(fontSize: 18, height: 1, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Image(
                image: AssetImage('assets/images/kbrtitle.png'),
                height: 210,
              ),
              SizedBox(height: 10.0),
              Text(
                'Русско - карачаево-балкарский словарь: около 35000 слов. Под ред. Х.И. Суюнчева и И.Х. Урусбиева. М. Сов. Энциклопедия, 1965. 744 стр. (Карачаево-Черкесский научно-исследовательский институт языка, литературы и истории).',
                style: TextStyle(fontSize: 18, height: 1, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Image(
                image: AssetImage('assets/images/rkbtitle.png'),
                height: 210,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    ]);
  }
}