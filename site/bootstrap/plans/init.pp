plan bootstrap (
  TargetSpec $nodes,
  String     $deploy_env = 'production',
) {

  # Install the puppet-agent package if Puppet is not detected
  # Copy over custom facts from the Bolt modulepath
  # Run the `facter` command line tool to gather node information
  $nodes.apply_prep

  # Apply necessary configs before deploying Puppet
  apply($nodes) {
    include bootstrap::config
  }.first.message.notice

  # Install r10k
  $r10k_install = run_command(
    "echo -e '\\e[0m'; /opt/puppetlabs/puppet/bin/gem install r10k",
    $nodes,
    '_catch_errors' => true,
  )

  notice($r10k_install.first.value['stdout'])
  if (!$r10k_install.ok) { fail_plan('Bootstrap task encountered an error during r10k installation.') }

  # Deploy environment with r10k and apply Puppetfile
  $r10k_deploy = run_command(
    "echo -e '\\e[0m'; /opt/puppetlabs/puppet/bin/r10k deploy environment ${$deploy_env} --puppetfile --verbose info 2>&1",
    $nodes,
    '_catch_errors' => true,
  )

  notice($r10k_deploy.first.value['stdout'])
  if (!$r10k_deploy.ok) { fail_plan('Bootstrap task encountered an error during r10k deployment.') }

  # Apply the environment with Puppet
  $puppet_apply = run_command(
    "echo -e '\\e[0m'; /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/${$deploy_env}/site.pp --verbose 2>&1",
    $nodes,
    '_catch_errors' => true,
  )

  notice($puppet_apply.first.value['stdout'])
  if (!$puppet_apply.ok) { fail_plan('Bootstrap task encountered an error during Puppet application.') }

}
