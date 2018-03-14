From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 14 Mar 2018 17:20:16 -0300
Subject: [PATCH 0/4] Code improvements in integrity and IMA
Message-ID: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello,

These patches come from the "appended signatures support for IMA appraisal"
series. They are code improvements and cleanups and I decided to submit
them separately for a couple of reasons:

1. they stand on their own and could be included in v4.17;

2. this will simplify the original patch series a bit, by having it contain
   only the patches actually necessary to implement the feature.

These are the changes made to them since v5 of the modsig series:

- Patch "integrity: Remove unused macro IMA_ACTION_RULE_FLAGS"
  - New patch.

- Patch "ima: Improvements in ima_appraise_measurement()"
  - Moved is_ima_sig() to its own patch (not in this series).

Mimi Zohar (1):
  ima: Improvements in ima_appraise_measurement()

Thiago Jung Bauermann (3):
  integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
  ima: Simplify ima_eventsig_init()
  integrity: Introduce struct evm_xattr

 security/integrity/evm/evm_crypto.c       |  4 ++--
 security/integrity/evm/evm_main.c         | 10 ++++----
 security/integrity/ima/ima_appraise.c     | 40 ++++++++++++++++++-------------
 security/integrity/ima/ima_template_lib.c | 11 +++------
 security/integrity/integrity.h            |  6 ++++-
 5 files changed, 39 insertions(+), 32 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
