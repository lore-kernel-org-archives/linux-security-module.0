Return-Path: <SRS0=ug0r=UM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3EC31E4A
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E552082C
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8V7naw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFMPeM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:34:12 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43061 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfFMKcw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jun 2019 06:32:52 -0400
Received: by mail-pf1-f174.google.com with SMTP id i189so11560675pfg.10
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2019 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c8B2WpV2ao/GiAyoXZe0rgTXimW81Zj9eba5b1nq+eE=;
        b=h8V7naw5ZXcy9hmK/khUBCeii6w8istWHF8EhmWYofLp5tS8e7g/0p6wZ6C0USi+Dh
         mrRUluvbHlgWF/K0yOocTUP2YlkLwNpFUDSsXVVnXSqzMxRZWRa8AlpSQUB4RrPs6IWp
         Un0SbBuDDP+12ShPcNz/XCABHYeLuj6PS9IayrYHiA8AwtHPQ4tPtuphrFBF90Vs17i1
         vsXkMoAETxkRSg8jeio5rfDxL0JIBqmfMMx1icRj4Xq3iUPOW52qUByywGCwTiXh8DFu
         1ObjgH9WASPPsW9zF4CAFudb6rqRmc7X2kjWgK4X/RZCxjra/QjT4/pkl2l4+HA8RP9h
         ch5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c8B2WpV2ao/GiAyoXZe0rgTXimW81Zj9eba5b1nq+eE=;
        b=aiPRSkY+ZlQ3H1eJC52yFfLYsxS2hSEQ4IPOu72BJ3meoELbj7fHJ/SVPn0DpBDUyq
         ZLbUt2hSlQrPUQqVkQMM2Z4/+CBQUQGJz7hRkfAKDPj47tHpor77SszxiMV6jzrvfe5w
         4sSW0Ebaq9zeLIAvim/Vn7Y4BjkoZGxtiq13PxhGRfpQzpU7ajBE9reMJmlm1o7oYiHl
         REjc9jI4p3Q3M+Rvm35bHM/3SipBX1qbTz7jDImAGJ7Via7cYZwKX0QraelZsAm5xBxO
         UVFoVE3muj/OuoKNpTCe1kKafr4mJld6p+lp6/BRrBefEekj+iMdxG52WNFlO01AyTLk
         OGbA==
X-Gm-Message-State: APjAAAUp4snwMaGNphWHHssdsy2QS09jIS9w8lx0/HUcSXpyi+Q/ajb0
        REJIx/qSxKDqjSJjGwhwB2WS+Q==
X-Google-Smtp-Source: APXvYqzzZ7YxoNMF8oKGpZA1V8rzQ5wmso5pRZlZbpTxImoytKeurGrlcgP5yFfHuYycERwMARH53w==
X-Received: by 2002:a17:90a:8c06:: with SMTP id a6mr963486pjo.45.1560421971996;
        Thu, 13 Jun 2019 03:32:51 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:32:51 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 7/7] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Thu, 13 Jun 2019 16:00:33 +0530
Message-Id: <1560421833-27414-8-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496c..db84fc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8728,6 +8728,15 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	security/keys/trusted.h
 
+KEYS-TEE-TRUSTED
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	Documentation/security/keys/tee-trusted.rst
+F:	include/keys/tee_trusted.h
+F:	security/keys/tee_trusted.c
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings@vger.kernel.org
-- 
2.7.4

