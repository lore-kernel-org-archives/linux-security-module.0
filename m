Return-Path: <SRS0=/BYZ=BA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BD8C433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7A120702
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSH0kB+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGUOPc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:15:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30175 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbgGUOP2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Jul 2020 10:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595340927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type;
        bh=p3hi3xrdZQgrcmCmh6VAQFFWaZ++JX8czQmDuqdNFJw=;
        b=eSH0kB+12dnVGE2JGJZ61zAmhps78TLdeUq1LgswMoSDZsZyBs62usJH3Zgbm32d0/mKrI
        jyNr4YJlR0ol/gZlVwVwleHmALY7LnYv8FvK9R5VwHAu+lnmURL5jAQj1vyVvDOQsACmXs
        +aE/PukkyFCTW0zwJPb0N6N5NQMLX1U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-fTph9XY8OQaqkC3aMoVdTQ-1; Tue, 21 Jul 2020 10:15:23 -0400
X-MC-Unique: fTph9XY8OQaqkC3aMoVdTQ-1
Received: by mail-qv1-f72.google.com with SMTP id r12so12429015qvk.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2020 07:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p3hi3xrdZQgrcmCmh6VAQFFWaZ++JX8czQmDuqdNFJw=;
        b=ua2GTeJ0HUCVoCuZqJR+0qeQtwZLtkpT7r/F87UoyaxdUcB4miXKVBHsgM94nnLnOY
         6xLEwh0Vdun4Ckv2ALvjztht/t5v6LrOp507DFjTwjXvzJqkmrvosQlW+FxT4oI241ik
         dd3Og8ywXTwRoKpJth5pYn83nKw9svjC0I4WgUHrdiRaLsl4oB9xT4awYDFpG+rDP2DA
         LfOivuKLHgaBMW9SIdtTsR7LKQiwGwn969uKf3nnWR4hHi5Fe6jeAksIJRN/aH/Wyu+n
         aosMHgiPKANza6o6LZ4K0XW7xcAbarF2kCUX3z/fycaKD80k2u909VU6rLOsbKss72Ky
         LFhQ==
X-Gm-Message-State: AOAM532gDUeH2vPA7BVxyCriIZ8/wvfGAiesaeD9Jcx+BoXr8cP+G9du
        U7v0M/A1zXptzOGsdleFQzWz0YSJztOlepMYp2Pbjdmu3qGxCYHcdJHDNFAXXIs47NzxZCHbJ64
        IZuykn8+CSIl18q5sPYT/mdaFJjFRjW7cQhPI
X-Received: by 2002:aed:2987:: with SMTP id o7mr29229967qtd.385.1595340923117;
        Tue, 21 Jul 2020 07:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpgbcSLCsIUUg/981LoMyBoE6jzlDFr+8f6gGViXBeoV3rMbiH7sCH6UBnDuUx0P9jhTDOgg==
X-Received: by 2002:aed:2987:: with SMTP id o7mr29229939qtd.385.1595340922836;
        Tue, 21 Jul 2020 07:15:22 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm22474159qti.41.2020.07.21.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:15:22 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] KEYS: remove redundant memsets
Date:   Tue, 21 Jul 2020 07:15:16 -0700
Message-Id: <20200721141516.20335-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Reviewing use of memset in keyctrl_pkey.c

keyctl_pkey_params_get prologue code to set params up

	memset(params, 0, sizeof(*params));
	params->encoding = "raw";

keyctl_pkey_params_get_2 and keyctl_pkey_query have the same
prologue and they call keyctl_pkey_params_get.

So remove the prologue from the callers.

In keyctl_pkey_params_get_2, reorder the copy_from_user
of uparams to closer to it's use to ensure that
the keyctrl_pkey_params_get is called first.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/keyctl_pkey.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..60b504681388 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -119,12 +119,6 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	struct kernel_pkey_query info;
 	int ret;
 
-	memset(params, 0, sizeof(*params));
-	params->encoding = "raw";
-
-	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
-		return -EFAULT;
-
 	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);
 	if (ret < 0)
 		return ret;
@@ -133,6 +127,9 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
+		return -EFAULT;
+
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 	case KEYCTL_PKEY_DECRYPT:
@@ -166,8 +163,6 @@ long keyctl_pkey_query(key_serial_t id,
 	struct kernel_pkey_query res;
 	long ret;
 
-	memset(&params, 0, sizeof(params));
-
 	ret = keyctl_pkey_params_get(id, _info, &params);
 	if (ret < 0)
 		goto error;
-- 
2.18.1

