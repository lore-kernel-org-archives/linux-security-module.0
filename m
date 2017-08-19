From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 19 Aug 2017 17:40:48 +0800
Subject: [security:next 6/15] security/apparmor/mount.c:227: warning:
	'perms.prompt' is used uninitialized in this function
Message-ID: <201708191743.FPV3TuQ6%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
head:   76e22e212a850bbd16cf49f9c586d4635507e0b5
commit: fa488437d0f95b2e5db1e624341fe0d5a233f729 [6/15] apparmor: add mount mediation
config: x86_64-randconfig-a0-08191640 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        git checkout fa488437d0f95b2e5db1e624341fe0d5a233f729
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   security/apparmor/mount.c: In function 'compute_mnt_perms':
>> security/apparmor/mount.c:227: warning: 'perms.prompt' is used uninitialized in this function
>> security/apparmor/mount.c:227: warning: 'perms.hide' is used uninitialized in this function
>> security/apparmor/mount.c:227: warning: 'perms.cond' is used uninitialized in this function
>> security/apparmor/mount.c:227: warning: 'perms.complain' is used uninitialized in this function
>> security/apparmor/mount.c:227: warning: 'perms.stop' is used uninitialized in this function
>> security/apparmor/mount.c:227: warning: 'perms.deny' is used uninitialized in this function

vim +227 security/apparmor/mount.c

   208	
   209	/**
   210	 * compute_mnt_perms - compute mount permission associated with @state
   211	 * @dfa: dfa to match against (NOT NULL)
   212	 * @state: state match finished in
   213	 *
   214	 * Returns: mount permissions
   215	 */
   216	static struct aa_perms compute_mnt_perms(struct aa_dfa *dfa,
   217						   unsigned int state)
   218	{
   219		struct aa_perms perms;
   220	
   221		perms.kill = 0;
   222		perms.allow = dfa_user_allow(dfa, state);
   223		perms.audit = dfa_user_audit(dfa, state);
   224		perms.quiet = dfa_user_quiet(dfa, state);
   225		perms.xindex = dfa_user_xindex(dfa, state);
   226	
 > 227		return perms;
   228	}
   229	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
