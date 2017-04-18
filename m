From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 18 Apr 2017 13:16:37 -0700
Subject: [PULL] Smack changes for 4.12
Message-ID: <83a253e0-0fd0-36fe-9487-e0d7292ab832@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Two very small changes for Smack for 4.12.


The following changes since commit e4e55b47ed9ae2c05ff062601ff6dacbe9dc4775:

  LSM: Revive security_task_alloc() hook and per "struct task_struct" security blob. (2017-03-28 11:05:14 +1100)

are available in the git repository at:

  git://github.com/cschaufler/smack-next smack-for-4.12

for you to fetch changes up to af96f0d6394a0af59c4dd71d6bcd3b1ddfba5196:

  Smack: Use GFP_KERNEL for smk_netlbl_mls(). (2017-04-04 15:41:15 -0700)

----------------------------------------------------------------
Tetsuo Handa (2):
      smack: fix double free in smack_parse_opts_str()
      Smack: Use GFP_KERNEL for smk_netlbl_mls().

 security/smack/smack_access.c | 2 +-
 security/smack/smack_lsm.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
