## Description
<!-- What does this PR do? -->

## Type of change
- [ ] Version upgrade
- [ ] Bug fix
- [ ] Workflow change
- [ ] Documentation update

## Testing
<!-- How did you test this change? -->
```bash
docker build -t test-adminer .
docker run --rm -p 127.0.0.1:8080:8080 test-adminer
```

## Checklist
- [ ] I have tested the Docker build locally
- [ ] Adminer, PHP and the entrypoint are still the official image's
- [ ] No unrelated changes are included
