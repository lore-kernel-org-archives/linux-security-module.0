From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 01:30:32 -0700
Subject: [PATCH 0/5] KEYS: sanitize key payloads
Message-ID: <20170421083037.12746-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This patch series introduces more thorough sanitization of keys managed
by the kernel key retention service.  This helps keep sensitive key
material from sticking around in the slab caches after keys are released.

This series covers the syscall interface and several of the common key
types.  It doesn't cover some of the less commonly used key types.  Also,
these changes are of course limited to the keyrings mechanism itself and
don't remove the responsibility for keyrings users to securely handle any
other sensitive data they may copy or generate.  Regardless, there's no
reason not to make the keyrings API follow best practices.

Eric Biggers (5):
  KEYS: sanitize add_key() and keyctl() key payloads
  KEYS: user_defined: sanitize key payloads
  KEYS: encrypted: sanitize all key material
  KEYS: trusted: sanitize all key material
  KEYS: sanitize key structs before freeing

 include/linux/key.h                      |  1 -
 security/keys/encrypted-keys/encrypted.c | 31 +++++++++-----------
 security/keys/gc.c                       |  4 +--
 security/keys/keyctl.c                   |  4 ++-
 security/keys/trusted.c                  | 50 ++++++++++++++------------------
 security/keys/user_defined.c             | 16 +++++++---
 6 files changed, 51 insertions(+), 55 deletions(-)

-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
