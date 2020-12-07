Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E2C2BBCD
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56227238EA
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgLGQel (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgLGQek (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=T0+2xB3iqqlQO38Ocx5wf702KoWyIEkSaz4NqibfUOM754sLBuAxr27ebjZ3z1VMESArMn
        gCLgRL4iiNjdh2G59bnuoKgT0IYuQeAnYFCoRhN2f+Gq7pecu0FYToZFRMwtUmc56t7K/1
        enfN7gory8SOJB40GLEHAmtrGtL50YY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Y_ccCjLIM6ywqbUnY5ktbw-1; Mon, 07 Dec 2020 11:33:12 -0500
X-MC-Unique: Y_ccCjLIM6ywqbUnY5ktbw-1
Received: by mail-ed1-f70.google.com with SMTP id cq17so2500395edb.17
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=GC/z+tjRrjgth0QpfkEBxQugHRpPnkD9PJy16CurcagHlflgmRGu3bD5vB309Szy8y
         WDq3gRzueyNE3V7UtHyOoCZhzc+z9QFzQ9GpgWsWk7X0pjZdDG+CDp2EAbqdtyJG5fTm
         QVq9oM2M7W+wbEgtmb2w4mpORW32AV+d58w/vuFLYcqksQFmV2XK9TxCQOPtvg/+vBtr
         0pXkvTIss/rImaQOsBIiJJ9smkRw+h5/h0lip9OrKE0z58VenGShdi7+aIy39UIN1JTP
         opCAc9LA4JvAEgNJF/ZJLTzCGpzLkj/1gf7VHQfuMx8JJqboT0a+WTZF6pEd155VEn3n
         Ihew==
X-Gm-Message-State: AOAM532krvaMnZwGdDzh7uTq1MEdRrFPYo0ZuF8QlB8OFtWT8yDDeeKf
        +ypmZNNpY8UY2c6FY2AME+ZJhK51b0Zt+tEvnZShNRO4gDsst66a/LZaal9/RKqX6MctiEngn2h
        ZwDv9K4qx7B8de2kuHPfltme8+05qOxN1PgjX
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156479ejb.207.1607358790895;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweaIFgMC09TO4pnW1Q9E6ePGnwgJZA2DaWMFT2e+UPWDLsluzpW5Ef28/5k5tUJJKQ0PR7fA==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156470ejb.207.1607358790718;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
Date:   Mon,  7 Dec 2020 17:32:53 +0100
Message-Id: <20201207163255.564116-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In case the file cannot be opened with O_NOATIME because of lack of
capabilities, then clear O_NOATIME instead of failing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index dc767034d37b..d6ac7ac66410 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
-- 
2.26.2

