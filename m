From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:41 -0700
Subject: [PATCH 00/18] LSM: Prepare for explict LSM ordering
Message-ID: <20180916003059.1046-1-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This refactors the LSM registration and initialization infrastructure
to more centrally support different LSM types. What was considered a
"major" LSM is split into "exclusive" and future "blob sharing" (to be
added later). The "minor" LSMs become more well defined as a result.

Instead of continuing to (somewhat improperly) overload the kernel's
initcall system, this changes the LSM infrastructure to store a
registration structure (struct lsm_info) table instead, where metadata
about each LSM can be recorded (name, type, order, enable flag, init
function). This can be extended in the future to include things like
required blob size for the coming "blob sharing" LSMs.

The "major" LSMs had to individually negotiate which of them should be
enabled. This didn't provide a way to negotiate combinations of other
LSMs (as will be needed for "blob sharing" LSMs). This is solved by
providing the LSM infrastructure with all the details needed to make
the choice (exposing the per-LSM "enabled" flag, if used, the LSM type,
and ordering expectations).

In better defining the "minor" LSMs, it was possible to remove the
open-coded security_add_hooks() calls for "capability", "yama", and
"loadpin", and to redefine "integrity" properly as a "minor" LSM (it
actually defines _no_ hooks, but needs the early initialization).

With all LSMs being proessed centrally, it was possible to implement
sensible parsing of the "security=" boot commandline argument to provide
explicit ordering, which is helpful for the future "blob sharing" LSMs.

To better show LSMs activation some debug reporting was added (enabled
with the "lsm.debug" boot commandline option).

Finally, I added a WARN() around LSM initialization failures, which
appear to have always been silently ignored. (Realistically any LSM init
failures would have only been due to catastrophic kernel issues that
would render a system unworkable anyway, but it'd be better to expose
the problem as early as possible.)

-Kees

Kees Cook (18):
  vmlinux.lds.h: Avoid copy/paste of security_init section
  LSM: Rename .security_initcall section to .lsm_info
  LSM: Remove initcall tracing
  LSM: Convert from initcall to struct lsm_info
  vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
  LSM: Convert security_initcall() into DEFINE_LSM()
  LSM: Add minor LSM initialization loop
  integrity: Initialize as LSM_TYPE_MINOR
  LSM: Record LSM name in struct lsm_info
  LSM: Plumb visibility into optional "enabled" state
  LSM: Lift LSM selection out of individual LSMs
  LSM: Introduce ordering details in struct lsm_info
  LoadPin: Initialize as LSM_TYPE_MINOR
  Yama: Initialize as LSM_TYPE_MINOR
  capability: Initialize as LSM_TYPE_MINOR
  LSM: Allow arbitrary LSM ordering
  LSM: Provide init debugging
  LSM: Don't ignore initialization failures

 .../admin-guide/kernel-parameters.txt         |  15 +-
 arch/arc/kernel/vmlinux.lds.S                 |   1 -
 arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
 arch/arm64/kernel/vmlinux.lds.S               |   1 -
 arch/h8300/kernel/vmlinux.lds.S               |   1 -
 arch/microblaze/kernel/vmlinux.lds.S          |   2 -
 arch/powerpc/kernel/vmlinux.lds.S             |   2 -
 arch/um/include/asm/common.lds.S              |   2 -
 arch/xtensa/kernel/vmlinux.lds.S              |   1 -
 include/asm-generic/vmlinux.lds.h             |  25 +-
 include/linux/init.h                          |   2 -
 include/linux/lsm_hooks.h                     |  45 +++-
 include/linux/module.h                        |   1 -
 security/apparmor/lsm.c                       |  15 +-
 security/commoncap.c                          |   9 +-
 security/integrity/iint.c                     |   6 +-
 security/loadpin/loadpin.c                    |  11 +-
 security/security.c                           | 252 ++++++++++++++----
 security/selinux/hooks.c                      |  15 +-
 security/smack/smack_lsm.c                    |   7 +-
 security/tomoyo/tomoyo.c                      |   6 +-
 security/yama/yama_lsm.c                      |   8 +-
 22 files changed, 295 insertions(+), 133 deletions(-)

-- 
2.17.1
