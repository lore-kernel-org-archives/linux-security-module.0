From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 05 Jan 2018 08:43:36 -0500
Subject: [GIT PULL] linux-integrity patches for 4.16-security-next-general
Message-ID: <1515159816.4418.7.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

This pull request contains a mixture of bug fixes, code cleanup, and
new functionality.  Of note is the integrity cache locking fix, file
change detection, and support for a new EVM portable and immutable
signature type.

The re-introduction of the integrity cache lock (iint) fixes the
problem of attempting to take the i_rwsem shared a second time, when it
was previously taken exclusively.  Defining atomic flags resolves the
original iint/i_rwsem circular locking - accessing the file data vs.
modifying the file metadata.  Although it fixes the O_DIRECT problem as
well, a subsequent patch is needed to remove the explicit O_DIRECT
prevention.

For performance reasons, detecting when a file has changed and needs to
be re-measured, re-appraised, and/or re-audited, was limited to after
the last writer has closed, and only if the file data has changed.
Detecting file change is based on i_version.  For filesystems that do
not support i_version, remote filesystems, or userspace filesystems,
the file was measured, appraised and/or audited once and never
re-evaluated.  Now local filesystems, which do not support i_version or
are not mounted with the i_version option, assume the file has changed
and are required to re-evaluate the file.  This change does not address
detecting file change on remote or userspace filesystems.

Unlike file data signatures, which can be included and distributed in
software packages (eg. rpm, deb), the existing EVM signature, which
protects the file metadata, could not be included in software packages,
as it includes file system specific information (eg. i_ino, possibly
the UUID).  This pull request defines a new EVM portable and immutable
file metadata signature format, which can be included in software
packages.

thanks,

Mimi
---

The following changes since commit d21bd6898336a7892914d308d5e0868f0b863571:

  Sync to v4.15-rc3 for security subsystem developers to work against. (2017-12-11 17:01:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to a2a2c3c8580a9158bca61221648fd6d5c98c443a:

  ima: Use i_version only when filesystem supports it (2017-12-18 09:43:49 -0500)

----------------------------------------------------------------
Bruno E. O. Meneguele (1):
      ima: log message to module appraisal error

Dmitry Kasatkin (1):
      ima: re-introduce own integrity cache lock

Jeff Layton (1):
      integrity: remove unneeded initializations in integrity_iint_cache entries

Joe Perches (1):
      ima: Fix line continuation format

Matthew Garrett (2):
      EVM: Allow userland to permit modification of EVM-protected metadata
      EVM: Add support for portable signature format

Mimi Zohar (2):
      ima: relax requiring a file signature for new files with zero length
      ima: support new "hash" and "dont_hash" policy actions

Roberto Sassu (1):
      ima: pass filename to ima_rdwr_violation_check()

Sascha Hauer (1):
      ima: Use i_version only when filesystem supports it

 Documentation/ABI/testing/evm         | 54 +++++++++++++-------
 Documentation/ABI/testing/ima_policy  |  3 +-
 include/linux/integrity.h             |  1 +
 security/integrity/evm/evm.h          |  9 ++--
 security/integrity/evm/evm_crypto.c   | 75 +++++++++++++++++++++++----
 security/integrity/evm/evm_main.c     | 67 +++++++++++++++++-------
 security/integrity/evm/evm_secfs.c    | 20 ++++++--
 security/integrity/iint.c             |  4 +-
 security/integrity/ima/ima_api.c      |  2 +-
 security/integrity/ima/ima_appraise.c | 46 +++++++++--------
 security/integrity/ima/ima_main.c     | 95 +++++++++++++++++++++++++----------
 security/integrity/ima/ima_policy.c   | 30 ++++++++++-
 security/integrity/ima/ima_template.c | 11 ++--
 security/integrity/integrity.h        | 41 +++++++++------
 14 files changed, 333 insertions(+), 125 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
