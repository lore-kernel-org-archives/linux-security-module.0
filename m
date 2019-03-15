Return-Path: <SRS0=7MUu=RS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C381CC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Mar 2019 04:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A82077B
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Mar 2019 04:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="b6pga2xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfCOEJK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:09:10 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43428 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfCOEJJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Mar 2019 00:09:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 53A3C834
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2019 04:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GV3h5MPv6p8I
        for <linux-security-module@vger.kernel.org>;
        Thu, 14 Mar 2019 23:09:08 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1F8C86A4
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2019 23:09:08 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v12so6632815itv.9
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2019 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9rMhtX1vR0PT9zKhPtIORvPqqG5lK1vASnyIVyfTAo=;
        b=b6pga2xTA+lKsRg+otrqeO/oE5Xtg2DfuJ+TfxKhq6LeTmYJLCP713zf2lKnLtllnh
         xeks4rF02YdJYpDG9wjhHVk0DSLQpwjuWLiz1AHyxnb5/ZxRoROeu5QvgFgUilG5JFe5
         ojdEleTNocLcrEr03u+luEeAXpn/JY6eWDnm7vnqiCxXKiJK6I8cfz3A9cCyEYODhT7B
         jpVF2YNvyCz95aH58ygPoWDVV/+fELahvp7jn0al8gKfYwJXhwqepbTNQOss88axO5g8
         JnGf1vmXXkIGSwFNqBd79aMemN6k6JVKn3zyh+fkoCuGFS5N+BArNPJ3AUj/5Hry8jyy
         6dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9rMhtX1vR0PT9zKhPtIORvPqqG5lK1vASnyIVyfTAo=;
        b=VsJltQnJv3cCAta/RyHHkFHDDcpPvk+wKKZ4YiTT82lcFefS1mEIbuKqaVavBWnrJh
         VzZstR/ggmTHxkXgl43jR/LVPUp1WJ6K5JK9E6TbC+R71bQCUO2AWRwxkhLRVrSeLz7O
         AFJacJZoamik8T7pv2xLk5UOPf5qMrAXrhLY0t7kdH51cvi1FSpk/fORArtRwoGppjds
         cmUccBaOWrYwAZlgqkOLYHtxtkmAATOP3s84SHimmnIN7n7N7hghH+58WvWMpCs5fjMN
         D+aoh+FCHZ9yNCjkReXd8ZbZUdUHhTmp9POo8oAX2hWf6E99qcdnhFXYG8ssl1O+KWKZ
         KyQg==
X-Gm-Message-State: APjAAAXk3sOIG2QzXojqZECTTiZNHVCNFnd0aYfpv/xuNK739MiVbm4F
        AatN1nRVwnCUvlo1YyusGNGlBvDiZRH6ILPcRG8DG2kC9TKV/uVY/f+FrZZjWHZrd5XFzEH+nrz
        OM69ZA6bCJDG5D5ZERi2uzVANd4kHTJDUcxbVICHI
X-Received: by 2002:a5e:c019:: with SMTP id u25mr990224iol.104.1552622947782;
        Thu, 14 Mar 2019 21:09:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMUBU57OzjlVlfyf6CG/asc9x8dUapj+TeZEbTNs/0vL1OTPifKfgwnDc3Z8Rr+6qeZEc2QA==
X-Received: by 2002:a5e:c019:: with SMTP id u25mr990210iol.104.1552622947540;
        Thu, 14 Mar 2019 21:09:07 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z22sm405105ioc.68.2019.03.14.21.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:09:06 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: inode: fix a missing check for securityfs_create_file
Date:   Thu, 14 Mar 2019 23:09:01 -0500
Message-Id: <20190315040901.31551-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

securityfs_create_file  may fail. The fix checks its status and
returns EFAULT upstream if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 security/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..11d9a6bc2161 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -339,6 +339,11 @@ static int __init securityfs_init(void)
 #ifdef CONFIG_SECURITY
 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
 						&lsm_ops);
+	if (IS_ERR(lsm_dentry)) {
+		unregister_filesystem(&fs_type);
+		sysfs_remove_mount_point(kernel_kobj, "security");
+		return -EFAULT;
+	}
 #endif
 	return 0;
 }
-- 
2.17.1

