#
# Cookbook Name:: iptables-ng
# Recipe:: default
#
# Copyright 2013, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe 'iptables-ng::install'

# Apply rules from node attributes
node['iptables-ng']['rules'].each do |table, chains|
  chains.each do |chain, p|
    # policy is read only, duplicate it
    policy = p.dup

    # Apply rules
    policy.delete('default')
    policy.each do |name, rule|
      iptables_ng_rule "#{name}-#{table}-#{chain}-attribute-rule" do
        chain chain
        table table
        rule  rule
      end
    end
  end
end
