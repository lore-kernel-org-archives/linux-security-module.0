From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 26 Nov 2017 22:15:47 +0000
Subject: [RFC 0/3] Safe, dynamically (un)loadable LSMs
Message-ID: <20171126221545.GA13751@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset introduces safe dynamic LSM support. It does this via
SRCU-protected security hooks. It also EXPORT_SYMBOL_GPLs the symbols
required to perform runtime loading, and unloading. The patchset is
meant to introduce as little overhead as possible when not used.
Additionally, the functionality is disabled by default.

The SRCU was made safe to call from an interrupt context in the patch
"srcu: Allow use of Classic SRCU from both process and interrupt context"
(1123a6041654e8f889014659593bad4168e542c2) by Paolo Bonzini. Therefore
this mechanism is safe to use for traversal of the callback list,
even when a hook is called from the interrupt context.

Currently, this maintains an entirely seperate mechanism to attach hooks
because the hooks are behind managed static_keys to prevent overhead.
This is also done so sealable memory support could be added at a later
point. The callbacks currently include a percpu_counter, but that could
sit outside of the struct itself. This may also have a benefit that these
counters, could have __cacheline_aligned_in_smp. Although, in my testing
I was unable to find much performance delta with percpu_counters that
were not aligned.

It includes an example LSM that prevents specific time travel.

Sargun Dhillon (3):
  security: Add safe, dynamic (runtime-loadable) hook support
  LSM: Add statistics about the invocation of dynamic hooks
  LSM: Add an example sample dynamic LSM

 include/linux/lsm_hooks.h | 254 +++++++++++++++++++++++++++++++++++++
 samples/Kconfig           |   6 +
 samples/Makefile          |   2 +-
 samples/lsm/Makefile      |   4 +
 samples/lsm/lsm_example.c |  46 +++++++
 security/Kconfig          |  16 +++
 security/Makefile         |   2 +
 security/dynamic.c        | 316 ++++++++++++++++++++++++++++++++++++++++++++++
 security/dynamic.h        |  33 +++++
 security/dynamicfs.c      | 118 +++++++++++++++++
 security/inode.c          |   2 +
 security/security.c       |  66 +++++++++-
 12 files changed, 863 insertions(+), 2 deletions(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c
 create mode 100644 security/dynamic.c
 create mode 100644 security/dynamic.h
 create mode 100644 security/dynamicfs.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
