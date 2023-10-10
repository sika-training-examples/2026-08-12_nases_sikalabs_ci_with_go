infracost comment gitlab \
  --gitlab-server-url https://gitlab.sikademo.com \
  --gitlab-token=5Q8kmmWNPafjBhod9kNA \
  --path=infracost.diff.out.json \
  --repo ondrejsika/tf \
  --commit b16cf09dd1c31e8c1768de1a0c95426dbd09424f

infracost comment gitlab \
  --gitlab-server-url https://gitlab.sikademo.com \
  --gitlab-token=7tMNgSABZLrgBLE8J7_2 \
  --path=infracost.diff.out.json \
  --repo ondrejsika/example \
  --merge-request ${CI_MERGE_REQUEST_ID}

infracost comment gitlab \
  --gitlab-server-url https://gitlab.sikademo.com \
  --gitlab-token=5Q8kmmWNPafjBhod9kNA \
  --path=infracost.diff.out.json \
  --repo ondrejsika/tf \
  --merge-request 1
