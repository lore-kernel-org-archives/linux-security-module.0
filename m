From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:01 +0100
Subject: [RFC][PATCH v2 0/9] ima: integrity models for appraised files
Message-ID: <20171130105610.15761-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

=======
CONTENT
=======

PATCH 1/9, PATCH 2/9: bug fix
PATCH 3/9: optimization
PATCH 4/9, PATCH 5/9: check inherited file descriptors
PATCH 6/9, PATCH 7/9: enforce integrity policies
PATCH 8/9: new policy action
PATCH 9/9: exclude mutable files from measurement


=============
PREREQUISITES
=============

ima: Store measurement after appraisal
https://patchwork.kernel.org/patch/10013259/

security: Add a cred_getsecid hook
https://patchwork.kernel.org/patch/10028005/

IMA: Support using new creds in appraisal policy
https://patchwork.kernel.org/patch/10028013/


====
GOAL
====

Protect the integrity of appraised files by enforcing the constraints of an
integrity model on top of existing LSMs. Use the appraisal status as a
criteria to determine if a file measurement should be added to the
measurement list.


==========
MOTIVATION
==========

Proposed changes are simple.

People will immediately benefit from this solution, as IMA is enabled on
most Linux distributions. Integrating a separate LSM would take more time.

Without existing LSMs, the separate LSM must assign its own labels. IMA can
work as a standalone solution.

The existing IMA behavior is not modified. Users can enable the new
behavior by specifying the desired integrity model in the kernel command
line.


Comment: TE should be used instead of Biba

Biba constraints can be checked also on TE, as shown in [1]. Information
flow analysis can be done with SELinux tools (e.g. setools).

Comment: dm-verity/dm-crypt should be used instead of IMA/EVM

These solutions protect an entire partition, while IMA/EVM can protect only
relevant files.

Comment: local appraisal does not replace remote attestation

Local appraisal does not replace remote attestation, but is part of a
solution to avoid unknown digests in the measurement list.

Comment: integrity model enforcement should be done in a separate LSM

This is discussed in REQ#3. Since IMA checks the read up constraint (when
it appraises files) and demotes TCB objects (removes security.ima), it
could also check the write down constraint.


=======
PROBLEM
=======

IMA measures files depending on criteria specified in the policy for
subjects and objects. The measurement list is sent to remote verifiers,
which determine if the system can be trusted to perform the desired tasks.

Measured files can be classified in three categories: executable code and
structured data can be verified by comparing reported digests with
reference values; unstructured data require mandatory access control
because remote verifiers cannot determine the impact of reading files with
unknown digests.

PRIMA (Policy-Reduced Integrity Measurement Architecture) [2] protects the
integrity of unstructured data by enforcing a SELinux policy, modified in
order to satisfy the constraints of the CW-Lite integrity model.


CW-Lite Integrity Requirements
==============================

REQ#1) Trusted Subjects: trusted subjects must be trusted by remote
                         verifiers;

REQ#2) Trusted Code/Data: the digest of code and unstructured data must be
                          found in a database of reference values;

REQ#3) Information Flows: all information flows to a trusted subject must
                          come from another trusted subject;

REQ#4) Initial Verification: the initial state of unstructured data must be
                             verified;

REQ#5) Filtering Interfaces: remote verifiers must be able to check that an
                             application is able to discard or filter
                             possibly malformed data read through the
                             declared interfaces;

REQ#6) Filtering Subjects: the permissions to read low-integrity data
                           through filtering interfaces must be granted
                           only to filtering subjects.


========
SOLUTION
========

REQ#1 - Trusted Subjects
========================

Remote verifiers can retrieve the set of trusted subjects from the IMA
policy.


REQ#2 - Trusted Code/Data
=========================

IMA can report the measurement of executable code and structured data.

IMA policy example (for each trusted subject):

measure func=CRED_CHECK subj_type=TCB_subject
measure func=MMAP_CHECK subj_type=TCB_subject mask=MAY_EXEC
measure func=FILE_CHECK subj_type=TCB_subject mask=^MAY_READ

However, with the third rule, both structured data and unstructured data
are measured. If appraisal is used, IMA could distinguish the data type
from security.ima (structured data has a digital signature, unstructured
data has an HMAC).


