From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 10 Jan 2018 17:40:43 -0800
Subject: [PULL] Smack: Changes for 4.16
Message-ID: <e926f995-11a6-0208-90dc-2e32e33b7c17@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James, please pull these two small patches for 4.16.

I think I am managing the tree the way you asked, but please
let me know if I managed to mess it up. Thank you.

The following changes since commit d21bd6898336a7892914d308d5e0868f0b863571:

  Sync to v4.15-rc3 for security subsystem developers to work against. (2017-12-11 17:01:08 +1100)

are available in the Git repository at:

  git://github.com/cschaufler/next-smack smack-for-4.16

for you to fetch changes up to d19dfe58b7ecbef3bd0c403c650200c57913ba1b:

  Smack: Privilege check on key operations (2018-01-10 09:29:14 -0800)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Privilege check on key operations

Vasyl Gomonovych (1):
      Smack: fix dereferenced before check

 security/smack/smack.h        |  1 +
 security/smack/smack_access.c | 40 +++++++++++++++++++++++++++++-----------
 security/smack/smack_lsm.c    | 10 +++++++++-
 3 files changed, 39 insertions(+), 12 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
