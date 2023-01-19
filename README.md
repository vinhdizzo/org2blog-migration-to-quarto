# [Org2Blog](https://github.com/org2blog/org2blog) Migration to [Quarto](https://quarto.org/)

I used to have a Wordpress blog that I publish to using Org mode files via [Org2Blog](https://github.com/org2blog/org2blog) in Emacs.  This repo documents the migration of my blog from Org2Blog to [Quarto](https://quarto.org/) (and Org mode files to markdown files), where the generated static html files are hosted using the [nginx](https://nginx.org/en/) web server.

The goal is to simplify my setup: a static website served by nginx, and ease of publication without Emacs (via Quarto now).

## Assumptions

Old blog's information:
  - Blog URL domain: `http://blog.nguyenvq.com`
  - Blog post's URL format:
    + `http://blog.nguyenvq.com/blog/yyyy/mm/dd/my-post-title`
    + `http://blog.nguyenvq.com/yyyy/mm/dd/my-post-title/`
  - RSS feed: `http://blog.nguyenvq.com/feed/`

New blog's information:
  - Blog URL domain: `https://www.nguyenvq.com/blog/`
  - Blog post's URL format: `https://www.nguyenvq.com/blog/posts/yyyy-mm-dd-my-post-title/`
  - RSS feed: `https://www.nguyenvq.com/blog/index.xml`

## Steps for Migration

  - `Posts org-mode`: directory containing Org mode files; each file contains the content of a single blog post.  The filename is of the format `yyyy-mm-dd-my-post-title.org`.
  - `Code/01_Extract_blog_urls_from_posts.sh`: search for direct links of blog posts referenced in the Org files; will get a list of files as output.
  - `Mappings/manual_url_mapping.xlsx`: paste the links from previous into this Excel file.
  - `Code/02_Links_Mapping.R`: use R to construct all blog links from Org mode filenames.  The intent is to map all old URL's to new URL's for URL redirection (http return code of 301) in nginx.
    + `Mappings/blog_posts_url_mapping.csv`: mapping of URL's for all blog posts.
    + `Mappings/all_urls.csv`: combining both `blog_posts_url_mapping.csv` and `manual_url_mapping.xlsx`.
    + `Mappings/blog_oldnew.map`: mapping for URL redirection in ngninx.
  - `Code/03_Convert_org_to_md.sh`: Convert all Org mode files in `Posts org-mode` to markdown format using [pandoc](https://pandoc.org/).  New markdown files are stored in `Posts md`.
    + `yyyy-mm-dd-my-post-title.md`
  - `Code/04_Process_md_files.R`: use R to post-process the markdown files (reformatting certain things) and save them to `Posts final`.
    + `Posts final/yyyy-mm-dd-my-post-title/index.qmd`
  - In my `www.nguyenvq.com` Quarto folder, copy the content of `Posts final/*` to `blog/posts/*`.

## nginx setup and URL redirect

My nginx server is set up using docker via the [swag](https://github.com/linuxserver/docker-swag) image.

Copy `blog_oldnew.map` into `/config/nginx/blog_oldnew.map`.  Copy the content of the Quarto's rendered static website (in `_site`) to `/config/nginx/www.nguyenvq.com-site/`.

Content of `/config/nginx/site-confs/blog.nguyenvq.com`:
```
# map_hash_bucket_size 256; # see http://nginx.org/en/docs/hash.html
# VQN: above line needs to go in nginx.conf file since it uses map module there.
# https://w3guides.com/tutorial/nginx-could-not-build-map-hash-you-should-increase-map-hash-bucket-size-64

map $request_uri $new_uri {
    # include /etc/nginx/oldnew.map; #or any file readable by nginx
    include /config/nginx/blog_oldnew.map;
}

server {
    listen       80;
    server_name  blog.nguyenvq.com;

    if ($new_uri) {
       return 301 $new_uri;
    }
}
```

Content of `/config/nginx/site-confs/blog.nguyenvq.com`:
```
server {
  listen 443 ssl http2;
  server_name www.nguyenvq.com;

  # Specify SSL config if using a shared one.
  #include conf.d/ssl/ssl.conf;

  # all ssl related config moved to ssl.conf
  include /config/nginx/ssl.conf;

  # Allow large attachments
  client_max_body_size 128M;

  root /config/nginx/www.nguyenvq.com-site;
}
```

Modify `/config/nginx/nginx.conf` to specify `map_hash_bucket_size` since we have a lot of URL mappings:
```
...

http {
    # VQN: blog.nguyenvq.com url redirect
    map_hash_bucket_size 512; # VQN
...
```

Log into the swag nginx container (`docker exec -it swag_nginx bash`, where `swag_nginx` is the name of the container).  Then restart `ngingx`:
```
nginx -s reload
```