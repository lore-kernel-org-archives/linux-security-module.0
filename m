Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF0C3A5A0
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC0922CE8
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuuv3POp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfHTASf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:35 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:48743 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfHTASf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:35 -0400
Received: by mail-vs1-f74.google.com with SMTP id a20so1397185vso.15
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cMgjmtuBmfVa/CsXfb8uiBDSNgmdufQRbjNib4Tgcig=;
        b=tuuv3POpIuofzhNqZUKQoKR1Pan8nwWbDZbwkAoTf4UYx4zufPYGCTgfuOTsya6RGQ
         yhtHIODniLc3KhY4ZNrfLG5DMHIpncF400yxkZvzgcc3s6Rbw5nBUC+PtXubOVUvqxtW
         vOsCKrnFcVtFQv6TtLlXPOsSU/B9p5kp66ZWz/7m9TQYtAmW9PdPPao4btOAdtTn8IKG
         YrzMo2tEos2UTNJq9hQzUZhg2pZrv1T8fxHplMi75VM98FE7pqee6WC6llvC/03CIQ2D
         dRtXGSsQe7pfvMEIW5L5zL025IAA2sgUjgiBonoQXU87ScvIdQRI+pnoRzlL7QF1H4Dt
         dBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cMgjmtuBmfVa/CsXfb8uiBDSNgmdufQRbjNib4Tgcig=;
        b=nRszEkgwhAYm8UvULfWcwyKRLODon4vxK5dYZUBA5YgW+4GiRL5Y9Bo5KJrTYOxY+t
         RGU1EjuPUK4WMLTXWUkEmseVyrH6VoOZgEY5zgJQzWZ4q9o9ptH41K7Op0SJ9sa/Dzxr
         fNRUerflozonYfFIKfGSs71kzh8N+7f/Bqj1H5jkbBt+Y++8RrE9KgdClyjJts4VM/gw
         HDWvc4pV8yjShXXF6XTeR7eIr9AeMU66TVBvT60tH51vPrwBaiKlrl4v8wqOqo4Jzsd1
         pmSap97aCp8AwJ3vFzY7tiZErHMQDase0dXb0H5pd74pzYRXv+W8mcTvHSf/8oFz8m0n
         R0WA==
X-Gm-Message-State: APjAAAWTuzKZckbrXUoZ67z0e0JXFo9Lq3e2Z1mB+PnUIraRSuvkll1F
        GgfCTYYtcFwbuWb9Gn4YPyGO365D/NnNTemRBlwzcg==
X-Google-Smtp-Source: APXvYqz2ynQdbLiUsjOrrUKHOXJ0Mc6Mp5pwCEivYXxMZqOZfnKiMw4ugozFFPwBAWnW5mdgj8UTYLY3eIdKjtzPeInLmg==
X-Received: by 2002:a67:d02:: with SMTP id 2mr3153609vsn.43.1566260313925;
 Mon, 19 Aug 2019 17:18:33 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:45 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 972931201995..43109ef4d6bf 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -208,7 +208,7 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		return 0;
+		return security_locked_down(LOCKDOWN_KEXEC);
 
 		/* All other errors are fatal, including nomem, unparseable
 		 * signatures and signature check failures - even if signatures
-- 
2.23.0.rc1.153.gdeed80330f-goog

