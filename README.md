# A masterless Puppet control repository template

This is a template control repository that has the minimum amount of scaffolding to make it easy to setup r10k masterless Puppet control repository.

## Deploying this repository

1. Install Puppet Agent on your server
2. Install r10k gem
    ```
    /opt/puppetlabs/puppet/bin/gem install r10k
    ```
3. Edit r10k configuration
    ```yaml
    # /etc/puppetlabs/r10k/r10k.yaml
    :cachedir: '/var/cache/r10k'
    :sources:
      :control:
        remote: 'INSERT YOUR GIT REPOSITORY HERE'
        basedir: '/etc/puppetlabs/code/environments'
    ```
4. Deploy production environment and Puppetfile modules with r10k
    ```
    /opt/puppetlabs/puppet/bin/r10k deploy environment production --puppetfile --verbose
    ```
5. Apply production environment
    ```
    /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/site.pp --verbose
    ```

## References

* [Official Puppet control repository](https://github.com/puppetlabs/control-repo)
* [Puppet simple masterless (old)](https://github.com/cpilsworth/puppet-simple-masterless)
* [r10k quickstart guide](https://github.com/puppetlabs/r10k/blob/master/doc/dynamic-environments/quickstart.mkd)
* [About Hiera](https://puppet.com/docs/puppet/6.4/hiera_intro.html)
* [Roles and profiles](https://puppet.com/docs/pe/2018.1/designing_system_configs_roles_and_profiles.html)
