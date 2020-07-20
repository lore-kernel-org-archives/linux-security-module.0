Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C5C433F4
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDD22080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn08oZ5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGTJO2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgGTJO1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44969C0619D4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q15so21518073wmj.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iIMCTOKKxeAH1WnqSQ9w5juFzPfT424/VCQldW4pX0=;
        b=cn08oZ5xfgQPVEPyEwI5g1xtTTnItB81ZZg15DE0NArj7hwjnUBC3PtrFpIklGgI7x
         FtRMeibW4Hh98Pfo+TFWEHWMul8/CRdmmltV7PppP7NhL3J56k2wIcbiB3BFH/1+KcfJ
         5gnOfhIjNvRgJ7Hhw/Bi4sZJZlQtJCxqxd6wI3epRrcfy3AoA7o0aMXj4cg+8lDimeQ3
         MBW6ngefbh5g63QPAF60BeLd1+20yxRZOx8XwWLaMZRdnnovBasByxXBLMyyOsdOGAxR
         uTF/CknI5ZU4ZX/GOvMLyas16Vo7n1eLUqXDkfbC8alNkugKjIHKvorbOUM+jzr8w0cd
         3qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iIMCTOKKxeAH1WnqSQ9w5juFzPfT424/VCQldW4pX0=;
        b=thS5g3LhX+9H+0CvRFy57YS37yJXk3/JzKis1dhOizjq+u+WJWOhqn/KiOeDNaWum4
         lYkm8rhKSAs3ttVHyZU667J/lXefVjP34dlfRN+I/CdIPJ9tY4lDcXpo7aQynGNMrrs2
         P94rz/ZzFRakSTLDyfQvZgZ20TkS3DTcOJS4v9PFOivQgDzanI0SnyUFTT7KbTjuKkwB
         eSZEc4lP5TwoCfJ35uqDX6xYbn8rnS5zGyauZbF+hI4DJbEvYZW1mv0aX+aQcPOQ6koD
         8zJvVIkAftlhVqbXGQm5jKltzGG9gaYyGU4qeq9Jrww+KSiBZaiIn9HcAvo2KTTUFRM2
         F+lQ==
X-Gm-Message-State: AOAM531+sujTGeCHEiO7Cb/IPqiC0OKi6WVAUKCyLbe8At35Bs+Rm6N/
        Xx5Dtzn1up39dXJpgY1Afkmdwkme
X-Google-Smtp-Source: ABdhPJxgrfh9c3mw9UJJkigm1F6HeghBMyAL3TqCdpTdBX7b4M9otR2Qaz7+GabRjhI0Fihg2Ifk2w==
X-Received: by 2002:a1c:e405:: with SMTP id b5mr11939114wmh.54.1595236466037;
        Mon, 20 Jul 2020 02:14:26 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id p11sm7494814wre.32.2020.07.20.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:25 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 09/15] Manual pages: getpcaps.8: Remove a stray .br macro
Date:   Mon, 20 Jul 2020 11:13:22 +0200
Message-Id: <20200720091328.290336-10-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/getpcaps.8 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index fb3bc65..dadd365 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -36,7 +36,6 @@ default terminal fonts.
 .SH SEE ALSO
 .BR capabilities (7),
 .BR capsh "(8), " setcap "(8) and " getcap (8).
-.br
 .SH AUTHOR
 This manual page was originally written by Robert Bihlmeyer
 <robbe@debian.org>, for the Debian GNU/Linux system (but may be used
-- 
2.26.2

