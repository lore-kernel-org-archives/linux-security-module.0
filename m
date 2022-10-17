Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD8C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Oct 2022 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJQSPB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQSPA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Oct 2022 14:15:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31771EEE3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:14:59 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so7162539qkk.7
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=aU8h9+ypy+2PCxvwWU9GRNf0d9lpWVNRA9Yo734m55o=;
        b=faQ/MA50+ZojtouKxrRjDRvSw/3y/CARqZKBACdeEJwvv5/5MNzRopeu/s6GJHpZwN
         0SmYylIgWrAOmg8nCNqOBOAtHNZ3bAZs4Mva0QADTU5YSS4QaRlCwEKQj/PZWoic6x28
         NrTohhPSVn5xhN75pUPRLjx2wWOcNhxTUKS1YyjNXSkB/279g0JuRRaAbdoQW3DasuAh
         UuzE6NYmYBmazqp+Qi/IFBW+dS1D8f2GWAV+NZf+lOHZ+y92/UfItL6vzPLxrLxytOFJ
         khjmpDV+V/Qjq3Tc2nloA3wXDGT1XSgBr7BqaFmNXnx7zzqPnvM0cIWo50yVOgsUwJyu
         hSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU8h9+ypy+2PCxvwWU9GRNf0d9lpWVNRA9Yo734m55o=;
        b=ZJg49We4t4fsJhbZOuO+cozwyJPNv5Vz4uvi9uqbOo0jAxAY/OasPRvQ2AMgTv75zC
         0FE81cv5k/HYU+3Y94NN/0OC4a/L+RLCrd6/iThGjcrxeTHGIAPFcFZO8qMqG5NsgJvJ
         CIUu7MqlQ/5NdAUce0G68CzjiwPr3WnMqli0hACaR5H+AJc0lNSMOOvX/VOnL0RX6IqH
         1scNmg/i4Vi5BugpSZmwREdJPiiCu4gNF0QE8bSdxk7CXRjLjn8EnuHHkuZ/bH+ANEOQ
         nFsvs4j8w75210C3RfShoJNXr4c55/yqdIHgoJsdKXCX74i7KU/cMqQfH+RKrqJnHuZ3
         3xYA==
X-Gm-Message-State: ACrzQf1pkxSFaVD8pChRhHBr8fWcRD262IzgQv4brnsuW4Tm6mqphaKJ
        pQW2jCXPA3QBz6q4oPRfx+78CPaTGQFn
X-Google-Smtp-Source: AMsMyM59uPcyQ/+V/blhAJoVUJjMmwyuPZpaLLMuEZkFpp8Nv/J2eApp4GR+QIsa0Ib7LKMlQaToZA==
X-Received: by 2002:a37:65c1:0:b0:6ee:9097:9ce3 with SMTP id z184-20020a3765c1000000b006ee90979ce3mr8824965qkb.620.1666030498612;
        Mon, 17 Oct 2022 11:14:58 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8580d000000b00399d5d564b7sm341019qtg.56.2022.10.17.11.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:14:58 -0700 (PDT)
Subject: [PATCH] fs: edit a comment made in bad taste
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Date:   Mon, 17 Oct 2022 14:14:57 -0400
Message-ID: <166603049758.227260.3219849022705789477.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I know nobody likes a buzzkill, but I figure it's best to keep the
bad jokes appropriate for small children.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/fs_context.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e46..6fbf49cc10e47 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -99,7 +99,7 @@ struct fs_context {
 	const struct cred	*cred;		/* The mounter's credentials */
 	struct p_log		log;		/* Logging buffer */
 	const char		*source;	/* The source name (eg. dev path) */
-	void			*security;	/* Linux S&M options */
+	void			*security;	/* LSM options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */

