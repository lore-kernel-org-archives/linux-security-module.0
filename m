From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:17 -0700
Subject: [PATCH v13 00/10] Make keyring link restrictions accessible from
	userspace
Message-ID: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Keyrings recently acquired the ability to validate keys before they are
linked using kernel internal APIs. This patch set enables configuration
of restricted keyrings from userspace.

These patches apply to linux-fs/keys-misc and are also available here:

    https://git.kernel.org/cgit/linux/kernel/git/martineau/linux.git/log/?h=keyctl-restrict

v13: Detect and avoid cycles in restriction references, and change
restrictions to store a single key pointer rather than arbitrary data.

v12: Rework the KEYCTL_RESTRICT_KEYRING command to take an additional
parameter, renamed some functions based on feedback, and dropped an
unnecessary locking change (patch 1 in previous set).

v11: Configure restrictions using KEYCTL_RESTRICT_KEYRING instead of
using a keyring payload at creation time. Make the garbage collector
aware of restrictions.

v10: Fixups from maintainer feedback. Added some missing documentation.

v9: Rebased on linux-fs/keys-misc (v4.9-rc5)

v8: Add option to look for signing keys within the destination keyring.
Fix a consistency issue with keyring locking and restriction checks.

v7: Rework key restriction payload syntax. Move key-type-specific payload
parsing to the key-type. Attach more restriction information to keyrings
(restriction function, data, and data free) so future restrictions are not
limited to storing a key ID to use for key validation. Validate key before
using it to verify another key. Modify key type locking model to allow key
type lookup during keyring creation.

v6: Return error if only restrict_key is supplied, address misc. review
comments.

v5: Fixed signature bypass problem in patch 3/6

v4: Added userspace restriction options based on builtin keyrings.
restrict_link_by_signature implementation is no longer modified. Split
up v3's patch 2/5 to isolate the change to key.h.

v3: Updated commit message for patch 2/5 (restrict_link_by_signature_indirect)

v2: Payload is now preparsed

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

 Documentation/crypto/asymmetric-keys.txt |  51 +++++++++
 Documentation/security/keys.txt          |  66 +++++++++---
 certs/system_keyring.c                   |  39 +++++--
 crypto/asymmetric_keys/asymmetric_type.c | 102 ++++++++++++++++--
 crypto/asymmetric_keys/restrict.c        | 161 ++++++++++++++++++++++++++-
 include/crypto/public_key.h              |  15 ++-
 include/keys/system_keyring.h            |   6 +-
 include/linux/key-type.h                 |   8 ++
 include/linux/key.h                      |  34 +++---
 include/uapi/linux/keyctl.h              |   1 +
 security/keys/compat.c                   |   4 +
 security/keys/gc.c                       |  11 ++
 security/keys/internal.h                 |   5 +
 security/keys/key.c                      |  46 ++++----
 security/keys/keyctl.c                   |  58 ++++++++++
 security/keys/keyring.c                  | 179 +++++++++++++++++++++++++++++--
 16 files changed, 706 insertions(+), 80 deletions(-)

-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
