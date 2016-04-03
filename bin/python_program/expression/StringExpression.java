package python_program.expression;

import python_program.Types;

public class StringExpression extends Expression {
	
	String value;
	
	public StringExpression(String value){
		this.value = value;
	}
	
	@Override
	public void print() {
		System.out.print(value);
	}

	@Override
	public Types getType() {
		return Types.int_type;
	}

	@Override
	public String translate() {
		return value;
	}
	
}
