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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B96C433EA
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083C2074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdaIbzh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGPKTX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKTW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A2C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so6481044wrw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dakoHSD/dbWABcNF+jvVYrxJzF+lfIDeO7FCP3v0d80=;
        b=kdaIbzh8QbNG3YhzqRyM5kDwjdnMGtvc9xT8uV29Gt5sAdljzNcYSml4kvV36MUVjw
         gM9yJt8WXOcqUu+b296SGfujsoi8gIsYBJIKfvDY/BcZKHN8h5ekmtICdzpIBCugX9Pk
         5qi6ctX11ZR9ibBle0AVn4U4Gfz3NsrttfEoU51tEoRsyf6uZ6OpiEcqeK6j/eb2ZDW1
         xI67SpDU65rpBEluc4oYNDzaMfNISCHBJYeVfwECIzMtkOEOhM0yvRKGIHy11VZBEi/s
         TxaUmuo4U34MSLLvGd5mIUrr6e/NSCikM/7ctavxL7ClT3FKnjmWnWtYrueGDyKiCA8F
         +RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dakoHSD/dbWABcNF+jvVYrxJzF+lfIDeO7FCP3v0d80=;
        b=OHr6JHXNA+3E9kC+Xaqj4wirvTphNv/T9qoavn1Ymlt9Yl6Zu/7fVz07JPSiC/jnoW
         JGXZ8zfBj9P/S/rmzAjXrnewcqnn7Zb60lUHyt2Vg6vjMRuRpOtPU9hS1GHPBwOng/Kj
         JBuE2T/YP8Tzk0XQCbHzYpYj/259M6RJsOcdlMaSr/ACTCOg75cFkEX1q4zJI2WSFlRi
         bAe3OD2shm7wwgoJ3wqD/R8k7lKO01/cgJtLcOde1n8bSX5dZhcpiEky94AObjsp6r1W
         vMg8VP4k31x0A0VF0uIUFAaetxW017D4BNjONl7MsUiT/pJ1AS79uz0CL0SNpf1n1GEa
         g5kg==
X-Gm-Message-State: AOAM530tGtJX/GeJdawTzMgya2y7s+cuN6VEPrJkfX5YrXWMogxU/Tkf
        Z2ZTYfwLj9WqOxScNaIj9Xs=
X-Google-Smtp-Source: ABdhPJy8AFUfpVRY27w1c6FfJkGtv08DGOhvgCMhe85MTxEQbuI+O6J2q8c+5U3QLBLsMRuzcJt0Pw==
X-Received: by 2002:adf:e944:: with SMTP id m4mr4520440wrn.252.1594894761196;
        Thu, 16 Jul 2020 03:19:21 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id p29sm8180280wmi.43.2020.07.16.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:20 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 12/16] Manual pages: capsh.1: Update the capsh --decode example
Date:   Thu, 16 Jul 2020 12:18:23 +0200
Message-Id: <20200716101827.162793-12-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With the update to the output of /proc/1/status in the previous patch,
the example no longer matches. So, add a different example.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index 916353a..fd6a5ba 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -206,15 +206,13 @@ CapAmb:	0000000000000000
 
 .fi
 This option provides a quick way to decode a capability vector
-represented in this form. For example, the missing capability from
-this effective set is 0x0100. By running:
+represented in this hexadecimal form.
+Here's an example that decodes the two lowest capability bits:
+.IP
 .nf
-
- capsh \-\-decode=0x0100
-
+$ \fBcapsh \-\-decode=3\fP
+0x0000000000000003=cap_chown,cap_dac_override
 .fi
-we observe that the missing capability is:
-.BR cap_setpcap .
 .TP
 .BI \-\-supports= xxx
 As the kernel evolves, more capabilities are added. This option can be used
-- 
2.26.2

