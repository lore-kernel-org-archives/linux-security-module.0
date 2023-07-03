Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72282EB64DC
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jul 2023 11:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGCLze (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Jul 2023 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGCLzd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jul 2023 07:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88247115
        for <linux-security-module@vger.kernel.org>; Mon,  3 Jul 2023 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688385289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f7Blmz01KkhnjG3CkQuHSrHa/R3BAwypyrKjulduXVA=;
        b=R5KbpsBo+HfIwanLp9AtkYzmcJpJAgoyckQ5bQ3U2IdeFhSfssLKwDoXUfEkP8Lyxcikb4
        UJyfWCPGH1mdiu3hGd8POrVaz/uKai6vMvzZT4MTW9HF1Wgl1tmfDJ9by3Vj8068eDIr/1
        5QqrD7pxgRocg9s/BUGOCUG6YJ/U/Zk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-tDdWXScfM8-ThrNNsIz3Cw-1; Mon, 03 Jul 2023 07:54:48 -0400
X-MC-Unique: tDdWXScfM8-ThrNNsIz3Cw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b8757995eeso3761761a34.1
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jul 2023 04:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385287; x=1690977287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7Blmz01KkhnjG3CkQuHSrHa/R3BAwypyrKjulduXVA=;
        b=hIr4vX/M2n9rKgWNdcrgtNricmIYEwnWA3o9nsqgcIkFvqkWiPEo9Uam4o5yhCu860
         q5d/Eq3c2vWqjgWnXUyOCHQoJUSauEua/rhUzDV0oJ/dDSWEwPIl6Ynw1BaKOrpoz+nu
         jfv9NwjThqRP+6BBJMhpJ/UP6uE08b1OoKQrg3Irv6zWRMfccMfYpiS6xMYa7XY7VIMm
         Nxrex1fSkwpCWyQiW4sQ+n0iCMy7K0Y3qUUTXgIXXpzneujJ+FRMJJ1Abzxsjz4W7WN+
         RTJ9jsHXKiNZaBYmyhHA88VG57Z0APvKi7Qe1EXJQMbVPt2tG7JmmUnqH2hPlkP5fzEp
         FOAw==
X-Gm-Message-State: AC+VfDws6NnwMyyYZlcS9v6L9lMSlfhjB+F9dfH6JDdhiZMtv6oUgTkS
        INBs7axsKfX31q0niE3M7TFMw3vEkJ1Rnz9jmg8c1DsZslf3cGiw4iR4/hgzflfUkXI5kyiYATv
        AxfdA3piFg9gO0mlLztdqW8xNjAZcPe4pu/iUcFZAJBc3V5HR2Q==
X-Received: by 2002:a05:6830:139a:b0:6b7:20f6:1242 with SMTP id d26-20020a056830139a00b006b720f61242mr9877367otq.20.1688385287103;
        Mon, 03 Jul 2023 04:54:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FVEteqImZ56jG0cTISB6k7WjoEl4kHlZ2OzvXOgqdAXDOGMsCexyRBXODj/JojKMnZ6RaGw==
X-Received: by 2002:a05:6830:139a:b0:6b7:20f6:1242 with SMTP id d26-20020a056830139a00b006b720f61242mr9877348otq.20.1688385286830;
        Mon, 03 Jul 2023 04:54:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s68-20020a635e47000000b005533f154df1sm14907784pgb.2.2023.07.03.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 04:54:46 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: require signed IMA policy when UEFI secure boot is enabled
Date:   Mon,  3 Jul 2023 19:54:41 +0800
Message-ID: <20230703115442.129725-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With the introduction of the .machine keyring for UEFI-based systems,
users are able to add custom CAs keys via MOK. This allow users to sign
their own IMA polices. For the sake of security, mandate signed IMA
policy when UEFI secure boot is enabled.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 9db66fe310d4..bb2881759505 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -58,6 +58,9 @@ static const char * const sb_arch_rules[] = {
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
 #endif
+#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
+	"appraise func=POLICY_CHECK appraise_type=imasig",
+#endif /* CONFIG_INTEGRITY_MACHINE_KEYRING && IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY */
 	"measure func=MODULE_CHECK",
 	NULL
 };
-- 
2.41.0

