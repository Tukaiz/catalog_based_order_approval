require "catalog_based_order_approval/version"

module CatalogBasedOrderApproval
  class CatalogBasedOrderApprovalFeatureDefinition
    include FeatureSystem::Provides

    def permissions
      [
        {
          can: true,
          callback_name: 'can_approve_catalog_based_order_holds',
          name: 'Can Approve Catalog Based Order Approvals'
        },
        {
          can: true,
          callback_name: 'can_bypass_order_approvals',
          name: 'Can bypass Order Approvals'
        }
      ]
    end
  end
  module Authorization
    module Permissions

      def can_bypass_order_approvals
        can :bypass_order_approvals, Order
      end

      def can_approve_catalog_based_order_holds
        ids = @user.claims.for_site(@site).pluck(:id)

        ## Can view the approvals section
        can :view_order_approval_section, Order

        ## Can read any order for which there is at least 1 order_hold that needs approval
        can :read, Order, id: Order.for_approvals(ids).pluck(:id)

        ## They can approve any order_holds for which they are a member
        can :manage, OrderHold, claim_id: ids
      end

    end
  end
end


require 'catalog_based_order_approval/railtie' if defined?(Rails)
