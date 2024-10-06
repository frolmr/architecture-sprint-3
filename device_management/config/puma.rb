workers 3
preload_app!

port ENV.fetch("PORT") { 8000 }
