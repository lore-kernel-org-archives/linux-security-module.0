Return-Path: <SRS0=jOYs=T4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23883C04AB6
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99EC208C3
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 15:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEickYCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfE1Pc4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 May 2019 11:32:56 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40658 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfE1Pc4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 11:32:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id k134so19273321ywe.7
        for <linux-security-module@vger.kernel.org>; Tue, 28 May 2019 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gfjeve/Jsw5lOi8JMAQQxMghnHhlj8GnAzUWdfIEwD4=;
        b=MEickYCOmg/vqRSyekS1D+0uAv2rRtP/GiT+iGHTYeeAYVwvz2sZEGrmL6FlvRGuIW
         9KcQGEuYnP4h34p/RDPaIbQqbuIFCOVdhgYWk+da2achzLGGIJqboEdCAiMic3s+m897
         HOF0nfz0zjPc/6EHUrW4NWgocinps9cnHCN/WkPojHEKIZANi1yKQKCZ5IFXhy8rpH1D
         JHLA+r7gvZDWJzDayK8poYJ+pByRsDuNWqGpFxrJR9wpG5EqamRZebocTZXfd1G03TFO
         1Qn6H6KLNTi0EgxuhbW5S2ylD04MD5N4OOgcG3IU2fnEf404r0rFKtZsKkIqP3gQmM/2
         mHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gfjeve/Jsw5lOi8JMAQQxMghnHhlj8GnAzUWdfIEwD4=;
        b=RyeuNuPxhJpDgGwxvsQTCrQ1BtPd1fpc3KnLx3PE3as7ZTHkKcJhDfgXYns4S9dg3O
         lu1Le8LcO/SfdaE3B0K0DbWj8vVbHcmtk08H493sml/z7Y0fTy/Vzr9am3sr6uX4aHJs
         JKdQF/MkuRnbafPz+7U77BjpPAgiRkkY6IsdrKcGK53f9uPbRhGIf9ZPeymmYX8NJ1Fi
         Kbrhb7QYwXlrzubt1vhOqemnBt7+hJDYrBfrnW7pX14EEbba7FdH749jaMaY7XBA87xA
         tsLWeMDvuLHPsuwIKq+Wp5LRNUN2UUAT1ZS5YIQtkQUI9D+X9qfLlOAi4rBgPZ1xcMfx
         /mkQ==
X-Gm-Message-State: APjAAAV+gQ/A03gsvYUJHpHDA0OUlT8FTkGa2PaMsaZ4T+zk09vkpikF
        0DZggj5QOd1rSChmUWekpqJ+cIMBDg==
X-Google-Smtp-Source: APXvYqy6G0sfGSdIfiMCVO4pDitrvgwqY8Z7QBE48lga4WLBMjK7M7si6BFhvixoZR3mn4nJc6CrOUVKFA==
X-Received: by 2002:a81:55c9:: with SMTP id j192mr6615282ywb.161.1559057575350;
 Tue, 28 May 2019 08:32:55 -0700 (PDT)
Date:   Tue, 28 May 2019 17:32:26 +0200
Message-Id: <20190528153226.248785-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] apparmor: enforce nullbyte at end of tag string
From:   Jann Horn <jannh@google.com>
To:     John Johansen <john.johansen@canonical.com>, jannh@google.com
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A packed AppArmor policy contains null-terminated tag strings that are read
by unpack_nameX(). However, unpack_nameX() uses string functions on them
without ensuring that they are actually null-terminated, potentially
leading to out-of-bounds accesses.

Make sure that the tag string is null-terminated before passing it to
strcmp().

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Warning: The existence of this bug has not been verified at runtime, and
the patch is compile-tested only. I noticed this while browsing through
the code, but didn't want to spend the time necessary to figure out how
to actually test this at runtime.


 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f6c2bcb2ab14..33041c4fb69f 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -276,7 +276,7 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 		char *tag = NULL;
 		size_t size = unpack_u16_chunk(e, &tag);
 		/* if a name is specified it must match. otherwise skip tag */
-		if (name && (!size || strcmp(name, tag)))
+		if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
 			goto fail;
 	} else if (name) {
 		/* if a name is specified and there is no name tag fail */
-- 
2.22.0.rc1.257.g3120a18244-goog

