#sshkey_utilities

[![Build Status](https://travis-ci.org/bobtfish/puppet-sshkey_utilities.png)

####Table of Contents

1. [Overview](#overview)
5. [Reference - Functions included](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Provides funcions for manipulating ssh private and public keys from strings.

If you want to work on ssh keys in files then you can use the built in _file()_
function to read them in, or my enhanced [better_file module](http://forge.puppetlabs.com/bobtfish/better_file)

##Reference

### sshkey_fingerprint_from_public_key

Takes the public key text as a parameter and returns the key fingerprint.

For example:

    $public_key = file('/etc/ssh/host_rsa_key.pub')
    $fingerprint = sshkey_fingerprint_from_public_key($public_key)

### sshkey_public_key_from_private_key

Generates and returns the public key corresponding to a given private key, the text of which should be supllied as a parameter.

The private key must not have a passphrase.

For example:

    $private_key = file('/etc/ssh/host_rsa_key')
    $public_key = sshkey_public_key_from_private_key($private_key)

##Limitations

This module should be compatible with any POSIX system which ships a 'setsid' command.

If your unix doesn't (*cough*Apple*cough*) then see here: https://github.com/jerrykuch/ersatz-setsid

##Development

Patches welcome! Please send pull requests or suggestions on github.

