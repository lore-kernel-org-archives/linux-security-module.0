From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 5 Jun 2018 12:29:23 -0700
Subject: [PULL] Smack: Changes for 4.18
Message-ID: <0eca3e49-a3de-3ba7-26c2-383c9bad3906@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James, apologies for the late pull request. It's one simple patch that
fixes a memory leak in kernfs and labeled NFS.

The following changes since commit b3859ee18ed287170b66b19a78191f7312ec3470:

  Merge tag 'v4.17-rc3' into next-general (2018-05-01 11:02:34 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/next-smack.git smack-for-4.18

for you to fetch changes up to 0f8983cf97d3327531b7843c831517cac3a1b9ed:

  Smack: Fix memory leak in smack_inode_getsecctx (2018-06-05 12:16:01 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Fix memory leak in smack_inode_getsecctx

 security/smack/smack_lsm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
