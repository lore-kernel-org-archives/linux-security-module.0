Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E0C32750
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E24A20663
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3slEEpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHMTVe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:21:34 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56044 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHMTVd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id 22so5058682pfn.22
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LGoSw8wdPlJ5LZexCtQbX5CILiN8poHoRBIV73YdzEI=;
        b=H3slEEpqUKKz7YIUBqg/8QpCBvIil0RBF/4+KpAWN1+qD5n2YDQa9WnC78++oRMQc7
         HRdFJzlZYsRgTZNpKs2esIFI9HtdhG9M4wYO5mGqJl0AMr/fvjn/qHkwffYYSuBIrYlO
         rR5PlV3rgfW9XnQrPvoIr7BaK49L/ldnKIMj4XVvQyZ9m8yG57UlMNCLkzNFqJOSFof7
         tv+rqUpPdp94GuSTka+vhaqja66yzDU+w1mPPEsXgfduv5fiPSfcsXwTK/7rB3f881vC
         mPENoNfW8z/140tEMn/oBnf69iZm4Y++8j6p1kK13pETOapVp9+CAOcCpRLPw25R4AGT
         isBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LGoSw8wdPlJ5LZexCtQbX5CILiN8poHoRBIV73YdzEI=;
        b=lPwJDLd+Uzxf3PEEApcJcDWTVA2LGt4o/uq4Mf5i8Phdd9vqmTmSgCBu7yyge2EVvE
         SsZzCjJoUp5Rjoj+2eOgo9PI+C83QqYUysMyBpDuh6Sj9bjnwi1rszCErjwnEHGxSpdg
         mHMQxSg+uVikfuFgWaaFiNhhdyxuY/t7Lye5IelZ2qWxMKyUCO4gKzXFGbJ0/C1r6wHD
         c5oO9qBRGvdGMpZSAL3XEW52UmKIykv3O/WW2Jc2z548VVL68rXUPh3vj4K83aZGpDSH
         /fvaoZuC/RDp+jezm4XGibUecWJTPsQdYTu/r7TeN0WkJiTMYJHzGfyRPG3hyUvEGs9X
         kWzQ==
X-Gm-Message-State: APjAAAWS216sPRAw/ZBVca+scu11t7jS5FuCn35/2bnz1YWIgNQB1VBi
        ZVElkU/kbs60E7x1M6dWqCTeHddXVSUEzPnOAgFgxg==
X-Google-Smtp-Source: APXvYqwzMe41fY7WVgXRqbj+bDqvVvSfpAGS+es7PR1B9q896RnZLvJbKOMAoWK6X7eFUaSIR9VBjcCvbecldsFqcZeRBw==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr35560835pgv.437.1565724092836;
 Tue, 13 Aug 2019 12:21:32 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:21 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 1/6] tracefs: Fix potential null dereference in default_file_open()
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Ben Hutchings <ben@decadent.org.uk>

The "open" operation in struct file_operations is optional, and
ftrace_event_id_fops does not set it.  In default_file_open(), after
all other checks have passed, return 0 if the underlying struct
file_operations does not implement open.

Fixes: 757ff7244358 ("tracefs: Restrict tracefs when the kernel is =E2=80=
=A6")
References: https://bugs.debian.org/934304
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/tracefs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 34da48036e08..761af8ce4015 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,6 +42,8 @@ static int default_open_file(struct inode *inode, struct =
file *filp)
 		return ret;
=20
 	real_fops =3D dentry->d_fsdata;
+	if (!real_fops->open)
+		return 0;
 	return real_fops->open(inode, filp);
 }
=20
--=20
2.23.0.rc1.153.gdeed80330f-goog

