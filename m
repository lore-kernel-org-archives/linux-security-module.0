From: guilherme.magalhaes@hpe.com (Guilherme Magalhaes)
Date: Thu, 11 May 2017 10:59:52 -0300
Subject: [RFC 00/11] ima: namespace support for IMA policy
Message-ID: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The IMA policy rules and policy/appraise flags are now encapsulated on a new
structure which completely describes the policy for a given namespace. The 
correct namespace structure is retrieved from a radix tree based on the 
namespace id in use by the process in the context whenever the IMA policy 
rules or flags are needed. The existent securityfs interface is reused to 
define policy per namespace. A new namespace file is used to create a 
folder for a given namespace id with a policy file which can then be used 
to define rules for that namespace.

Patches 1, 2 and 4 qualify the file pathname considering multiple namespaces.
Patch 3 adds a new kernel config which enables all the policy per namespace 
functionality.
Patch 5 adds the namespace securityfs file which is the interface to define
IMA policy per namespace. New policy file is creanted for each namespace and
the policy securityfs mechanism is completely reused.
Patche 7 adds a hook to fs/namespace.c to automatically delete all namespace
IMA policy resources such as radix tree entry and securityfs files.
Patches 8, 10, 11 and 14 are small implementation details
Patches 6, 9, 12 are key changes to encapsulate all policy rules and flags in
a structure per namespace. The correct structure is retrieved for the target
namespace and the namespace rules are used on that context.
Patch 13 adds the enforce_ns appraise mode which enables different appraise 
modes per namespace.

Other areas might still need work to completely namespace IMA. For instance, 
EVM and templates per namespace are not yet covered.

Guilherme Magalhaes (11):
  ima: qualify pathname in audit info record
  ima: qualify pathname in audit measurement record
  ima: qualify pathname in measurement file
  ima: add support to namespace securityfs file
  ima: store new namespace policy structure in a radix tree
  ima, fs: release namespace policy resources
  ima: new namespace policy structure to track initial namespace policy
    data
  ima: block initial namespace id on the namespace policy interface
  ima: delete namespace policy securityfs file in write-once mode
  ima: handling all policy flags per namespace using ima_ns_policy
    structure
  ima: appraise mode per namespace with new enforce_ns appraise mode

 fs/namespace.c                            |   4 +
 include/linux/integrity.h                 |   9 +
 security/integrity/ima/Kconfig            |   8 +
 security/integrity/ima/ima.h              |  78 ++++-
 security/integrity/ima/ima_api.c          |  14 +-
 security/integrity/ima/ima_appraise.c     |  30 +-
 security/integrity/ima/ima_fs.c           | 454 ++++++++++++++++++++++++++++--
 security/integrity/ima/ima_init.c         |  13 +-
 security/integrity/ima/ima_main.c         |  40 ++-
 security/integrity/ima/ima_policy.c       | 210 +++++++++++---
 security/integrity/ima/ima_template.c     |  10 +-
 security/integrity/ima/ima_template_lib.c |  70 +++++
 security/integrity/ima/ima_template_lib.h |  13 +
 security/integrity/integrity_audit.c      |   5 +
 14 files changed, 860 insertions(+), 98 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
