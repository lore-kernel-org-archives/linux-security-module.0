From: dhowells@redhat.com (David Howells)
Date: Wed, 12 Apr 2017 15:44:34 +0100
Subject: [GIT PULL] KEYS: Blacklisting, restrictions and DH
Message-ID: <18309.1492008274@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Hi James,

Could you pull these changes into security/next please:

 (1) Provide a blacklist keyring and a blacklist key type such that X.509
     keys and PKCS#7 certs can be blacklisted.  It is possible to load the
     blacklist from a file at compile time.  A future patch will
     additionally load the blacklist from the UEFI blacklist if available.

 (2) Make it possible to create a userspace keyring and to apply a
     restriction to it such that no new keys can be added unless they meet
     the criteria.

 (3) Add SP800-56A KDF support for the DH operation.

David
---
The following changes since commit ddb99e118e37f324a4be65a411bb60ae62795cf9:

  security, keys: convert key_user.usage from atomic_t to refcount_t (2017-04-03 10:49:06 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-next-20170412

for you to fetch changes up to 4cd4ca7cc848bedc70b5d0acac9d1ae33d73513a:

  keys: select CONFIG_CRYPTO when selecting DH / KDF (2017-04-11 23:18:09 +0100)

----------------------------------------------------------------
Keyrings changes for next

----------------------------------------------------------------
David Howells (5):
      KEYS: Add a system blacklist keyring
      X.509: Allow X.509 certs to be blacklisted
      PKCS#7: Handle blacklisted certificates
      Merge branch 'keys-blacklist' into keys-next
      Merge branch 'keyctl-restrict' of git://git.kernel.org/.../martineau/linux into keys-next

Mat Martineau (10):
      KEYS: Use a typedef for restrict_link function pointers
      KEYS: Split role of the keyring pointer for keyring restrict functions
      KEYS: Add a key restriction struct
      KEYS: Use structure to capture key restriction function and data
      KEYS: Add an optional lookup_restriction hook to key_type
      KEYS: Consistent ordering for __key_link_begin and restrict check
      KEYS: Add KEYCTL_RESTRICT_KEYRING
      KEYS: Add a lookup_restriction function for the asymmetric key type
      KEYS: Restrict asymmetric key linkage using a specific keychain
      KEYS: Keyring asymmetric key restrict method with chaining

Stephan Mueller (1):
      KEYS: add SP800-56A KDF support for DH

Stephan M?ller (1):
      keys: select CONFIG_CRYPTO when selecting DH / KDF

 Documentation/crypto/asymmetric-keys.txt |  51 +++++++
 Documentation/security/keys.txt          | 100 ++++++++++----
 certs/Kconfig                            |  18 +++
 certs/Makefile                           |   6 +
 certs/blacklist.c                        | 174 ++++++++++++++++++++++++
 certs/blacklist.h                        |   3 +
 certs/blacklist_hashes.c                 |   6 +
 certs/blacklist_nohashes.c               |   5 +
 certs/system_keyring.c                   |  39 ++++--
 crypto/asymmetric_keys/asymmetric_type.c | 102 ++++++++++++--
 crypto/asymmetric_keys/pkcs7_parser.h    |   1 +
 crypto/asymmetric_keys/pkcs7_verify.c    |  32 +++--
 crypto/asymmetric_keys/restrict.c        | 161 +++++++++++++++++++++-
 crypto/asymmetric_keys/x509_parser.h     |   1 +
 crypto/asymmetric_keys/x509_public_key.c |  15 +++
 include/crypto/public_key.h              |  15 ++-
 include/keys/system_keyring.h            |  18 ++-
 include/linux/compat.h                   |   7 +
 include/linux/key-type.h                 |   8 ++
 include/linux/key.h                      |  34 +++--
 include/uapi/linux/keyctl.h              |   8 ++
 security/integrity/digsig.c              |   9 +-
 security/integrity/ima/ima_mok.c         |  11 +-
 security/keys/Kconfig                    |   2 +
 security/keys/Makefile                   |   3 +-
 security/keys/compat.c                   |   9 +-
 security/keys/compat_dh.c                |  38 ++++++
 security/keys/dh.c                       | 220 +++++++++++++++++++++++++++++--
 security/keys/gc.c                       |  11 ++
 security/keys/internal.h                 |  29 +++-
 security/keys/key.c                      |  46 ++++---
 security/keys/keyctl.c                   |  60 ++++++++-
 security/keys/keyring.c                  | 179 +++++++++++++++++++++++--
 33 files changed, 1305 insertions(+), 116 deletions(-)
 create mode 100644 certs/blacklist.c
 create mode 100644 certs/blacklist.h
 create mode 100644 certs/blacklist_hashes.c
 create mode 100644 certs/blacklist_nohashes.c
 create mode 100644 security/keys/compat_dh.c
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
