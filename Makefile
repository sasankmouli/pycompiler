
All:  clean compile

compile:
	jflex -d bin src/lex.lex
	java -jar bin/java-cup-11b.jar src/Parser.cup
	mv *.java bin/
	mkdir bin/parseBin
	javac -d bin/parseBin -cp bin/java-cup-11b-runtime.jar:. bin/*.java bin/python_program/*.java bin/python_program/expression/*.java bin/python_program/statement/*.java bin/python_program/operators/*.java 

clean:
	rm -rf bin/parseBin
	rm -f bin/*.java
	rm -f bin/*.class
	rm -f *.html
	rm -f bin/*.html
