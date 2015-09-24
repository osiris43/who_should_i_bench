group :specs, halt_on_fail: true do
  guard :rspec, cmd: "bundle exec rspec" do
    require "guard/rspec/dsl"
    dsl = Guard::RSpec::Dsl.new(self)

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_files)
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }

    # Ruby files
    dsl.watch_spec_files_for(dsl.ruby.lib_files)

    watch(%r{^(lib/guard/rspec/template)s/Guardfile$}) do
      rspec.spec.("lib/guard/rspec/template")
    end

    watch(%r{^lib/guard/rspec/dsl.rb$}) do
      rspec.spec.("lib/guard/rspec/template")
    end

    # Rails files
    watch('spec/spec_helper.rb')                        { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  end

  #guard :rubocop, all_on_start: false do
  #  watch(%r{.+\.rb$})
  #  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  #end
end
