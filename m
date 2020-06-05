Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6AAC433DF
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FAB206A2
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X9Xd39sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgFEXAf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgFEXAe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E4C08C5C9
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 16:00:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so3248566pjs.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lbYp8Ah5PsaIVi4QJJDeodrUyhJmdB2XhNayDLcqg4=;
        b=X9Xd39sMlyaFaDsKVcJ8nmOkzZyJ3sF0+ia3NlMgbiPN/DjckV6mw691tNQX5Eh/fX
         iFU9jT5lWR8S6FCQkBWpOKGw3n3aIiukA2UCdHfPC1IPwPji8KyaIlFMbkFNEJG0ek+/
         r2rW2WvDkIaQFixit5DMC0B8gT0N/0roYnqzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lbYp8Ah5PsaIVi4QJJDeodrUyhJmdB2XhNayDLcqg4=;
        b=JYoKWvM0dAgubxdae2FR2pk74jtqE/g9S30rmBSDXMIMg6I1UXbQuigymFHQYrD/qL
         TDRk9iU3QZYhNNQvxFvMkZVJ8i0S2QADzgpJ4hVpdBBVzECCVZ/oxb7miH0fP5EFo0RJ
         fXcnl4gCH6QnLsVQOOFr+UE5YLnJiabGbTRHDDbmYBIfPSd8t2mSJvlNkOmEFq6VLKWn
         FntEIz7J6RWDMizNKgl0MK8DpulVm98zpU27S01vFsAO8EGwC93YlKAl1Gv6DFeTt9cR
         D8+E4GgXWK0dkDW75xv+2rhxK27rj5HKuLREW9n/BpRlvtE5hnPVaJ4FIZkrEwC2Cy/s
         qmtA==
X-Gm-Message-State: AOAM530CYKFAhV+I5a8Z3/93YLHdd1UzrHQvoM4iGaEVdSDG4GQtt8fk
        wYztwG2eLvYlWzAVAmoUMdWCVw==
X-Google-Smtp-Source: ABdhPJzgVYLQyOZxOcb7SX3uvv2pqjz1hQwvUTTdKJpGNev9cMW+7bhSDkMdJrOjyWI0ETUi+YJusA==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr5266002pjw.233.1591398033613;
        Fri, 05 Jun 2020 16:00:33 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:32 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: [PATCH v6 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  5 Jun 2020 15:59:58 -0700
Message-Id: <20200605225959.12424-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b045b70e54df..9fbf255fe093 100644
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

