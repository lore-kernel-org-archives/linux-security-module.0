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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D2C433EC
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C520B22482
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvb8GzIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGTJOT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTJOS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE1C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so17046412wrv.9
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sx7WzXi8t9iKijcQLqMcZUMKtCWBmlWEZDj1w8g4xrg=;
        b=rvb8GzIHCr8917x7PZuhUXdPgL/1eJkAWe57JBJOJ7m1Ej6j2VXY6WGo2RdJziwCj5
         4QkcncjW6uYhcN+v94GqP01FsPpOBOieYX4yPEG2T7PniOwJjqujsbEXHNkC2cbn1Gjc
         OfQWJQ7Pj/ldRSHigZfqOCi1ZPhLsYg1r7qM/ksleA0Gz86yzRNm4QHrZVzxbkr51Bu6
         XSRbUMsqKw/i/rXENwJdJKgpfsZtoa/lkxLFHU4s78FSqvVqsAJ5YkiibZ+GMePE6kXQ
         ARVPoxkxt5fs9EkJ32oEG1DUuSdkSffKNd3LvtVFwqWNRXTzuXXSCOU2P7aAcr1PnIK5
         EW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sx7WzXi8t9iKijcQLqMcZUMKtCWBmlWEZDj1w8g4xrg=;
        b=mYtoCMpMgjM/vs6erbIFurjYxffR+woVOtVvCKDsh58dlvQ0A2DkPdKbgfsd7Hq58A
         YfUANQN6DrUzau/Q8AH2V+U9snn5pwTu8uogBNvpYFd0BeEI4V8IOlINFc4Di8J1zcw5
         RQ2sWbid2xOLU/654Rzqhd3moq8qUF3uEU/S+HwZbyoy/2WGRdmWwDXxRL1GNlp26oIJ
         zHA38IpWDIrnr0up0S6FeSyy8FYcfmVReFsEzqnKPs9x4AJgnzZKtVx6LneeBenmRC3A
         HtLVhIR9K7GClZSnLyTxmYikuA9sR0v/hH9mG06gzvCsGQKRfUk95hgPSAObchAiv/lh
         WGRg==
X-Gm-Message-State: AOAM5305FWJPiYoxhc3ChKWyUiFzZtXtZEPn5D4X4DQ2l45lsHUxOw1B
        c0bFLLwZj1RbEGp2D5TFzeQ=
X-Google-Smtp-Source: ABdhPJxjnTh03KRx7IJaU7jg4zjIg5d2BHLhX9K4VAwYj5xItqfDGwla2k7wSNANdbLdaWysQrBlKQ==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr11329182wrv.160.1595236456888;
        Mon, 20 Jul 2020 02:14:16 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id y189sm34488914wmd.27.2020.07.20.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:16 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 07/15] Manual pages: getcap.8: Fix a clumsily worded sentence
Date:   Mon, 20 Jul 2020 11:13:20 +0200
Message-Id: <20200720091328.290336-8-mtk.manpages@gmail.com>
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
 doc/getcap.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/getcap.8 b/doc/getcap.8
index 367d010..2ad8092 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -20,7 +20,7 @@ a file's capabilities.
 enables recursive search.
 .TP 4
 .B \-v
-enables to display all searched entries, even if it has no file-capabilities.
+display all searched entries, even if the have no file-capabilities.
 .TP 4
 .IR filename
 One file per line.
-- 
2.26.2

