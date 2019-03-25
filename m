Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E75C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0320A2075E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dURQ4cQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfCYWKL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:11 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41123 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfCYWKJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:09 -0400
Received: by mail-qt1-f202.google.com with SMTP id d49so11672700qtk.8
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fDig7kZw4F64jZ3glkaJ4FkOKfyo+66KlbXAoLiDIK8=;
        b=dURQ4cQZveYMOaE8wiQxqpQBPWN0bOzFc/OMjfuVpV/SpRxVkciThZh/XQp7aJUIoY
         Hpjqu1ojnBarr+Vb7V4twmoEaE7jZMFYiLZ/ruIcSSjRQCqleuF93UWWx27BMhJA+9MD
         GySbwDLTsb3iBPgkvE33DDYr0Qieqhpl+/c4AvqimN8UbCQbMGRoZr4Wx8wECE/sdcAS
         nyXqXomtgd+aaUVqkQ8WMRYNYXSU1Vh5CyrjW2uWtZEsUGxoJsZ20Z4rUrECYdswgZ1Q
         +iYF25aCFRUm8cNep9ZTuSi2XDOzYU0ae47vBLiSJEvCoYGBZ9CNJ8PLYsPrYNXQnTVn
         /A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fDig7kZw4F64jZ3glkaJ4FkOKfyo+66KlbXAoLiDIK8=;
        b=nV7gqG07vdg/s2apn5OmshL8HwNgRcii7wTuEyAm1ddOn200YYheNqXXdp9412uhSP
         uacVfsJzwVfr75Nuusn22AM/zPYZAkEpyIbwhhvY/iTp8T+uiv/bmC8h34A72utC37yd
         gbi141dkYRxQKZmBLAY5+TIAIrB5PJPGx8SrwfyTugwKt9FDXeqLmuvuVXeijtVI8dLA
         ixsY9RfnW3lu1gdU5JjjmWCv3ooorTtDDiGq2fnSnyxsehfz7OqVSRPjbUx+8l1h1dZ0
         ZMPfEoU6IOl0O/bWlPR7ukI5oS6Wr+Yf4S91m96UJhumMu1L88GiMm54bXvHzqeuDaYJ
         Ay/A==
X-Gm-Message-State: APjAAAUo2eiF9HdT4nhE5n2opU5UdaFoCjXajOz2rfueW26AUWoeNxso
        OG4iTKhM5jj6T5A5RDb3/syn7l+6QBzVlxCNKOakQA==
X-Google-Smtp-Source: APXvYqyYDbDjyIPsgtUkV7wYTNzsy9uc81+oc0MTtB1XElESzz+HhRURfIWwdxwJKz8FQcYg85rNE3LjoQkSu+eLuDBVsQ==
X-Received: by 2002:ac8:3092:: with SMTP id v18mr23438957qta.41.1553551808486;
 Mon, 25 Mar 2019 15:10:08 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:31 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 04/27] kexec_load: Disable at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..8ea0ce31271f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.392.gf8f6787159e-goog

