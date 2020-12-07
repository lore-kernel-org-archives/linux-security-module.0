Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D455C1B0E3
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DD238E8
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLGQfB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbgLGQei (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrWD39vQ5236vo/77WTHcclMwYYEe2kMnOzynaA/vIg=;
        b=WiJfPFuvP82BTfFLYWTgoyT2hsXFJczhgll13eCieVipEmC6ny+An0ekNfoblKbYVTECZZ
        D5MK2OPrMZpoXxSmd5lW14e9w/UwfCFEIqbWEfOCW/W9buaneMYClx7vsMGBVh4+EFxBM2
        qQ6llKkMrMGmAxtOLal+TU7V7w3/rJ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-IGCgKdClPTGEnYt-ViIvZA-1; Mon, 07 Dec 2020 11:33:10 -0500
X-MC-Unique: IGCgKdClPTGEnYt-ViIvZA-1
Received: by mail-ed1-f69.google.com with SMTP id l24so5980117edt.16
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrWD39vQ5236vo/77WTHcclMwYYEe2kMnOzynaA/vIg=;
        b=szs41aCQnEvufJUOCPQOdiHihhpFtrX2xPChDaqqHTsxHJE4nCwwVAqNDyUO45WTpb
         NwO22E0m440JKLg1l0B2y1Qh2fhm5d9s4+COpUJFTadTiUrGU2d8mRPdEt9q3Z0xRxcD
         C9DaM+ubgJrKq0OvKJ9xjXoDsSJsgDIK8nt69EHPblomtGeKyw0uZjz8cDps68nfKtdF
         23ZnIUa5yXj0x3h7/kHOtbphdixTvlqUopYbMq2JipNcHj/tBBUGw3o+YI3k039NLczC
         kV1NTaz5dYQvZJKw9HkIkvAmptkV3xwApsajTzHbGlIite10UZ1MEwxTaVgUUuL81vh/
         ZvsA==
X-Gm-Message-State: AOAM533YbDDIB0xvKSK+V1W4HjXSTaoxF3hmRRNxoo9D/izmTLHSfkIq
        l77cQwlehTezl5rnCRx3ePlXFV8XSP54MmGMgZqEmanusMY3d+fr1SBCuMxzYxE4lZyzUT6QwOL
        AEQed6LstGY7qO+O9fqgox346NafvRJ/rLQbs
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr20433024edb.191.1607358789300;
        Mon, 07 Dec 2020 08:33:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDZ8PBOMTmy7Viq25/DAuAax7RMDShGdfStsG7a9V/Uv4Vpsy2gyL1w0kDb+e0n297b859wQ==
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr20433017edb.191.1607358789148;
        Mon, 07 Dec 2020 08:33:09 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:08 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] ovl: do not fail when setting origin xattr
Date:   Mon,  7 Dec 2020 17:32:52 +0100
Message-Id: <20201207163255.564116-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Comment above call already says this, but only EOPNOTSUPP is ignored, other
failures are not.

For example setting "user.*" will fail with EPERM on symlink/special.

Ignore this error as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 955ecd4030f0..8a7ef40d98f8 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -352,7 +352,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 				 fh ? fh->fb.len : 0, 0);
 	kfree(fh);
 
-	return err;
+	/* Ignore -EPERM from setting "user.*" on symlink/special */
+	return err == -EPERM ? 0 : err;
 }
 
 /* Store file handle of @upper dir in @index dir entry */
-- 
2.26.2

