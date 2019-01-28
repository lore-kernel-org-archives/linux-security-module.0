Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E264C282C8
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8FD20989
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ni4Pf2iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA1UbF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:31:05 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69]:42997 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfA1UbF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 15:31:05 -0500
Received: by mail-ot1-f69.google.com with SMTP id a3so6798384otl.9
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 12:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L/IgE1dL2CfX4vf+NJW5ajTnVze/gHlne8zTXqTdYY4=;
        b=ni4Pf2iTwNpTWXnCIswXP0Aina0ZtBn16nqxkxqqI4ozSFcbAqOpfkynA74Xk7cnfp
         r0ku2ENfIrKeUJHJfYI/rAmyYIXchgYQ7Uh5G5KoM39ZTiigyL0ykoz3dcSikZdRPklA
         /GA6YX084T55Yq+Y7iz7IYabj1EcyZ8cpnPlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L/IgE1dL2CfX4vf+NJW5ajTnVze/gHlne8zTXqTdYY4=;
        b=i+JX4xxt9BWZDKG8sUorVuTkr8Czc8ppRB147iHA4oT/xI2FcT3dOclsnpfDe8VtxN
         Em5fWYzLFbAN/JU4InTg/TNVYtXT5ddRuY6vtlyFpI0vk2l4BIDbmJ4bWNfGCyFglNtf
         Aa4u8h+DnHfSe1p4wqicfpNSehrjnLE76vV4ixrhll18l3/+unN7Zb6korJwCM7MLEc/
         pWfUH7qxsAzSefvxB1gCzT+IrNdlDRAR5S0YxhxAqHFNFyjhtn7y2ulfitooU1uNdxbz
         jzeyJaCC7U9c4EYymZ00bXqfrX1JsQbXX7tG8RL2yqNXFrzSJ3DQi3Z17RzAxh/g5OWZ
         k1+Q==
X-Gm-Message-State: AHQUAuYH2eJA7ShQfZN+wNAkPEShzeCixjiQ7uUsHYr+/wwH9kciA8YF
        vTN6uH/GDKwSKtIL9kNTlgctQhB/o9ouNGGL
X-Google-Smtp-Source: AHgI3IYyOwp5oeDOQwuop7Ftw/D3v4McOi0jzMyg1VZIUv+RFJdaLsd0o7mvH+uJBP11YYJdLtsRzOmy6dCEzRcV
X-Received: by 2002:aca:4e86:: with SMTP id c128mr993594oib.20.1548707464694;
 Mon, 28 Jan 2019 12:31:04 -0800 (PST)
Date:   Mon, 28 Jan 2019 12:30:56 -0800
In-Reply-To: <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
Message-Id: <20190128203056.102178-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] LSM: Add 'name' field for SafeSetID in DEFINE_LSM
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

Without this, system boot was crashing with:

[0.174285] LSM: Security Framework initializing
[0.175277] BUG: unable to handle kernel NULL pointer dereference
...
[0.176272] Call Trace:
[0.176272]  ordered_lsm_parse+0x112/0x20b
[0.176272]  security_init+0x9b/0x3ab
[0.176272]  start_kernel+0x413/0x479
[0.176272]  secondary_startup_64+0xa4/0xb0

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 3a2c75ac810c..282a242beb86 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -274,4 +274,5 @@ static int __init safesetid_security_init(void)
 
 DEFINE_LSM(safesetid_security_init) = {
 	.init = safesetid_security_init,
+	.name = "safesetid",
 };
-- 
2.20.1.495.gaa96b0ce6b-goog

