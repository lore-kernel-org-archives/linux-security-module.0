From: elena.reshetova@intel.com (Elena Reshetova)
Date: Fri, 31 Mar 2017 15:20:47 +0300
Subject: [PATCH 0/2] security, keys refcount conversions
Message-ID: <1490962849-3634-1-git-send-email-elena.reshetova@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I just realized that I forgot to send these with Acks from David.
Fixing it now. Please take it to the security tree.

Elena Reshetova (2):
  security, keys: convert key.usage from atomic_t to refcount_t
  security, keys: convert key_user.usage from atomic_t to refcount_t

 include/linux/key.h              |  5 +++--
 security/keys/gc.c               |  2 +-
 security/keys/internal.h         |  3 ++-
 security/keys/key.c              | 12 ++++++------
 security/keys/keyring.c          |  8 ++++----
 security/keys/proc.c             |  4 ++--
 security/keys/process_keys.c     |  2 +-
 security/keys/request_key_auth.c |  2 +-
 8 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
