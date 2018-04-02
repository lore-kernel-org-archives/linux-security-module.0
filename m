From: jmorris@namei.org (James Morris)
Date: Mon, 2 Apr 2018 21:20:30 +1000 (AEST)
Subject: [GIT PULL][SECURITY] general changes for v4.17
Message-ID: <alpine.LRH.2.21.1804022107260.30102@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these changes for the security subsystem.

In this patchset:

- Convert security hooks from list to hlist, a nice cleanup, saving about 
50% of space, from Sargun Dhillon.

- Only pass the cred, not the secid, to kill_pid_info_as_cred and 
security_task_kill (as the secid can be determined from the cred), from 
Stephen Smalley.

- Close a potential race in kernel_read_file(), by making the file 
unwritable before calling the LSM check (vs after), from Kees Cook.

Once this is merged, I'll send separate pull requests for TPM, Integrity, 
Smack, and the new kernel lockdown feature.  All of these have been in 
linux-next and tested by the SELinux testsuite.


The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to df0ce17331e2501dbffc060041dfc6c5f85227b5:

  security: convert security hooks to use hlist (2018-03-31 13:18:27 +1100)

----------------------------------------------------------------
James Morris (2):
      Merge tag 'v4.16-rc2' into next-general
      Merge tag 'v4.16-rc6' into next-general

Kees Cook (1):
      exec: Set file unwritable before LSM check

Sargun Dhillon (1):
      security: convert security hooks to use hlist

Stephen Smalley (1):
      usb, signal, security: only pass the cred, not the secid, to kill_pid_info_as_cred and security_task_kill

 drivers/usb/core/devio.c                      |  10 +-
 fs/exec.c                                     |   6 +-
 include/linux/lsm_hooks.h                     | 433 +++++++++++++-------------
 include/linux/sched/signal.h                  |   2 +-
 include/linux/security.h                      |   4 +-
 kernel/signal.c                               |   6 +-
 scripts/gcc-plugins/randomize_layout_plugin.c |   4 +-
 security/apparmor/lsm.c                       |  17 +-
 security/security.c                           |  26 +-
 security/selinux/hooks.c                      |   7 +-
 security/smack/smack_lsm.c                    |  12 +-
 11 files changed, 265 insertions(+), 262 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
