From: dhowells@redhat.com (David Howells)
Date: Tue, 04 Apr 2017 08:28:21 +0100
Subject: [PATCH v13 00/10] Make keyring link restrictions accessible from
	userspace
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20172.1491290901@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

>  Documentation/crypto/asymmetric-keys.txt |  51 +++++++++
>  Documentation/security/keys.txt          |  66 +++++++++---
>  certs/system_keyring.c                   |  39 +++++--
>  crypto/asymmetric_keys/asymmetric_type.c | 102 ++++++++++++++++--
>  crypto/asymmetric_keys/restrict.c        | 161 ++++++++++++++++++++++++++-
>  include/crypto/public_key.h              |  15 ++-
>  include/keys/system_keyring.h            |   6 +-
>  include/linux/key-type.h                 |   8 ++
>  include/linux/key.h                      |  34 +++---
>  include/uapi/linux/keyctl.h              |   1 +
>  security/keys/compat.c                   |   4 +
>  security/keys/gc.c                       |  11 ++
>  security/keys/internal.h                 |   5 +
>  security/keys/key.c                      |  46 ++++----
>  security/keys/keyctl.c                   |  58 ++++++++++
>  security/keys/keyring.c                  | 179 +++++++++++++++++++++++++++++--

This breaks the integrity code which also uses keyring restrictions:

../security/integrity/digsig.c:46:30: error: passing argument 7 of 'keyring_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
../security/integrity/digsig.c:46:30: note: in definition of macro 'restrict_link_to_ima'
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
