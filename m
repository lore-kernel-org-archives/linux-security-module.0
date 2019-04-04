Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA91C10F06
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7FD20820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRAlL/xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDDAfQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:35:16 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50751 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfDDAdN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:13 -0400
Received: by mail-vk1-f202.google.com with SMTP id k78so426786vkk.17
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iaaF5/aYD/K1PTKwNLEWQdX8WLqLGYfc09hndKsTKvo=;
        b=IRAlL/xFWhgbbpXtzjS8gWTXeZcNeEhAKd8NbdYGUmAEC44bgqLt8+paigb80y/Q0j
         EhV7F6H8vUaAzgky2cnEOMhIdDbk1k6Fv6F3Q+LIf2cT/CCUnf4GmpjSJPMvtiH2tkYG
         DcvYmZAKAj6LnpeL7LtQoyvQ58e3LcxfNJMrANWVlrJGynzrJEELOa5/D8v4unQ04F0D
         cWPZYcEadltcA9SHWmsAWpxyXliB1Rlsqv+3CXICyR9weXkQOfvfgDs2Jchw2Pd86cwk
         o2v5txavD8MqgJlM6iqRLbj4+x1qUHY1kEoEM3vxd8y+jE4rxGz4Mlc1IRFvNTCy9Ro5
         60Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iaaF5/aYD/K1PTKwNLEWQdX8WLqLGYfc09hndKsTKvo=;
        b=eJ4tbaP99fzdgR3xUsE4xx2ktdBLbhzs/Vem3adoqjF0lbMB5vqXGz3Vuj9U3f8KLd
         4foXWpc85Rh56/9sI4SlMvZhyQDpSjnz87oUuZwaPgaVETloxdfM/EVXUfYBYZRB/IRC
         tU/AHFOkSgd13GU28co6iDbQ2Jl+8t6h6Y/ybXLro0j6N6l5U1o5sWVbsnAhc5TIvmK1
         FAUPHungfebFyzo8b1xT9pEDjCqPgTvRgR3BUSqAx5rDEkfNIIzR3Ov/9khiVVrQKRjt
         yMEHiL8J0Lm6++lNExEk2n6XEhLktaWAls5kCFGI3uO5Ss+hKSmh7yEawaW8LeftCuh0
         quiA==
X-Gm-Message-State: APjAAAUPc22TRegZMCQXXgH6r4Kdrx3Pj8Hf2aCMbxo1W3rVvOzwvntR
        hJWpfx8sGwUt5eloZhCniDF0pGV5NbgU8Z0APh6wtw==
X-Google-Smtp-Source: APXvYqw9Lw50mP2E9RFKzr2uBzyKV4bQkDkKFIehcmqEqfdPpSpIAo1DzC+63SbTNAY3OaDhNoijQBd0lYyFH/X0Ouz5nw==
X-Received: by 2002:a1f:1b82:: with SMTP id b124mr367884vkb.11.1554337992127;
 Wed, 03 Apr 2019 17:33:12 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:29 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 07/27] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..a1cc37c8b43b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.392.gf8f6787159e-goog

