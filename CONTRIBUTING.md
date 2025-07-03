
This repo has been forked from https://github.com/alvarcarto/url-to-pdf-api as it seems the original author has given up the repository.
I also renamed it here because the original is too long, has too many hyphens and doesn't really reflect the project, since it can convert more than just a URL and can also convert to PNG, not just PDF :D
I'm very thankful for all the effort the original author put into this!


Goals of this fork:

- Keep security vulnerabilities at a minimum in https://github.com/andrepiske/webrender-api/security/code-scanning
- Keep the API backwards compatible
- Avoid feature creep
- Browser is installed in the docker image, version controlled. I have no intention of supporting dynamic browser versions
- Keep tests at a decent level

You're very welcome to contribute to this project! Just keep in mind the goals above.
Also, don't expect me to work on feature requests if you don't bring a Pull Request with you :)

# Running locally

You can run this locally by just running `node .` or you can build one of the docker images under the `docker/` path.

