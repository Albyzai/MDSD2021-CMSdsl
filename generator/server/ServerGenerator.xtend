package jonasmohr.mdsd2021.generator.server

import jonasmohr.mdsd2021.cMSdsl.Project
import org.eclipse.xtext.generator.IFileSystemAccess2
import jonasmohr.mdsd2021.cMSdsl.Entity
import javax.inject.Inject

class ServerGenerator {
	
	val path = "server/"
	@Inject extension ControllerGenerator
	@Inject extension ServerConfigGenerator
	
	def generateServer(Project project, IFileSystemAccess2 fsa){
		val entities = project.entities
		val config = project.serverConfig
		
		fsa.generateFile(path + "index.js", entities.generateServerIndexFile)
		config.generate(path, fsa)
		entities.generateControllers(path, fsa)
	}
	
	def generateServerIndexFile(Entity[] entities)'''
		const express = require('express')
		const { sequelize } = require('./models')
		const app = express()
		
		const main = async () => {
		  await sequelize.sync()
		}
		
		main()
		
		app.use(express.json())
		app.use(express.urlencoded({extended: true}))
		
		«FOR e: entities»
			app.use('/«e.name.toFirstLower»', require('./routes/«e.name.toFirstLower»'))
		«ENDFOR»
		
		const PORT = process.env.PORT || 5000
		
		app.listen(PORT, console.log('Server started on port 5000'))
	'''
	
}