Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686BCC433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F84207F9
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xY0giUdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFBOTe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgFBOTd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 10:19:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A4C08C5C1
        for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2020 07:19:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so1520670pjs.3
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xCxdAYBVIrnVoprqZ3jc+GoVPrFZj6YiVt4v2J1Jy+c=;
        b=xY0giUdNw9UJ2TjpJyNqI4efCSRpXtJ7KKCsoCmsl7Kdk1y5wXcoLznAn3lxWsl7gE
         P0N0oaJKpEO4QHz3289dxJouCe3Ss924AcbddVxgz1ZBpwNu5NS4AF4iFgefY/XZ8haj
         l4e8qU+Gj+HDdPTtQ74oTHfApphH057dmr7/8WJkrtiz1zee+wHNNpWa6CQSTSsNJ0QW
         t8dbUyNW200HiMjzM+5w4tm+98SjEEiqF3pxh3PgDrsNWoEa4+EvBCH6vYkUhZ9gI0KK
         HfGbwzfPPfQI0pksrCWAmbeyOwCSGGdcTUuoPgkYbDKl6nKl1VzWOAuzCnv92EzERP3s
         xc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xCxdAYBVIrnVoprqZ3jc+GoVPrFZj6YiVt4v2J1Jy+c=;
        b=hss1/qUbqdpvugKJfRO3SgI+qMkfXozSseUxPBwxjaBS44k9CyF9VQk9sGiI9TrpjT
         QCyJwHbSfNb0SLm7htwkoP2KYfBSFgrv+o0+v4gOZ8cgEu23Eu91czfMHDDF15HkCRsw
         QuORNTOROGkyfG34d0eyj4tjkRQKKYNwaAeQjayZzdcRDoIcnhyGb17+Qdb/gbJFy8oh
         Yiw7iBUsIiYttdnA4GGUrl8og9fF1g9h5SnERFXeiIphMVWGjSqpflBiiyNiKQBjHDXj
         meVt+E6cwhSkyCiqfXBmBcKO3HXR3rxRsFWsDeE6jHFxWwZ/eITqLUxEqpxM+euWMcvb
         Ob+g==
X-Gm-Message-State: AOAM532X3HdqQQ9yTfDgl3O1DRwU+5o8YBCk43uXZ42JmZuG6ERGfA65
        hA8P3O/2x9o59l92PO42UWZh7A==
X-Google-Smtp-Source: ABdhPJxG830cH55AExGhe6B55/Arou3ybH7xW+GyhjWQJsAYEmUijypwo8iXX6XtFsQd8+bFbMS8dg==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1mr24928855plr.8.1591107571910;
        Tue, 02 Jun 2020 07:19:31 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id 141sm2529670pfz.171.2020.06.02.07.19.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 07:19:31 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Tue,  2 Jun 2020 19:48:25 +0530
Message-Id: <1591107505-6030-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b58ca2..50d0502 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9396,6 +9396,14 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
+KEYS-TRUSTED-TEE
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4

