From: jmorris@namei.org (James Morris)
Date: Wed, 27 Jun 2018 03:00:12 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: more keys fixes for v4.18-rc3
Message-ID: <alpine.LRH.2.21.1806270257460.18107@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these two further fixes for the keys subsystem.

The following changes since commit 813835028e9ae1f18cd11bb0ec591d0f0577d96a:

  Merge branch 'fixes-v4.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security (2018-06-26 08:44:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.18-rc3

for you to fetch changes up to 3619dec5103dd999a777e3e4ea08c8f40a6ddc57:

  dh key: fix rounding up KDF output length (2018-06-26 09:43:05 -0700)

----------------------------------------------------------------
Eric Biggers (1):
      dh key: fix rounding up KDF output length

Nick Desaulniers (1):
      certs/blacklist: fix const confusion

 certs/blacklist.h  | 2 +-
 security/keys/dh.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
