desc "Starting our little bot"
task :default do
    sh %{ruby core.rb}
end
desc "Build our Docker Image"
task :buildDockerImage do
    sh %{docker build . -t robomegumin:0.0.1}
end
desc "And DESTROY our docker image"
task :removeDockerImage do
    sh %{docker rmi robomegumin:0.0.1}
end