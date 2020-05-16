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
