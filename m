Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA68EC10F13
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 01:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9F20869
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 01:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDLBVq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:21:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726646AbfDLBVp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 21:21:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3C1E7tx049665
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 21:21:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtexakvnk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 21:21:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 12 Apr 2019 02:21:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 02:21:41 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3C1LelU51839186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 01:21:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A0B42042;
        Fri, 12 Apr 2019 01:21:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2C674203F;
        Fri, 12 Apr 2019 01:21:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.70])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 01:21:39 +0000 (GMT)
Subject: [GIT PULL] linux-integrity patches for Linux 5.2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Thu, 11 Apr 2019 21:21:29 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041201-0020-0000-0000-0000032EEF8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041201-0021-0000-0000-0000218122A7
Message-Id: <1555032089.4914.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120007
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

This pull request contains just three patches, the remainder are
either included in other pull requests (eg. audit, lockdown) or will
be upstreamed via other subsystems (eg. kselftests, Power).  Included
in this pull request is one bug fix, one documentation update, and
extending the x86 IMA arch policy rules to coordinate the different
kernel module signature verification methods.

Thanks,

Mimi


The following changes since commit 8d93e952fba216cd0811247f6360d97e0465d5fc:

  LSM: lsm_hooks.h: fix documentation format (2019-03-26 16:46:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-for-james

for you to fetch changes up to 41475a3ebaceb270e47a77356ddc30960354cb00:

  doc/kernel-parameters.txt: Deprecate ima_appraise_tcb (2019-04-10 16:41:01 -0400)

----------------------------------------------------------------
Mimi Zohar (2):
      x86/ima: require signed kernel modules
      x86/ima: add missing include

Petr Vorel (1):
      doc/kernel-parameters.txt: Deprecate ima_appraise_tcb

 Documentation/admin-guide/kernel-parameters.txt |  5 ++---
 arch/x86/kernel/ima_arch.c                      | 10 +++++++++-
 include/linux/module.h                          |  5 +++++
 kernel/module.c                                 |  5 +++++
 4 files changed, 21 insertions(+), 4 deletions(-)

