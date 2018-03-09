From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri,  9 Mar 2018 15:14:18 -0500
Subject: [RFC PATCH v2 0/3] ima: namespacing IMA
Message-ID: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch set implements an IMA namespace data structure that gets
created alongside a mount namespace with CLONE_NEWNS, and lays down the
foundation for namespacing the different aspects of IMA (eg. IMA-audit,
IMA-measurement, IMA-appraisal).

The original PoC patches [1] created a new CLONE_NEWIMA flag to
explicitly control when a new IMA namespace should be created. Based on
comments, we elected to hang the IMA namepace off of existing namespaces,
and the mount namespace made the most sense. In this version of the patches
we are adding a pointer to the mnt_namespace pointing to the ima_namespace.
Both are now tied together and joining the mnt_namespace with setns()
also joins the ima_namespace that was created along with it.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch uses these flags
for namespacing the IMA-audit messages, enabling the same file to be
audited each time it is accessed in a new namespace.

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: mamespace audit status flags

Yuqiong Sun (1):
  ima: extend clone() with IMA namespace support

 fs/mount.h                               |  14 --
 fs/namespace.c                           |  29 +++-
 include/linux/ima.h                      |  70 ++++++++++
 include/linux/mount.h                    |  20 ++-
 init/Kconfig                             |  10 ++
 kernel/nsproxy.c                         |   1 +
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  47 ++++++-
 security/integrity/ima/ima_api.c         |   8 +-
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  44 ++++++
 security/integrity/ima/ima_main.c        |  15 +-
 security/integrity/ima/ima_ns.c          | 230 +++++++++++++++++++++++++++++++
 13 files changed, 469 insertions(+), 26 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
