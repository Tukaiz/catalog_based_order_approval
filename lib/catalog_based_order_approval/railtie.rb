module CatalogBasedOrderApproval
  class Railtie < Rails::Railtie

    initializer "my_railtie.configure_rails_initialization" do |app|
      FeatureBase.register(app, CatalogBasedOrderApproval)
    end

    config.after_initialize do
      FeatureBase.inject_feature_record("Catalog Based Order Approvals",
        "CatalogBasedOrderApproval",
        "This will enable catalog based order approvals."
      )
      FeatureBase.inject_permission_records(
        CatalogBasedOrderApproval,
        CatalogBasedOrderApprovalFeatureDefinition.new.permissions
      )
    end

  end
end
