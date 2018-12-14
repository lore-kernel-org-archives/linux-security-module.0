Return-Path: <SRS0=mair=OX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEBC43178
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Dec 2018 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD0620656
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Dec 2018 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeLNNxP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:53:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbeLNNxO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Dec 2018 08:53:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEDqbrr069964
        for <linux-security-module@vger.kernel.org>; Fri, 14 Dec 2018 08:53:14 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pcca6vbue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 14 Dec 2018 08:53:09 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Dec 2018 13:52:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 13:52:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEDqhN133554598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 13:52:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6E9D52063;
        Fri, 14 Dec 2018 13:52:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.89.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 381DF52050;
        Fri, 14 Dec 2018 13:52:43 +0000 (GMT)
Subject: [GIT PULL] linux-integrity patches for Linux 4.21
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Fri, 14 Dec 2018 08:52:32 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121413-0020-0000-0000-000002F6F72A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121413-0021-0000-0000-000021473050
Message-Id: <1544795552.3879.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140122
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

In Linux 4.19, a new LSM hook named security_kernel_load_data was
upstreamed, allowing LSMs and IMA to prevent the kexec_load
syscall.  Different signature verification methods exist for verifying
the kexec'ed kernel image.  This pull request adds additional support
in IMA to prevent loading unsigned kernel images via the kexec_load
syscall, independently of the IMA policy rules, based on the runtime
"secure boot" flag.  An initial IMA kselftest is included.

In addition, this pull request defines a new, separate keyring named
".platform" for storing the preboot/firmware keys needed for verifying
the kexec'ed kernel image's signature and includes the associated IMA
kexec usage of the ".platform" keyring.

(David Howell's and Josh Boyer's patches for reading the
preboot/firmware keys, which were previously posted for a different
use case scenario, are included here.)

Mimi

The following changes since commit 26b76320a8a550472bbb8f42257df83fcb8d8df6:

  Merge tag 'v4.20-rc2' into next-general (2018-11-12 09:07:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to eed9de3b4f47114f440980203ca27c5fab70f529:

  ima: Use inode_is_open_for_write (2018-12-12 22:09:34 -0500)

----------------------------------------------------------------
Dave Howells (2):
      efi: Add EFI signature data types
      efi: Add an EFI signature blob parser

Eric Richter (1):
      x86/ima: define arch_get_ima_policy() for x86

Josh Boyer (2):
      efi: Import certificates from UEFI Secure Boot
      efi: Allow the "db" UEFI variable to be suppressed

Mimi Zohar (4):
      integrity: support new struct public_key_signature encoding field
      x86/ima: retry detecting secure boot mode
      ima: don't measure/appraise files on efivarfs
      selftests/ima: kexec_load syscall test

Nayna Jain (7):
      x86/ima: define arch_ima_get_secureboot
      ima: prevent kexec_load syscall based on runtime secureboot flag
      ima: refactor ima_init_policy()
      ima: add support for arch specific policies
      integrity: Define a trusted platform keyring
      integrity: Load certs to the platform keyring
      ima: Support platform keyring for kernel appraisal

Nikolay Borisov (1):
      ima: Use inode_is_open_for_write

Stefan Berger (1):
      docs: Extend trusted keys documentation for TPM 2.0

 Documentation/security/keys/trusted-encrypted.rst  |  31 +++-
 arch/x86/kernel/Makefile                           |   4 +
 arch/x86/kernel/ima_arch.c                         |  75 ++++++++
 include/linux/efi.h                                |  34 ++++
 include/linux/ima.h                                |  15 ++
 security/integrity/Kconfig                         |  11 ++
 security/integrity/Makefile                        |   5 +
 security/integrity/digsig.c                        | 110 ++++++++----
 security/integrity/digsig_asymmetric.c             |   1 +
 security/integrity/ima/Kconfig                     |  10 +-
 security/integrity/ima/ima_appraise.c              |  14 +-
 security/integrity/ima/ima_main.c                  |  21 ++-
 security/integrity/ima/ima_policy.c                | 171 +++++++++++++-----
 security/integrity/integrity.h                     |  23 ++-
 security/integrity/platform_certs/efi_parser.c     | 108 ++++++++++++
 security/integrity/platform_certs/load_uefi.c      | 194 +++++++++++++++++++++
 .../integrity/platform_certs/platform_keyring.c    |  58 ++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/ima/Makefile               |  11 ++
 tools/testing/selftests/ima/config                 |   4 +
 tools/testing/selftests/ima/test_kexec_load.sh     |  54 ++++++
 21 files changed, 863 insertions(+), 92 deletions(-)
 create mode 100644 arch/x86/kernel/ima_arch.c
 create mode 100644 security/integrity/platform_certs/efi_parser.c
 create mode 100644 security/integrity/platform_certs/load_uefi.c
 create mode 100644 security/integrity/platform_certs/platform_keyring.c
 create mode 100644 tools/testing/selftests/ima/Makefile
 create mode 100644 tools/testing/selftests/ima/config
 create mode 100755 tools/testing/selftests/ima/test_kexec_load.sh

