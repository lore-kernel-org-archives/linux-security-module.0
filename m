Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B48C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E120671
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBXm0Z1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENOGB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 10:06:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgENOGB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 10:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589465159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbY83E69uffAESaWml+T0AXcFZ6rmqCOkFWMnK8Nufs=;
        b=DBXm0Z1P8NRslHxgau1i7XAZdntuVaJSbkxBW6kdFVStU2NWtkL+XToZ7LRue0sVhCHPxP
        ZZTwcHbeqTvjRXVTn4P41VRw3RF8kHSF4nRYkDE9af1CLlZ1TazNO6yipDThxuhIUMMB4h
        /i3ZCdJajqb+Kskna8qnAYtNceLpwAQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-Yy03X8ywOHeXv5Wy9rh22A-1; Thu, 14 May 2020 10:05:57 -0400
X-MC-Unique: Yy03X8ywOHeXv5Wy9rh22A-1
Received: by mail-qv1-f72.google.com with SMTP id g6so3542402qvn.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2020 07:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbY83E69uffAESaWml+T0AXcFZ6rmqCOkFWMnK8Nufs=;
        b=U/K3RAqvsXGnX1rQcJhQeIHS7WzMOCkbM1Y8oIfirUp8I4K4/6+PMdIY0bXKMDPtMr
         ZXFTLhsO2Q8qzinre00cyMeXt5twW34Dg0sNLrGsvIl4YQhWtTKoghdpU9dSDK3dcI6v
         OTyx+qkpxCT/HIf0uMlx9MwKGKMasRW7XYRWhE4SIhYvG8zHWTn6hz2PC3Ie8esWRBgc
         VKxQ1OaLY1Jeq0DY39Q2cyxlItlOXtalpYTOdcvxcxbDyNLP51+qbbaqS6MAEdUQVjmx
         KY5qH+ea8xMTdZyFJaE/N8H0QsWavV4I4aroB2MjR3OGHXgktmqTCfHU8vHBnTTbukMp
         N7Zg==
X-Gm-Message-State: AOAM531o64z5UTPi6OIaF+Zf/5OEyygQ5WQczbHr+0I84EEIzPwpDthk
        A+RfJS3NIhI346wI11VbFRrB7jZk247suGzXoTJG4hL/+1GLSpzxTDbhgqCK5R8ynPIicS4r9yY
        Rem6bS1idbom7TCTopUhT7N8+AeByWJSBwW3V
X-Received: by 2002:a05:620a:4c9:: with SMTP id 9mr4749667qks.487.1589465156861;
        Thu, 14 May 2020 07:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo2fADFfavryjF15PayRQMc7FxwNus8UzpkWG2jA0/z5miZ85649I/y0hblRMmuuaFVkmfuQ==
X-Received: by 2002:a05:620a:4c9:: with SMTP id 9mr4749650qks.487.1589465156577;
        Thu, 14 May 2020 07:05:56 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id z65sm2536791qkc.91.2020.05.14.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:05:55 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        "Frank Ch . Eigler" <fche@redhat.com>
Subject: [PATCH RESEND] lockdown: Allow unprivileged users to see lockdown status
Date:   Thu, 14 May 2020 10:05:46 -0400
Message-Id: <20200514140546.826698-1-jcline@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200220151738.1492852-1-jcline@redhat.com>
References: <20200220151738.1492852-1-jcline@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A number of userspace tools, such as systemtap, need a way to see the
current lockdown state so they can gracefully deal with the kernel being
locked down. The state is already exposed in
/sys/kernel/security/lockdown, but is only readable by root. Adjust the
permissions so unprivileged users can read the state.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Cc: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eba..87cbdc64d272c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.26.2

