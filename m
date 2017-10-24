From: brdeoliv@redhat.com (Bruno E. O. Meneguele)
Date: Tue, 24 Oct 2017 15:36:59 -0200
Subject: [PATCH v3 0/2] ima: change how MODULE_SIG_FORCE is checked on modules
	checking policy
Message-ID: <cover.1508865786.git.brdeoliv@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset ensure that IMA's modules checking policy:

    measure func=MODULE_CHECK uid=0

rely on the correct value of CONFIG_MODULE_SIG_FORCE, since the way it
is today the code completely ignores the module.sig_enforce cmdline
param, which behaves in a OR logic with the CONFIG value
(CONFIG_MODULE_SIG_FORCE || module.sig_enforce). That said, everytime a
module would load, in the current checking code, when the kernel was not
compiled with the CONFIG set the call to init_module syscall fails with
-EACCES:

# strace -f -v modprobe <any-module> | grep init_module
init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)

With this patchset the result would rely on the module.sig_enforce
cmdline as well. Once the CONFIG is not set, but the param is, the
result would be 'success', as it should be:

# strace -f -v modprobe <any-module> | grep init_module
init_module(0x7f9602d6e010, 386646, "") = 0

The patchset was tested in two different kernels: 4.13.6 (Fedora 27) and
4.14.0-rc4 (integrity-next tree).

Changes:
    v3: 
        1/2 - added dummy is_module_sig_enforced() function to the case
        where CONFIG_MODULES is not set and IMA=y.
    v2:
        1/2 - code changes to correct checkpatch.pl warnings.

Bruno E. O. Meneguele (2):
  module: export module signature enforcement status
  ima: check signature enforcement against cmdline param instead of
    CONFIG

 include/linux/module.h            |  7 +++++++
 kernel/module.c                   | 10 ++++++++++
 security/integrity/ima/ima_main.c |  6 +++---
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
