Return-Path: <SRS0=B56X=3F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B262C33CB7
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305C320684
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198318;
	bh=Z5A90g+/eZtkcA/YgSKg43FyETGEqdOD7qAPa/dHGwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0L5I9NInqEUKwtOJWzL44pAX3pJbdYTjccIGUd2zqT3wsuxC+zemvWgd+owBUTAq
	 e7TO23FM29kXQ40mbUcm1JheY9xijcNwZ1Z733PQFHPrV3vhPuIdRLdjccNlE7Hbbg
	 HLKERdsidOUsXpxyXEjWdhNxZ7956O0t2SwcJyQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395312AbgAPSL5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731650AbgAPRhX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2472E246D3;
        Thu, 16 Jan 2020 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196243;
        bh=Z5A90g+/eZtkcA/YgSKg43FyETGEqdOD7qAPa/dHGwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0AYaeH1JHY+8e2ki9btplhTmAjBDzYI2Jg48ZRU4y8jYyiBM4maEp31QgKh21tDg
         j30UamRQrxn/lg0L4cKLyau/JTeuZVVrQsibVoSZY16CjMq07virKbaz+7wVRZjGHa
         klG1Dm5sx1qgjMnJgAX3Hb3ggx6apXCkUgpU02zg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 072/251] keys: Timestamp new keys
Date:   Thu, 16 Jan 2020 12:33:41 -0500
Message-Id: <20200116173641.22137-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 7276d1a009d4..280b4feccdc0 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -296,6 +296,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
-- 
2.20.1

