Como usar:
	execute o programa eliza.sh
	quando o programa der um prompt "> ", digite uma mensagem
	o programa só tem respostas preparadas pras palavras presentes em "keywords.txt"

O problema:
	no momento, o código imprime tudo que o usuário digita, com pesos e a palavra mais importante
	entretanto, toda vez que o usuário digita uma palavra em keywords que é seguida de um /n, ou seja, todas exceto a última, o shell trata ela como não-inteiro e fica incapacitado de executar a comparação -gt

Exemplos:
	Boa tarde!
	> oi
	KW: oi;1
	Weight: 1
	Highest: 0
	: integer expression expected
	Peso menor



	Boa tarde!
	> oi
	KW: oi;1
	Weight: 1
	Highest: 0
	: integer expression expected
	Peso menor
	> bolo eu quero bolo
	KW: bolo;2
	Weight: 2
	Highest: 0
	: integer expression expected
	Peso menor
	KW:
	KW: quero;3
	Weight: 3
	Highest: 0
	: integer expression expected
	Peso menor
	KW: bolo;2
	Weight: 2
	Highest: 0
	: integer expression expected
	Peso menor