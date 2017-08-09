module Express
  class Engine < ::Rails::Engine
    isolate_namespace Express
  end
end
