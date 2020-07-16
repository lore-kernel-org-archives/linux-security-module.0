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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97336C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688222074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRsuF5Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgGPKTO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKTN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAAC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o11so6461709wrv.9
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfyRa+58G22/2XBv+O+dqyICphuUuPPiFqHgi1xebcc=;
        b=eRsuF5YygDSB4NenzFKi0q0zj0Ii8PIDZA0own0J90nvAZ/jUMUJUnYUIB+DwFwNxR
         xQ96UZtdVhkoW6xWjAhqfJf5oeadgeYjFDu/sYf0VxAaKwy+IKc0IPuqAAey7oGwZIgS
         bn7b1u5JGDD7b/92Ev4Gzt5SZ53o0jS5jHiOmnOh/69cqaIMFFtaSDzqPViD7z6G7Qhy
         i7VuFQH87tRdpYgC0wQ9NNT59f7IS5qSJv0u8zlc4f5CPs7aoXtHhgaeX9US8k6aTqOc
         3KHOAYZNh5rNxNpqgzpdCYuOgO2PikzZSma+57Gl7VZLxyptEoUuymuVmvLo7TMQg2S5
         qIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfyRa+58G22/2XBv+O+dqyICphuUuPPiFqHgi1xebcc=;
        b=kMQK1lfKq4yGgrxxNfQ+Gj9w09hWRoXnRaxZPBNUJleULYGVb0YT4xauwIffuQEwO3
         0aOttiZ1qYvrgB6UeMlJhRP+GEphtXaN8C9si1mL/kBL9THYInwENFHlRPmFdl+jZCO+
         LVvAFPigztrS8o+X4ec7KfNeU90CySTXMnt7pyyuEjbxOdIBwOV6xt/VTQnanH0EB7Ny
         aflTC6je91jPmWdiiF115ZyN3sPF9y5ATzf6g+DfUy+mEdILcjdXWz7cYIpA1YV1P95c
         YippF4Oi6nyJd7ZmZJ148tSfK4ItnRds4MAse38JVoF6MNF8lFTqc/Soe2eFHjbHZORc
         i8jQ==
X-Gm-Message-State: AOAM533yq9CHRtqS4EVEoU/q6VDSzsE6SKr0x44b03cohUpcujdKMGfd
        XN7v7h62NvASgVhgMaZ1qck=
X-Google-Smtp-Source: ABdhPJxQiVuIHIgacpzNoBWQbHtckZKyCH15yy5E5vTriXd3d5sOoDWeU9dqZF5LwSIVI34SpgMqNQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4322247wro.214.1594894751920;
        Thu, 16 Jul 2020 03:19:11 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id 59sm8546292wrj.37.2020.07.16.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:11 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 10/16] Manual pages: capsh.1: Remove stray .TP macro
Date:   Thu, 16 Jul 2020 12:18:21 +0200
Message-Id: <20200716101827.162793-10-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index 24e80b7..522e719 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -249,8 +249,6 @@ Removes the specified ambient capability from the running process.
 .TP
 .B \-\-noamb
 Drops all ambient capabilities from the running process.
-.TP
-
 .SH "EXIT STATUS"
 Following successful execution the tool exits with status 0. Following
 an error, the tool immediately exits with status 1.
-- 
2.26.2

