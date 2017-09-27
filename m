From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed, 27 Sep 2017 12:50:40 -0700
Subject: [PATCH v3 0/7] KEYS: instantiation and atomicity fixes
Message-ID: <20170927195047.122358-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The first two patches in this series fix bugs related to instantiating
keys which allowed unprivileged users to cause a kernel oops.
Specifically, the first patch removes the ability for add_key() to
update an uninstantiated key, as this was heavily broken; and the second
patch fixes a race condition related to add_key() updating a negative
key into a positive one.

The remaining patches fix some other, more theoretical atomicity issues
with accessing key->flags and key->expiry, then eliminate
KEY_FLAG_NEGATIVE, which becomes unnecessary after the second patch.

Eric Biggers (7):
  KEYS: don't let add_key() update an uninstantiated key
  KEYS: fix race between updating and finding negative key
  KEYS: load key flags atomically in key_is_instantiated()
  KEYS: load key flags and expiry time atomically in key_validate()
  KEYS: load key flags and expiry time atomically in
    keyring_search_iterator()
  KEYS: load key flags and expiry time atomically in proc_keys_show()
  KEYS: remove KEY_FLAG_NEGATIVE

 include/linux/key.h                      | 25 +++++++++++++++++++++----
 security/keys/encrypted-keys/encrypted.c |  2 +-
 security/keys/gc.c                       |  4 +---
 security/keys/key.c                      | 24 +++++++++++++++++-------
 security/keys/keyctl.c                   |  5 ++++-
 security/keys/keyring.c                  | 22 +++++++++++++---------
 security/keys/permission.c               |  7 ++++---
 security/keys/proc.c                     | 28 ++++++++++++++++------------
 security/keys/request_key.c              | 11 +++++++----
 security/keys/trusted.c                  |  2 +-
 security/keys/user_defined.c             |  2 +-
 11 files changed, 86 insertions(+), 46 deletions(-)

-- 
2.14.2.822.g60be5d43e6-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
