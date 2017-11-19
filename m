From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sat, 18 Nov 2017 22:26:58 -0500
Subject: [GIT PULL] integrity: fixes
Message-ID: <1511062018.6069.6.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Please forward this patch to Linus.

Thanks,

Mimi

The following changes since commit e5729f86a2987c9404f9b2fb494b9a6fc4412baf:

  ima: Remove redundant conditional operator (2017-11-08 15:16:36 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git security-next-integrity

for you to fetch changes up to bb6d4c0a616d7277cf8ef08de95b632b3f6533b1:

  ima: do not update security.ima if appraisal status is not INTEGRITY_PASS (2017-11-18 21:29:46 -0500)

----------------------------------------------------------------
Roberto Sassu (1):
      ima: do not update security.ima if appraisal status is not INTEGRITY_PASS

 security/integrity/ima/ima_appraise.c | 3 +++
 1 file changed, 3 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
