From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:36:55 +0100
Subject: [PATCH v2 00/15] ima: digest list feature
Message-ID: <20171107103710.10883-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA is a security module with the objective of reporting or enforcing the
integrity of a system, by measuring files accessed with the execve(),
mmap() and open() system calls. For reporting, it takes advantage of the
TPM and extends a PCR with the digest of an evaluated event. For enforcing,
it returns a value which is zero if the operation should be allowed,
negative if it should be denied.

Measuring files of an operating system introduces three main issues. First,
since the overhead introduced by the TPM is noticeable, the performance of
the system decreases linearly with the number of measurements taken. This
can be seen especially at boot time. Second, managing large measurement
lists requires computation power and network bandwidth. Third, it is
necessary to obtain reference measurements (i.e. digests of software known
to be good) to evaluate/enforce the integrity of the system. If file
signatures are used to enforce access, Linux distribution vendors have to
modify their building systems in order to include signatures in their
packages.

Digest lists aim at mitigating these issues. A digest list is a list of
digests that are taken by IMA as reference measurements and loaded before
files are accessed. Then, IMA compares calculated digests of accessed files
with digests from loaded digest lists. If the digest is found, measurement,
appraisal and audit are not performed.

Multiple digest lists can be loaded at the same time, by providing to IMA
metadata for each list: digest, signature and path. The digest is specified
so that loaded digest lists can be identified only with the measurement of
metadata. The signature is used for appraisal. If the verification
succeeds, IMA loads the digest list even if security.ima is missing.

Digest lists address the first issue because the TPM is used only if the
digest of a measured file is unknown. On a minimal system, 10 of 1400
measurements are unknown because of mutable files (e.g. log files).

Digest lists mitigate the second issue because, since digest lists do not
change, they don't have to be sent at every remote attestation. Sending
unknown measurements and a reference to digest lists would be sufficient.

Finally, digest lists address also the third issue because Linux
distribution vendors already provide the digests of files included in each
RPM package. The digest list is stored in the RPM header, signed by the
vendor.

When using digest lists, a limitation must be considered. Since a
measurement is not reported if the digest of an accessed file is found in a
digest list, the measurement list does not show which files have been
actually accessed, and in which sequence.

A possible solution would be to load a list with digest of files which are
usually accessed. Also, it is possible to selectively enable digest list
lookup only for a subset of IMA policy rules. For example, a policy could
enable digest lookup only for file accesses from the TCB and disable it
for execve() and mmap() from regular users.

Changelog

v1:
- added new policy option digest_list to selectively enable digest lookup
- added support for appraisal
- added support for immutable/mutable files

Roberto Sassu (15):
  ima: generalize ima_read_policy()
  ima: generalize ima_write_policy()
  ima: generalize policy file operations
  ima: use ima_show_htable_value to show hash table data
  ima: add functions to manage digest lists
  ima: add parser of digest lists metadata
  ima: add parser of compact digest list
  ima: add parser of RPM package headers
  ima: introduce securityfs interfaces for digest lists
  ima: disable digest lookup if digest lists are not checked
  ima: add policy action digest_list
  ima: do not update security.ima if appraisal status is not
    INTEGRITY_PASS
  evm: add kernel command line option to select protected xattrs
  ima: add support for appraisal with digest lists
  ima: add Documentation/security/IMA-digest-lists.txt

 Documentation/admin-guide/kernel-parameters.txt |   4 +
 Documentation/security/IMA-digest-lists.txt     | 161 ++++++++++++
 include/linux/evm.h                             |   6 +
 include/linux/fs.h                              |   2 +
 security/integrity/evm/evm_main.c               |  36 +++
 security/integrity/iint.c                       |   1 +
 security/integrity/ima/Kconfig                  |  19 ++
 security/integrity/ima/Makefile                 |   1 +
 security/integrity/ima/ima.h                    |  33 ++-
 security/integrity/ima/ima_api.c                |   7 +-
 security/integrity/ima/ima_appraise.c           |  52 +++-
 security/integrity/ima/ima_digest_list.c        | 326 ++++++++++++++++++++++++
 security/integrity/ima/ima_fs.c                 | 181 ++++++++-----
 security/integrity/ima/ima_main.c               |  47 +++-
 security/integrity/ima/ima_policy.c             |  33 ++-
 security/integrity/ima/ima_queue.c              |  42 +++
 security/integrity/integrity.h                  |  11 +
 17 files changed, 877 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/security/IMA-digest-lists.txt
 create mode 100644 security/integrity/ima/ima_digest_list.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
