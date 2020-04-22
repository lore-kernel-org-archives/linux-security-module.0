Return-Path: <SRS0=ipMR=6G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F780C5518B
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE120644
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAyTHliV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgDVTIa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgDVTI3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Apr 2020 15:08:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC1C03C1A9;
        Wed, 22 Apr 2020 12:08:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so3817689wrs.9;
        Wed, 22 Apr 2020 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wHAhiwb0HmUtLybhCQWVdXxIEXLGFSsRrqwWb+5qYg=;
        b=FAyTHliV1YsB8uZlFGxJG2NXUQ/FproBZ2/1VKMFSV+RZq0dVo8ndoMCWAX39niYPy
         bL7bSvaFhC7D7wGO2EEKpmZKe1lDKN1MMqgknoH6zBBOZQR/QT6MB8HF3nhfibKwa3ot
         luk3vlSNHb8Qf3xn3nt6PTV3b96P+Hpv8uiefL2Qd5e90CUN462sufcsZcxoArCSzVqk
         7TNweh5RU89TFn/c8VLlBoEx7UW6y68srpRUjXON+fy6LPkGaBOXkNox0WCEcXtgmz0D
         QqCUd1zvsFj/osLHYmTHopQF/MzpU5IIcmajfvoccH6veVyW2arldWBS9uRu8uNlJ1ao
         u1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8wHAhiwb0HmUtLybhCQWVdXxIEXLGFSsRrqwWb+5qYg=;
        b=DtRKjZZa+AxPiIOO6eTmyin6jN/k8ysNYQ87eTpbAb1O+hSFH0WZWVZ5xFTYfq9RQ4
         lbTbPaF8vKa2zLtpv5ytUPV8Eyt4QIle6Z4EgGXOe1FMoGTvHfRaiyOitDp0ooUu1Cnf
         8dSwI1K2KR+0otYbhMoO5292iaJVJnLyXeZgjMqJTzbianrrm78cA/o0J20tdbSsy07F
         HsjG6/hbAEZjY6KjQOWX3j0UJDuN7q2OP5Cv8mP5srMYKYv7VhpGShRZHzYX9czTQfjI
         859XOHX7jUcW2T1Rj1P2yDrBQrDUlRopa99ZWmLxUDpdWisBIdz/SOeIhjaUeqPNc+Yy
         Y97Q==
X-Gm-Message-State: AGi0Puai1aJbC6BNDvcEgm/IrvLkjZp1N8pbepxvd1RkZcL1/mpeHNPg
        zlvKbOSt0E5vAU2oWw+dGgAgMJP+w6U=
X-Google-Smtp-Source: APiQypLGW/AwtswnCFh+9vE9yJ/7nYCzvgTxlM5Ko2T7e8EuX6uGB3KzBz0wXJxHDE2cvQH7pKqgUQ==
X-Received: by 2002:adf:f450:: with SMTP id f16mr567036wrp.346.1587582508253;
        Wed, 22 Apr 2020 12:08:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id g74sm231833wme.44.2020.04.22.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:08:26 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     netdev@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] netlabel: Kconfig: Update reference for NetLabel Tools project
Date:   Wed, 22 Apr 2020 21:07:53 +0200
Message-Id: <20200422190753.2077110-1-carnil@debian.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The NetLabel Tools project has moved from http://netlabel.sf.net to a
GitHub. Update to directly refer to the new home for the tools.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/netlabel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
index 64280a1d3906..07b03c306f28 100644
--- a/net/netlabel/Kconfig
+++ b/net/netlabel/Kconfig
@@ -14,6 +14,6 @@ config NETLABEL
 	  Documentation/netlabel as well as the NetLabel SourceForge project
 	  for configuration tools and additional documentation.
 
-	   * http://netlabel.sf.net
+	   * https://github.com/netlabel/netlabel_tools
 
 	  If you are unsure, say N.
-- 
2.26.2

