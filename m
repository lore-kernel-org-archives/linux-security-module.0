Return-Path: <SRS0=RuUe=A3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BEC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8BB20775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnULQ+Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgGPKSh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKSg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A211C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so6478677wrw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDt2xal84TATsstOSphmaodG2nGyovL6j06R7GLtHSQ=;
        b=CnULQ+JxnvrBvP3CVEPqy+kflvLtkvTcHvw62fEqw+JJZapNqIX7/WLn2seql+rAvA
         Iycsnv4mqumdBCDxPGe7ttG6p4V7Dxt9hEKM9SMek+nPofwPtU1LaFSUa7SrRIu84W+V
         c+jhvhVFhJbSCM5WMiabsJCPauOPYOWtIwifZZnutbIpVj0SZpygjwbFVmm6UnXrCkr8
         qATyNQfZ4aaVxpB7jJvzzE4l5C3u7dJI34k7BaeGfrWOw4qHieAI4ifhoEnMu4M8i91U
         KV7PGkYOERwKbDzuvHW2jqPDXxTvc+WsXCO47+6ue4PB2c3YnF8Jmvw17BEaZ6584JZJ
         j+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDt2xal84TATsstOSphmaodG2nGyovL6j06R7GLtHSQ=;
        b=lTglh9jz9CJ6yWTQTEd+WQ4NQeSj06/gnoabIKZoMdp0dAvWdGtp5ajrTp7ChzK2v+
         LupLKaHqONoqOVbopg3hh3pJGCA/dpZ4UG6J10CV7Ukmy17gU7ksS1nfpD/IQIg1gJ22
         xK+q2ZEJIGlzwaTNZU/kCBkPzUmj3CwQfF6b7dSdVzUFKLyu1KA4qseUHeUiqYXcEkal
         m7WKBZ4g9/ACTEcgyMTrksodTqgmK3onD3wTs74Fq/ukVOwPLZXGN/Dl2C9KX3/RZBw7
         HsWgoe5MyPjKTUEEaubYT3PW4syG2kCtHY4xFDrSzW4d3oz2PzTd+aRI1ZJoNDztwEQI
         0JXA==
X-Gm-Message-State: AOAM5306DxQNGFNTUVRlrXw/nE9sh4J/xvFZko2ApJSA2FsCQFbxG4Ai
        MjpX+Pwvzo+ti7ppKl24+mw=
X-Google-Smtp-Source: ABdhPJzSaQaS21LlMBeMl3T7Hr2RMN7lGH5fZ16XRMd/vMzCv1fyRQ4F9dB262v1kwLi4RSPyNSL0Q==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr4126071wrr.279.1594894715292;
        Thu, 16 Jul 2020 03:18:35 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id k126sm8562152wme.17.2020.07.16.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:34 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 02/16] Manual pages: cap_get_file.3, getcap.8, setcap.8: SEE ALSO: add user_namespaces(7)
Date:   Thu, 16 Jul 2020 12:18:13 +0200
Message-Id: <20200716101827.162793-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Since namespaces are mentioned in this page, it's wise also to have
a reference to the relevant page that explains the concept.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 3 ++-
 doc/getcap.8       | 1 +
 doc/setcap.8       | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index a99ab40..9c115a6 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -136,4 +136,5 @@ Permitted or Inheritable flag enabled.
 .BR cap_from_text (3),
 .BR cap_get_proc (3),
 .BR cap_init (3),
-.BR capabilities (7)
+.BR capabilities (7),
+.BR user_namespaces (7)
diff --git a/doc/getcap.8 b/doc/getcap.8
index 0547ff9..497699c 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -32,4 +32,5 @@ https://bugzilla.kernel.org/buglist.cgi?component=libcap&list_id=1047723&product
 .BR cap_get_file (3),
 .BR cap_to_text (3),
 .BR capabilities (7),
+.BR user_namespaces (7),
 .BR setcap (8)
diff --git a/doc/setcap.8 b/doc/setcap.8
index da95afb..99e3c36 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -59,4 +59,5 @@ https://bugzilla.kernel.org/buglist.cgi?component=libcap&list_id=1047723&product
 .BR cap_from_text (3),
 .BR cap_get_file (3),
 .BR capabilities (7),
+.BR user_namespaces (7),
 .BR getcap (8)
-- 
2.26.2

