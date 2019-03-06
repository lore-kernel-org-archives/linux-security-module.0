Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9599C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B579120663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwYXtqg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCFX7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:50 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50980 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfCFX7u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:50 -0500
Received: by mail-vk1-f201.google.com with SMTP id v123so7256371vkv.17
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7CZJafxJx5K8s0KTAGx/cb0COJjD1VsMHrphX4q9xHc=;
        b=TwYXtqg92i8rtVNs3UFbQo0S5dqxiJRdLg7OmvpgqdBn2thEpiMDx7+y3OiyBCyVIK
         5bQ5Zlyojb7UvS7jwwD1ssl42j3Z4qHdQQ0UsmCC5Q43XsxM/W8h9yY3LeXnRnx5tTG3
         vgxfRjf0bpwIaBBiUmESuUDGqk2QcWgC759lLgs+CAryqFzz3Wpf9NA5dfw2NFyyeKR0
         YhQpCufdemS8shSLjEqi9Ak9Wp3laaLwEpjJs9AuK6biLJuyh19Pm60FHWCNSA/D17Z+
         N38omPB+Twprj9bOBJGuWP09sRitBmX8+4c0LNb+Yx6osYSt5Zv+q2moX06QpkVc33kW
         U5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7CZJafxJx5K8s0KTAGx/cb0COJjD1VsMHrphX4q9xHc=;
        b=OgWLmoXOt4wuKV7vI5EFqW9yZpj7HC+82tnyVsYwzHQKasGVgloTaGLaA+5ItOotmN
         eQ955rxrutIFezVWKBxNCgwnjUMyLxsEa33G9mGVQ5kAQOAXvjKLRss8OFbeCy7prEKr
         d1wIsmMejQ/LpsC3NOR2LBI32YsOhG3+ndwGhOgLpmQSe3s+MulK8CqZatUdj2ZPED1Q
         m4uMeC5QYnlrZzWz5q6+dOplYOYy05l/BzRS85TydFQH/AGkMMKo4RPxIeIocY+vfJS2
         YkivwdZ8N/gaz2bkGh8z3qsxtJXV+9Zxwc+3fcWuQXQ+ca9p3vlrEKxe+06FEuwly67M
         ANjw==
X-Gm-Message-State: APjAAAWm9mNkoGCNrAbKdiN1SUQqcsUzSCLYTgpvUGicSvvI0NNyaXC9
        aC0NL9mqso+41dzwZnhTPqqnZNuU9VJxgotLkYw5Hg==
X-Google-Smtp-Source: APXvYqyEyqxCfr/0CcoThrN8sYnOFddoPmHNo3SSBCt3q9qooH4LMAn+PUgqnonjxmvruYh7L6YbUj4snzJoNfX2IuxTAA==
X-Received: by 2002:a9f:2d84:: with SMTP id v4mr6876735uaj.22.1551916789062;
 Wed, 06 Mar 2019 15:59:49 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:55 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 09/27] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pm@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..802795becb88 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
 }
 
 /**
-- 
2.21.0.352.gf09ad66450-goog

