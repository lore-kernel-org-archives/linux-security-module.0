Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D7EB64D7
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jun 2023 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjFUHoZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Jun 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUHoY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 03:44:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99C10D
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 00:44:22 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QmFnL2jPdzqVCP;
        Wed, 21 Jun 2023 15:41:42 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 15:44:18 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] device_cgroup: Fix kernel-doc warnings in device_cgroup
Date:   Wed, 21 Jun 2023 15:44:18 +0800
Message-ID: <20230621074418.497564-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix kernel-doc warnings in device_cgroup:

security/device_cgroup.c:835: warning: Excess function parameter
'dev_cgroup' description in 'devcgroup_legacy_check_permission'.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/device_cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 41fca6487ca3..dc4df7475081 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -822,7 +822,6 @@ struct cgroup_subsys devices_cgrp_subsys = {
 
 /**
  * devcgroup_legacy_check_permission - checks if an inode operation is permitted
- * @dev_cgroup: the dev cgroup to be tested against
  * @type: device type
  * @major: device major number
  * @minor: device minor number
-- 
2.25.1

