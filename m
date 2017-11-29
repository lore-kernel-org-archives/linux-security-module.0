From: keescook@chromium.org (Kees Cook)
Date: Tue, 28 Nov 2017 16:38:19 -0800
Subject: [GIT PULL] seccomp updates for next
Message-ID: <20171129003819.GA30686@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Please pull these seccomp changes for next. This implements an interface
for examining seccomp filter metadata when using CRIU.

Thanks!

-Kees

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next

for you to fetch changes up to 26500475ac1b499d8636ff281311d633909f5d20:

  ptrace, seccomp: add support for retrieving seccomp metadata (2017-11-28 15:41:01 -0800)

----------------------------------------------------------------
add support for retrieving seccomp filter metadata (Tycho Andersen)

----------------------------------------------------------------
Tycho Andersen (2):
      seccomp: hoist out filter resolving logic
      ptrace, seccomp: add support for retrieving seccomp metadata

 include/linux/seccomp.h     |   8 ++++
 include/uapi/linux/ptrace.h |   6 +++
 kernel/ptrace.c             |   4 ++
 kernel/seccomp.c            | 106 +++++++++++++++++++++++++++++++-------------
 4 files changed, 94 insertions(+), 30 deletions(-)

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
