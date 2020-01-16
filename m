Return-Path: <SRS0=B56X=3F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F33C33CAF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149D208C3
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199546;
	bh=3GDST97Zptw0/e84om70F9jZkf2LN43fAxlrhDAXbIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x48MpRpmsgG6jgcbVTq+2aEhyjC5FDjnmytPZ50cUA0Vy6R4iszwI0icossyuWXY3
	 ydPq3Uj/Gk+defxLeTT4PaR1e097DC3UlZdbH0F2LllGUr3Av89KcEdcCtIwfPC1rO
	 E+Q08EYULteltkIjWFGndxenkjlE5HoAZItTMeLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391999AbgAPScZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391849AbgAPRZA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33F2246A5;
        Thu, 16 Jan 2020 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195499;
        bh=3GDST97Zptw0/e84om70F9jZkf2LN43fAxlrhDAXbIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpwG32FE5HKa3b6t5qUW/+4XxzQ/5T354s3lYXPGpVJ7KGKoqMeU88WhEk4NVhWfR
         2cEoRjbqX8qRwmmHFgCISiVjC0Aazdjilf6aniIuKI4OXoyLa6r7sAeKYPdTezoOC1
         qMW/SunBZoRi9rc+0ObspA8xfIFFlec9mWpZPtHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 100/371] keys: Timestamp new keys
Date:   Thu, 16 Jan 2020 12:19:32 -0500
Message-Id: <20200116172403.18149-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7c1857bdbdf1e4c541e45eab477ee23ed4333ea4 ]

Set the timestamp on new keys rather than leaving it unset.

Fixes: 31d5a79d7f3d ("KEYS: Do LRU discard in full keyrings")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 87172f99f73e..17244f5f54c6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -297,6 +297,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
-- 
2.20.1

