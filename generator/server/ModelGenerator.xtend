package jonasmohr.mdsd2021.generator.server

import jonasmohr.mdsd2021.cMSdsl.Entity
import jonasmohr.mdsd2021.cMSdsl.Relationship
import jonasmohr.mdsd2021.cMSdsl.BelongsTo
import jonasmohr.mdsd2021.cMSdsl.BelongsToMany
import jonasmohr.mdsd2021.cMSdsl.HasOne
import jonasmohr.mdsd2021.cMSdsl.HasMany
import jonasmohr.mdsd2021.cMSdsl.Field

class ModelGenerator {
	
	
	def compileModel(Entity e) {
		'''
		'use strict';
		const uuidV4 = require('uuid').v4 
		
		const { Model } = require('sequelize');
		
		module.exports = (sequelize, DataTypes) => {
		
		  class «e.name.toFirstUpper» extends Model {
		    /**
		     * Helper method for defining associations.
		     * This method is not a part of Sequelize lifecycle.
		     * The `models/index` file will call this method automatically.
		     */
		    static associate({«IF e.relationship !== null» «e.relationship.entity.name.toFirstUpper» «ENDIF»}) {
		      // define association here
		      «IF e.relationship !== null» «e.relationship.compile»«ENDIF»
		    }
		  };
		
		  «e.name.toFirstUpper».init({
		  	
		    id: {
		      type: DataTypes.UUID,
		      primaryKey: true,
		      allowNull: false,
		      defaultValue: () => uuidV4()
		    },
		    «FOR f: e.model.fields»
		    	«f.compile»
		    «ENDFOR»
		  }, {
		    sequelize,
		    modelName: '«e.name.toFirstUpper»',
		  });
		  
		  return «e.name.toFirstUpper»;
		};
		'''
	}
	
		def compile(Relationship rel) {
			val type = rel.relationType
			switch(type) {
				BelongsTo: '''this.belongsTo(«rel.entity.name.toFirstUpper»)'''
				BelongsToMany: '''this.belongsToMany(«rel.entity.name.toFirstUpper»)'''
				HasOne: '''this.hasOne(«rel.entity.name.toFirstUpper»)'''
				HasMany: '''this.hasMany(«rel.entity.name.toFirstUpper»)'''
			}
	}
	
	def compile(Field f)'''
	
	'''
	
	def generateModelsIndexFile()'''
		'use strict'
		
		const fs = require('fs')
		const path = require('path')
		const Sequelize = require('sequelize')
		const basename = path.basename(__filename)
		const env = process.env.NODE_ENV || 'development'
		const config = require(__dirname + '/../config/config.json')[env]
		const db = {}
		
		let sequelize
		if (config.use_env_variable) {
		  sequelize = new Sequelize(process.env[config.use_env_variable], config)
		} else {
		  sequelize = new Sequelize(
		    config.database,
		    config.username,
		    config.password,
		    config
		  )
		}
		
		fs.readdirSync(__dirname)
		  .filter((file) => {
		    return (
		      file.indexOf('.') !== 0 && file !== basename && file.slice(-3) === '.js'
		    )
		  })
		  .forEach((file) => {
		    const model = require(path.join(__dirname, file))(
		      sequelize,
		      Sequelize.DataTypes
		    )
		    db[model.name] = model
		  })
		
		Object.keys(db).forEach((modelName) => {
		  if (db[modelName].associate) {
		    db[modelName].associate(db)
		  }
		})
		
		db.sequelize = sequelize
		
		module.exports = db
	'''
	
//		def dispatch compile(Field f)
//		'''
//		«f.name»: {
//			«FOR p: f.properties»
//				«p.compile»,
//			«ENDFOR»
//«««			«FOR p: f.property»
//«««				«p.compile»,
//«««			«ENDFOR»
//«««			«IF f.constraints !== null»
//«««				«FOR c: f.constraints.constraints»
//«««					«c.compile»,
//«««				«ENDFOR»
//«««			«ENDIF»
//			
//		},
//		'''
//	
}