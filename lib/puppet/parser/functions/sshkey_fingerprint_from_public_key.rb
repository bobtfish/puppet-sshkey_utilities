module Puppet::Parser::Functions

  newfunction(:sshkey_fingerprint_from_public_key, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts an ssh public key into it's fingerprint string, using ssh-keygen

    ENDHEREDOC
    ) do |args|

    require 'tempfile'
    unless args.length == 1 then
      raise Puppet::ParseError, ("sshkey_fingerprint_from_public_key(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    f = Tempfile.new('puppet-sshkey_utils')
    f.write "#{arg.to_s}\n"
    f.close

    output = `ssh-keygen -lf #{f.path} 2>&1`

    if $?.exitstatus != 0
      raise Puppet::ParseError, ("#{arg.inspect} is not a valid ssh key, ssh-keygen exited with #{$?.exitstatus}: #{output} when given ssh key like: #{arg.to_s}")
    end

    output.split(' ')[1]
  end
end

