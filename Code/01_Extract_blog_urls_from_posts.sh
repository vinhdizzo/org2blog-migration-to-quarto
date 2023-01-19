#! /bin/env bash

# Extract all blog post url's in org files

# https://stackoverflow.com/a/31704200
# echo "http://blog.nguyenvq.com/hello-world" | grep -E --only-matching "http://blog.nguyenvq.com[A-Za-z0-9_/.-]+"
cat Posts\ org-mode/*.org | grep -E --only-matching "http://blog.nguyenvq.com[A-Za-z0-9_/.-]+" | sort | uniq

# For following, create lookup file: Mappings/manual_url_mapping.xlsx with old_url and new_url fields
"
http://blog.nguyenvq.com/2009/05/11/computer-modern-latex-font-in-r-plots/
http://blog.nguyenvq.com/2009/05/12/colored-contour-plot-heat-map/post
http://blog.nguyenvq.com/2009/05/13/drawing-in-latex-picture-environment-arrows-xy-package/
http://blog.nguyenvq.com/2009/05/14/latex-on-top-of-graphics/
http://blog.nguyenvq.com/2009/06/01/run-screen-in-emacs-with-ansi-term-combine-this-with-emacs-ess-remote-r/
http://blog.nguyenvq.com/2009/06/19/passwordless-ssh/
http://blog.nguyenvq.com/2009/08/14/surf-web-anonymously-tor/
http://blog.nguyenvq.com/2009/08/29/perfect-voip-combo-google-voice-gizmo/
http://blog.nguyenvq.com/2009/12/01/file-management-emacs-dired-to-replace-finder-in-mac-os-x-and-other-os/
http://blog.nguyenvq.com/2010/01/20/scheduled-parallel-computing-with-r-r-rmpi-openmpi-sun-grid-engine-sge/
http://blog.nguyenvq.com/2010/02/18/linksys-wrt160nv3-with-dd-wrt-as-wireless-bridge/
http://blog.nguyenvq.com/2010/04/15/accessing-ms-sql-server-from-command-line-in-mac-os-x-and-linuxunix/
http://blog.nguyenvq.com/2010/04/17/repeater-bridge-with-dd-wrt-linksys-wrt160nv3/
http://blog.nguyenvq.com/2010/06/16/controlmaster-in-openssh-speeding-up-editing-files-remotely-with-emacs-tramp/
http://blog.nguyenvq.com/2010/07/10/how-to-set-up-sending-mail-from-the-command-line/
http://blog.nguyenvq.com/2010/07/23/705/
http://blog.nguyenvq.com/2010/07/26/wget-to-mass-download-files/
http://blog.nguyenvq.com/2010/08/05/mediatomb/
http://blog.nguyenvq.com/2010/10/30/google-voice-on-asterisk-with-an-auto-attendant-and-free-calls/
http://blog.nguyenvq.com/2010/11/02/gnu-general-public-license-gpl/
http://blog.nguyenvq.com/2010/11/09/be-on-my-home-network-when-im-away-from-home-via-openvpn/
http://blog.nguyenvq.com/2010/11/30/automatically-start-asterisk-at-boot-time/
http://blog.nguyenvq.com/2010/12/01/slipstream-service-pack-and-create-a-new-windows-xp-installation-cd/
http://blog.nguyenvq.com/2010/12/01/virtualization-with-virtualbox-running-windows-inside-linux/
http://blog.nguyenvq.com/2010/12/02/synapse-to-replace-gnome-do/
http://blog.nguyenvq.com/2010/12/04/mac-os-x-in-linux-via-virtualbox-as-guest-os/
http://blog.nguyenvq.com/2010/12/16/photopictureimage-repository-viewable-using-a-web-browser/
http://blog.nguyenvq.com/2010/12/31/update-using-my-playstation-3-ps3-as-a-media-player-play-mkv-files-and-more/
http://blog.nguyenvq.com/2011/02/15/emacs-as-my-default-pdf-viewer/
http://blog.nguyenvq.com/2011/02/23/burn-dvd-from-the-command-line/
http://blog.nguyenvq.com/2011/03/10/foxit-phantom-an-adobe-acrobat-alternative-for-linux-via-wine/
http://blog.nguyenvq.com/2011/03/16/amazon-ec2-free-hosting-micro-instance-for-1-year-ubuntu-wordpress-asterisk/
http://blog.nguyenvq.com/2011/05/12/cups-pdf-example/
http://blog.nguyenvq.com/2011/06/07/non-latex-presentations-using-org-mode-s5-and-html5-slides/
http://blog.nguyenvq.com/2011/06/13/google-voice-on-a-telephone-without-a-server/
http://blog.nguyenvq.com/2011/06/13/version-control-and-collaborating-with-latex-files/
http://blog.nguyenvq.com/2011/06/15/determining-number-of-nodes-or-cores-available-in-an-sge-queue/
http://blog.nguyenvq.com/2011/07/01/follow-up-on-obi-ata-and-google-voice/
http://blog.nguyenvq.com/2011/07/11/r-from-source/
http://blog.nguyenvq.com/2011/07/18/real-time-file-synchronization-like-dropbox-via-unison/
http://blog.nguyenvq.com/2011/08/06/encrypt-hard-drives-and-usb-drives-with-dm-crypt-and-truecrypt/
http://blog.nguyenvq.com/2011/08/06/full-disk-encryption-on-ubuntu-with-dm-crypt-luks/
http://blog.nguyenvq.com/2011/08/11/build-multiarch-r-32-bit-and-64-bit-on-debianubuntu/
http://blog.nguyenvq.com/2011/08/29/navit-a-map-and-navigation-program/
http://blog.nguyenvq.com/2011/09/15/backup-re-install-ubuntu-with-full-disk-encryption-and-restore-all-files-and-settings/
http://blog.nguyenvq.com/2011/09/16/lightweight-portable-security-linux-distribution-by-the-us-department-of-defense/
http://blog.nguyenvq.com/blog/2010/10/30/google-voice-on-asterisk-with-an-auto-attendant-and-free-calls/
http://blog.nguyenvq.com/blog/2011/09/15/backup-re-install-ubuntu-with-full-disk-encryption-and-restore-all-files-and-settings/
http://blog.nguyenvq.com/blog/2013/07/20/make-windows-like-linux/
http://blog.nguyenvq.com/blog/2013/08/01/delimited-file-where-delimiter-clashes-with-data-values/
http://blog.nguyenvq.com/blog/2013/08/24/remotely-access-files-on-your-home-windows-computer/
http://blog.nguyenvq.com/blog/2014/08/07/change-delimiter-in-a-csv-file-and-remove-line-breaks-in-fields/
http://blog.nguyenvq.com/blog/2016/03/18/secure-access-to-home-ip-cameras-over-the-web-with-ssl/
http://blog.nguyenvq.com/tag/dd-wrt/
http://blog.nguyenvq.com/tag/screen/
http://blog.nguyenvq.com/wp-admin/install.php
http://blog.nguyenvq.com/wp-content/uploads/2009/05/BetaHat-vs-r-DISCRETE.jpeg
http://blog.nguyenvq.com/wp-content/uploads/2009/05/CI-animations.gif
http://blog.nguyenvq.com/wp-content/uploads/2009/05/ColoredContourHeatMap-MVN.jpeg
http://blog.nguyenvq.com/wp-content/uploads/2009/05/Consistency-Ani.gif
http://blog.nguyenvq.com/wp-content/uploads/2009/05/LinearRegressionNormalErrors.jpeg
http://blog.nguyenvq.com/wp-content/uploads/2009/05/sinTaylor.gif
http://blog.nguyenvq.com/wp-content/uploads/wpid-2014-02-07-chameleon-wizard5.png
http://blog.nguyenvq.com/wp-content/uploads/wpid-2014-02-07-multibeast5.png
http://blog.nguyenvq.com/wp-content/uploads/wpid-2014-11-10-Python_blas-atlas-openblas2.png
http://blog.nguyenvq.com/wp-content/uploads/wpid-2014-11-10-R_blas-atlas-openblas-mkl2.png
http://blog.nguyenvq.com/
"
