require 'spec_helper'

shared_examples_for "all execution environments" do
  it 'gets the database username' do
    EY::Metadata.database_username.should == 'FAKE_SSH_USERNAME'
  end

  it 'gets the database name' do
    EY::Metadata.database_name.should == 'FAKE_APP_NAME'
  end

  it 'gets the database host' do
    EY::Metadata.database_host.should == 'FAKE_DB_MASTER_PUBLIC_HOSTNAME'
  end

  it 'gets the ssh username' do
    EY::Metadata.ssh_username.should == 'FAKE_SSH_USERNAME'
  end
  
  it 'gets the app server hostnames' do
    EY::Metadata.app_servers.should == [ 'app_1.compute-1.amazonaws.com' , 'app_master.compute-1.amazonaws.com' ]
  end

  it 'gets the db server hostnames' do
    EY::Metadata.db_servers.should == [ 'FAKE_DB_MASTER_PUBLIC_HOSTNAME', 'db_slave_1.compute-1.amazonaws.com' ]
  end

  it 'gets the utilities hostnames' do
    EY::Metadata.utilities.should == [ 'FAKE_UTIL_1_PUBLIC_HOSTNAME' ]
  end

  it 'gets the app master hostname' do
    EY::Metadata.app_master.should == 'app_master.compute-1.amazonaws.com'
  end

  it 'gets the db master hostname' do
    EY::Metadata.db_master.should == 'FAKE_DB_MASTER_PUBLIC_HOSTNAME'
  end

  it 'gets the db slave hostnames' do
    EY::Metadata.db_slaves.should == [ 'db_slave_1.compute-1.amazonaws.com' ]
  end

  it 'gets the app slave hostnames' do
    EY::Metadata.app_slaves.should == [ 'app_1.compute-1.amazonaws.com' ]
  end

  it 'gets the solo hostname' do
    EY::Metadata.solo.should == nil
  end

  it 'gets the environment name' do
    EY::Metadata.environment_name.should == 'FAKE_ENVIRONMENT_NAME'
  end
  
  it 'gets the stack name' do
    EY::Metadata.stack_name.should == 'FAKE_STACK_NAME'
  end
end

describe 'EY::Metadata' do
  describe "being executed from a developer/administrator's local machine" do
    before(:all) do
      pretend_we_are_on_a_developer_machine
      # forcibly reload metadata.rb, so that it can extend itself based on its execution environment
      load File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'engineyard-metadata', 'metadata.rb'))
    end

    after(:all) do
      stop_pretending
    end
    
    it 'cannot get the present instance ID' do
      lambda {
        EY::Metadata.present_instance_id
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end

    it 'cannot get the present instance role (as a string)' do
      lambda {
        EY::Metadata.present_instance_role
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end
    
    it 'cannot get the present public hostname' do
      lambda {
        EY::Metadata.present_public_hostname
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end
    
    it 'cannot get the present security group' do
      lambda {
        EY::Metadata.present_security_group
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end

    it 'cannot get the database password' do
      lambda {
        EY::Metadata.database_password
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end

    it 'cannot get the ssh password' do
      lambda {
        EY::Metadata.ssh_password
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end
    
    it 'cannot get the mysql command' do
      lambda {
        EY::Metadata.mysql_command
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end
    
    it 'cannot get the mysqldump command' do
      lambda {
        EY::Metadata.mysqldump_command
      }.should raise_error(EY::Metadata::CannotGetFromHere)
    end
    
    it 'gets the raw EngineYard Cloud API data' do
      EY::Metadata.engine_yard_cloud_api.data.should be_a(Hash)
    end

    it_should_behave_like "all execution environments"
  end
  
  describe "being executed on an EngineYard AppCloud (i.e. Amazon EC2) instance" do
    before(:all) do
      pretend_we_are_on_an_engineyard_appcloud_ec2_instance
        # forcibly reload metadata.rb, so that it can extend itself based on its execution environment
      load File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'engineyard-metadata', 'metadata.rb'))
    end
    
    after(:all) do
      stop_pretending
    end
    
    it_should_behave_like "all execution environments"
    
    it 'has a FakeFS dna.json' do
      File.exist?('/etc/chef/dna.json').should == true
    end
    
    it 'gets the present instance ID' do
      EY::Metadata.present_instance_id.should == PRESENT_INSTANCE_ID
    end

    it 'gets the present instance role (as a string)' do
      EY::Metadata.present_instance_role.should == 'app_master'
    end

    it 'gets the present public hostname' do
      EY::Metadata.present_public_hostname.should == PRESENT_PUBLIC_HOSTNAME
    end

    it 'gets the present security group' do
      EY::Metadata.present_security_group.should == PRESENT_SECURITY_GROUP
    end
    
    it 'gets the database password' do
      EY::Metadata.database_password.should == 'USERS-0-PASSWORD'
    end
    
    it 'gets the ssh password' do
      EY::Metadata.ssh_password.should == 'SSH-PASSWORD'
    end
    
    it 'gets the mysql command' do
      EY::Metadata.mysql_command.should =~ %r{mysql -h FAKE_DB_MASTER_PUBLIC_HOSTNAME -u FAKE_SSH_USERNAME -pUSERS-0-PASSWORD FAKE_APP_NAME}
    end

    it 'gets the mysqldump command' do
      EY::Metadata.mysqldump_command.should =~ %r{mysqldump -h FAKE_DB_MASTER_PUBLIC_HOSTNAME -u FAKE_SSH_USERNAME -pUSERS-0-PASSWORD FAKE_APP_NAME}
    end
  end
end
