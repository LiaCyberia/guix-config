(define-module (guix-home-config)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (guix gexp)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages text-editors))

(define home-config
  (home-environment
    (services
      (append
        (list          
          (service home-files-service-type
                   `((".guile" ,%default-dotguile)
                     (".Xdefaults" ,%default-xdefaults)
                     (".bash_profile" ,(plain-file "bash-profile"
"export GUIX_PROFILE=\"$HOME/.guix-profile\"\nexport XDG_DATA_DIRS=\"${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share\"\nexport PATH=\"$HOME/.local/bin:$PATH\"\n\n# \nif [ -f ~/.bashrc ]; then\n  . ~/.bashrc\nfi\n"))))

          (service home-xdg-configuration-files-service-type
                   `(("gdb/gdbinit" ,%default-gdbinit)
                     ("nano/nanorc" ,%default-nanorc))))

        %base-home-services))))

home-config

