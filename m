Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182FECAAD2
	for <linux-security-module@archiver.kernel.org>; Sat, 27 Aug 2022 11:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiH0LPx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 27 Aug 2022 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiH0LPw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 27 Aug 2022 07:15:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126143880;
        Sat, 27 Aug 2022 04:15:50 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MFDbB2yTnznTYZ;
        Sat, 27 Aug 2022 19:13:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:15:48 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next v2 0/6] landlock: add chmod and chown support
Date:   Sat, 27 Aug 2022 19:12:09 +0800
Message-ID: <20220827111215.131442-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

v2:
 * abstract walk_to_visible_parent() helper
 * chmod and chown rights only take affect on directory's context
 * add testcase for fchmodat/lchown/fchownat
 * fix other review issues

Xiu Jianfeng (6):
  landlock: expand access_mask_t to u32 type
  landlock: abstract walk_to_visible_parent() helper
  landlock: add chmod and chown support
  landlock/selftests: add selftests for chmod and chown
  landlock/samples: add chmod and chown support
  landlock: update chmod and chown support in document

 Documentation/userspace-api/landlock.rst     |   9 +-
 include/uapi/linux/landlock.h                |  10 +-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/fs.c                       | 110 ++++++--
 security/landlock/limits.h                   |   2 +-
 security/landlock/ruleset.h                  |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
 9 files changed, 386 insertions(+), 31 deletions(-)

-- 
2.17.1

