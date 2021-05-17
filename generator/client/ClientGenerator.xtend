package jonasmohr.mdsd2021.generator.client

import jonasmohr.mdsd2021.cMSdsl.Project
import org.eclipse.xtext.generator.IFileSystemAccess2

class ClientGenerator {
	
		val path = "client/"
	
		def generateClient(Project project, IFileSystemAccess2 fsa) {
			fsa.generateFile(path + "public/index.js", project.name.generateClientIndexFile)
		}
	
		def generateClientIndexFile(String projectName)'''
		<!DOCTYPE html>
		<html lang="en">
		  <head>
		    <meta charset="utf-8" />
		    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
		    <meta name="viewport" content="width=device-width, initial-scale=1" />
		    <meta
		      name="description"
		      content="Website created using CMS DSL"
		    />
		    <title>«projectName» CMS</title>
		  </head>
		  <body>
		    <div id="root"></div>
		  </body>
		</html>	
	'''
}