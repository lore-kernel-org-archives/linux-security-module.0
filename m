Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBCC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 01:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKBBxw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Nov 2023 21:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBBxv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 21:53:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C4119
        for <linux-security-module@vger.kernel.org>; Wed,  1 Nov 2023 18:53:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77a453eb01cso23708585a.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Nov 2023 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698890025; x=1699494825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=37+mNFmGhNhaOfRXTXcvrpHmGQE/WN93HJkE71oO5zk=;
        b=Fdnp+OGozlv9jxCZYpkjZyvSbjAj8GYac/1e9m/HRGhy/l0kaVvC2EWD5baF/TzkqM
         d5Hu67wplTICwDOk5kFwAbWyhQ1m8/YNfhaXjDp/mM7uHLX6lQT4iN186oBLNOmPy9Tk
         Sbb9GcWUMEj2EGIfRQ1F6rDpd3MYOSUH7X5DA8wadFFwr0LRHPudj3b5ODVqKpSnBlfh
         QT1sKuBjS0EWzk+8mW+HabH1HkfHJrbPxURQB3gJPn5lNgMEsaQRUu7MtMSfR203c9oz
         N5mpte3Xes7l2PSksu68OUl8lzIgq15CIwHci5QfKH7fg8NGmDJlFANM8EEszmSSqz9t
         iavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698890025; x=1699494825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37+mNFmGhNhaOfRXTXcvrpHmGQE/WN93HJkE71oO5zk=;
        b=nK5pnhucjSVG4TmnS2oK/Qj4FGjVEkFdjpjiQ74m7HP+L+vh39gmYVEDL+naSc3OeX
         CCGEc+UOLZ0FBbEX+u8h87CU35IwNj4YbfhM6pvPiliue8ob/7+zxwde6TEt7ByRq2wG
         h+5ZMH+ghRBno8JOhIhMLlP5awWzpaG9lM0ptBQ1GTPYhfkK20B1t7L+H38+e/XgaCAb
         XyP7sqTr6DEhaSyPyDFzli1HoQ3yNyhBh9XuMKTl1FCFuOSJwYFqDqMTrLGxnkFnnSuk
         8245FvxgQfl2DHB3MfK60meH2lAZjNkx8nttRtFqJhp7EIP+Tdm1PYe3uwjE1GKL8ZOo
         V6NQ==
X-Gm-Message-State: AOJu0YzCD8Y2ALeuVa+PTznJP2c26A/CRNOWcQnSuwYZu3jhpReLxr9l
        1LNONs5XNTtizQExcekHsDP/0WFo9V2li75Ktg==
X-Google-Smtp-Source: AGHT+IHYjO9BgVsmKC3TTlFq1+Ckib+PZr8tJuacn96Ny7t2xQGG0MSZYN4UpTCvibhkZ0TwvNp6/A==
X-Received: by 2002:a05:620a:190d:b0:778:8822:9a3f with SMTP id bj13-20020a05620a190d00b0077888229a3fmr21707831qkb.63.1698890024954;
        Wed, 01 Nov 2023 18:53:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id de14-20020a05620a370e00b007756c8ce8f5sm952001qkb.59.2023.11.01.18.53.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:53:44 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: align based on pointer length in lsm_fill_user_ctx()
Date:   Wed,  1 Nov 2023 21:53:38 -0400
Message-ID: <20231102015337.510827-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=paul@paul-moore.com; h=from:subject; bh=C6WLJZ7gAV0X573yUDz60N3O/EhKYa28yLkwvUBqRao=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlQwEhszTohcD86gWrk/JYm1GDCPZxMnhl0bcLA wf2SzOPPeSJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZUMBIQAKCRDqIPLalzeJ cwfkD/9cBZJoUoJ6svQGrDZwtt79Mm1Mqcy87qEp6VSX38GNmX+7UkbQhpu8wtwBEWNmKv0l3wA HNcWZ8tkxk3vTU6VPFpgJzHsssSqGbRx7/7kUCe5lP1jJoK1Bgbz0xunUnN+l2mhJoKWUhwQ88c tS0K7ScrTMooXDcoVt/xasx1UaxSzoFA0TdVF747BCi4BMGCMKmJqnlw7djfpMJK65pplaRMp/B eHiXPZYFjeJlUr1ysT4YML+yRIfYCfjnbNXqmo8lWhKKE2HEyufbxyle9kMps+8wpI7loi9eOb0 KUOlisFnHJ/TXewnYutil/0EkscKq3v18Rfq7Eudf2CMW8XOWkAvHXQCryHMFNOyDUgw+QJF9fb QJw69tTu5KXPFu8Q2/V3STSCfmQKHXE0nnZB7KrXP14osx0tXcbaBng1JtbazYbupuZ5dpSCpGA 59YN4kP989c9lB8DAXEg1tcXwivtCZbFsT7fTml2EA1VctWGzOebqFajS4EISC3J7hW/dtDaakG uSP0aOPLWvpejIjrlDYCRC1BDkRO3qH6DTkjjrIwkv1Fsqb6A9e/D/2e1ASl/AzuA6DHB8eQC63 c9NtFUjYWWsugKt7knBP2DjWnMOaEZW/qEKrhqzd+C0y+gSsFoSFkCNgjTgGawg+9G2ptnTOaP9 qJX2uSJ02/JTDbw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Using the size of a void pointer is much cleaner than
BITS_PER_LONG / 8.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 86f7a1995991..a808fd5eba6d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	size_t nctx_len;
 	int rc = 0;
 
-	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), BITS_PER_LONG / 8);
+	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
 	if (nctx_len > *uctx_len) {
 		rc = -E2BIG;
 		goto out;
-- 
2.42.0

