# frozen_string_literal: true

module MyGit
  module Lint
    module Commits
      module Systems
        # Provides GitHub Action build environment feature branch information.
        class GitHubAction
          include MyGit::Lint::Import[:repository]

          def call = repository.commits("origin/#{repository.branch_default}..#{name}")

          private

          def name = "origin/#{repository.branch_name}"
        end
      end
    end
  end
end
