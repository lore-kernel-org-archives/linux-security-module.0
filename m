Return-Path: <SRS0=zBV4=7T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE28C433E1
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 05:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699CE207DF
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 05:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LKRXcXAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFFFHS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Jun 2020 01:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgFFFHR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jun 2020 01:07:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE2C08C5C3
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 22:07:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so5911929pfa.12
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=LKRXcXAxk/S4d1ojJso185sZY4EDd7oB/TMjk4qHxfa7tmHK7uGzpexJtAQ0bVeTe4
         gxBGgLgZRHQuGtimtkN1dVO21gb6VLxc7FipvFzOng1pcG9UzU9p6XcUDSBuN+VOdGTa
         UMazTNd+n15aosaq7Nu8SUmiRSlNUnFAGE6lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=iO3tXTKJxs/jFLlHoYYOeHpjR5E6UjzeUhAgYJjDUWVBNH4oizJ4+o6ilRQ+HV4HIg
         fErO0bNpT+fzavGelmgiDRjrSSLYOpdVN4U2evDAjukhPZzqbvOtnB1EiPdt+sCWUeod
         Er/m07FcGZ4BV0Y7bdf06rPA8Szwjz07AJ23FTnDUtZ6Hmp13aS2PDR/o/pM2rCNep3G
         WQ5y+fj93067GbJQp/jgDvhPNSvLaC742kZah7/MwIvH02xqeK2qTOAB7I6ee1KjvYAO
         2ooqUKhJdJGd7J+D/gjJoTB8r4SX6OkL0k6e531JxX66EUBaQhoyj/H4bxh5udLCoNzw
         RDIA==
X-Gm-Message-State: AOAM532dfNaXK63XzTHX7idCCHMMs53c5o9b/GfIkKn0jocTRDRWUUU2
        LhMhtkk4tVNOT1ZsZ3HXjBh5eA==
X-Google-Smtp-Source: ABdhPJxeVT9a/KR76jybKQryE79B0JYUNZw1/TXZXF/G9QFvxCuTwEjn/4pcIn1mqf1SwS4HR8Nf4g==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr11796192pgg.404.1591420036309;
        Fri, 05 Jun 2020 22:07:16 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:07:15 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v7 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  5 Jun 2020 22:04:57 -0700
Message-Id: <20200606050458.17281-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 411cd97bb485..ced084c526df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

