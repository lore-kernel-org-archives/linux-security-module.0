From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 07 Nov 2017 08:37:35 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <1510061855.3425.113.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Roberto,

On Tue, 2017-11-07 at 11:36 +0100, Roberto Sassu wrote:
> IMA is a security module with the objective of reporting or enforcing the
> integrity of a system, by measuring files accessed with the execve(),
> mmap() and open() system calls. For reporting, it takes advantage of the
> TPM and extends a PCR with the digest of an evaluated event. For enforcing,
> it returns a value which is zero if the operation should be allowed,
> negative if it should be denied.
> 
> Measuring files of an operating system introduces three main issues. First,
> since the overhead introduced by the TPM is noticeable, the performance of
> the system decreases linearly with the number of measurements taken. This
> can be seen especially at boot time.

I've said this previously. ?The solution IS FIRST to improve the
performance of the TPM device driver, before finding solutions around
it.

TPM performance patches:
a233a0289cf9 "tpm: msleep() delays - replace with usleep_range() in i2c nuvoton driver"
0afb7118ae02 "tpm: add sleep only for retry in i2c_nuvoton_write_status()"
9f3fc7bcddcb "tpm: replace msleep() with  usleep_range() in TPM 1.2/2.0 generic drivers"

Nayna Jain submitted additional performance improvements, that were posted
https://www.spinics.net/lists/linux-integrity/msg00238.html?and are
currently being tested.

Even after these TPM performance improvements, there are still more
TPM performance improvements.

> Second, managing large measurement
> lists requires computation power and network bandwidth.

"Large" for whom? ?Large for the attestation server? ?Large for the
client? ?Smaller devices would have fewer measurements than larger
devices. ?We're not discussing gigabytes/terabytes of data here.
?Attestation servers should be able to handle the bandwidth. ?If it
becomes a problem, then the attestation server/client communication
could be optimized to send just the recent measurements, not the
entire measurement list.

> Third, it is
> necessary to obtain reference measurements (i.e. digests of software known
> to be good) to evaluate/enforce the integrity of the system. If file
> signatures are used to enforce access, Linux distribution vendors have to
> modify their building systems in order to include signatures in their
> packages.

Although IMA-appraisal verifies file integrity based on either a file
hash or signature, they are not equivalent. ?File signatures provide
file provenance. ?Not only does the file hash have to match, but a
certificate used to sign the file data must be loaded onto the IMA
keyring. ?File hashes should be limited to mutable files.

Instead of working around the problem of a lack of file signatures in
software packages, help promote including them so that there are
measurement and signature chains of trust anchored in hardware.

> Digest lists aim at mitigating these issues. A digest list is a list of
> digests that are taken by IMA as reference measurements and loaded before
> files are accessed. Then, IMA compares calculated digests of accessed files
> with digests from loaded digest lists. If the digest is found, measurement,
> appraisal and audit are not performed.

Although the previous patch set did not break userspace per-se, it
changed the existing meaning of the IMA measurement list. ?Without
taking into account my previous comments, this patch set makes similar
changes to IMA-appraisal and IMA-measurement.

Instead of including the individual file measurements, the previous
version of this patch set, I assume it hasn't changed, includes a hash
of a file containing a list of all potential file measurements, not
the actual file measurements.

Instead of changing the meaning of the IMA measurement list, I
previously suggested defining a new securityfs file for this purpose.

> Multiple digest lists can be loaded at the same time, by providing to IMA
> metadata for each list: digest, signature and path. The digest is specified
> so that loaded digest lists can be identified only with the measurement of
> metadata. The signature is used for appraisal. If the verification
> succeeds, IMA loads the digest list even if security.ima is missing.

Previously IMA-appraisal verified the file signature of the file
containing the file hashes. ?It now sounds like even this guarantee is
gone.

Normally, the protection of kernel memory is out of scope for IMA.
This patch set introduces an in kernel white list, which would be a
prime target for attackers looking for ways of by-passing IMA-
measurement, IMA-appraisal and IMA-audit. ?Others might disagree, but
from my perspective, this risk is too high.

Mimi

> Digest lists address the first issue because the TPM is used only if the
> digest of a measured file is unknown. On a minimal system, 10 of 1400
> measurements are unknown because of mutable files (e.g. log files).
> 
> Digest lists mitigate the second issue because, since digest lists do not
> change, they don't have to be sent at every remote attestation. Sending
> unknown measurements and a reference to digest lists would be sufficient.
> 
> Finally, digest lists address also the third issue because Linux
> distribution vendors already provide the digests of files included in each
> RPM package. The digest list is stored in the RPM header, signed by the
> vendor.
> 
> When using digest lists, a limitation must be considered. Since a
> measurement is not reported if the digest of an accessed file is found in a
> digest list, the measurement list does not show which files have been
> actually accessed, and in which sequence.
> 
> A possible solution would be to load a list with digest of files which are
> usually accessed. Also, it is possible to selectively enable digest list
> lookup only for a subset of IMA policy rules. For example, a policy could
> enable digest lookup only for file accesses from the TCB and disable it
> for execve() and mmap() from regular users.
> 
> Changelog
> 
> v1:
> - added new policy option digest_list to selectively enable digest lookup
> - added support for appraisal
> - added support for immutable/mutable files
> 
> Roberto Sassu (15):
>   ima: generalize ima_read_policy()
>   ima: generalize ima_write_policy()
>   ima: generalize policy file operations
>   ima: use ima_show_htable_value to show hash table data
>   ima: add functions to manage digest lists
>   ima: add parser of digest lists metadata
>   ima: add parser of compact digest list
>   ima: add parser of RPM package headers
>   ima: introduce securityfs interfaces for digest lists
>   ima: disable digest lookup if digest lists are not checked
>   ima: add policy action digest_list
>   ima: do not update security.ima if appraisal status is not
>     INTEGRITY_PASS
>   evm: add kernel command line option to select protected xattrs
>   ima: add support for appraisal with digest lists
>   ima: add Documentation/security/IMA-digest-lists.txt
> 
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/security/IMA-digest-lists.txt     | 161 ++++++++++++
>  include/linux/evm.h                             |   6 +
>  include/linux/fs.h                              |   2 +
>  security/integrity/evm/evm_main.c               |  36 +++
>  security/integrity/iint.c                       |   1 +
>  security/integrity/ima/Kconfig                  |  19 ++
>  security/integrity/ima/Makefile                 |   1 +
>  security/integrity/ima/ima.h                    |  33 ++-
>  security/integrity/ima/ima_api.c                |   7 +-
>  security/integrity/ima/ima_appraise.c           |  52 +++-
>  security/integrity/ima/ima_digest_list.c        | 326 ++++++++++++++++++++++++
>  security/integrity/ima/ima_fs.c                 | 181 ++++++++-----
>  security/integrity/ima/ima_main.c               |  47 +++-
>  security/integrity/ima/ima_policy.c             |  33 ++-
>  security/integrity/ima/ima_queue.c              |  42 +++
>  security/integrity/integrity.h                  |  11 +
>  17 files changed, 877 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/security/IMA-digest-lists.txt
>  create mode 100644 security/integrity/ima/ima_digest_list.c
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
