require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :all
  
  it { should have_many(:posts) }
  it { should have_many(:dogs) }
  it { should have_many(:friendships) }
  it { should have_many(:friends) }
  it { should have_many(:posts, :dogs, :friendships, :friends) }
  
  it { should have_one(:address) }
  it { should have_one(:address, :dependent => :destroy) }
  
  it { should have_indices(:email, :name, [:email, :name]) }
  it { should have_index(:age) }
  
  it { should have_named_scope(:old, :conditions => "age > 50") }
  it { should have_named_scope(:eighteen, :conditions => { :age => 18 }) }

  it { should have_named_scope('recent(5)', :limit => 5) }
  it { should have_named_scope('recent(1)', :limit => 1) }
  it { should have_named_scope('recent_via_method(7)', :limit => 7) }

  describe "when given an instance variable" do
    before do
      @count = 2
    end
    it { should have_named_scope("recent(#{@count})", :limit => 2) }
  end
  
  it { should_not allow_values_for(:email, "blah", "b lah") }
  it { should allow_values_for(:email, "a@b.com", "asdf@asdf.com") }
  it { should ensure_length_in_range(:email, 1..100) }
  it { should ensure_value_in_range(:age, 1..100) }
  it { should protect_attributes(:password) }
  it { should have_class_methods(:find, :destroy) }
  it { should have_instance_methods(:email, :age, :email=, :valid?) }
  
  it { should have_db_columns(:name, :email, :age) }
  it { should have_db_column(:name) }
  it { should have_db_column(:id, :type => "integer", :primary => true) }
  it { should have_db_column(:email, :type => "string",  :default => nil,    :precision => nil,  :limit => 255,
                                          :null => true,      :primary => false,  :scale => nil,      :sql_type => 'varchar(255)') }
  
  it { should require_acceptance_of(:eula) }
  it { should require_unique_attributes(:email, :scoped_to => :name) }
  
  it { should ensure_length_is(:ssn, 9, :message => "Social Security Number is not the right length") }
  it { should only_allow_numeric_values_for(:ssn) }
  
  it { should have_readonly_attributes(:name) }
  
  it { should_not protect_attributes(:name, :age) }
end