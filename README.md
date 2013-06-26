# Mirror
## Description
A cookbook that manages different types of repository mirrors. The goals
were originally to just create a SSH repository mirror. It became clear
that cloning a repository completely wasn't effective when you need
nodes to come up quickly for testing. A mirror-server will run the
`mirror::server` role which will allow repositories to be cloned through
SSH for git or hg and allow tarballs to be downloaded for specific
branches. A repository called 'foo' that was marked for tarring on the
master and develop branches have two tarballs created one named
"foo-master.tgz" and one called "foo-develop.tgz".

## Requirements
### Platform
* Mac OS X (Tested on 10.8 Mountain Lion)
* Ubuntu (Tested on 12.04 )

## Attributes
* `node[:mirror][:repositories]`
* `node[:mirror][:repository_path]`

## Usage
Override `node[:mirror][:repositories]` and include
`mirror::{default,server,client}` in your run list.

The ruby format would be:

```ruby
{
  :'chef-repo' => {
    :repository => 'https://github.com/rapid7/chef-repo',
    :reference => 'HEAD',
  }
}
```

### mirror::default
If using Chef Client `mirror::default` will search for a node with the
`mirror-server` role. If using Chef Solo the node will be converged as
a `mirror-server`.

### mirror::client
Installs SCM tools such as git and mercurial. In addition your node
attributes are updated to include a `mirror-server` to clone from. This
comes in handy when there's a large repository that must download from a
remote repository and you can just use the following to clone from your
local mirror:

```ruby
  source "#{node[:mirror][:local] || 'https://example.org'}/foo.git"
```

### mirror::server

## License and Author
### Authors
* Erran Carey (erran_carey@rapid7.com)
