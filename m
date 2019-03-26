Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A868C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E471E20700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7dNOb7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfCZS3i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:38 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54537 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbfCZS2g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:36 -0400
Received: by mail-qt1-f201.google.com with SMTP id b3so14392694qtr.21
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=h7dNOb7RQMavv0sp0Zow1gRw63LnZH39UfrTPdhj02fkrvrZrEAZH78cfkEj+UQc+0
         CJjusC/IoWX8sWu5YfQZWyBfIgCg1kdW7WmC1R0rHpjM1s0mtPsNpGYbUAw46xxOqXel
         5tAmEK9SZvRqh7JM+1CynPqgm4agy0u9BCaznisqLEyI4iz7fwYVAXlnEe3mqReVkYi5
         4mr/vqCxtGCrvpZY5FgmdB521DBRBqUSK5XY3wb/gMVqgChTLP1opGEFzTWsSfXhNHwd
         HVr3wnpU0+ls7oaLhQK8AaYMFujCCN2584QK2ScCQc8RLOMnVgvxdxBTdqIU+FBrYXyX
         6JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=qvPLn2eKHYj2c4e92037/kWI3vhnq9QtI/B1+HN5wVvRjjevbFllPxnesiDoqNg3sH
         xeLghULKW//mcWRSyVP16VOzmfxd2Cl5PJukUw6JBF09BD5XQUJs7k7qQFROD/ryyR9Q
         WUVGmTAXFn06D2Ks4tFdF0rTuGzOOhta2WDA6ZE56jzBFF0i+7D2c4t3X6wVmziAGxN9
         7c+0Gyopa/H9/ub+ttr186TOs/WjBS3J6+SsQFh7p8rrDVbzZNbYMaHYLUXklBBHVIX7
         EDb2nMb3+0EchSTEP1C5A1lsyJQs/Muw2S8NrKyJjUcrWVwwmoNu7Ica8acGXSGNmI9F
         P+CA==
X-Gm-Message-State: APjAAAXp+Ok1pnVhi6XJmk3S/aqZtA4DLMcy0v8N4rEJ7y7VLcLwO+b6
        LQ1y/DqOzJfQy3F/p+Xu8AZI2MgauFsbNoWLeUqRuA==
X-Google-Smtp-Source: APXvYqxQhg0QFZGUTOuDkDlVLMMfRXQc/lsxF8gnvkp3TvGjpj2EedXHo5jW5sl13rNyrq6r75ypdN01tARzQW4WSXWCWQ==
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr24386884qkj.185.1553624915314;
 Tue, 26 Mar 2019 11:28:35 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:32 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 16/25] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/pcmcia/cistpl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..9e23300a55e5 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage",
+				  LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.392.gf8f6787159e-goog