REQ#3 - Information Flows
=========================

Previous Work

Checking Biba constraints can be done also on TE, if trusted subjects are
represented with a type. The domain transition graph can be used as a
source for TCB candidates. The TCB is integrity-protected if the policy
does not allow TCB candidates to read objects that can be written by other
subjects. Information flows from non-TCB subjects to TCB subjects violate
Biba constraints.

Conflicts can be resolved by removing subjects and objects from the TCB (if
a functionality is not offered by the system), or adding new ones. Another
strategy is to assume, under the Clark-Wilson integrity model, that a
subject does not become compromised even if it reads low-integrity objects.
In this case, the subject must read those objects through a filtering
interface.

Current Proposal

Since security policies for general purpose systems have to support
different configurations, they often contain more permissions than those
required for a specific use case. Instead of adapting the policy,
integrity constraints can be enforced by an additional LSM depending on
labels assigned by existing LSMs. This would also reduce the likelihood
that constraints are violated, as constraints would be checked on actual
interactions.

New Integrity LSM - Stacking with existing LSMs
-----------------------------------------------

1) existing LSMs
2) New Integrity LSM
3) IMA


New Integrity LSM Policy - Biba Strict
--------------------------------------

neverallow TCB_subject non-TCB_object read
neverallow non-TCB_subject TCB_object write

This implies that the following filtered rules are allowed by SELinux + new
Integrity LSM:

allow TCB_subject non-TCB_object write
allow TCB_subject TCB_object write
allow TCB_subject TCB_object read

allow non-TCB_subject non-TCB_object write
allow non-TCB_subject non-TCB_object read
allow non-TCB_subject TCB_object read

Objects that belong to the TCB should be determined in advance. The minimum
set of TCB objects required by TCB subjects can be found by running the
applications and logging actual interactions. However, some interactions
could be missing as they might happen only if certain conditions are true.


IMA Policy - additional rules
-----------------------------

appraise obj_type=TCB_object
dont_measure obj_type=TCB_object valid_hmac (unstructured data)

The first rule protects the integrity of unstructured data against offline
attacks. The second rule (automatically applied if an integrity model is
selected) prevents IMA from adding unknown digests of unstructured data to
the measurement list if the HMAC is valid.

Appraisal denies access if the appraisal status is invalid. However,
the Biba integrity models would allow write-only operations by TCB subjects
on files with invalid appraisal status. The new policy action
'try_appraise' has been introduced to grant access regardless of the
appraisal status. security.ima is updated only if the appraisal status is
valid and there are no concurrent writes by non-TCB subjects. With
'try_appraise', the IMA policy should be:

appraise obj_type=TCB_object mask=^MAY_EXEC
appraise obj_type=TCB_object mask=^MAY_READ
try_appraise obj_type=TCB_object mask=^MAY_WRITE (update HMAC if valid)
dont_measure obj_type=TCB_object valid_hmac (unstructured data)


New Integrity LSM Policy - Low Watermark for Objects
----------------------------------------------------

neverallow TCB_subject non-TCB_object read
demote non-TCB_subject TCB_object write

It is not necessary to determine exactly which TCB objects are accessed by
TCB subjects. All can be included, and those that are written by non-TCB
subjects will be simply demoted.

The new Integrity LSM should keep track of which TCB objects have been
demoted, so that the next time they are accessed by TCB subjects, access is
denied. The list of demoted TCB objects must be stored persistently, and
obtained at the next reboot. IMA would still continue to appraise demoted
TCB objects and exclude them from measurement.

Alternatively, demoting TCB objects can be implemented by IMA. The new
Integrity LSM can request that IMA removes the HMAC for each demoted
object. The new Integrity LSM would not maintain the list of demoted
objects and access will be denied by IMA (missing HMAC).


New Integrity LSM Policy - Low Watermark for Objects - Demote only
------------------------------------------------------------------

demote non-TCB_subject TCB_object write

The read constraint on TCB subjects is removed. Instead of denying access,
IMA reports the violations by measuring files with missing/invalid HMAC
(which is removed for demoted TCB objects). Additionally, IMA should erase
the EVM key, as it could be misused after the system becomes compromised
due to reading non-TCB objects.

