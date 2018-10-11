Return-Path: <SRS0=pW3O=MX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27520C677FC
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDC32075C
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 19:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDC32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJLDCT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:02:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbeJLDCT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Oct 2018 23:02:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BJTlmi132070
        for <linux-security-module@vger.kernel.org>; Thu, 11 Oct 2018 15:33:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2c769kn0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 11 Oct 2018 15:33:38 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 20:33:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 20:33:34 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BJXXmW5570992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 19:33:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17545204E;
        Thu, 11 Oct 2018 22:33:05 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.86.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3E4435205A;
        Thu, 11 Oct 2018 22:33:05 +0100 (BST)
Subject: [GIT PULL] linux-integrity patches for Linux 4.20
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Thu, 11 Oct 2018 15:33:21 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101119-0028-0000-0000-00000305DAAA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101119-0029-0000-0000-000023C039C5
Message-Id: <1539286401.11939.110.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110183
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

Sorry for the delay.  This pull request contains a couple of bug
fixes, including one for a recent problem with calculating file hashes
on overlayfs, and some code cleanup.

Mimi

The following changes since commit
e6123c524064a571616ec978b1317f1696eff0ae:

  security: fix LSM description location (2018-10-09 12:18:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git next-integrity

for you to fetch changes up to
34bccd61b139dbb452421aebf480e7af5f7a12ed:

  MAINTAINERS: add Jarkko as maintainer for trusted keys (2018-10-11
12:10:16 -0400)

----------------------------------------------------------------
Eric Biggers (4):
      vfs: require i_size <= SIZE_MAX in kernel_read_file()
      security/integrity: constify some read-only data
      security/integrity: remove unnecessary 'init_keyring' variable
      ima: fix showing large 'violations' or
'runtime_measurements_count'

Goldwyn Rodrigues (1):
      ima: open a new file instance if no read permissions

Mimi Zohar (1):
      MAINTAINERS: add Jarkko as maintainer for trusted keys

 MAINTAINERS                           |  1 +
 fs/exec.c                             |  8 +++---
 security/integrity/digsig.c           | 10 ++-----
 security/integrity/evm/evm_crypto.c   |  4 +--
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_api.c      |  3 +-
 security/integrity/ima/ima_crypto.c   | 54 ++++++++++++++++++++++--
-----------
 security/integrity/ima/ima_fs.c       |  9 +++---
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_template.c | 11 +++----
 11 files changed, 59 insertions(+), 47 deletions(-)

