From: dhowells@redhat.com (David Howells)
Date: Thu, 13 Jul 2017 13:15:18 +0100
Subject: [PATCH 0/3] KEYS: Miscellany
Message-ID: <149994811849.15121.8667303093371871645.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Hi James,

Could you pass these on to Linus please?

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-next

David
---
Eric Biggers (1):
      KEYS: DH: validate __spare field

Jarkko Sakkinen (1):
      modsign: add markers to endif-statements in certs/Makefile

Mat Martineau (1):
      KEYS: Add documentation for asymmetric keyring restrictions


 Documentation/crypto/asymmetric-keys.txt |   65 ++++++++++++++++++++++++++----
 Documentation/security/keys/core.rst     |    6 +++
 certs/Makefile                           |    6 +--
 security/keys/compat_dh.c                |    2 +
 security/keys/dh.c                       |    5 ++
 5 files changed, 73 insertions(+), 11 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
