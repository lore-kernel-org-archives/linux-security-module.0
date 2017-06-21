From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 16:02:13 -0400
Subject: [GIT PULL] IMA patches for 4.13
Message-ID: <1498075333.3200.11.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

This pull request contains a number of simple and not so simple clean
up patches, which are precursors to new features (eg. appended
signature support, TPM crypto agile templates), and other minor bug
fixes.

thanks,

Mimi

----
The following changes since commit cdac74ddf28e2f07319cc89446f9dea35d22d999:

  Merge branch 'smack-for-4.13' of git://github.com/cschaufler/smack-next into next (2017-06-21 11:30:20 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next

for you to fetch changes up to fc26bd50539b6f52aa75ffbaec7b083825ec5451:

  IMA: update IMA policy documentation to include pcr= option (2017-06-21 14:37:12 -0400)

----------------------------------------------------------------
Ben Hutchings (1):
      IMA: Correct Kconfig dependencies for hash selection

Eric Richter (1):
      IMA: update IMA policy documentation to include pcr= option

Geliang Tang (1):
      ima: use memdup_user_nul

Laura Abbott (1):
      ima: Add cgroups2 to the defaults list

Mimi Zohar (4):
      ima: extend the "ima_policy" boot command line to support multiple policies
      ima: define a set of appraisal rules requiring file signatures
      ima: define Kconfig IMA_APPRAISE_BOOTPARAM option
      ima: define is_ima_appraise_enabled()

Roberto Sassu (4):
      ima: introduce ima_parse_buf()
      ima: use ima_parse_buf() to parse measurements headers
      ima: use ima_parse_buf() to parse template data
      ima: fix get_binary_runtime_size()

Thiago Jung Bauermann (3):
      integrity: Small code improvements
      ima: Simplify policy_func_show.
      ima: Log the same audit cause whenever a file has no signature

Tycho Andersen (1):
      ima: fix up #endif comments

 Documentation/ABI/testing/ima_policy            |   8 +-
 Documentation/admin-guide/kernel-parameters.txt |  21 ++--
 include/linux/ima.h                             |   6 ++
 security/integrity/digsig_asymmetric.c          |   4 +-
 security/integrity/iint.c                       |   2 +-
 security/integrity/ima/Kconfig                  |  16 ++-
 security/integrity/ima/ima.h                    |  31 +++---
 security/integrity/ima/ima_appraise.c           |  16 ++-
 security/integrity/ima/ima_fs.c                 |  13 +--
 security/integrity/ima/ima_policy.c             | 106 +++++++++-----------
 security/integrity/ima/ima_queue.c              |   2 +-
 security/integrity/ima/ima_template.c           | 124 ++++++++----------------
 security/integrity/ima/ima_template_lib.c       |  61 ++++++++++++
 security/integrity/ima/ima_template_lib.h       |   6 ++
 security/integrity/integrity.h                  |   7 +-
 15 files changed, 239 insertions(+), 184 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
