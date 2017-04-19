From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 19 Apr 2017 07:38:13 -0400
Subject: [GIT PULL] IMA patches for 4.12
Message-ID: <1492601893.3081.16.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

This pull request contains three patches - your __ro_after_init patch,
a bug fix and an IMA policy extension. ?They've been in linux-next for
quite some time.

Thanks,

Mimi

---
The following changes since commit ca97d939db114c8d1619e10a3b82af8615372dae:

  security: mark LSM hooks as __ro_after_init (2017-03-06 11:00:15 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next

for you to fetch changes up to 3dd0c8d06511c7c61c62305fcf431ca28884d263:

  ima: provide ">" and "<" operators for fowner/uid/euid rules. (2017-03-13 07:01:24 -0400)

----------------------------------------------------------------
Daniel Gl?ckner (1):
      ima: accept previously set IMA_NEW_FILE

James Morris (1):
      integrity: mark default IMA rules as __ro_after_init

Mikhail Kurinnoi (1):
      ima: provide ">" and "<" operators for fowner/uid/euid rules.

 security/integrity/ima/ima_appraise.c |   5 +-
 security/integrity/ima/ima_policy.c   | 123 +++++++++++++++++++++++++---------
 2 files changed, 94 insertions(+), 34 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
