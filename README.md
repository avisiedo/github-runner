# github-runner

![lint](https://github.com/avisiedo/github-runner/workflows/lint/badge.svg)

Base image build to get started with github-runner container builds.

For building this image just run: `./helper.sh build --url YOUR_URL --token YOUR_TOKEN`

For running the runner just run: `./helper.sh run`

For running the linters locally just run:
`./helper.sh lint Dockerfile helper.sh README.md`

## References

- [Adding self-hosted runners](https://help.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners).
- [About self-hosted runners](https://help.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners).
- [GitHub Actions Runner](https://github.com/actions/runner).
- [GitHub Workflow Syntax](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions).
- [Build, Tag, Publish Docker](https://github.com/marketplace/actions/build-tag-publish-docker).
- [Creating a Docker container action](https://help.github.com/en/actions/building-actions/creating-a-docker-container-action).
- [Setting exit code for actions](https://help.github.com/en/actions/building-actions/setting-exit-codes-for-actions).
- [About actions](https://help.github.com/en/actions/building-actions/about-actions).
- [Configuring a Workflow](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow).
