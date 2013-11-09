module Puppet::Parser::Functions

  newfunction(:sshkey_public_key_from_private_key, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts an ssh public key into it's fingerprint string, using ssh-keygen

    ENDHEREDOC
    ) do |args|

    require 'tempfile'
    unless args.length == 1 then
      raise Puppet::ParseError, ("sshkey_public_key_from_private_key(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end
    f = Tempfile.new('puppet-sshkey_utils')
    f.chmod 0400
    f.write "#{arg.to_s}\n"
    f.close
 
    truecmd = `which true`.chomp
    output=`sh -c 'SSH_ASKPASS=#{truecmd} DISPLAY=dummydisplay:0 setsid ssh-keygen -yf #{f.path}' </dev/null 2>&1`

    if $?.exitstatus != 0
      raise Puppet::ParseError, ("#{arg.inspect} is not a valid ssh key, ssh-keygen exited with #{$?.exitstatus}: #{output}")
    end

    output.split(' ')[1]
  end
end

