From: lkp@intel.com (kbuild test robot)
Date: Fri, 24 Aug 2018 02:35:04 +0800
Subject: [PATCH] apparmor: remove dead code
In-Reply-To: <20180823134255.GA12128@embeddedor.com>
References: <20180823134255.GA12128@embeddedor.com>
Message-ID: <201808240108.0FcluUrs%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Gustavo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on security/next]
[also build test ERROR on v4.18 next-20180822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gustavo-A-R-Silva/apparmor-remove-dead-code/20180824-005627
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: i386-randconfig-x079-201833 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   security//apparmor/policy_unpack.c: In function 'unpack_dfa':
>> security//apparmor/policy_unpack.c:445:4: error: label 'fail' used but not defined
       goto fail;
       ^~~~

vim +/fail +445 security//apparmor/policy_unpack.c

736ec752d John Johansen 2010-07-29  414  
736ec752d John Johansen 2010-07-29  415  /**
736ec752d John Johansen 2010-07-29  416   * unpack_dfa - unpack a file rule dfa
736ec752d John Johansen 2010-07-29  417   * @e: serialized data extent information (NOT NULL)
736ec752d John Johansen 2010-07-29  418   *
736ec752d John Johansen 2010-07-29  419   * returns dfa or ERR_PTR or NULL if no dfa
736ec752d John Johansen 2010-07-29  420   */
736ec752d John Johansen 2010-07-29  421  static struct aa_dfa *unpack_dfa(struct aa_ext *e)
736ec752d John Johansen 2010-07-29  422  {
736ec752d John Johansen 2010-07-29  423  	char *blob = NULL;
736ec752d John Johansen 2010-07-29  424  	size_t size;
736ec752d John Johansen 2010-07-29  425  	struct aa_dfa *dfa = NULL;
736ec752d John Johansen 2010-07-29  426  
736ec752d John Johansen 2010-07-29  427  	size = unpack_blob(e, &blob, "aadfa");
736ec752d John Johansen 2010-07-29  428  	if (size) {
736ec752d John Johansen 2010-07-29  429  		/*
736ec752d John Johansen 2010-07-29  430  		 * The dfa is aligned with in the blob to 8 bytes
736ec752d John Johansen 2010-07-29  431  		 * from the beginning of the stream.
dd51c8485 John Johansen 2013-07-10  432  		 * alignment adjust needed by dfa unpack
736ec752d John Johansen 2010-07-29  433  		 */
dd51c8485 John Johansen 2013-07-10  434  		size_t sz = blob - (char *) e->start -
dd51c8485 John Johansen 2013-07-10  435  			((e->pos - e->start) & 7);
736ec752d John Johansen 2010-07-29  436  		size_t pad = ALIGN(sz, 8) - sz;
736ec752d John Johansen 2010-07-29  437  		int flags = TO_ACCEPT1_FLAG(YYTD_DATA32) |
abbf87340 John Johansen 2017-01-16  438  			TO_ACCEPT2_FLAG(YYTD_DATA32) | DFA_FLAG_VERIFY_STATES;
736ec752d John Johansen 2010-07-29  439  		dfa = aa_dfa_unpack(blob + pad, size - pad, flags);
736ec752d John Johansen 2010-07-29  440  
736ec752d John Johansen 2010-07-29  441  		if (IS_ERR(dfa))
736ec752d John Johansen 2010-07-29  442  			return dfa;
736ec752d John Johansen 2010-07-29  443  
736ec752d John Johansen 2010-07-29  444  		if (!verify_accept(dfa, flags))
736ec752d John Johansen 2010-07-29 @445  			goto fail;
736ec752d John Johansen 2010-07-29  446  	}
736ec752d John Johansen 2010-07-29  447  
736ec752d John Johansen 2010-07-29  448  	return dfa;
736ec752d John Johansen 2010-07-29  449  }
736ec752d John Johansen 2010-07-29  450  

:::::: The code at line 445 was first introduced by commit
:::::: 736ec752d95e91e77cc0e8c97c057ab076ac2f51 AppArmor: policy routines for loading and unpacking policy

:::::: TO: John Johansen <john.johansen@canonical.com>
:::::: CC: James Morris <jmorris@namei.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
