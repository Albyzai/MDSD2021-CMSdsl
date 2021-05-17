package jonasmohr.mdsd2021.generator.server

import jonasmohr.mdsd2021.cMSdsl.ConnectionConfiguration
import jonasmohr.mdsd2021.cMSdsl.ServerDeclaration
import org.eclipse.xtext.generator.IFileSystemAccess2

class ServerConfigGenerator {
	
	val path = "config/"
	
	def generate(ConnectionConfiguration serverConfiguration, String basePath, IFileSystemAccess2 fsa){
		fsa.generateFile(basePath + path + 'config.json', serverConfiguration.compile)
	}
	
	
	def compile(ConnectionConfiguration connectionConfig)
	'''
	«IF connectionConfig !== null»
			{
				  "development": {
				  	«FOR decl: connectionConfig.config»
				  		«decl.compile»,
				  	«ENDFOR»
				  },
				  "test": {
				    «FOR decl: connectionConfig.config»
				    	 «decl.compile»,
				    «ENDFOR»
				  },
				  "production": {
				    «FOR decl: connectionConfig.config»
				    	«decl.compile»,
				   	«ENDFOR»
				  }
				}
		«ENDIF»
	
	'''
		
	
	def compile(ServerDeclaration d)
	'''
	
	'''

	
}