#---------------------------------------------------------------------------
# Copyright (c) Microsoft Open Technologies, Inc.
# All Rights Reserved.  Licensed under the Apache License, Version 2.0.
# See License.txt in the project root for license information.
#---------------------------------------------------------------------------

module VagrantPlugins
  module WinAzure
    module Action
      class WinProvision < Vagrant::Action::Builtin::Provision
        # Override the core vagrant method and branch out for windows
        def run_provisioner(env)
          # Raise an error if we're not on a Windows Host.
          # Non-Windows OS will be supported once we move to WinRb/WinRm
          env[:ui].info "Is Host OS Windows?: #{Vagrant::Util::Platform.windows?}"
          raise 'Unsupported OS for Windows Provisioning' unless \
            Vagrant::Util::Platform.windows?
          env[:ui].info "Provisioning for Windows"

          # TODO: Add Shell, Chef-solo and other provisioners
          case env[:provisioner].class.to_s
          when "VagrantPlugins::Shell::Provisioner"
            VagrantPlugins::WinAzure::Provisioner::Shell.new(
              env
            ).provision_for_windows
          when "VagrantPlugins::Puppet::Provisioner::Puppet"
            VagrantPlugins::WinAzure::Provisioner::Puppet.new(
              env
            ).provision_for_windows
          when "VagrantPlugins::Chef::Provisioner::ChefSolo"
            VagrantPlugins::WinAzure::Provisioner::ChefSolo.new(
              env
            ).provision_for_windows
          end
        end
      end
    end
  end
end
