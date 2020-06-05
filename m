Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F707C433E2
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E621206A2
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N2VTGCAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgFEXA2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgFEXA1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033CDC08C5D1
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 16:00:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so4266236plo.6
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=N2VTGCAxLShf+NltxaRrg0tDyugL5y/JZISwomOE1XhWz9pQJ1r367lpz8y+mcTMa1
         mw+bGsSyVNJhVfCFWfwawobM0sydx8CrYnqY//22mp072eTfdnRZc+o70JJOyjgwARCw
         qa0T30qb5yYf/I6iIszbk99K5lW/H1oZAP7mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=NC8EQTo4BzCRy43YCfB8XSAlwEv/0MhhUax7sm54ZeqZHPJpthiZju4yeaKjvmO27I
         UDUt8LKdTIt/FYbcmH8YC7EebK6cF3QOWjTWYKbidUaPw2UcEmKnQ5NKvLLyfJVeMcFV
         cOz1JdgHb5Ppfs/FiNmVQ5vEiCGd0+XYzP4Xyy9yUnJuAKRZWgoR54FjID1BmdgepN5n
         Rmo1h+TCoopjgGRQWEP8829DPBe7WyRxQ4db8BEuf36USFt0iEOls8jZ70P0wZSWY+fa
         AWRcdcYOUh+sNBZtbTcEh917ny193PHNTSa4U/VRifc8DdqpMxp2l5amBJGKZqv9pdR2
         e11Q==
X-Gm-Message-State: AOAM5303j70xbzNcscIKX0d+qYPGb80Bh3dwO/ZvJZiQ0mEmLk2totSd
        4uLpAI4RzNjV9JUfzaY+hmlT3Q==
X-Google-Smtp-Source: ABdhPJzOswhG9A2QWB1Ol1+irts8PB8Cjsm2B2FxeurNfMtbYK9/loEAEddbKhTB1BEwbVX1PMMH1g==
X-Received: by 2002:a17:90a:df98:: with SMTP id p24mr5442938pjv.135.1591398026312;
        Fri, 05 Jun 2020 16:00:26 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:25 -0700 (PDT)
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
Subject: [PATCH v6 5/8] bcm-vk: add bcm_vk UAPI
Date:   Fri,  5 Jun 2020 15:59:56 -0700
Message-Id: <20200605225959.12424-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add user space api for bcm-vk driver.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..783087b7c31f
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef __UAPI_LINUX_MISC_BCM_VK_H
+#define __UAPI_LINUX_MISC_BCM_VK_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define BCM_VK_MAX_FILENAME 64
+
+struct vk_image {
+	__u32 type; /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
+};
+
+struct vk_reset {
+	__u32 arg1;
+	__u32 arg2;
+};
+
+#define VK_MAGIC		0x5e
+
+/* Load image to Valkyrie */
+#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
+
+/* Send Reset to Valkyrie */
+#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
+
+/*
+ * message block - basic unit in the message where a message's size is always
+ *		   N x sizeof(basic_block)
+ */
+struct vk_msg_blk {
+	__u8 function_id;
+#define VK_FID_TRANS_BUF	5
+#define VK_FID_SHUTDOWN		8
+	__u8 size;
+	__u16 trans_id; /* transport id, queue & msg_id */
+	__u32 context_id;
+	__u32 args[2];
+#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
+#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
+#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
+#define VK_CMD_MASK		0x0f00 /* command mask */
+};
+
+#define VK_BAR_FWSTS			0x41c
+#define VK_BAR_COP_FWSTS		0x428
+/* VK_FWSTS definitions */
+#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
+#define VK_FWSTS_RELOCATION_EXIT	BIT(1)
+#define VK_FWSTS_INIT_START		BIT(2)
+#define VK_FWSTS_ARCH_INIT_DONE		BIT(3)
+#define VK_FWSTS_PRE_KNL1_INIT_DONE	BIT(4)
+#define VK_FWSTS_PRE_KNL2_INIT_DONE	BIT(5)
+#define VK_FWSTS_POST_KNL_INIT_DONE	BIT(6)
+#define VK_FWSTS_INIT_DONE		BIT(7)
+#define VK_FWSTS_APP_INIT_START		BIT(8)
+#define VK_FWSTS_APP_INIT_DONE		BIT(9)
+#define VK_FWSTS_MASK			0xffffffff
+#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
+					 VK_FWSTS_ARCH_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
+					 VK_FWSTS_POST_KNL_INIT_DONE | \
+					 VK_FWSTS_INIT_DONE | \
+					 VK_FWSTS_APP_INIT_START | \
+					 VK_FWSTS_APP_INIT_DONE)
+/* Deinit */
+#define VK_FWSTS_APP_DEINIT_START	BIT(23)
+#define VK_FWSTS_APP_DEINIT_DONE	BIT(24)
+#define VK_FWSTS_DRV_DEINIT_START	BIT(25)
+#define VK_FWSTS_DRV_DEINIT_DONE	BIT(26)
+#define VK_FWSTS_RESET_DONE		BIT(27)
+#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
+					 VK_FWSTS_APP_DEINIT_DONE  | \
+					 VK_FWSTS_DRV_DEINIT_START | \
+					 VK_FWSTS_DRV_DEINIT_DONE)
+/* Last nibble for reboot reason */
+#define VK_FWSTS_RESET_REASON_SHIFT	28
+#define VK_FWSTS_RESET_REASON_MASK	(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_UNKNOWN		(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

