
require 'rainbow'
require 'yaml'

class User
  DATADIR="data"

  def initialize
    @profile = {}
    guest_username
    guest_hostname
    guest_locale
    load_saved_data
  end

  def data
    @profile
  end

  def filepath
    "#{DATADIR}/#{@profile[:username]}_#{@profile[:hostname]}.yaml"
  end

  def save
    @profile[:last_access] = Time.new
    @profile.delete :current_access
    File.open(filepath, 'w') {|f| f.write @profile.to_yaml }
  end

  private

  def guest_username
    username = `whoami`.chop
    @profile[:username] = username
    @profile[:cusername] = Rainbow(username).green.bright
  end

  def guest_hostname
    hostname = `hostname`.chop
    @profile[:hostname] = hostname
    @profile[:chostname] = Rainbow(hostname).green.bright
  end

  def guest_locale
    output = `locale|grep LANG`.chop
    locale = output.split("=")
    @profile[:locale] = locale[1]
  end

  def load_saved_data
    if File.exist?(filepath)
      @profile = YAML::load_file(filepath)
      @profile[:current_access] = Time.new
    else
      @profile[:last_access] = Time.new
      @profile[:current_access] = Time.new
      File.open(filepath, 'w') {|f| f.write @profile.to_yaml }
    end
  end
end
