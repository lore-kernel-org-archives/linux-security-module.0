Return-Path: <SRS0=lufb=SV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA9AC282DF
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2120663
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EaGOt+0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfDSSzQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39932 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfDSSzQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id j10so3367453qkk.6
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2019 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IyzQ5btbQftJrbWM0aHTnEtKVALpoNzETGpMHZaIPvE=;
        b=EaGOt+0EjjEkZgjxbIbsyF5CCsH0DiRZAP64/JO76ukHiMz7xpBd/ZHMZlU8hwD05Q
         9uh0QsqqJuizACVSgE+gZpSqDgOZDCiHVMu8oWbUzHJVkes/fjAXHxrD6dzu2NgHxTzX
         k1wY1aKglJ5k2JJg1OO3dKnu6fHSIywZoXslbRflUCvFg06dSx9wOi/NQ0F1/YYf2w12
         VRtTwMmoDALfx92FZLAfpwy3hvk4AZKdjUo3xqRqgeOWbTyyIjNz7HCJO7z7vfaZ00fV
         JJOa+HrmSsiZe2gPRd6xgkSxVbGMhZkFbzY7HHnxVdEf4kuMoqr4ulDiKZhN+eXLqHYb
         aZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=IyzQ5btbQftJrbWM0aHTnEtKVALpoNzETGpMHZaIPvE=;
        b=cpfHqYoL5KYggGiYDZ5/IzAp4npioFfUV0roz1yoBYEF1IevHxOH7Ej+DtY6t1fdan
         igEvIS3+AySf0UUwqli58NLLTpDFHOuXg9bVmQQXWv7MkFd2Nio/4BjmTokk2FNjO18t
         PRiPlvb31wES06IYQ+db515CHbhWWiAqj+4y/8/Ow5G6/FkvuBUZ2dHxwnTU6AY3wsCN
         E3RTzVR9K3+qwGa2yU06RvDrYmzJAGLTFZa0hnCiEmnl1MSxTtpUR381Qbn0u1oEcH+x
         Uxax0ZQB6IFvQKJUfzOBzAOqLbDix2vRRUnkjNPgE5C9mWy5G9Ud4vZvF5uDTSx9knv3
         ncUg==
X-Gm-Message-State: APjAAAXRLl8LxtJVJs71HzxJRAs3FtYy6YR6n86X6egjIyesAFzzJ/do
        HgQQDFdAuaXsRKU2PGMZwfhfwaZ4VQ==
X-Google-Smtp-Source: APXvYqxjIFdh64aCmn9++d8Zgq+lvKLUbo7+LEFA6/PpeMyN4ILZGc9obA0vkGVNMfX58ANeYQdOiw==
X-Received: by 2002:a37:2c82:: with SMTP id s124mr4258770qkh.286.1555700114582;
        Fri, 19 Apr 2019 11:55:14 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id i24sm3512340qti.76.2019.04.19.11.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:55:13 -0700 (PDT)
Subject: [PATCH] proc: prevent changes to overridden credentials
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, cj.chengjian@huawei.com,
        john.johansen@canonical.com, casey@schaufler-ca.com
Date:   Fri, 19 Apr 2019 14:55:12 -0400
Message-ID: <155570011247.27135.12509150054846153288.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Prevent userspace from changing the the /proc/PID/attr values if the
task's credentials are currently overriden.  This not only makes sense
conceptually, it also prevents some really bizarre error cases caused
when trying to commit credentials to a task with overridden
credentials.

Cc: <stable@vger.kernel.org>
Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/proc/base.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..87ba007b86db 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2539,6 +2539,11 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 		rcu_read_unlock();
 		return -EACCES;
 	}
+	/* Prevent changes to overridden credentials. */
+	if (current_cred() != current_real_cred()) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
 	rcu_read_unlock();
 
 	if (count > PAGE_SIZE)

