# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Infusible::Stub

  let(:configuration) { MyGit::Lint::Configuration::Loader.with_defaults.call }
  let(:environment) { Hash.new }
  let(:kernel) { class_spy Kernel }

  let :logger do
    Cogger::Client.new Logger.new(StringIO.new),
                       formatter: -> _severity, _name, _at, message { "#{message}\n" }
  end

  before { MyGit::Lint::Import.stub configuration:, environment:, kernel:, logger: }

  after { MyGit::Lint::Import.unstub :configuration, :environment, :kernel, :logger }
end
