From: lkp@intel.com (kbuild test robot)
Date: Thu, 20 Apr 2017 11:04:40 +0800
Subject: [PATCH 6/6] ima: Support appended signatures for appraisal
In-Reply-To: <1492546666-16615-7-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <201704201148.IPsFhl4B%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Thiago,

[auto build test ERROR on security/next]
[also build test ERROR on v4.11-rc7 next-20170419]
[cannot apply to integrity/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thiago-Jung-Bauermann/Appended-signatures-support-for-IMA-appraisal/20170419-053422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: i386-randconfig-h0-04201028 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from security/integrity/ima/ima_appraise.c:19:0:
   include/keys/asymmetric-type.h: In function 'asymmetric_key_ids':
>> include/keys/asymmetric-type.h:76:12: error: dereferencing pointer to incomplete type 'const struct key'
     return key->payload.data[asym_key_ids];
               ^~

vim +76 include/keys/asymmetric-type.h

7901c1a8 David Howells 2014-09-16  70  							    size_t len_1,
7901c1a8 David Howells 2014-09-16  71  							    const void *val_2,
7901c1a8 David Howells 2014-09-16  72  							    size_t len_2);
146aa8b1 David Howells 2015-10-21  73  static inline
146aa8b1 David Howells 2015-10-21  74  const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
146aa8b1 David Howells 2015-10-21  75  {
146aa8b1 David Howells 2015-10-21 @76  	return key->payload.data[asym_key_ids];
146aa8b1 David Howells 2015-10-21  77  }
7901c1a8 David Howells 2014-09-16  78  
9eb02989 David Howells 2016-04-06  79  extern struct key *find_asymmetric_key(struct key *keyring,

:::::: The code at line 76 was first introduced by commit
:::::: 146aa8b1453bd8f1ff2304ffb71b4ee0eb9acdcc KEYS: Merge the type-specific data with the payload data

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25689 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170420/76e9340a/attachment.bin>
