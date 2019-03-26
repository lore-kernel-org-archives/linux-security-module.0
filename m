Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA64EC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7E206DF
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/9vwQqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfCZSa0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:30:26 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:36123 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbfCZS2G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:06 -0400
Received: by mail-vs1-f74.google.com with SMTP id l4so1796649vsq.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LW7lq5jkExR1NuLSqDh6tdSVxounhx+I412qfIcDAFY=;
        b=q/9vwQqeELW8VlIFBstln+nSZdV89CEKrwLeAoPYLE0WmwDflbjM9zmZfkKzmVHUCm
         BRnYfeAzcXfVP3XdbekpJi4zOfVDDYynZcWlYJti/6+3PxXoHiybysEqPwNAyOwkVt5z
         6L1AOH9G3bHZuwcCpB3xab+jt0vlMwC1dvuwiaHH84kZPIiYvnVXeABd6keKeimDoNiQ
         UxsPfKdmLHQpyQPhNC7Sa2RQjxS3K2H2JEzrv6rj/nis1F03CbK2WTnLlqiaDqM6GC0e
         cx56GL8Ws9KW2dbhz2y9dpGYjqfK4CjEmLkgl8xLX7USn7CY0pmxMYV1pgX6tmm3D3dT
         gMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LW7lq5jkExR1NuLSqDh6tdSVxounhx+I412qfIcDAFY=;
        b=tdRC0cOP3olZ3Z6Tcovgf0C2kWYviMeYWJxClmzVZO+l9VZ4mivqDAAc6MoPWbHEQW
         RX6OnemxZuXh4+sMfCSC8LFqAg2yJRyExh89oMtPu4OnHdaaptWM93J2M77E1bNGd417
         TlSA/OjJ5c49lUkzdC3ziWZY1rr3IV4MyUE1zlaNV3DJqjc7yEPTrgSh3+iVnSa2UAgR
         coqhNpXA7dxwARE8n78rAdL0eM2FngUh41EhPY6YVqOEyXu2CLnop9BREEFjffUS52jX
         wyXxLqdslJ7gbHc4qNR9GfuuWoiWNJzUnDgN56PPGO0t/B+kwozkfczzeCahkBBhXyhA
         ti4Q==
X-Gm-Message-State: APjAAAXXDLSmvWcfTW5Ni9evJuOQl+NL/CKMUuZGQgddxe+5dQlkELgI
        10r2xAc7y8vVE12R4crjx+/hbfEe0UH1Z8eC8a7Rgw==
X-Google-Smtp-Source: APXvYqyA91v3/8afrN3palsHlyZwOfxxJU/6gpXp8Dz1dELvFCw4kA9b2STRODD028ObSqqbRbJywu9/c/Poz5yc+WFrRA==
X-Received: by 2002:a1f:a18e:: with SMTP id k136mr7884472vke.88.1553624885547;
 Tue, 26 Mar 2019 11:28:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:20 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 04/25] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
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

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
---
 kernel/kexec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..57047acc9a36 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images",
+				  LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.392.gf8f6787159e-goog

