Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34529C678DC
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Aug 2023 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbjHRABK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356519AbjHRAAu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 20:00:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727F3C1F
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 16:59:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso2911035ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316799; x=1692921599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlZwTjULNXL0MSeceST2nTPY5dYfoFRLbfS9U1Zv9es=;
        b=d+VbPkWufrRXthaDxdNUui/S17G/tmvNX7IqEco+/8o3ee9vxotGH/4g3BD7A2ZJ+H
         Yid2nGjIrKsaY/+DmSyPDARjLRts3gozDKp0ZRg6HH9Pf6kj0m3TPykIHknZz2GYSjgA
         Hubx974xUHWMch3i6ki96stvBbLosRgyejyUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316799; x=1692921599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlZwTjULNXL0MSeceST2nTPY5dYfoFRLbfS9U1Zv9es=;
        b=lfeO7sFdTFXJu/3SGp3V1JXzyT2/dWgldztsnXF/b0ZF2mSIeDpGb+31OC75KOO8FW
         WOSTPl6ontwDxO3Mf6GnJRd9Fueb9/dL8Nsyq3p8wmt1imUcu8nX2qk/kusz5L+TDGXC
         R1SXFjAe9dE1cYAG9b+W+ByiWc8tJGlocAVXMqumly55dkb5gOpOKmLJU8UZBuh1qDWu
         fQmu3sN9urdY0b3D09szjh7fL3CjC4zxn9j4nVdl/voRASlmNQWXz+TxqGbsf+XEw9EJ
         nWloNvYQBMGk49ze+rTo8mxe0Ezr0NUeTQ2pfRHJYXqdjUI5v6xMykhY6n5V5S03N375
         RkIg==
X-Gm-Message-State: AOJu0Yyw4ZJPbya1lsmmSbRtg+9aljkdIezZXbvfVuKlGI0oAOuVSPmy
        CoGm/qBvHrjP8JSdwgwiw2PGfA==
X-Google-Smtp-Source: AGHT+IEZN0eiMgoFeTiDuL98J12BoFQXzUyH1iR9WfEu30+aZRIx+2aMlLrOvoBZVZz8HJbKs8MMbw==
X-Received: by 2002:a17:903:247:b0:1bb:1523:b2d7 with SMTP id j7-20020a170903024700b001bb1523b2d7mr1064631plh.14.1692316798858;
        Thu, 17 Aug 2023 16:59:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902bd4a00b001bba669a7eesm348680plx.52.2023.08.17.16.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by
Date:   Thu, 17 Aug 2023 16:59:56 -0700
Message-Id: <20230817235955.never.762-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TlZvULm9TYJxvzYvyHtGp79eQ9cs52J2eowJQXxaQlQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rR8Jpb6jYCE1H2Z7r1VdMRPlT4IoaSG9P+6O
 TraiYv2JDeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60fAAKCRCJcvTf3G3A
 JjIHD/44aHrnkkewA1A9a8OG6hGVMYANzESYfUGAA9dl8IaTcUf5hz6awlrlkNt19soLhhGXaxf
 6zZZK3951OIkAIYfKrjp48XoTFOKI47ha4xWcryisDbf/lBUlQ6K2ALIFp2ZBobJko9KmWFRxEu
 r6rBph5S6FqVIJVZPG2xFFxsd4lYyuD2jXO/1O8xnS6ismHiTUMbYOUcRgg9nwR+iZmHYFYMDNa
 S2MZ/a7mqLSK3+rg8Ffsq0D8hTy0DP/fSQLLiZ73LWFe2Un8IvI78NYawzPNoBV6prHXxLdJphU
 DSjmWKtlrOmsJO7mEk9ipaIDkC0bnBkXv9TzXjvtwSpy0RrHgPmIr9VEou5TwHceriaF/OwIrc3
 aSGyVXXILMWSq7cvXiAiPkJFxpQgVmYN1aHl2rb4O2hlQ34EphuiDLTOJriwowTTCcd81btCfpg
 ue37gNf40o92kdqIkxIeg2BWmyuWCKVsCeH67+FgE3jIOFn8eqq31yhYwA1qy7+ZJz+UDJkWKrx
 r42QK0aS3ebKJ6Kt0oal+a0ZsPp6bhhU2ticTpo0kKWKmpsZZg5v9leTKD1TOciwblKRJCERaYC
 2YuuoTR0bS+GC/8nQOg9/q76Mny1hU02LM69MiCaJwH1oNPqJGyCm95eW1Sm3G/ONjIa1Cks+BO
 UK26fPZ LQjP69ig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct dm_verity_loadpin_trusted_root_digest.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/dm-verity-loadpin.h | 2 +-
 security/loadpin/loadpin.c        | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index 552b817ab102..3ac6dbaeaa37 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -12,7 +12,7 @@ extern struct list_head dm_verity_loadpin_trusted_root_digests;
 struct dm_verity_loadpin_trusted_root_digest {
 	struct list_head node;
 	unsigned int len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 #if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ebae964f7cc9..a9d40456a064 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -336,6 +336,7 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 			rc = -ENOMEM;
 			goto err;
 		}
+		trd->len = len;
 
 		if (hex2bin(trd->data, d, len)) {
 			kfree(trd);
@@ -343,8 +344,6 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 			goto err;
 		}
 
-		trd->len = len;
-
 		list_add_tail(&trd->node, &dm_verity_loadpin_trusted_root_digests);
 	}
 
-- 
2.34.1

