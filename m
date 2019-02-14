Return-Path: <SRS0=hpNi=QV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E933C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 14:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2621927
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 14:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBNOEs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:04:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731159AbfBNOEs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Feb 2019 09:04:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EE25Yr023989
        for <linux-security-module@vger.kernel.org>; Thu, 14 Feb 2019 09:04:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qn8wgc13e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 14 Feb 2019 09:04:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Feb 2019 14:04:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 14:04:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EE4Nmu4522440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 14:04:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4BD211C04C;
        Thu, 14 Feb 2019 14:04:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 320A911C05B;
        Thu, 14 Feb 2019 14:04:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.92.83])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 14:04:23 +0000 (GMT)
Subject: [GIT PULL] linux-integrity patches for Linux 5.1
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Thu, 14 Feb 2019 09:04:12 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021414-0008-0000-0000-000002C073D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021414-0009-0000-0000-0000222C9686
Message-Id: <1550153052.4078.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140099
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

Linux 5.0 introduced the platform keyring to allow verifying the IMA
kexec kernel image signature using the pre-boot keys.  This pull
request similarly makes keys on the platform keyring accessible for
verifying the PE kernel image signature.*

Also included in this pull request is a new IMA hook that tags tmp
files, in policy, indicating the file hash needs to be calculated.
 The remaining patches are cleanup.

*Upstream commit "993a110319a4 (x86/kexec: Fix a kexec_file_load()
failure)" is required for testing.

Mimi

The following changes since commit 2181e084b26bddca22bc3f23364c15809cfed28b:

  LSM: SafeSetID: remove unused include (2019-01-30 12:29:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to e7fde070f39bc058c356cf366cb17ac2d643abb0:

  evm: Use defined constant for UUID representation (2019-02-04 17:36:01 -0500)

----------------------------------------------------------------
Andy Shevchenko (1):
      evm: Use defined constant for UUID representation

Kairui Song (2):
      integrity, KEYS: add a reference to platform keyring
      kexec, KEYS: Make use of platform keyring for signature verify

Mimi Zohar (2):
      encrypted-keys: fix Opt_err/Opt_error = -1
      ima: define ima_post_create_tmpfile() hook and add missing call

YueHaibing (1):
      evm: remove set but not used variable 'xattr'

 arch/x86/kernel/kexec-bzimage64.c        | 14 ++++++++++---
 certs/system_keyring.c                   | 23 ++++++++++++++++++++-
 fs/namei.c                               |  1 +
 include/keys/system_keyring.h            |  8 ++++++++
 include/linux/ima.h                      |  5 +++++
 include/linux/verification.h             |  1 +
 security/integrity/digsig.c              |  3 +++
 security/integrity/evm/evm_crypto.c      |  3 +--
 security/integrity/evm/evm_main.c        |  6 +-----
 security/integrity/ima/ima_main.c        | 35 ++++++++++++++++++++++++++++++--
 security/keys/encrypted-keys/encrypted.c |  4 ++--
 11 files changed, 88 insertions(+), 15 deletions(-)

