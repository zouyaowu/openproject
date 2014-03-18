#-- copyright
# OpenProject Reporting Plugin
#
# Copyright (C) 2010 - 2014 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#++

class CostQuery::Filter::UserId < Report::Filter::Base
  def self.label
    WorkPackage.human_attribute_name(:user)
  end

  def self.available_values(*)
    users = Project.visible.collect {|p| p.users}.flatten.uniq.sort
    values = users.map { |u| [u.name, u.id] }
    values.delete_if { |u| (u.first.include? "OpenProject Admin") || (u.first.include? "Anonymous")}
    values.sort!
    values.unshift ["<< #{::I18n.t(:label_me)} >>", User.current.id.to_s] if User.current.logged?
    values
  end
end
