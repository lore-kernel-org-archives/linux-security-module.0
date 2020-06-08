Return-Path: <SRS0=DAbT=7W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C4C433E1
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 00:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1C5206C3
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 00:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662737;
	bh=Rpz6e0uR3d1cysrBltsKjY+NI12F8N4yh3/xCLaugV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uK1GLytE3w1uFM6VZP0cT9AlWi97ALHKapicjjlmfFQJY8kcz3/4Uusqkl5ceR82q
	 d4689bjGvLCdke9iSJ748nMYnw/FMitZl4SmlN+MmSZXlCcbb9wz/mj9eCRbdsPnul
	 CJNYSyynqPqZOD6niN96B/wNUytJ3mxNHFXFQTFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgFIAcQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgFHXPR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C3D2076A;
        Mon,  8 Jun 2020 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658116;
        bh=Rpz6e0uR3d1cysrBltsKjY+NI12F8N4yh3/xCLaugV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2eMugxBLM55aadAy46sn4/aKlcG42P5EPC15nNPqCA3urxkrasblGVRzxOS0d7hvA
         dnDtwLAv8TrHlAdALDQiYfyMPNVAfIY9bfo0rJ6Gi6msiHx7H+V3t18ht/o2z1BQkE
         ewVYjaBxOdiT9z++zdqvhrPPuAnBa39dgAds4epI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 154/606] apparmor: fix potential label refcnt leak in aa_change_profile
Date:   Mon,  8 Jun 2020 19:04:39 -0400
Message-Id: <20200608231211.3363633-154-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit a0b845ffa0d91855532b50fc040aeb2d8338dca4 upstream.

aa_change_profile() invokes aa_get_current_label(), which returns
a reference of the current task's label.

According to the comment of aa_get_current_label(), the returned
reference must be put with aa_put_label().
However, when the original object pointed by "label" becomes
unreachable because aa_change_profile() returns or a new object
is assigned to "label", reference count increased by
aa_get_current_label() is not decreased, causing a refcnt leak.

Fix this by calling aa_put_label() before aa_change_profile() return
and dropping unnecessary aa_get_current_label().

Fixes: 9fcf78cca198 ("apparmor: update domain transitions that are subsets of confinement at nnp")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6ceb74e0f789..a84ef030fbd7 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1328,6 +1328,7 @@ int aa_change_profile(const char *fqname, int flags)
 		ctx->nnp = aa_get_label(label);
 
 	if (!fqname || !*fqname) {
+		aa_put_label(label);
 		AA_DEBUG("no profile name");
 		return -EINVAL;
 	}
@@ -1346,8 +1347,6 @@ int aa_change_profile(const char *fqname, int flags)
 			op = OP_CHANGE_PROFILE;
 	}
 
-	label = aa_get_current_label();
-
 	if (*fqname == '&') {
 		stack = true;
 		/* don't have label_parse() do stacking */
-- 
2.25.1

