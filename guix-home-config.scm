(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu packages shells)
             (gnu packages bash)
             (guix gexp)
	     (gnu packages)
             (gnu system shadow)
             (gnu packages admin))

(home-environment
 (packages (list pfetch))
 (services
  (list
   (service home-bash-service-type
            (home-bash-configuration
             (bashrc
              (list
               (plain-file "bashrc"
                    "PS1='(¬\\`‸´¬)# '
echo \"Hare Hare Krishna Krishna\"
printf \"%s\n\"
pfetch")))))

   (service home-files-service-type
            `((".config/nano/nanorc" ,(plain-file "nanorc" "set linenumbers set mouse set tabsize 4")))))))

(home-environment
 (packages (specifications->packages
            (list
	     "flameshot"
	     "pfetch"
	     "flatpak"
	     "rofi"
	     "wine"
	     "steam"
	     "alacritty"
	     "7zip"
	     "unrar"
	     ))))
