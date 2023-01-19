# Goal: create an old_url <-> new_url mapping for posts from blog for url re-direct in new platform

setwd('G:/My Drive/Documents/Web/org2blog migrate to quarto')

# Need
library(dplyr)
library(stringr)
library(RCurl)
library(readxl)
library(readr)

# Variables
#path_blog_dir <- '../blog-snc-org/entries'
path_blog_dir <- './Posts org-mode'
old_url_prefix <- 'http://blog.nguyenvq.com/blog'
new_url_prefix <- 'https://www.nguyenvq.com/blog/posts'
new_relative_url_prefix <- '..'

# Excel
d_man <- read_excel('Mappings/manual_url_mapping.xlsx')

url_valid_flag <- url.exists(d_man$old_url)
sum(!url_valid_flag)
d_man$old_url[!url_valid_flag]

## dd-wrt tag url ok
## add following two links map to following 2 in manual mapping
## from: http://blog.nguyenvq.com/2010/07/23/705/
## from: http://blog.nguyenvq.com/blog/2010/07/24/705/
## to: https://www.nguyenvq.com/posts/2010-07-24-migrating-back-to-linux-ubuntu-from-mac-os-x/

## rename: 2010-07-24-705.org
## to: 2010-07-24-migrating-back-to-linux-ubuntu-from-mac-os-x.org

# Get list of files
org_files <- dir(path_blog_dir)
org_files <- org_files[str_detect(org_files, 'org$')]

# Create old url to new url lookup from filename
d_url <- tibble(org_files) %>%
  mutate(yyyy=substring(org_files, 1, 4)
         , mm=substring(org_files, 6, 7)
         , dd=substring(org_files, 9, 10)
         , title=substring(org_files, 12, nchar(org_files)-4)
         , old_url=paste(old_url_prefix, yyyy, mm, dd, title, sep='/')
         , new_url=paste0(new_url_prefix, '/', yyyy, '-', mm, '-', dd, '-', title, '/')
         , new_relative_url=paste0(new_relative_url_prefix, '/', yyyy, '-', mm, '-', dd, '-', title, '/')
          )

# Test if this works
url.exists('http://blog.nguyenvq.com/2022/10/21/hello')

# Test all old URLs
url_valid_flag <- url.exists(d_url$old_url)
sum(!url_valid_flag)
url_valid_flag[!url_valid_flag]

# remaining "error" is from a rename:
# http://blog.nguyenvq.com/blog/2010/07/23/migrating-back-to-linux-ubuntu-from-mac-os-x
# from
# http://blog.nguyenvq.com/blog/2010/07/24/705/

# Manually rename org files:
"
2009-07-15-generate-multiple-forms-and-filling-them-with-data-from-a-spreadsheet-or-database.org
2009-07-14-generate-multiple-forms-and-filling-them-with-data-from-a-spreadsheet-or-database.org # change in file

2009-09-16-free-webinar-web-app-dimdim-and-drop-io.org
2009-09-15-free-webinar-web-app-dimdim-and-drop-io.org

2009-09-18-emacs-key-bindings-in-mac-os-x-cocoa.org
2009-09-17-emacs-key-bindings-in-mac-os-x-cocoa.org

2010-03-28-mendeley-last-fm-approach-to-research-papers-annotation-notes.org
2010-03-27-mendeley-last-fm-approach-to-research-papers-annotation-notes.org

2010-04-16-accessing-ms-sql-server-from-command-line-in-mac-os-x-and-linuxunix.org
2010-04-15-accessing-ms-sql-server-from-command-line-in-mac-os-x-and-linuxunix.org

2010-07-12-using-r-ess-remote-with-screen-in-emacs.org
2010-07-11-using-r-ess-remote-with-screen-in-emacs.org

2010-10-31-google-voice-on-asterisk-with-an-auto-attendant-and-free-calls.org
2010-10-30-google-voice-on-asterisk-with-an-auto-attendant-and-free-calls.org

2011-08-11-build-multiarch-r-32-bit-and-64-bit-on-debianubuntu.org
2011-08-10-build-multiarch-r-32-bit-and-64-bit-on-debianubuntu.org

2011-08-11-sideway-or-landscape-table-over-multiple-pages-in-latex.org
2011-08-10-sideway-or-landscape-table-over-multiple-pages-in-latex.org

2011-09-08-strong-long-passwords.org
2011-09-07-strong-long-passwords.org

2014-03-30-parental-control-on-home-network.org
2014-03-29-parental-control-on-home-network.org

2011-11-12-Ubuntu-boot-or-startup-log.org
2011-11-12-email-boot-log-at-startup-in-ubuntu-with-bootmail.org

2011-11-22-pbx-in-a-flash+incredible-pbx-makes-setting-up-freepbx+asterisk-easy.org
2011-11-22-pbx-in-a-flash-incredible-pbx-makes-setting-up-freepbx-asterisk-easy.org

