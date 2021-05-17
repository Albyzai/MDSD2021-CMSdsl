/*
 * generated by Xtext 2.22.0
 */
package jonasmohr.mdsd2021.parser.antlr;

import jonasmohr.mdsd2021.parser.antlr.internal.InternalCMSdslParser;
import org.antlr.runtime.Token;
import org.antlr.runtime.TokenSource;
import org.eclipse.xtext.parser.antlr.AbstractIndentationTokenSource;

public class CMSdslTokenSource extends AbstractIndentationTokenSource {

	public CMSdslTokenSource(TokenSource delegate) {
		super(delegate);
	}

	@Override
	protected boolean shouldSplitTokenImpl(Token token) {
		// TODO Review assumption
		return token.getType() == InternalCMSdslParser.RULE_WS;
	}

	@Override
	protected int getBeginTokenType() {
		// TODO Review assumption
		return InternalCMSdslParser.RULE_BEGIN;
	}

	@Override
	protected int getEndTokenType() {
		// TODO Review assumption
		return InternalCMSdslParser.RULE_END;
	}

}