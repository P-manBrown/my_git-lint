# frozen_string_literal: true

RSpec.shared_context "with commit system dependencies" do
  using Infusible::Stub

  include_context "with application dependencies"

  let(:repository) { instance_spy GitPlus::Repository, branch_default: "main", branch_name: "test" }
  let(:executor) { class_spy Open3 }

  before { MyGit::Lint::Import.stub repository:, executor: }

  after { MyGit::Lint::Import.unstub :repository, :executor }
end
