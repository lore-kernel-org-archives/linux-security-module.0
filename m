From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 5 Apr 2018 19:44:52 +0200
Subject: Updates on ima digest list feature
Message-ID: <90d641fa-27eb-5ffd-2b8a-9241dc86aa16@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi everyone

back in November, I submitted the second version of the patch set for
measuring and appraising files with digest lists
(https://lkml.org/lkml/2017/11/7/231).

For those who did not follow the previous discussion, the digest list
feature is an enhancement of Integrity Measurement Architecture (IMA)
which introduces a white list of file digests to the kernel. If the
digest of an accessed file is not found in the white list, a measurement
is reported (the standard behavior is to report every access depending
on the policy) and access to that file is denied if appraisal is
enabled.

Although this feature was initially developed to solve a performance
degradation due to the TPM, it became useful for other open issues.

Digest lists address the issue of availability of reference measurements
for remote attestation and appraisal. RPM packages and DEB repository
metadata already contain file digests and are signed by Linux vendors.
Including file signatures into packages wouldn't be necessary.

Digest lists also address the issue of unpredictability of PCR values,
since a PCR is extended only when unknown files are accessed. PCRs can
be useful to restrict the usage of the EVM key depending on the software
being executed on the system (now, unsealing depends only on boot
components), or restrict the usage of TPM keys for secure communication.

I developed a new patch set, by taking into consideration the comments
received for the previous version. Digest lists parsers have been moved
from kernel space to user space, PGP signature verification is now
supported and a different PCR (11) is used for measurements with
digest lists.

I'm providing some links:

- kernel patches (53d3a65aed39..b9febcfd9c84):

https://github.com/euleros/linux/commits/ima-digest-lists-v3

- documentation of the kernel patches

https://github.com/euleros/linux/wiki/IMA-Digest-Lists-Extension

- documentation of a user space tool

https://github.com/euleros/digest-list-tools/wiki

I also created binary packages for openSUSE Leap 42.3 and Fedora 27, for
simplyfing the installation process.

I would be happy to receive a feedback on the code or the packages.

Thanks

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
