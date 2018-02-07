From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Feb 2018 06:21:28 +0800
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180204164732.28241-5-igor.stoppa@huawei.com>
References: <20180204164732.28241-5-igor.stoppa@huawei.com>
Message-ID: <201802080632.2iF5UlI3%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v4.15]
[cannot apply to linus/master mmotm/master next-20180207]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/drivers/vde.o: In function `vde_open_real':
   (.text+0x951): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   (.text+0x79c): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   (.text+0xab5): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoaddr':
   (.text+0xdee5): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametonetaddr':
   (.text+0xdf85): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoproto':
   (.text+0xe1a5): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoport':
   (.text+0xdfd7): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   mm/usercopy.o: In function `__check_object_size':
>> (.text+0x3aa): undefined reference to `is_pmalloc_object'
>> collect2: error: ld returned 1 exit status

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
