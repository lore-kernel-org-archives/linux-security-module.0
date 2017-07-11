From: lkp@intel.com (kbuild test robot)
Date: Tue, 11 Jul 2017 12:12:33 +0800
Subject: [PATCH 3/3] Make LSM Writable Hooks a command line option
In-Reply-To: <20170710150603.387-4-igor.stoppa@huawei.com>
Message-ID: <201707111218.WdNdnvYN%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test ERROR on linus/master]
[cannot apply to v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20170711-084116
config: score-spct6600_defconfig (attached as .config)
compiler: score-elf-gcc (GCC) 4.9.1 20140622 (prerelease)
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=score 

All errors (new ones prefixed by >>):

   security/security.o: In function `security_init':
>> security.c:(.init.text+0x68): undefined reference to `pmalloc_create_pool'
>> security.c:(.init.text+0x98): undefined reference to `pmalloc'
>> security.c:(.init.text+0x150): undefined reference to `pmalloc_protect_pool'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
