From: jmorris@namei.org (James Morris)
Date: Thu, 16 Aug 2018 08:34:50 +1000 (AEST)
Subject: [GIT PULL] security subsystem: Smack updates for v4.19
Message-ID: <alpine.LRH.2.21.1808160831490.19586@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these Smack updates for v4.19, all of which are minor fixes 
from Piotr Sawicki.


The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to df6b4e6608eebc2ff18113706f4e3b9d9a972e68:

  Merge branch 'smack-for-4.19-a' of https://github.com/cschaufler/next-smack into next-smack (2018-07-30 10:31:54 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge branch 'smack-for-4.19-a' of https://github.com/cschaufler/next-smack into next-smack

Piotr Sawicki (3):
      Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets
      Smack: Check UDP-Lite and DCCP protocols during IPv6 handling
      Smack: Inform peer that IPv6 traffic has been blocked

 security/smack/smack_lsm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
James Morris
<jmorris@namei.org>
