From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 30 Jul 2018 08:51:41 -0700
Subject: [PULL] Smack: Changes for 4.19
Message-ID: <09ae8f36-1870-ba78-458b-fcbc02cac28b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James, would you take this small set of changes for 4.19, please?

The following changes since commit 4f0496d8ffa3ed5956a2ddee5d84f0246977799d:

  ima: based on policy warn about loading firmware (pre-allocated buffer) (2018-07-16 12:31:57 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/next-smack.git smack-for-4.19-a

for you to fetch changes up to d66a8acbda926fa2398ae930f50787e8663bce96:

  Smack: Inform peer that IPv6 traffic has been blocked (2018-07-23 13:00:03 -0700)

----------------------------------------------------------------
Piotr Sawicki (3):
      Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets
      Smack: Check UDP-Lite and DCCP protocols during IPv6 handling
      Smack: Inform peer that IPv6 traffic has been blocked

 security/smack/smack_lsm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
