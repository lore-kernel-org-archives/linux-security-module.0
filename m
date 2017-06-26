From: keescook@chromium.org (Kees Cook)
Date: Mon, 26 Jun 2017 10:02:05 -0700
Subject: [GIT PULL] seccomp updates for next
Message-ID: <20170626170205.GA108402@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Please pull these seccomp changes for next. These are all tiny changes,
but I got delayed sending them to you. I'd like have these land for v4.13;
I should have sent them for v4.12. :P

Thanks!

-Kees

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next

for you to fetch changes up to 0b5fa2290637a3235898d18dc0e7a136783f1bd2:

  seccomp: Switch from atomic_t to recount_t (2017-06-26 09:24:00 -0700)

----------------------------------------------------------------
- cleans up some coding style issues
- adjusts selftests to work correctly under Bionic
- switch from atomic_t to refcount_t for usage tracking

----------------------------------------------------------------
Kees Cook (3):
      seccomp: Clean up core dump logic
      seccomp: Adjust selftests to avoid double-join
      seccomp: Switch from atomic_t to recount_t

 kernel/seccomp.c                              | 16 ++++-----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 51 ++++++++++++++++++---------
 2 files changed, 42 insertions(+), 25 deletions(-)

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
