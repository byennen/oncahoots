class AddInvitationIdtoMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :invitation_id, :integer
  end
end
