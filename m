From: jmorris@namei.org (James Morris)
Date: Fri, 29 Sep 2017 08:33:13 +1000 (AEST)
Subject: [GIT PULL] security: keys fixes for v4.14-rc3
Message-ID: <alpine.LRH.2.21.1709290822590.15742@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Please pull these fixes for the keys subsystem.

Notable here is a rewrite of big_key crypto by Jason Donenfeld to address 
some issues in the original code.

>From Jason's commit log:

"This started out as just replacing the use of crypto/rng with 
get_random_bytes_wait, so that we wouldn't use bad randomness at boot 
time. But, upon looking further, it appears that there were even deeper 
underlying cryptographic problems, and that this seems to have been 
committed with very little crypto review. So, I rewrote the whole thing, 
trying to keep to the conventions introduced by the previous author, to 
fix these cryptographic flaws."

There has been positive review of the new code by Eric Biggers and Herbert 
Xu, and it passes basic testing via the keyutils test suite.  Eric also 
manually tested it.

Generally speaking, we likely need to improve the amount of crypto review 
for kernel crypto users including keys (I'll post a note separately to 
ksummit-discuss).


---

The following changes since commit 9cd6681cb1169e815c41af0265165dd1b872f228:
  Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2017-09-27 12:22:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.14-rc3

Eric Biggers (10):
      KEYS: fix cred refcount leak in request_key_auth_new()
      KEYS: don't revoke uninstantiated key in request_key_auth_new()
      KEYS: fix key refcount leak in keyctl_assume_authority()
      KEYS: fix key refcount leak in keyctl_read_key()
      KEYS: fix writing past end of user-supplied buffer in keyring_read()
      KEYS: prevent creating a different user's keyrings
      KEYS: prevent KEYCTL_READ on negative key
      KEYS: reset parent each time before searching key_user_tree
      KEYS: restrict /proc/keys by credentials at open time
      KEYS: use kmemdup() in request_key_auth_new()

James Morris (1):
      Merge commit 'keys-fixes-20170927' into fixes-v4.14-rc3

Jason A. Donenfeld (2):
      security/keys: properly zero out sensitive key material in big_key
      security/keys: rewrite all of big_key crypto

 include/linux/key.h              |    2 +
 security/keys/Kconfig            |    4 +-
 security/keys/big_key.c          |  139 ++++++++++++++++++--------------------
 security/keys/internal.h         |    2 +-
 security/keys/key.c              |    6 +-
 security/keys/keyctl.c           |   13 ++--
 security/keys/keyring.c          |   37 +++++-----
 security/keys/proc.c             |    8 +--
 security/keys/process_keys.c     |    6 +-
 security/keys/request_key_auth.c |   74 +++++++++-----------
 10 files changed, 139 insertions(+), 152 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
