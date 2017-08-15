From: keescook@chromium.org (Kees Cook)
Date: Tue, 15 Aug 2017 15:03:19 -0700
Subject: [GIT PULL] seccomp updates for next
Message-ID: <20170815220319.GA63342@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Please pull these seccomp changes for next.

Thanks!

-Kees

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next

for you to fetch changes up to f3e1821d9e1cc3fb434d7763001791dcd6720c90:

  selftests/seccomp: Test thread vs process killing (2017-08-14 13:46:50 -0700)

----------------------------------------------------------------
Major additions:
- sysctl and seccomp operation to discover available actions. (tyhicks)
- new per-filter configurable logging infrastructure and sysctl. (tyhicks)
- SECCOMP_RET_LOG to log allowed syscalls. (tyhicks)
- SECCOMP_RET_KILL_PROCESS as the new strictest possible action.
- self-tests for new behaviors.

----------------------------------------------------------------
Kees Cook (8):
      selftests/seccomp: Add tests for basic ptrace actions
      selftests/seccomp: Add simple seccomp overhead benchmark
      selftests/seccomp: Refactor RET_ERRNO tests
      seccomp: Provide matching filter for introspection
      seccomp: Rename SECCOMP_RET_KILL to SECCOMP_RET_KILL_THREAD
      seccomp: Introduce SECCOMP_RET_KILL_PROCESS
      seccomp: Implement SECCOMP_RET_KILL_PROCESS action
      selftests/seccomp: Test thread vs process killing

Tyler Hicks (6):
      seccomp: Sysctl to display available actions
      seccomp: Operation for checking if an action is available
      seccomp: Sysctl to configure actions that are allowed to be logged
      seccomp: Selftest for detection of filter flag support
      seccomp: Filter flag to log all actions except SECCOMP_RET_ALLOW
      seccomp: Action to log before allowing

 Documentation/networking/filter.txt                |   2 +-
 Documentation/sysctl/kernel.txt                    |   1 +
 Documentation/userspace-api/seccomp_filter.rst     |  52 +-
 include/linux/audit.h                              |   6 +-
 include/linux/seccomp.h                            |   3 +-
 include/uapi/linux/seccomp.h                       |  23 +-
 kernel/seccomp.c                                   | 321 ++++++++++-
 samples/seccomp/bpf-direct.c                       |   4 +-
 samples/seccomp/bpf-helper.h                       |   2 +-
 tools/testing/selftests/seccomp/Makefile           |  18 +-
 .../testing/selftests/seccomp/seccomp_benchmark.c  |  99 ++++
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 610 +++++++++++++++++----
 12 files changed, 1009 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/seccomp/seccomp_benchmark.c

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
