# CMS versions

This repository is set up to automatically retrieve the versions of the
following CMSs daily with a GitHub Actions workflow cronjob:

* Drupal
* Joomla
* Magento
* WordPress

All CMS versions will be checked against the versions in `cms_versions.json`
and updated accordingly. The result is a `cms_versions.json` file that can be
[downloaded directly][1].

[1]: https://raw.githubusercontent.com/guardian360/cms-versions/main/cms_versions.sh
