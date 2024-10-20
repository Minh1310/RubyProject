class Person 
    include ActiveModel::Attributes
    include ActiveModel::API
    include ActiveModel::Dirty
    extend ActiveModel::Naming
    attr_accessor :name, :active
    attribute :isName, :boolean
    attribute :date_of_birth, :date
    attribute :numberId, :integer

    attr_accessor :first_name, :last_name
    define_attribute_methods :first_name, :last_name

    def call_date(param)
        self.date_of_birth = param
        self.date_of_birth
    end
    
end
