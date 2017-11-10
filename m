From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 10 Nov 2017 21:28:16 +0100
Subject: [PATCH 0/2] security/keys/trusted: Fine-tuning for two function
	implementations
Message-ID: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 21:21:12 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code in trusted_update()
  Use common error handling code in tpm_unseal()

 security/keys/trusted.c | 61 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
