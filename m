From: james.l.morris@oracle.com (James Morris)
Date: Thu, 2 Nov 2017 21:21:00 +1100 (AEDT)
Subject: [GIT PULL] Keys fixes for v4.15
Message-ID: <alpine.LFD.2.20.1711022118180.24938@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Please pull these fixes for the Keys subsystem by Eric Biggers.

The following changes since commit 3a99df9a3d14cd866b5516f8cba515a3bfd554ab:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2017-11-01 16:04:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.14-rc7

Eric Biggers (3):
      KEYS: return full count in keyring_read() if buffer is too small
      KEYS: trusted: fix writing past end of buffer in trusted_read()
      KEYS: fix out-of-bounds read during ASN.1 parsing

 lib/asn1_decoder.c      |    3 +++
 security/keys/keyring.c |   39 +++++++++++++++++++--------------------
 security/keys/trusted.c |   23 ++++++++++++-----------
 3 files changed, 34 insertions(+), 31 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
