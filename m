From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 13 Aug 2017 16:43:15 +0200
Subject: [PATCH 0/4] SELinux: Fine-tuning for some function implementations
Message-ID: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 13 Aug 2017 16:25:43 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete eight unnecessary variable assignments
  Adjust jump targets in ebitmap_read()
  Delete an unnecessary return statement in ebitmap_destroy()
  Adjust five checks for null pointers

 security/selinux/selinuxfs.c   |  1 -
 security/selinux/ss/avtab.c    |  2 --
 security/selinux/ss/ebitmap.c  | 53 +++++++++++++++++++-----------------------
 security/selinux/ss/policydb.c | 10 ++------
 4 files changed, 26 insertions(+), 40 deletions(-)

-- 
2.14.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
