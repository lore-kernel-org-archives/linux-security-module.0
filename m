From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:23 -0700
Subject: [PATCH v5 00/15] exec: Use sane stack rlimit under secureexec
Message-ID: <1501614998-62619-1-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Based Linus's comments, my intent is to carry this series for -next and
send it as a distinct pull request during the v4.14 merge window. I'm
happy to adjust this plan as needed.

Changes from v4:
- fixed typo introduced during patch reordering
- rebased to v4.13-rc2 (mainly apparmor changes)
- fixed bisect error if building only to patch 7 and 8 under !CONFIG_SECURITY
- added more Acks/Reviews

Main cover letter contents:


As discussed with Linus and Andy, we need to reset the stack rlimit
before we do memory layouts when execing a privilege-gaining (e.g.
setuid) program. To do this, we need to know the results of the
bprm_secureexec hook before memory layouts. As it turns out, this
can be made _mostly_ trivial by collapsing bprm_secureexec into
bprm_set_creds.

The LSMs using bprm_secureexec nearly always save state between
bprm_set_creds and bprm_secureexec. In the face of multiple calls to
bprm_set_creds (via prepare_binprm() calls from binfmt_script, etc),
all LSMs except commoncap only pay attention to the first call, so
that aligns well with collapsing bprm_secureexec into bprm_set_creds.
The commoncaps, though, needs to check the _last_ bprm_set_creds, so
this series just swaps one bprm flag for another (cap_effective is no
longer needed to save state between bprm_set_creds and bprm_secureexec,
but we do need to keep a separate state, so we add the cap_elevated flag).

Once secureexec is available to setup_new_exec() before the memory
layout, we can add an rlimit sanity-check for setuid execs. (With no
need to clean up since we're past the point of no return.)

Along the way, this fixes comments, renames a variable, and consolidates
dumpability and pdeath_signal clearing, which includes some commit log
archeology to examine the subtle differences between what we had and
what we need.

Several folks have looked at this already (thank you!) but I'd appreciate
any other eyes on this to make sure it isn't broken in some special
way. Looking at the diffstat, even after all my long comments, this is
a net reduction in lines. :)

Thanks!

-Kees
----------------------------------------------------------------
Kees Cook (15):
      exec: Rename bprm->cred_prepared to called_set_creds
      exec: Correct comments about "point of no return"
      binfmt: Introduce secureexec flag
      apparmor: Refactor to remove bprm_secureexec hook
      selinux: Refactor to remove bprm_secureexec hook
      smack: Refactor to remove bprm_secureexec hook
      commoncap: Refactor to remove bprm_secureexec hook
      commoncap: Move cap_elevated calculation into bprm_set_creds
      LSM: drop bprm_secureexec hook
      exec: Use secureexec for setting dumpability
      exec: Use secureexec for clearing pdeath_signal
      smack: Remove redundant pdeath_signal clearing
      exec: Consolidate dumpability logic
      exec: Use sane stack rlimit under secureexec
      exec: Consolidate pdeath_signal clearing

 fs/binfmt_elf.c                    |  2 +-
 fs/binfmt_elf_fdpic.c              |  2 +-
 fs/binfmt_flat.c                   |  2 +-
 fs/exec.c                          | 56 ++++++++++++++++++++++++++++----------
 include/linux/binfmts.h            | 24 ++++++++++++----
 include/linux/lsm_hooks.h          | 14 ++++------
 include/linux/security.h           |  7 -----
 security/apparmor/domain.c         | 21 ++------------
 security/apparmor/include/domain.h |  1 -
 security/apparmor/include/file.h   |  3 --
 security/apparmor/lsm.c            |  1 -
 security/commoncap.c               | 50 ++++++++--------------------------
 security/security.c                |  5 ----
 security/selinux/hooks.c           | 26 ++++--------------
 security/smack/smack_lsm.c         | 34 ++---------------------
 security/tomoyo/tomoyo.c           |  2 +-
 16 files changed, 91 insertions(+), 159 deletions(-)

v5:
- fixed typo introduced during patch reordering
- rebased to v4.13-rc2 (mainly apparmor changes)
- fixed bisect error if building only to patch 7 and 8 under !CONFIG_SECURITY
- added more Acks/Reviews

v4:
- add {Ack,Review,Test}ed-bys
- reorder patches to move trivial refactoring to the front
- move secureexec flag set earlier in the series to setup_new_exec(); amluto

v3:
- collapse brpm_secureexec into bprm_set_creds; ebiederm.
- continue to improve various comments

v2:
- fix missed current_security() uses in LSMs.
- research/consolidate dumpability setting logic
- research/consolidate pdeath_signal clearing logic
- split up logical steps a little more for easier review (and bisection)
- fix some old broken comments
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
