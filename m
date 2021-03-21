Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7EBC433DB
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 04:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816F5619C5
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 04:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCUEKD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Mar 2021 00:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUEKD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Mar 2021 00:10:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B248C061574;
        Sat, 20 Mar 2021 21:10:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r14so9945268qtt.7;
        Sat, 20 Mar 2021 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gB06eIi+AHoV6u6Rh5CWH8MdVE/5WSskFA6H59FSDO4=;
        b=u3yhtY/yum6Lz+WhbrEJnbfw1x5kkUu+VAjI7e+OifspeOYATcX6b0W0AlLJoDnF7L
         DnryCqzQkPPiAE2400DaC1WRYzyTEMJ8OBN4DX6cOtMPZC/qsntodq4j5s43g+ccMiRL
         Y4ITEdDAaEScFs5u/qq5AtH9giIy8eK+I4VC4CNVIOXr5DRrlTt1OFvD6IC/qz6G7sIh
         bIGUbRDE77TIUov30/YwkZmXYE8bun9JM6T2radnBh5CG5eSMhkMH1EHeUKeAhQbwTxj
         UFT+fCkOlwOEW03P5JCZXeLN6euI7HnoBo1PQR2/JFWqF523pSIM5kx7/qw3ZBgTrqdY
         cZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gB06eIi+AHoV6u6Rh5CWH8MdVE/5WSskFA6H59FSDO4=;
        b=U+3PtT1GzUrRDpzDCyij47rv0oAP+CXssqBch1QNPyE11rTDeTSBRRAJ7RyOG7yfaA
         i+g4MWuEh9dIR9NbZ7awGXmZdc5KuO8XERRTPRBxoyndPQbvHdKSyfHxQaIDszkK+eFB
         TYpfMxG4Mvx4iFn4tW/GOBDU4mL36FLQ2tcn5vvaR+77p5M6kzzUvYg5thJkFFQQ4lws
         2r432bft17a61ygAtlrN2J8gl3lq8MaPAxjL8wYUmOn4gUpzj8jIS24KUjOa/jlCJVlk
         X+98q7NwXF8Vr9kUFEKs0OZer9zm8C5TcgCsqExvSJpjazahNxs564JEiwJB4zYJGa8Z
         qG1w==
X-Gm-Message-State: AOAM530UpIH/ZQ3/PufEyKW+YuT46MACMXgNp3hAX7jdl49dfna4Nxzq
        1mpGtl75/owagaAuQEupkR5+6WxnLnkFfj4/
X-Google-Smtp-Source: ABdhPJxLz0Nit66lTrXnzQ5G3P4RCFORCXatYUJT2mmTACAS6nkXrfMn3Z1gcVexiDXxr8n3IKfvjA==
X-Received: by 2002:ac8:7fc1:: with SMTP id b1mr4907122qtk.363.1616299802311;
        Sat, 20 Mar 2021 21:10:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.26])
        by smtp.gmail.com with ESMTPSA id 18sm8323882qkr.90.2021.03.20.21.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 21:10:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] device_cgroup: A typo fix
Date:   Sun, 21 Mar 2021 09:39:41 +0530
Message-Id: <20210321040941.31973-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


s/acessed/accessed/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Getting rid of unwanted comment delimeter addition
  Subject line missed propper commit subject labeling

 security/device_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 04375df52fc9..30b3083276df 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -409,7 +409,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
 		} else {
 			/*
 			 * new exception in the child will add more devices
-			 * that can be acessed, so it can't match any of
+			 * that can be accessed, so it can't match any of
 			 * parent's exceptions, even slightly
 			 */
 			match = match_exception_partial(&dev_cgroup->exceptions,
--
2.20.1

