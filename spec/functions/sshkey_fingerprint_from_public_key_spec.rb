require 'spec_helper'

describe 'sshkey_fingerprint_from_public_key' do
  test_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSgeWBAUL3HT9bbJ3lQEluVFN27smFdm6D2skGFVHM1KbJb3Em72KEVOK/vxopcQ3tAPhJBFfg64c11BkXwtTXfW3qoi4IcwUOWfqO//RcadBxUf58QaaNOlgvCa9RznbQ86dfCytL7H+67WdnRt9UPNpX31Gd9drN2Q8Zhetd3rjdb/BTUVGUXZdlsUGmSO5F+CQhYbg9hwVnSO7a/cjwadLR/3cB0vBg59nfJMeybzHkakW2sdeIq/apG7JZ5aP+AacG69Ym5DHbIzc2jXzPvjQA0Y6hOEB6q3jPdgg2968LIThiVEZGzN8dDTGyllXnEVcsQrGehjLRYyWZt0m7mtZFzs1RtcOR5//S4yRHBwmZNWW0wBq6Ln9ZF05Uuc7dTUBV8asvK0nygA+czw35632s6RWf93hHYV84iL+88lIIjWdCm75wF0GqguccU6R+j9dLIA/bZjH3PEUwNn1/qHXyVGZSu5Flluhp48Sb3h2dLnor8ienFw0I3cP52SG00jtyBIsZU6kavTVRx5rFN0iqdR9W/ICN1AYsP9WGtP4MvsYzbPoXBau7UrvARWShr3q/KRiLMQHHTTR3QkIDimwhqi72ECxb4GQ766AqqA2PYqCYMZD4wY+SdcW0D9YAbxqgVSVnCGfmdmm3av7R89zwuzxCQFXg+voJXMg7eQ=='
  test_fingerprint = 'd3:15:57:fb:34:9d:52:ac:bc:76:77:e0:5c:2d:cf:ca'

  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given something ssh-keygen does not like' do
    expect { subject.call(['foo']) }.to raise_error(Puppet::ParseError)
  end
  it 'should work if given a real key' do
    expect { subject.call([test_key]) }.not_to raise_error()
  end
  it { should run.with_params(test_key).and_return(test_fingerprint) }
end

