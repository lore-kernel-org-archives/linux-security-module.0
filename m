Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D879C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  5 May 2022 13:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379268AbiEEN2l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 May 2022 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiEEN2h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 May 2022 09:28:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82CA554A1;
        Thu,  5 May 2022 06:24:56 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KvDv43rQjzhYWn;
        Thu,  5 May 2022 21:24:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 21:24:54 +0800
Received: from ubuntu1804.huawei.com (10.67.174.152) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 21:24:54 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH 0/3] Append line feed to files in securityfs
Date:   Thu, 5 May 2022 21:22:58 +0800
Message-ID: <20220505132301.124832-1-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.152]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patchset add line feed to files in securityfs which lack LF.

Wang Weiyang (3):
  securityfs: Append line feed to /sys/kernel/security/lsm
  evm: Append line feed to /sys/kernel/security/evm
  ima: Append line feed to ima/binary_runtime_measurements

 security/inode.c                   | 16 ++++++++++++++--
 security/integrity/evm/evm_secfs.c |  2 +-
 security/integrity/ima/ima_fs.c    |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.17.1

