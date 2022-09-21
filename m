Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B32C6FA91
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Sep 2022 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIUNB4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIUNBw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Sep 2022 09:01:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CB8C45C;
        Wed, 21 Sep 2022 06:01:50 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXdjH1byBzMn8Z;
        Wed, 21 Sep 2022 20:57:07 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:01:48 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v5 0/2] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Wed, 21 Sep 2022 20:58:02 +0800
Message-ID: <20220921125804.59490-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

IMA happens to measure extra files if LSM based rules are specified and
the corresponding LSM is updating its policy.

The root cause is explained in the second patch.

GUO Zihua (2):
  ima: Simplify ima_lsm_copy_rule
  ima: Handle -ESTALE returned by ima_filter_rule_match()

 security/integrity/ima/ima_policy.c | 51 ++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 16 deletions(-)
---

v5:
  Updated code to avoid reusing rule. Fixed a potential mem leak caused
by race condition. Updated commit message for the first patch based on
Mimi's feedback.

v4:
  Use a tempory rule instead of updating the rule in place. To do that,
also update ima_lsm_copy_rule so we can make use of it.

v3:
  Update current rule instead of just retrying, as suggested by Mimi

v2:
  Fixes message errors pointed out by Mimi

-- 
2.17.1

