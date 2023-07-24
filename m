Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE593C0015E
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jul 2023 03:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGXDpX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Jul 2023 23:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGXDpT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jul 2023 23:45:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99373E5D;
        Sun, 23 Jul 2023 20:45:14 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8QvX2HcYztRZc;
        Mon, 24 Jul 2023 11:42:00 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 11:45:11 +0800
Message-ID: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
Date:   Mon, 24 Jul 2023 11:45:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     <ebiederm@xmission.com>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
From:   "Wenyu Liu(D)" <liuwenyu7@huawei.com>
Subject: [PATCH] kexec_lock:Fix comment for kexec_lock
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

kexec_mutex is replaced by an atomic variable in
56314b90fd43bd2444 (panic, kexec: make __crash_kexec() NMI safe).

Fix some comment that still using kexec_mutex.

Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
---
 kernel/kexec_file.c                | 2 +-
 security/integrity/ima/ima_kexec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..b5bbb2fe0668 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:  Buffer contents and memory parameters.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  * On successful return, @kbuf->mem will have the physical address of
  * the buffer in memory.
  *
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..ad133fe120db 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  */
 void ima_add_kexec_buffer(struct kimage *image)
 {
--
2.33.0
