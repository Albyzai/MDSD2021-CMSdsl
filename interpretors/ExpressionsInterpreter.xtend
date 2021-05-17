package jonasmohr.mdsd2021.interpretors

import jonasmohr.mdsd2021.cMSdsl.Disjunction
import jonasmohr.mdsd2021.cMSdsl.Conjunction
import jonasmohr.mdsd2021.cMSdsl.Comparison
import jonasmohr.mdsd2021.cMSdsl.Add
import jonasmohr.mdsd2021.cMSdsl.Sub
import jonasmohr.mdsd2021.cMSdsl.Mul
import jonasmohr.mdsd2021.cMSdsl.Div
import jonasmohr.mdsd2021.cMSdsl.CompOp
import jonasmohr.mdsd2021.cMSdsl.Eq
import jonasmohr.mdsd2021.cMSdsl.Gt
import jonasmohr.mdsd2021.cMSdsl.Lt
import jonasmohr.mdsd2021.cMSdsl.Lteq
import jonasmohr.mdsd2021.cMSdsl.Gteq

class ExpressionsInterpreter {
	
	def dispatch CharSequence generateLogic(Disjunction x)'''(«x.left.generateLogic»||«x.right.generateLogic»)'''
	
	def dispatch CharSequence generateLogic(Conjunction x) '''(«x.left.generateLogic»&&«x.right.generateLogic»)'''
	def dispatch CharSequence generateLogic(Comparison x) '''(«x.left.generateExp»«x.op.generateOperator»«x.right.generateExp»)'''

	def dispatch CharSequence generateExp(Add x) '''(«x.left.generateExp»+«x.right.generateExp»)'''
	def dispatch CharSequence generateExp(Sub x) '''(«x.left.generateExp»-«x.right.generateExp»)'''
	def dispatch CharSequence generateExp(Mul x) '''(«x.left.generateExp»*«x.right.generateExp»)'''
	def dispatch CharSequence generateExp(Div x) '''(«x.left.generateExp»/«x.right.generateExp»)'''
	
	def generateOperator(CompOp op) {
		switch op {
			Eq: '=='
			Lt: '<'
			Gt: '>'
			Lteq: '<='
			Gteq: '>='
			default: throw new Error("Invalid operator input")
		}
	}
}