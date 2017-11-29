From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Nov 2017 02:08:38 +0800
Subject: [PATCH 4/4] selinux: Add SCTP support
In-Reply-To: <20171127193217.2768-1-richard_c_haines@btinternet.com>
References: <20171127193217.2768-1-richard_c_haines@btinternet.com>
Message-ID: <201711300049.TRR2hqSQ%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Richard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on security/next]
[cannot apply to net-next/master net/master v4.15-rc1 next-20171129]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Richard-Haines/Add-SELinux-SCTP-protocol-support/20171129-222900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
>> security/selinux/hooks.c:5185:10: error: 'struct sk_security_struct' has no member named 'nlbl_state'
     newsksec->nlbl_state = sksec->nlbl_state;
             ^~
   security/selinux/hooks.c:5185:30: error: 'struct sk_security_struct' has no member named 'nlbl_state'
     newsksec->nlbl_state = sksec->nlbl_state;
                                 ^~

vim +5185 security/selinux/hooks.c

  5168	
  5169	/* Called whenever a new socket is created by accept(2) or sctp_peeloff(3). */
  5170	static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
  5171					  struct sock *newsk)
  5172	{
  5173		struct sk_security_struct *sksec = sk->sk_security;
  5174		struct sk_security_struct *newsksec = newsk->sk_security;
  5175	
  5176		/* If policy does not support SECCLASS_SCTP_SOCKET then call
  5177		 * the non-sctp clone version.
  5178		 */
  5179		if (!selinux_policycap_extsockclass)
  5180			return selinux_sk_clone_security(sk, newsk);
  5181	
  5182		newsksec->sid = ep->secid;
  5183		newsksec->peer_sid = ep->peer_secid;
  5184		newsksec->sclass = sksec->sclass;
> 5185		newsksec->nlbl_state = sksec->nlbl_state;
  5186	}
  5187	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
