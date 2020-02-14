Return-Path: <SRS0=+399=4C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590EC3F68F
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624102168B
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703927;
	bh=Ni2uE3UrzUOKeHuUBp47BRf/YTw6+RTDvh2UjhiuMWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yt28QbGmh6++VirxBZUm9uk60BN5Uw/dnPqKCzy0AS8MLMvkZ7dBEJvIMyCggnJ6Y
	 kXnaS1v2ou08+2V0TYwHC/p1WKvi/o4gi6AmN43Hw/4gO+vJwN3BCxz0CpUpvPsZol
	 e0mtzyPQzRCpKb+rf82oiOx9twr0KpzgXuQIonUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgBNPxQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbgBNPxQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6522465D;
        Fri, 14 Feb 2020 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695596;
        bh=Ni2uE3UrzUOKeHuUBp47BRf/YTw6+RTDvh2UjhiuMWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zetdz+kUT07mO63PLzYlGX2wN4GNXUulW6SWAtDPO50seA1/1XBUnhpd4jv96BG7s
         uYK+pEK85v2lxS3E+JsC3PumYW0J8xJusI+wAGYr0PyfKGdGkt7WBO13+RVLkGRH7R
         mu/tNg3fNa/EmIFTkA///vpPivNYJ+NT0bx0SWnA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 201/542] IMA: Check IMA policy flag
Date:   Fri, 14 Feb 2020 10:43:13 -0500
Message-Id: <20200214154854.6746-201-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

[ Upstream commit c5563bad88e07017e08cce1142903e501598c80c ]

process_buffer_measurement() may be called prior to IMA being
initialized (for instance, when the IMA hook is called when
a key is added to the .builtin_trusted_keys keyring), which
would result in a kernel panic.

This patch adds the check in process_buffer_measurement()
to return immediately if IMA is not initialized yet.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf1274..9b35db2fc777a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -655,6 +655,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
-- 
2.20.1

