Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315AC43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D14D2133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVqaNZmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfB1XMU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:20 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:53258 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733299AbfB1XMR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:17 -0500
Received: by mail-it1-f202.google.com with SMTP id 190so8361586itv.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=omvW46xVRIJwG7a8uUzxR/RTr/Sb5wtOc00auoVaOTc=;
        b=CVqaNZmT/Vxo3WpAM7ktoGnUP7Q/3Hx0MG5cQwh9S0SE/J5yZCEog/cy4qgT/Top4V
         JXL0JlsqLvMEz/iuxg9miOURifPBUNIQQdqd9DTk3jboMiFD9Gpm/Ty0DATFBMCHLzRo
         sEhvOu0cPA+j4usH1UVgAzYuFmmZL06a4OtYjRRkz7aP02dz/gjQeceXfVe2rNvRvCbl
         8vikkPt5QQ30X9wvHV4nVfVjc2wo8Dqodx/3jyVJJg43fapTWHgQN66blfpaeOlUDjhm
         jdXuEbPrRkArOWpORujX/IXd7Lzboi/jDh2JE9Lsmv68uH0PM8X910TxaHaE8OOepXOq
         K9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=omvW46xVRIJwG7a8uUzxR/RTr/Sb5wtOc00auoVaOTc=;
        b=h3pMZwEsiqfMzf+M05zvyfKIajH/hFYczzfMKC+6fcVVwa6tfr01IVZn0BwUVWZ1T2
         2N7YVCPJih7692wiW5aiGwwF20MfCSKbtXC6EWOjwIE0VaZrxA8dEh8EipKMbTUvu8pV
         z6RtLN+rqcwnEoQjh8QIyM8ecXt9A1K9o4dR2r3AkrTR3p5ElVGWBVfsFN5/OqucWRpq
         gzA3zt5ukryWPDt+NLu2YVXGL3/AQ16+o6IGqtAvBvhfM5obdH0tgeFicnzInRAAqE3L
         ziO9a/0G7SdwXSBD1BHcfSf2rEdseb5taC+XowjWj2dyd3dfWX+tPScQz+t4Jr+E3gnJ
         8NFA==
X-Gm-Message-State: AHQUAua1gZ61MhxEJeF0mYN9tAatuzm812mLVYsyoZxO+nPlMtzQtn0t
        vvXS6yN+EQ8ZGDh06TtS2dMaO7s1jzigmg81y5U56A==
X-Google-Smtp-Source: APXvYqxN++346xVExb88s90l6mAGuPKjGUD+3tiMTwdRvtYnnzM8Y5Op2dnO142zdc5PVmmMAcM77+lQIwSp+hj5CTq8/Q==
X-Received: by 2002:a24:16cf:: with SMTP id a198mr1544187ita.0.1551395536713;
 Thu, 28 Feb 2019 15:12:16 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:41 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 05/27] kexec_load: Disable at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: kexec@lists.infradead.org
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
2.21.0.352.gf09ad66450-goog

