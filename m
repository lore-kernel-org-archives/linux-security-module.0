From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 4 Jul 2018 13:35:00 +0300
Subject: [bug report] AppArmor: policy routines for loading and unpacking
	policy
Message-ID: <20180704103500.d5j5vhu3r6mizfg6@kili.mountain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello John Johansen,

The patch 736ec752d95e: "AppArmor: policy routines for loading and
unpacking policy" from Jul 29, 2010, leads to the following static
checker warning:

    security/apparmor/policy_unpack.c:410 verify_accept()
    warn: bitwise AND condition is false here

    security/apparmor/policy_unpack.c:413 verify_accept()
    warn: bitwise AND condition is false here

security/apparmor/policy_unpack.c
   392  #define DFA_VALID_PERM_MASK             0xffffffff
   393  #define DFA_VALID_PERM2_MASK            0xffffffff
   394  
   395  /**
   396   * verify_accept - verify the accept tables of a dfa
   397   * @dfa: dfa to verify accept tables of (NOT NULL)
   398   * @flags: flags governing dfa
   399   *
   400   * Returns: 1 if valid accept tables else 0 if error
   401   */
   402  static bool verify_accept(struct aa_dfa *dfa, int flags)
   403  {
   404          int i;
   405  
   406          /* verify accept permissions */
   407          for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
   408                  int mode = ACCEPT_TABLE(dfa)[i];
   409  
   410                  if (mode & ~DFA_VALID_PERM_MASK)
   411                          return 0;
   412  
   413                  if (ACCEPT_TABLE2(dfa)[i] & ~DFA_VALID_PERM2_MASK)
   414                          return 0;

Normally, I don't report this kind of static checker warning because it
looks like maybe we had intended to make DFA_VALID_PERM_MASK
configurable or something.

But these kinds of things make me nervous when they're part of a
permission check.  It's been 8 years and this function has always just
been a no-op which says that the the permissions are OK.  Can we just
remove the function?

   415          }
   416          return 1;
   417  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
