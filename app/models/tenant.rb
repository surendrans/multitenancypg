class Tenant < ActiveRecord::Base

	# attr_accessible :subdomain
	after_create :create_schema


	def create_schema
		c = Tenant.connection
		c.execute("create schema tenant#{id}")
			scope_schema do
				load Rails.root.join("db/schema.rb")
				c.execute("drop table #{self.class.table_name}")
			end
	end


	def scope_schema *paths
		p paths,"-------------------"
		p ["tenant#{id}", *paths].join(",")
		original_search_path = Tenant.connection.schema_search_path
		Tenant.connection.schema_search_path  = ["tenant#{id}", *paths].join(",")
		yield
	ensure
		Tenant.connection.schema_search_path  = original_search_path
	end


end
