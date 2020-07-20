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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD5C433E3
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E1E22482
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPlB57LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGTJN4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgGTJN4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:13:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C0C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so17045177wru.6
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABvjT7IUEPxXaer7HfCvBTOQieEMtzVplcRO8FaOpAY=;
        b=FPlB57LWw64zQmwTlhcPByyUZh2YOb/dLQjVMyGMo3z2jNpe1XkGXnXMiO5jMF1azX
         OCBt0rpudSYb3ATErpQqr/ypexKUlqG4JCr+8TIQOHmc+DnNpsBxDwN23dZomNyp3lDC
         PZA0W0TFDaP7HZSsuQcgAUuWSqG5LeMy7X5HI/3xDP4w7Haf9mqfIno4WmLBNIf8b8Bu
         2v6GoLZU5TTPIUlxs6FE32x5QUEf+S/v/2sNrDRoevYSfoOmXhnE9NrgOtsDcWXfoFc2
         2TlrACK8BqIdY3xv8xpVNcZP0Xr2BG37ckhg12pLDPMsyJwa0zv/R0KKVVmMMbswncwC
         TwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABvjT7IUEPxXaer7HfCvBTOQieEMtzVplcRO8FaOpAY=;
        b=CF3yJZ8how9nTnu8JhltMaXVSylovhClrGQgFG0Ylvh+l/jXru/uE0/4Vxapx3AB6s
         y8YSXturP9umqA6IKG1SWLV8phESJgYLqp5Lx8ogPuZFawh45DSPIzWxVpj1pM7c/AiZ
         P2TRDdg/rMjTdhM16B9e0XhkR0XgxPYy/X7dAXh9mXwCSwHB9hA4aDhxHtoOC1EBk5Q3
         o4XnO8NdTrAKTkXLqROwkl10780mbf1pHqdXYjjYbQ2V1CJvDgn6UC8hAVhj1NtgV/Ui
         KvfmnhBdYZUd8siTns9gJuoY0WXh9yHSZKPRXCODK7OFBoJUPbSNupX7oYNdM0ye1AEl
         94qw==
X-Gm-Message-State: AOAM531Hu6OEDuDiu0TSxkuDyDBnfh5WfieF9eNb9+0UyjVTVSHjtMLo
        kt/6qs4AVb8fNftPdsIdD1A=
X-Google-Smtp-Source: ABdhPJxxTlzYaPkk4Hvu15GMj2+PJQvSnGSGqV5tkqxt5jQAfL4KxlTsXhoQxRBFZX1MreGQA8VSaA==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr22084475wru.142.1595236434521;
        Mon, 20 Jul 2020 02:13:54 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id f17sm33894994wme.14.2020.07.20.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:13:53 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 02/15] Manual pages: cap_init.3: Formatting fix
Date:   Mon, 20 Jul 2020 11:13:15 +0200
Message-Id: <20200720091328.290336-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use nonbreaking space inside 'char *'. In addition to prevent a line break
between these two tokens, the space is not widened when performing line
fill. (The filling makes it look weird.)

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_init.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/cap_init.3 b/doc/cap_init.3
index 96cfea6..362db66 100644
--- a/doc/cap_init.3
+++ b/doc/cap_init.3
@@ -41,7 +41,7 @@ The
 argument may identify either a
 .I cap_t
 entity, or a
-.I char *
+.I "char\ *"
 entity allocated by the
 .BR cap_to_text ()
 function.
-- 
2.26.2

