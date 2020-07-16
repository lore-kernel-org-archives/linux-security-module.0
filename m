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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B52C433E6
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30BD2074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEqqPMRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgGPKSu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKSt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6549C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so6457814wrp.7
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Jymf/fV1v9U0nn13ckikvGFoC4Q4Gd26Q+zfmxDfgc=;
        b=eEqqPMRm4J7rNT+sDZvgURAWCOdHLDUMke7xBWRA031+dGM/Mmlh7QhoegLHaAEFTZ
         kwTGLnbDDRG/WGerYDXyolOuHntOeJXBaBH7O/GcbmQ9lLxP9fSVZZJo2d1r83RwIjVE
         oV5Rfd6M98v/YH4EsM+OAS+iT+15VLTHBwDp/SXRpGkl4qdjDYUfyYjIiv3edoDUPL/T
         hPzQ6/7S+FEuCXPlxDPorf2UMmJNJkQQn2IP0y0CBGvjmJmPwiaLa91AECeyZPnp+Iks
         502OyErFMwQidbZj0itA6islmnbx3NJ5heoQTdCashCvrfY2RYJg4tBwy5SMOjSB3p5V
         43oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Jymf/fV1v9U0nn13ckikvGFoC4Q4Gd26Q+zfmxDfgc=;
        b=tpHkHBVw+nCCKwULOR16za9VYl1YfrNvVgUdjf8uvz34xN+Vh80coitF9PJYmTkvh8
         eGYHkfwaUu3N9TdEUBg2rKJzxjvB8T5PuHa1Q9mxtwLBhi2NAQIe3seL5R3y+U4OYwsu
         PwMv7QRSaM19dCZlcHicOSWNRRDFls+AH21k8R9M5GZlC8tLCa3xMhtkI4NI3Wf6DsX5
         lg0RsZoI5M7mWRd8ZmpoAmPMKPMcQj8b7D9QSglw4jigSV77dHlN6GV5eFlLDFMfRhos
         Y6iy2Vx+78ye2lc8FuW11/8ZYePYw2TFR/7s2Xa0odghLCefAimjGAHz5d34b4v6eRC+
         kQYg==
X-Gm-Message-State: AOAM531afCN85B0nZGkVu6BIpihvPZguhP/LWtIc0goRxkkuWywTr+dP
        1RAZsA7DEaASCU3rEoVyOsM=
X-Google-Smtp-Source: ABdhPJwlKxeJ9rAEQtyvwxrXflFJYJfKfcxzjafJYXpKPYBgsZsWMENmbD9hLh+U366SETAtJqzrQA==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr4342546wrr.196.1594894728455;
        Thu, 16 Jul 2020 03:18:48 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id f12sm8418673wrw.53.2020.07.16.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:48 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 05/16] Manual pages: cap_get_file.3, getcap.8, setcap.8: clarify "namespace"
Date:   Thu, 16 Jul 2020 12:18:16 +0200
Message-Id: <20200716101827.162793-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In these pages, the "namespace" that is being mentioned is the
"user namespace". Make this clearer by adding the word "user".

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 2 +-
 doc/getcap.8       | 2 +-
 doc/setcap.8       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index 9c115a6..42255ee 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -69,7 +69,7 @@ capability state to any file type other than a regular file are
 undefined.
 .PP
 A capability set held in memory can be associated with the rootid in
-use in a specific namespace. It is possible to get and set this value
+use in a specific user namespace. It is possible to get and set this value
 (in the memory copy) with
 .BR cap_get_nsowner ()
 and
diff --git a/doc/getcap.8 b/doc/getcap.8
index 497699c..d867203 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -13,7 +13,7 @@ displays the name and capabilities of each specified
 prints quick usage.
 .TP 4
 .B \-n
-prints any non-zero namespace rootid value found to be associated with
+prints any non-zero user namespace rootid value found to be associated with
 a file's capabilities.
 .TP 4
 .B \-r
diff --git a/doc/setcap.8 b/doc/setcap.8
index 90aa13f..ae044aa 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -15,7 +15,7 @@ to the
 specified.  The optional
 .B \-n <rootid>
 argument can be used to set the file capability for use only in a
-namespace with this rootid owner. The
+user namespace with this rootid owner. The
 .B \-v
 option is used to verify that the specified capabilities are currently
 associated with the file. If \-v and \-n are supplied, the
-- 
2.26.2

