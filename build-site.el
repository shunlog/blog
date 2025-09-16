
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
)


(setq my-website--root
  (file-name-directory (or load-file-name buffer-file-name)))


;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory (expand-file-name "./content" my-website--root)
             :publishing-directory (expand-file-name "./public" my-website--root)
             :publishing-function 'org-html-publish-to-html

             :with-author nil
             :with-creator t
             :with-toc t
             :section-numbers nil
             :time-stamp-file t
             )))


;; Generate the site output
(org-publish-all t)
