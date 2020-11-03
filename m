Return-Path: <SRS0=HMJF=EJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1FC55178
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Nov 2020 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C7B2236F
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Nov 2020 16:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yogn/KZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgKCQDM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCQDM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Nov 2020 11:03:12 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E3C061A47
        for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2020 08:03:11 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t22so8749945plr.9
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2020 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zDggAsDI739UznsdJGV123TENJ6R94pJsrrMJ096A5w=;
        b=Yogn/KZ7ijrqJ0T2z6E6jJ/rsJS/CsbY+bDuFIpVxXfqjMcWW2r08cwmXmAnkPO8Zk
         c7p/xjaHTOXmoh8uNv5PKN9wLS4o5WIjsMHsU1kQq5RaEOxjg0bxrN7YquTnw/jETLzN
         6O2kQyddalRqkFMq+FMzq6T1IBEUisid1qQEJQGyA09dLUaAvuP+4K8B6p04KoC/t/yB
         dY4VycxSHAP9qayaKCSYcfYI4XUqe8Z6W/dVieZiJG51iCGiehSC/g42n2M4ylVHfJhE
         gz+Q5wKalOZ/rS17Pyx2kfsZINr2mm7Q13P09PN8q5rP4/huSmsGxOCUU2wKZv1EorO5
         8GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zDggAsDI739UznsdJGV123TENJ6R94pJsrrMJ096A5w=;
        b=kNRbyOqYtAN2ZrC8neIk/4a03l1fuPJXjY98gaq+Ve2xhuyzeA1Ak3c3jIiwLrkCea
         O0wcfRYporcH0WQVj2kpqsJPK/KqP2PLp809iD6Uwrrnyj+VuJ+pvDhgmQk62IFMvElw
         Alo8CS7o74n5qAHf1Dzh8kiBfDiJqfaBwV2ogq2BIWEp0Alx8dpg/EuXhX3QU+fKeUq5
         4GQLUOF/2usZKF9xktlbpZ4Rp/UOSdDd8g1m7RLrEMCaj2YNf5WksviQT2NWGvd18O7V
         H+aW7//uGZIJwnhgGb+H1RAKsPYh9rbe5V41HTN2rkYiFJWGcN7R0D8qt25TUTPRuaWx
         mHjQ==
X-Gm-Message-State: AOAM531oopHftJGBbJERJZcQGefsH2OgTmJo4tXe3Rh5OjffLfTYomCb
        HxV7Uy4AFUcABy5GThLPCOqCtg==
X-Google-Smtp-Source: ABdhPJzq35Qf86wUQrahPKwseE7thoRB6fMPDxpfeiSBGzmY3jo07CAGFTuARsNI+6+8+yZsb+pOVQ==
X-Received: by 2002:a17:902:6942:b029:d6:18b0:8a with SMTP id k2-20020a1709026942b02900d618b0008amr25452573plt.23.1604419391553;
        Tue, 03 Nov 2020 08:03:11 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id j140sm8471006pfd.216.2020.11.03.08.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:03:10 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v8 4/4] MAINTAINERS: Add myself as Trusted Keys co-maintainer
Date:   Tue,  3 Nov 2020 21:31:46 +0530
Message-Id: <1604419306-26105-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a Trusted Keys co-maintainer entry in order to support TEE based
Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..52687bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9732,11 +9732,13 @@ KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
 M:	Mimi Zohar <zohar@linux.ibm.com>
+M:	Sumit Garg <sumit.garg@linaro.org>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
+F:	include/keys/trusted_tee.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
-- 
2.7.4

