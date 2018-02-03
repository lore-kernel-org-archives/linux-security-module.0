From: jmorris@namei.org (James Morris)
Date: Sat, 3 Feb 2018 12:21:57 +1100 (AEDT)
Subject: [GIT PULL] integrity fixes for v4.16-rc1
Message-ID: <alpine.LRH.2.21.1802031219230.13612@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these updates:

- Add James Bottommley as a Trusted Keys maintainer.

- IMA: re-initialize iint->atomic_flags on iint_free(), from Mimi.


The following changes since commit 4bf772b14675411a69b3c807f73006de0fe4b649:

  Merge tag 'drm-for-v4.16' of git://people.freedesktop.org/~airlied/linux (2018-02-01 17:48:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc1

for you to fetch changes up to e2598077dc6a26c9644393e5c21f22a90dbdccdb:

  ima: re-initialize iint->atomic_flags (2018-02-02 21:03:08 +1100)

----------------------------------------------------------------
Mimi Zohar (2):
      maintainers: update trusted keys
      ima: re-initialize iint->atomic_flags

 MAINTAINERS               | 1 +
 security/integrity/iint.c | 1 +
 2 files changed, 2 insertions(+)

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c104db..10ba368 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7792,6 +7792,7 @@ F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
+M:	James Bottomley <jejb@linux.vnet.ibm.com>
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 L:	linux-integrity at vger.kernel.org
 L:	keyrings at vger.kernel.org
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index fc38ca0..9700e96 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -74,6 +74,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
+	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
