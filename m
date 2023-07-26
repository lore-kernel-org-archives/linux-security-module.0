Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890ADEB64DD
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jul 2023 02:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGZCJD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jul 2023 22:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGZCJB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jul 2023 22:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F8212A
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690337292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95LJOf0z/Eno4OCFcFMWl++emGtMZCHYgwGRjUbJaTM=;
        b=iRJGJLGQXNZX0OsPglxB2JZ7FDlyYxjCFXT+I8brKarrgmqngF6qGriQ4vH1MHj/u77sRY
        OMZqxj5i60dFmgR/6uin7wPB6Qy5klGKBvKVGgYK3l75KYMziUbsMkWsZSp2FG2/2Zvw+g
        UQK3JVwkqUhfVuB5JLwtxhcvSB60nIQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3xkmOnXpPweG5CYq7POv_g-1; Tue, 25 Jul 2023 22:08:11 -0400
X-MC-Unique: 3xkmOnXpPweG5CYq7POv_g-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bb8f751372so30350525ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 19:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337290; x=1690942090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95LJOf0z/Eno4OCFcFMWl++emGtMZCHYgwGRjUbJaTM=;
        b=W6ZGRgWaRpihlitrL67KQ8HFWPjOxiGsEneMDAMdEvfK7k+jPBhNwl9UzGNzeV22dF
         AAzOSzEaxSekC0ZBa1GPgXfmlvxJL4NT1V55s17gBDRWBb6D/3E9t6wyBvW7qvgBMdpE
         05BWBcrkNmkx/kj+GAPxnpAxV4XYV5f3Pn8TKRbqRWc9UCVwzImjMCFxFMlU16sky8Qo
         MsAxIT9hglsboczaubktgn71eMzbQGB/I8jFM5URqGntxzT1lRKzVM/fCcbhFy3RTa7l
         b7KqKQq3TtVCT+WX3CF8clD9gU8PKDbEOq6Rnbwl0GH4GmaTWbsy3SXgEc9Z2l0ZPJSf
         7B4A==
X-Gm-Message-State: ABy/qLa2mtVCV75jhfUacvrEKOChK+5141BAEptgpYRgcFhV0MQz7X8w
        lMmRPBRKUzToOOArCy45If6uo7lpjKdcxnYMDdM9YNVIHUL5wndvNyGlXToYb2OjjeiyB7p2YVt
        nQ8GYkLvWiJVWEhx3E0ZuCC2UXzotJZONOcZ9
X-Received: by 2002:a17:902:ce81:b0:1b8:adc:7c3d with SMTP id f1-20020a170902ce8100b001b80adc7c3dmr1085529plg.40.1690337289915;
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFME03RuiNFMjrYDkMFSyzXe5DoUsVifAoxnjrckHRpcYIqgyVS/r0ZzVYgv+QZMxRzMOzqxA==
X-Received: by 2002:a17:902:ce81:b0:1b8:adc:7c3d with SMTP id f1-20020a170902ce8100b001b80adc7c3dmr1085513plg.40.1690337289554;
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902788800b001b9fef7f454sm11760512pll.73.2023.07.25.19.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ima: require signed IMA policy when UEFI secure boot is enabled
Date:   Wed, 26 Jul 2023 10:08:05 +0800
Message-ID: <20230726020806.926734-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703115442.129725-1-coxu@redhat.com>
References: <20230703115442.129725-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With commit 099f26f22f58 ("integrity: machine keyring CA
configuration"), users are able to add custom IMA CA keys via
MOK.  This allows users to sign their own IMA polices without
recompiling the kernel. For the sake of security, mandate signed IMA
policy when UEFI secure boot is enabled.

Note this change may affect existing users/tests i.e users won't be able
to load an unsigned IMA policy when the IMA architecture specific policy
is configured and UEFI secure boot is enabled.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
 - improve commit message [Mimi]
  - explicitly mention the dependent commit
  - add a note that the change will affect user space
 - remove "/* CONFIG_INTEGRITY_MACHINE_KEYRING .. */" to improve code
   readability
---
 security/integrity/ima/ima_efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 9db66fe310d4..138029bfcce1 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -57,6 +57,9 @@ static const char * const sb_arch_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK",
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
+#endif
+#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
+	"appraise func=POLICY_CHECK appraise_type=imasig",
 #endif
 	"measure func=MODULE_CHECK",
 	NULL
-- 
2.41.0

