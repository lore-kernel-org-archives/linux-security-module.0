Return-Path: <SRS0=+lL4=5Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24312C2BA19
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 03:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AE720768
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 03:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDIDjM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Apr 2020 23:39:12 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46159 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgDIDjM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Apr 2020 23:39:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tv02ywN_1586403548;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tv02ywN_1586403548)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 11:39:08 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] support to read and tune appraise mode in runtime
Date:   Thu,  9 Apr 2020 11:39:05 +0800
Message-Id: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Support the read and write operations of ima_appraise by adding a
securifyfs file 'appraise_mode'.

In order to tune appraise mode in runtime, writing a PKCS#7 signature
corresponding the signed content is required. The content should be off,
enforce, log or fix. Given a simple way to archive this:

$ echo -n off > mode
$ openssl smime -sign -nocerts -noattr -binary \
    -in mode -inkey <system_trusted_key> \
    -signer <cert> -outform der -out mode.p7s
$ sudo cat mode.p7s \
    > /sys/kernel/security/ima/appraise_mode

Note that the signing key must be a trust key located in
system trusted keyring. So even the root privilege cannot
simply disable the enforcement.

Tianjia Zhang (2):
  ima: support to read appraise mode
  ima: support to tune appraise mode in runtime

 security/integrity/ima/ima_fs.c | 134 +++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

-- 
2.17.1

