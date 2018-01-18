From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 18 Jan 2018 17:31:16 -0500
Subject: [GIT PULL] IMA bug fix for 4.16
Message-ID: <1516314676.3772.20.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Sorry, here's one last patch for 4.16.

thanks,

Mimi

---
 
The following changes since commit a2a2c3c8580a9158bca61221648fd6d5c98c443a:

  ima: Use i_version only when filesystem supports it (2017-12-18 09:43:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 36447456e1cca853188505f2a964dbbeacfc7a7a:

  ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)

----------------------------------------------------------------
Mike Rapoport (1):
      ima/policy: fix parsing of fsuuid

 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