If IMA only demotes TCB objects, the new Integrity LSM is not necessary. It
would be also easier to enforce the write down constraint directly in IMA,
because the list of trusted subjects is specified in the IMA policy
(REQ#2). It would be sufficient to deny access to appraised files if they
are being written by a non-TCB subject.

To enforce integrity constraints in IMA, appraisal rules should contain
criteria for TCB subjects, so that appraisal verification is used to
check the read up constraint. The write down constraint is checked if an
integrity model is specified in the kernel command line.

Without the new Integrity LSM, the complete IMA policy should be:

appraise subj_type=TCB_subject mask=^MAY_EXEC (check read up)
appraise subj_type=TCB_subject mask=^MAY_READ (check read up)
try_appraise subj_type=TCB_subject mask=^MAY_WRITE (update HMAC if valid)

dont_measure obj_type=TCB_object valid_hmac (unstructured data)
measure func=CRED_CHECK subj_type=TCB_subject
measure func=MMAP_CHECK subj_type=TCB_subject mask=MAY_EXEC
measure func=FILE_CHECK subj_type=TCB_subject mask=^MAY_READ

The kernel command line should contain:

ima_integrity_model=biba-strict (or low-watermark-obj)


REQ#4 - Initial Verification
============================

Previous work

PRIMA authors proposed to verify the initial state of unstructured data at
every boot and to report to remote verifiers the measurement of the
verification tool and the verification result. This solution seems
impractical, as it requires having knowledge of the data format of verified
files.

Current proposal

IMA/EVM protect the integrity of appraised files against offline attacks.
If the EVM key can be used only when the system satisfies REQ#1, REQ#2 and
REQ#3, then the integrity status is preserved across boots. It would seem
to a remote verifier that the system never rebooted.

Then, remote verifiers only have to check that the initial state of
unstructured data was good at the first access. A system might prove that
the EVM key can be unsealed only if that system accepts files signed with a
specific key.


REQ#5 - Filtering Interfaces
============================

Previous work

PRIMA requires that SELinux is modified to grant additional permissions to
processes with filtering interfaces. Those processes would be allowed to
read low-integrity data, even if the additional permissions violate Biba
constraints.

Current proposal

If integrity constraints are enforced by the new Integrity LSM or IMA, it
would be possible to specify which constraints should be relaxed without
modifying the SELinux policy.


REQ#6 - Filtering Subjects
==========================

Previous work

Applications should request that SELinux enables the permissions to read
low-integrity data.

Current proposal

The new Integrity LSM or IMA could expose an interface which would allow
applications to specify when constraints should be relaxed.


==========
REFERENCES
==========

[1] Analyzing Integrity Protection in the SELinux Example Policy
    by Trent Jaeger, Reiner Sailer, and Xiaolan Zhang
[2] PRIMA: Policy-Reduced Integrity Measurement Architecture
    by Trent Jaeger, Reiner Sailer, and Umesh Shankar

Roberto Sassu (9):
  ima: pass filename to ima_rdwr_violation_check()
  ima: preserve flags in ima_inode_post_setattr() if file must be
    appraised
  ima: preserve iint flags if security.ima update is successful
  ima: introduce ima_mk_null_file()
  ima: measure/appraise/audit inherited file descriptors
  ima: enforce the Biba strict policy on appraised files
  ima: enforce the Biba low watermark for objects policy on appraised
    files
  ima: introduce policy action try_appraise
  ima: don't measure files with valid appraisal status

 Documentation/admin-guide/kernel-parameters.txt |   4 +
 security/integrity/ima/ima.h                    |  24 +++-
 security/integrity/ima/ima_appraise.c           | 142 ++++++++++++++++++++++--
 security/integrity/ima/ima_fs.c                 |  57 ++++++++++
 security/integrity/ima/ima_main.c               | 125 ++++++++++++++++++---
 security/integrity/ima/ima_policy.c             |  16 ++-
 security/integrity/integrity.h                  |   1 +
 7 files changed, 338 insertions(+), 31 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