2012-01-28-understanding-bin-sbin-usr-bin-usr-sbin-split.org
2012-01-28-understanding-the-bin-sbin-usrbin-usrsbin-split.org

2012-03-20-beware-certain-amazon-ec2-ami-terminate-at-shutdown.org
2012-03-20-beware-certain-amazon-ec2-amis-terminate-at-shutdown.org

delete: hauppauge

2015-03-15-make-a-wireless-printer-using-a-router-with-usb-running-openwrt.org
2015-03-15-make-a-printer-wireless-using-a-router-with-usb-running-openwrt.org

2010-09-01-twitter-in-pidgin.org
2010-08-31-twitter-in-pidgin.org # fix in file as well

2011-12-09-emacs-24-crashing-when-launched-with-synapse-and-an-emacslcient-window-is-closed.org
2011-12-09-emacs-24-crashing-when-launched-with-synapse-and-an-emacsclient-window-is-closed.org

2012-04-03-record-streaming-radio-with-streamripper.org
2012-04-13-record-streaming-radio-with-streamripper.org

2012-04-05-flipping-the-classroom-creating-screencast-lectures-in-linux.org
2012-04-25-flipping-the-classroom-creating-screencast-lectures-in-linux.org

2013-08-01-delimited-file-where-delimiter-cashes-with-data-values.org
2013-08-01-delimited-file-where-delimiter-clashes-with-data-values.org

delete: 2014-11-09-optimized-r-and-python-on-amazon-ec2-cloud-for-on-demand-data-analysis.org

# following OK since we never published: will publish in new platform
http://blog.nguyenvq.com/blog/2014/11/06/build-r-on-aix
# following OK due to rename
http://blog.nguyenvq.com/blog/2010/07/24/migrating-back-to-linux-ubuntu-from-mac-os-x
"

d_url_both_forms <- bind_rows(
  d_url
  , d_url %>%
    mutate(old_url=str_replace_all(old_url, fixed('com/blog/'), 'com/') %>% paste0('/'))
)

url_2_valid_flag <- url.exists(d_url_both_forms$old_url[(nrow(d_url)+1):nrow(d_url_both_forms)])
sum(!url_2_valid_flag)
d_url_both_forms$old_url[(nrow(d_url)+1):nrow(d_url_both_forms)][!url_2_valid_flag]

# OK to delete
# http://blog.nguyenvq.com/2010/04/05/526/
# http://blog.nguyenvq.com/2011/02/25/875/

d_url_both_forms_2 <- d_url_both_forms %>%
  filter(!(old_url %in% c('http://blog.nguyenvq.com/2010/04/05/526/', 'http://blog.nguyenvq.com/2011/02/25/875/')))

# Export
write_csv(d_url_both_forms, 'Mappings/blog_posts_url_mapping.csv', na='')

# Check if links from manual file are in blog posts file
d_man %>%
  # filter(is.na(new_url)) %>%
  filter(is.na(new_url)) %>%
  left_join(d_url_both_forms %>% rename(new_url_2=new_url, new_relative_url_2=new_relative_url)) %>%
  filter(is.na(new_url_2)) %>%
  select(old_url, new_url, new_relative_url, new_url_2, new_relative_url_2) %>%
  as.data.frame

# Export final
d_out <- bind_rows(
  d_url_both_forms %>% select(old_url, new_url, new_relative_url)
  , d_man %>% filter(!is.na(new_url) | !is.na(new_relative_url))
)
n_distinct(d_out$old_url)
nrow(d_out)

write_csv(d_out, 'Mappings/all_urls.csv', na='')

# nginx mapping https://stackoverflow.com/a/40576333
d_out_nginx <- d_out %>%
  filter(!is.na(new_url)) %>%
  mutate(old=str_replace_all(old_url, fixed('http://blog.nguyenvq.com'), '')
         , new=new_url
         , mapping=paste0(old, ' ', new, ';')
         )

# 12/5/2022: found out google has links with trailing '/' (http://blog.nguyenvq.com/blog/2009/12/01/file-management-emacs-dired-to-replace-finder-in-mac-os-x-and-other-os/); add these too
nrow(d_out_nginx)
d_out_nginx <- d_out_nginx %>%
  filter(str_detect(old, '^/blog'), !str_detect(old, '/$')) %>%
  mutate(mapping=str_replace(mapping, ' ', '/ ')) %>%
  bind_rows(., d_out_nginx)
nrow(d_out_nginx)

length(d_out_nginx$mapping)
length(unique(d_out_nginx$mapping))

# write_lines(d_out_nginx$mapping, 'Mappings/blog_oldnew.map')
write_lines(d_out_nginx$mapping %>% unique, 'Mappings/blog_oldnew.map')

# Content of nginx/site-confs/blog.nguyenvq.com
"
map_hash_bucket_size 512; # see http://nginx.org/en/docs/hash.html

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
"
