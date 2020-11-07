Return-Path: <SRS0=bsG4=EN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D6C388F7
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D097208E4
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPl2FG84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKGIYa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 03:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgKGIY3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 03:24:29 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAAC0613CF;
        Sat,  7 Nov 2020 00:24:28 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id z1so2061295plo.12;
        Sat, 07 Nov 2020 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tu3kWxeosmXDoauuhkoszDn3Cj2sxvN5RrGeZRd8L+k=;
        b=NPl2FG84jc7LQKTk3T2sSekJ3+VWN5yxNn/fCzyGjS9rC68sfFm3m69KCbI5sMDxzg
         DXcldUFS2ixyJKqkPFeappVmrxu1xSAPps5qDApeYVqYz6hytnKr2e73WGvNISXTRh9t
         Rgey/lLpfHlwL5NCSXaxX3jVkF884LFJn+iu/WdgIdE56QXy7o3qScew8N0H5C1bj+vK
         HftZXyvvEK9L33DgF/xSkVFvn4JAXogYWBXX0IOahGRYN941XELseHZlQaKPcK94HdNa
         A3wGZZPcq3bxsC+C0ARKJBgZZ1zw8QBFbDL/ZIGz9+BU57nhvmRQ6ji8OBvtEDZIaPls
         yRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tu3kWxeosmXDoauuhkoszDn3Cj2sxvN5RrGeZRd8L+k=;
        b=QqG/qaC3OOallQrng7e9+iDj+TPlrWMrEE+ISG0WvpiY82tBRhz/KwowMwbZp2rdhd
         5kyT4diem7AxZ9d+qkoTfgYuRahRZbBlGj6fxVo7hVXXwfcJVO95ex4gHfd9DyOkIUDX
         gwA8KBJQJQFbS6BDUJNNMR6MXqiLzG4GthGzbpVRjkELN0COE9dt2Kmsdc/4uWZhZibI
         5QUQk03TI1wPZL6MF75NNNklROOqdUj/afQfawq/TtsryhvwXAjwtb/UdCkiLHyRaUWJ
         oaKFofCTrUzpIMNfAe0tFpnCqo5ypUETKgwaSdINsAON4r4nUaNTZWFQryaaF/BamMDr
         clvA==
X-Gm-Message-State: AOAM530fUEuKLopw0Zs+4X1soFldnM9IRWLiAJd0c1BvmCqQlSgtRj4z
        A9hAdc6NuFP+/76QXzNf1w4=
X-Google-Smtp-Source: ABdhPJyRwRusAKGvDTfhHb0s28hfonRW/6Xs+ConXh5fstgWxMb67p5amzVejehyEZwDLoVDf7W9wQ==
X-Received: by 2002:a17:902:23:b029:d5:b88a:c782 with SMTP id 32-20020a1709020023b02900d5b88ac782mr4746076pla.5.1604737467694;
        Sat, 07 Nov 2020 00:24:27 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.253.68])
        by smtp.gmail.com with ESMTPSA id 128sm4705273pfd.110.2020.11.07.00.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 00:24:27 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] tomoyo: Fixed typo in documentation
Date:   Sat,  7 Nov 2020 13:54:11 +0530
Message-Id: <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixed typo s/Poiner/Pointer

Fixes: 5b636857fee6 ("TOMOYO: Allow using argv[]/envp[] of execve() as conditions.")
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 security/tomoyo/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index bd748be..7b2babe 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -891,7 +891,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
  *
  * @bprm: Pointer to "struct linux_binprm".
  * @pos:  Location to dump.
- * @dump: Poiner to "struct tomoyo_page_dump".
+ * @dump: Pointer to "struct tomoyo_page_dump".
  *
  * Returns true on success, false otherwise.
  */
-- 
1.9.1

