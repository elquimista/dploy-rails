require 'colored'
require 'net/ssh'

def print_step_description(description)
  puts ''
  puts '----->'.green + " #{description}"
end

def print_output_unless_blank(output)
  puts output unless output.strip.blank?
end

class WithInPath
  def initialize(path, ssh)
    @basepath = path
    @ssh = ssh
  end

  def run(&block)
    instance_eval &block
  end

  def exec!(command)
    @ssh.exec! %{cd #{@basepath} && #{command}}
  end
end

desc "Deploy to the production server"
task :deploy do
  domain = ENV['DEPLOY_DOMAIN']
  user = ENV['DEPLOY_USER']
  identity_file = ENV['DEPLOY_IDENTITY_FILE']
  path = ENV['DEPLOY_PATH']

  if [domain, user, identity_file, path].any? { |e| e.blank? }
    abort <<~TEXT
      One or more of the following environment variables are blank or not set at all.

      DEPLOY_DOMAIN
      DEPLOY_USER
      DEPLOY_IDENTITY_FILE
      DEPLOY_PATH

      Please make sure they are all set and non-blank.
    TEXT
  end

  Net::SSH.start(domain, user, keys: [identity_file]) do |ssh|
    WithInPath.new(path, ssh).run do
      pid = exec!(%{cat tmp/pids/puma.pid}).to_i
      break if pid <= 0

      print_step_description "Killing puma server process..."
      print_output_unless_blank exec!(%{kill -9 #{pid}})

      print_step_description "Pulling latest update from git remote..."
      print_output_unless_blank exec!(%{git pull})
      last_commit = exec!(%{git log -1 --oneline}).strip

      print_step_description "Running bundle install..."
      print_output_unless_blank exec!(%{bundle})

      print_step_description "Running database migration..."
      print_output_unless_blank exec!(%{bin/rails db:migrate})

      print_step_description "Running yarn install..."
      print_output_unless_blank exec!(%{yarn})

      print_step_description "Precompiling assets..."
      print_output_unless_blank exec!(%{yarn build})

      print_step_description "Starting Ruby on Rails application..."
      print_output_unless_blank exec!(%{yarn start})

      print_step_description "Done. Deployed to #{domain} (#{last_commit})"
    end
  end
end
