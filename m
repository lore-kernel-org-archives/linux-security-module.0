From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 11:11:16 +0800
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <201706131101.GMlYp44a%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Salvatore,

[auto build test ERROR on security/next]
[also build test ERROR on v4.12-rc5]
[cannot apply to next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Salvatore-Mesoraca/S-A-R-A-Documentation/20170613-050631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> ERROR: "security_usb_device_auth" [drivers/usb/core/usbcore.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
