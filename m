Return-Path: <SRS0=7MUu=RS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53641C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Mar 2019 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910421871
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Mar 2019 21:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S94HRmfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCOVBB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:01:01 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:44990 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCOVBA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Mar 2019 17:01:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 72727DCF
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 21:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x4FowCeHp-o7
        for <linux-security-module@vger.kernel.org>;
        Fri, 15 Mar 2019 16:00:58 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 75C36D19
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 16:00:40 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id r136so8871110ith.3
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtAS4qSg7Giefp86uKjVG9vec2LGb+bwqRxzy4Wg2fI=;
        b=S94HRmfQr/m0sZKQMPtqCskXQEaZ2Y2D78HGRgtvjSlv501+fMcAc6M3XLiclCqjYe
         Mn6ifpEukgiJAd+VDjn7BrKva6FUYFk58n/O/suvBi7ReQ8UEjoNTreCqqFmivPDEKAQ
         LQywFVu+Ni7k9nxpEa1cgVix7iPvqcaPF/idEYTkKpMhxYPT8TFZBJ0dMNkC+ZcofwcE
         lC/L2XqLJsK/tsGCm/myDCyqlVU2TFpw8sIEDzSDRaZmU6lRuk3GiYiP/coM6IjfQx9f
         o03bVvgdOmWM9eP3iwRFqjwG/m6Yx5UjQnGs+WbdNGPZO9p+qSTbGviDIySQ/youV+1/
         Iadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtAS4qSg7Giefp86uKjVG9vec2LGb+bwqRxzy4Wg2fI=;
        b=lZwl+cPeWQZkrG30g0RkAf7aFgyr3HAvV47tEtt0yPV+skZdW5w78/Uf6IHq97l9mh
         ygM6F+eZHM7HScACrWpywNq+XUFGP0kCEOI9gzy1q5n3Q15p8njCtAUNgJQBPY8eFeQT
         YVuEd0BQsrLeIEiyJiZk/9SSpWgyec66nojP2IMHF8yHwY68GIo/ld/MlTjZrHBT8D2a
         bLEH2kemjRDpPd58drDHm9nvbxxtD2VrrYlCIzz7JUWZLMoQNTByUMbJzlFdtl6j5TB/
         745xfAfTTymYnIPYm8fL1L7nVGxlGUYbCCoV/1X+v/RGZlU0hbCQyQ+Br5j81dAJ7qJA
         DJ6Q==
X-Gm-Message-State: APjAAAVRHfYCT4tddvHJFK+uF+weBgHWVEZzR5ud+W/T1utEt6Zrcc54
        ahG0FQIv49bQEYsDvrumLk/HhKT0T2qaQr0gD12VehwEZr31rVMhNIJsVQC4LxCUigxt21RYMfv
        vIriFpNYFhnQpTz3vuum6xnghCwOEQGI9lS5qom7r
X-Received: by 2002:a6b:3905:: with SMTP id g5mr3551935ioa.39.1552683640043;
        Fri, 15 Mar 2019 14:00:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkGObh0pJxwSO+noGpgDpqgJQP48cBGHktiLN8hoNG8Em2ePVj6ao8u95ndKX+ZwUu5tf4BA==
X-Received: by 2002:a6b:3905:: with SMTP id g5mr3551923ioa.39.1552683639755;
        Fri, 15 Mar 2019 14:00:39 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id m26sm1590510iti.6.2019.03.15.14.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 14:00:38 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: inode: fix a missing check for securityfs_create_file
Date:   Fri, 15 Mar 2019 16:00:25 -0500
Message-Id: <20190315210025.17832-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.LRH.2.21.1903160608080.2905@namei.org>
References: <alpine.LRH.2.21.1903160608080.2905@namei.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

securityfs_create_file  may fail. The fix checks its status and
returns the error code upstream if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
Return the exact error code upstream.
---
 security/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..667f8b15027d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -339,6 +339,11 @@ static int __init securityfs_init(void)
 #ifdef CONFIG_SECURITY
 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
 						&lsm_ops);
+	if (IS_ERR(lsm_dentry)) {
+		unregister_filesystem(&fs_type);
+		sysfs_remove_mount_point(kernel_kobj, "security");
+		return PTR_ERR(lsm_dentry);
+	}
 #endif
 	return 0;
 }
-- 
2.17.1

