# frozen_string_literal: true

require "spec_helper"
require "my_git/lint/rake/tasks"

RSpec.describe MyGit::Lint::Rake::Tasks do
  subject(:tasks) { described_class.new shell: }

  let(:shell) { instance_spy MyGit::Lint::CLI::Shell }

  before { Rake::Task.clear }

  describe ".setup" do
    it "installs rake tasks" do
      described_class.setup
      expect(Rake::Task.tasks.map(&:name)).to contain_exactly("git_lint")
    end
  end

  describe "#install" do
    before { tasks.install }

    it "executes --analyze option via git_lint task" do
      Rake::Task["git_lint"].invoke
      expect(shell).to have_received(:call).with(["--analyze"])
    end
  end
end
