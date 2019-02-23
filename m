Return-Path: <SRS0=Scw7=Q6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6911C10F0B
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Feb 2019 21:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15C20651
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Feb 2019 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956730;
	bh=As7jo/wDN4MQQnrRe4af41siS39wE+PSEtqZl6MG9Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alKzsrFz3GZ59UGcqLOdRY6h/3HSDjzmIN2WkpM8OY8/aXvKxAzsfMIX/0+93ZKU2
	 ItpkAKKCEQcC1ojXZPOdkOQNIXXquJVsRmd9zSRIMe4C76rx+9oXtnussW0mMWatub
	 FKWE11QCyoDdq0Z0pBWUf4OWXyjDPq0/LPSxGhI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfBWVJf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfBWVJd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68D12085A;
        Sat, 23 Feb 2019 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956172;
        bh=As7jo/wDN4MQQnrRe4af41siS39wE+PSEtqZl6MG9Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQAggGkhfZSYcvxW5PS967QepDx+Ixs6dl9vfiNkCkpAUjxMt5gRQ/a4kZ7Tf/xPW
         6t7xqWFP0ergRL2ejghz0aDm33tGxr4mB/ghVZ2TdLHzI+cmuM37qm5ODdCCspXx4G
         Y0One5OHhQz2EUkdQeBsbHkT80CMrOiDtGVkLwto=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/45] apparmor: Fix aa_label_build() error handling for failed merges
Date:   Sat, 23 Feb 2019 16:08:27 -0500
Message-Id: <20190223210835.201708-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit d6d478aee003e19ef90321176552a8ad2929a47f ]

aa_label_merge() can return NULL for memory allocations failures
make sure to handle and set the correct error in this case.

Reported-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index dd754b7850a82..67bf8b7ee8a28 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1260,7 +1260,10 @@ int aa_change_profile(const char *fqname, int flags)
 					aa_get_label(&profile->label));
 		if (IS_ERR_OR_NULL(new)) {
 			info = "failed to build target label";
-			error = PTR_ERR(new);
+			if (!new)
+				error = -ENOMEM;
+			else
+				error = PTR_ERR(new);
 			new = NULL;
 			perms.allow = 0;
 			goto audit;
-- 
2.19.1

