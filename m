Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA7C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Oct 2023 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbjJaMc5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Oct 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJaMc4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Oct 2023 08:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42B98
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwcTumPEA8MXD9aE6NAuiQnpk8SlcZkJMMNjOT52wQs=;
        b=fssdZvZHBYokIq/zHxOozixsLLJyKetALYZTmiu/97OjX2oOY8MNnLVuH/3jFnVW+zxn52
        eu0LZSRQj8HZTmKAcA3n2hu0IRAX72i6OLlA57VcS/yQXpsxe4UdqyhIDZFZfDP98lEwTV
        QZtDaYHZnkUG02NA7519MgSjhow8/Os=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-cthUV14aPVCEaXTs4FjvUg-1; Tue, 31 Oct 2023 08:32:14 -0400
X-MC-Unique: cthUV14aPVCEaXTs4FjvUg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789405320fso708054385a.0
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755533; x=1699360333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwcTumPEA8MXD9aE6NAuiQnpk8SlcZkJMMNjOT52wQs=;
        b=gLYOQ6xQs0TZYn+sGh8r4Rp/ZGbiZjB4D9WprLxOwS2+xmgn+L/Xr/W4bUF5PEnCfp
         7H5xMMlgCq/wyHOp5m97RFvgwxJ7ZEiVKfhrzhLXLJBzFD91iVTYiwS4sUzHVsLu8va6
         BArVz9rpJGfCe/tw+NvN650cSbuOMa73g++WVLBnvtMIKtjq+ziXN1xiJrwh3padFdtJ
         hfzQ/1czzxGpnluGULlNGkCNEEtqVgOhF0LqwOlX6nXL4aaAFWEz9XdDWEB83E6bdZFt
         GGPtsaSmq1PjKyLmn8KTrtDaXpQUyiIzY7z836oBAzv9dWQDz3+7kGClp4EJRx4HSZ04
         O5Pw==
X-Gm-Message-State: AOJu0YzsiywCQu90ncwrqMQ3XduDDn6uvhdwMYxRt4/7XTZ15ORnxD0D
        8+u4LBx3dlipV+syg3z7ig153kk4OwikW7NMgzP8hhpXCDWyB2bGzcb3D96sd7V8UQbdvoxLbkB
        Q6NwyVrMEv6Oyfsq+SvzsfNbBpZ/gaTPJIgvM
X-Received: by 2002:a05:620a:2408:b0:774:2e8f:2170 with SMTP id d8-20020a05620a240800b007742e8f2170mr15537037qkn.4.1698755533768;
        Tue, 31 Oct 2023 05:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1PibxJcjMn2MZ8vm902icTDEZ+hR9K82a6PAvEbaLbNmN/JzZjcwNxAmmW4i0Zd0iBebAFA==
X-Received: by 2002:a05:620a:2408:b0:774:2e8f:2170 with SMTP id d8-20020a05620a240800b007742e8f2170mr15537013qkn.4.1698755533490;
        Tue, 31 Oct 2023 05:32:13 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lsm: fix default return value for inode_getsecctx
Date:   Tue, 31 Oct 2023 13:32:07 +0100
Message-ID: <20231031123207.758655-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
References: <20231031123207.758655-1-omosnace@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

-EOPNOTSUPP is the return value that implements a "no-op" hook, not 0.

Without this fix having only the BPF LSM enabled (with no programs
attached) can cause uninitialized variable reads in
nfsd4_encode_fattr(), because the BPF hook returns 0 without touching
the 'ctxlen' variable and the corresponding 'contextlen' variable in
nfsd4_encode_fattr() remains uninitialized, yet being treated as valid
based on the 0 return value.

Reported-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 4dd55fdfec267..ff217a5ce5521 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -273,7 +273,7 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
-- 
2.41.0

