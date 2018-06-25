From: jmorris@namei.org (James Morris)
Date: Tue, 26 Jun 2018 05:30:23 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: bugfixes for v4.18-rc
Message-ID: <alpine.LRH.2.21.1806260524480.5927@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Please pull these bugfixes.

- Smack: fix a regression caused by 1bbc55131e5
- X.509: fix a (usually un-seen) bug in RSA signature parsing


The following changes since commit 894b8c000ae6c106cc434ee0000dfb77df8bd9db:

  Merge tag 'for_v4.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2018-06-22 18:04:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.18-rc2

for you to fetch changes up to b65c32ec5a942ab3ada93a048089a938918aba7f:

  X.509: unpack RSA signatureValue field from BIT STRING (2018-06-25 12:17:08 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 security/smack/smack_lsm.c                | 1 +
 2 files changed, 10 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
