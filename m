Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24823C4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Oct 2022 22:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJMWhm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJMWhM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AFE19C054
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 15:37:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 128so2779529pga.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfEEfwgV0r1esosEkP9F/ee8FXM+KPxMeG8W8EWcy+c=;
        b=JW1eReH2xnq/C7+qm0+Z9UsAitzAXfF7GB0HYN1tCAYKUKow3bX0dKmchXFpJokbg8
         8ulCWFvoB+AlAS/hs/dQjHvgdTJZWh8sTWXS57Kyfm6/B4XXSIb3Y0YtToM6dnSU+K9I
         1uP8vopBMgYMNvwEnNqbcKWN4XM7T4uvLVwTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfEEfwgV0r1esosEkP9F/ee8FXM+KPxMeG8W8EWcy+c=;
        b=pry/8/zFTgC2PcbsoupEK4vrSg4RPQhEhjsJhbZtoQYlNu0+fow/qqlOWGMjy0IXmH
         wE5fRZEdV0VdHd+ykQxE6mhAyMsTJv+hK5tO36txxXtNFT/rdkcuM7HPJa/D7eAOs9pD
         202TpNLz0zHaGEldHCRq0z5w61zMhbMu5RImI64M2uSaZrm3XVFir2Zlrq+yDOMyglwP
         VgiTDRNXpaN0oHX9PqRzeQPiioZWRxosYYkeWrlh4v3XKIELHOw9bZ80ihdbnNDSQsVX
         bJmdt/q66wV8JhCkrybwbJmJEmdUvqBGfBdcY5hz8VH/kNUxrqgswxuRlK+371o5mStM
         byUw==
X-Gm-Message-State: ACrzQf0VFfxRQYNmj3fDrdVRgacF0ZMWf2W72jLoc2GUT66F8tTBVDKE
        WvUYCNcSL+nmadUkGhQsvmVZ9g==
X-Google-Smtp-Source: AMsMyM6ixmF/Cza7ZgkkuryxEzoa1v2tdo5DyCND7oB7+nJU7GcCrnsApxrn3IdkHVa2ykn4dDvzKA==
X-Received: by 2002:a65:4508:0:b0:43c:e3c6:d1c2 with SMTP id n8-20020a654508000000b0043ce3c6d1c2mr1821471pgq.582.1665700623894;
        Thu, 13 Oct 2022 15:37:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 201-20020a6215d2000000b00563933243adsm207496pfv.85.2022.10.13.15.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 9/9] integrity: Move integrity_inode_get() out of global header
Date:   Thu, 13 Oct 2022 15:36:54 -0700
Message-Id: <20221013223654.659758-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; h=from:subject; bh=FjECzdw5vk4KbUumDxIRN5saJ9SkT4eAnWhKYkWPT8g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMFeyBOTwM/Gd1K9I43czpeG1w4C1JSQ7QXid4d 6uJrx+6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBQAKCRCJcvTf3G3AJvg9D/ oCYzGgLf4XwARfk6jZrk9TCXMGlneCjrt3Gciwcp8nh2moA085Sy+H0pocKDwzK2B6x1FgES5wCFaj ip2gVoCE8odPeGoYFCvO9A8xfM67uTH8W+BFNRnZIBnpMyWTlg4yCMMmaH5j1PPHWo7woQjrPdQPbf 0robFn9Qwaof2KTzywOGeALzfmUxWyjJGYrTbIrC1RyVwsnb1TvJVA7s6C2vU8zE7v6B0SL0x4VtKc ZzV8KpARqMpRIsLRclCbmJMRhCI+12kyHo+JNa/aHQlFNrHd2R8H5ej6kDY7UQ702ENB2Ud0I9hJjC 6fljP9Veexa4NXymEnDY8h3l+8DbAcH0/K1fSCzsU5oTNg9gd0/O8wHYUvuI82Pmz7+aXNlrUDYKVS kpce6gLgeLYBHgzuEbHJSx/R6ll1rWcsuEsiH9xvZeUwd64HbldzGDIdzwLIIjIU/hU61wBSyWFkOb o8z7/uYYAl1LKsa+7RQxRyVg6N5EWswXFNV59ThfGsrd9KR40lIeODNjy1OIcr5HGfxrNi3YsZH3aB pKdtGVi+VacVhfIu36bTLd2C+jDeHa+QkZBj4SuxgrAaWqKwGK0cWUlFZ2pDwsZVxP28zx6Ob12ZCu Mqoav641GmnwnvGBx6N8pWg45UosfbKi5OHrlP/eO0f5KAWbN42ubgkcp+ig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The function integrity_inode_get() does not need to be shared with the
rest of the kernel, so move it into the internal integrity.h header.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/integrity.h      | 11 +----------
 security/integrity/integrity.h |  1 +
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index c86bcf6b866b..4c6fd79b5bf8 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -21,19 +21,10 @@ enum integrity_status {
 
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
-extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
 extern void __init integrity_load_keys(void);
-
 #else
-static inline struct integrity_iint_cache *
-				integrity_inode_get(struct inode *inode)
-{
-	return NULL;
-}
-
 static inline void integrity_load_keys(void)
-{
-}
+{ }
 #endif /* CONFIG_INTEGRITY */
 
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 93f35b208809..acd904c12f87 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -178,6 +178,7 @@ struct integrity_iint_cache {
  * integrity data associated with an inode.
  */
 struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
+struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
 
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
-- 
2.34.1

