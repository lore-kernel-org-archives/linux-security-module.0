From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 4 Apr 2017 13:10:07 +0200
Subject: [PATCH 0/3] SELinux: Fine-tuning for two function implementations
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Message-ID: <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Apr 2017 13:02:03 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed memory allocation in policydb_index()
  Return an error code only as a constant in sidtab_insert()
  Use an other error code for an input validation failure in sidtab_insert()

 security/selinux/ss/policydb.c | 15 +++++----------
 security/selinux/ss/sidtab.c   | 27 ++++++++++-----------------
 2 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.12.2


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
