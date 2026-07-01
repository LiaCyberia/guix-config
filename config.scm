(use-modules (gnu)
             (nongnu packages linux)
             (gnu services sysctl))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (locale "pt_BR.utf8")
  (timezone "America/Fortaleza")
  (keyboard-layout (keyboard-layout "br"))
  (host-name "lorem")

  (users (cons* (user-account
                  (name "caol")
                  (comment "Caol")
                  (group "users")
                  (home-directory "/home/caol")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (services
   (append (list (service xfce-desktop-service-type)
                 (set-xorg-configuration
                  (xorg-configuration 
                    (keyboard-layout keyboard-layout))))
           (modify-services %desktop-services
             (sysctl-service-type config =>
                                  (sysctl-configuration
                                   (settings (append '(("vm.swappiness" . "5"))
                                                     %default-sysctl-settings)))))))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))

  (swap-devices (list (swap-space
                        (target (uuid
                                 "f9179f10-e74e-4712-a7fa-23066bc48d8f")))))

  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "fc547ebd-7d3a-4fe4-a2ff-fdb66f0ac388"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
