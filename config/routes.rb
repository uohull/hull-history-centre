Rails.application.routes.draw do
  
  root :to => "catalog#index"
  
  # Original route config for 'catalog' spelling
  # blacklight_for :catalog

  # New route config based on hyhull example
  # We want to override the the Blacklight catalog route to direct to 'resources' 
  Blacklight.add_routes(self, except: [:catalog, :solr_document])
  # We don't add the Blacklight catalog/solr_document routes so that...
  # ... we can override url route with 'resources'..
  match 'resources/opensearch', to: 'catalog#opensearch',  as: 'opensearch_catalog', via: :get
  match 'resources/facet/:id', to: 'catalog#facet', as: 'catalog_facet', via: :get
  match 'resources', to: 'catalog#index', as: 'catalog_index', via: :get
  resources :solr_document,  path: 'resources', controller: 'catalog', only: [:show, :update] 
  resources :catalog, path: 'resources', controller: 'catalog', only:  [:show, :update]
  # End of catalog/solr_document overides
end
