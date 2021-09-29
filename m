Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC3C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Sep 2021 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CD361242
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Sep 2021 22:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbhI2WDE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346531AbhI2WDD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Sep 2021 18:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5302F6124D;
        Wed, 29 Sep 2021 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632952881;
        bh=URMMMZt8fHfsGDwMPhlYxjgma7E3Ju+CICWTCJPmQ9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=dzxJO7NsSf2wz8Jy27r1e+tkjF1xFTi/odcpl5kRJaxovY3VviWfXwkq6tTcd7bRu
         1tbky5DiPFaSaw+GUvOfp6ChOK3gOqbzwLc/Oazu1MjvgfIBoEyo9VwTelf2MB/wMs
         paIrfgf2mtoVeunMEkRggqgOccQMINCkySP5LSBjUsWzcqzR0DWSoFbAHY6mhjUajb
         g+jCDaFPgjg763/PFR7VVjrjG6fXR6+SjQe915CKQ/7fJMDJNAYHuSj66s9sVi74pV
         8AIoFZE4DaUDUIHZYwEie8RuRbqVuBNq5rqBNmOdkcmTL+JFWFoLjFqKMfPO1FBK5V
         BACVs67zRj5kg==
Date:   Wed, 29 Sep 2021 17:05:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] apparmor: Use struct_size() helper in kzalloc()
Message-ID: <20210929220526.GA355783@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/apparmor/label.c  | 3 +--
 security/apparmor/policy.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 6222fdfebe4e..0b0265da1926 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -425,8 +425,7 @@ struct aa_label *aa_label_alloc(int size, struct aa_proxy *proxy, gfp_t gfp)
 	AA_BUG(size < 1);
 
 	/*  + 1 for null terminator entry on vec */
-	new = kzalloc(sizeof(*new) + sizeof(struct aa_profile *) * (size + 1),
-			gfp);
+	new = kzalloc(struct_size(new, vec, size + 1), gfp);
 	AA_DEBUG("%s (%p)\n", __func__, new);
 	if (!new)
 		goto fail;
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 17191a9eae41..5827dbdfbfca 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -260,8 +260,7 @@ struct aa_profile *aa_alloc_profile(const char *hname, struct aa_proxy *proxy,
 	struct aa_profile *profile;
 
 	/* freed by free_profile - usually through aa_put_profile */
-	profile = kzalloc(sizeof(*profile) + sizeof(struct aa_profile *) * 2,
-			  gfp);
+	profile = kzalloc(struct_size(profile, label.vec, 2), gfp);
 	if (!profile)
 		return NULL;
 
-- 
2.27.0

