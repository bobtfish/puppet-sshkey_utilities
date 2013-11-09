require 'spec_helper'

test_rsa_priv = '-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAuSsfJz1oj2PzZQgEAae3l7/nDVhPKfizgi5t5R82C1HR6k48
uC0VBNODSDjo1Yd1mayO1J2q59nhzcCD6eeiZXPSMhDoTNTaWQwt8sP5ZmwdxSC0
vul1dOF+YR/m35ppUA6M51CS7pVucR5f82W+1Bzzwp0CoTiqRZgucZHmoBAm7WOK
oWZGRTQAForQo/1ySDJLLYhSAJ9R58tdU7rlOqq0x3b6/eF9vds0uTKoMjTwRKNW
OnHyZdY2g4j/S18rj5XOaJRvUHD9RKZzmvXMQDQksszQVLo3OOCla1BwPks8+K+r
vxlmM1DBawmhbM1v6Qk7Kn0QGraUWhXYvTjDXwIDAQABAoIBAAVGaDXK9w6Wr1li
eBK//2fwTJnBuUed0SdVQUY0tGpwI0XEgtBQYHfpuqS1ElT67eu50bvW3gaK23bs
FBX2xlaTjRpmBughbDL7ONfgo1s6m0KBYwTJS9JPljUYHpCiKnvgXj08u2LWmPXa
AqvBa0VJqdwScv+6yIcBBdmwaVyH7NwPm+X+qw346sE8kDQceJH4En/KQh4xCg9m
wm6+/agGcHGeSnbnnVzRSDURaUhjNhRBI24CSIce4KTD4/r2rK0UQGzfq1gQHhOx
BAwYmoJe6MmDGT8Ntl1kQyYfyimS1kYsHncWfNJqgFPF/CdZs3M2e43Qz3qqn9gx
PbMYxrkCgYEA3E8XV15+GA/6vn+FxxEY3CmqDMGyt4EBMifvDwYwQW24UC4jA9Ml
rUmH0j+nS2335+GwhhOTQL3WmOEnO2iDBnTYwZCJxBbpYmHLTezaP9bqIbgQnDOT
NO3gXdMnyCMkSukAOVudsuK5BUnHNXzYs3mG1l7J+pKTIXdOP22fLtUCgYEA1yqk
gpHyUguLJz38ecgAmiwn7CtI7sO+cw6XW6vSKRPS7bWcWkbVAeUV88Wyh7ZSW/cB
qkl2jCrkFljzSFzONVF1Z7x3yQQgnCV7nIvgOvdsaB1xGIw/W9Ena+Cz7fyTJx/y
0lfVqZe2fA7XwOecmKjVhPpFEyKoG/paMXdMi2MCgYEAm3NHUgO/z3S/BdnvaDZd
J0RS0+t9ElR5po1c9mn0dMZZrmHPnSxIwoxGxQjbH7M5oKm0J/b6CU2qdXcxeo7V
HSInq/Uz8GQGS8AbdyGwIimgTSiWt9EAhvFuRmXvBR4exqi/2rkVfhrSWLPlV41/
TqxqgyqhNChmns+TK9hK4P0CgYEAtoCw8R8hzn2EFlD5acI+4IY7hpJgVkUpsSXb
NCJVLApoir/UUq5p1iWdrRsvBvWafe7RNsMBDnsC5AGmuOYe8hKZ5tdxMsuRbWBN
rMbn9pwPE3CFkTDEPPj22wXJGD94AWOT7t4ZmLPaUPe2ASVzKflqwlQVatmmhbSf
8/0gq8kCgYBQIkKSZbJb18EAHgYmzvl9I/1hnyXcEXSyyeJaw4Lr87Wbd+PI7+vb
dXuWc9BR+NnQjRQ8YrfccAGxdwIUsG4yAX8J7ZXzRht7ofbHFBGj8zG/UJN0z8lj
Yxm+oZHYf6WY+qiy3XRI2Zoy7ZIoKz6zUKHmmiDJFmTbXp+pMHpg1g==
-----END RSA PRIVATE KEY-----
'

test_rsa_pub = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC5Kx8nPWiPY/NlCAQBp7eXv+cNWE8p+LOCLm3lHzYLUdHqTjy4LRUE04NIOOjVh3WZrI7Unarn2eHNwIPp56Jlc9IyEOhM1NpZDC3yw/lmbB3FILS+6XV04X5hH+bfmmlQDoznUJLulW5xHl/zZb7UHPPCnQKhOKpFmC5xkeagECbtY4qhZkZFNAAWitCj/XJIMkstiFIAn1Hny11TuuU6qrTHdvr94X292zS5MqgyNPBEo1Y6cfJl1jaDiP9LXyuPlc5olG9QcP1EpnOa9cxANCSyzNBUujc44KVrUHA+Szz4r6u/GWYzUMFrCaFszW/pCTsqfRAatpRaFdi9OMNf'

describe 'sshkey_public_key_from_private_key' do
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
    expect { subject.call([test_rsa_priv]) }.not_to raise_error()
  end
  it { should run.with_params(test_rsa_priv).and_return(test_rsa_pub) }
end

