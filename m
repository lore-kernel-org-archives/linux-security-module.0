Return-Path: <SRS0=4koF=W7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C3C3A5AA
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664221670
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 23:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JOrsbjia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIDXAT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:00:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38088 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfIDXAT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Sep 2019 19:00:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id b2so485264qtq.5
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2019 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p6FARsIiGBayh7RXc5GwZS41ZyR7vGfiSOuld2zxCBE=;
        b=JOrsbjiaxrQWvtzB4BWDFXd5z1k1wMTBaOXmDKZAqo768pm7vQttFm5CUiLjbpo8/q
         hXnGuSFxxW+lnTzzOtguXkYG8pX2Drre9TGyb/BRM8y5bDWigL8AtJtfK4Tlm85DAIWl
         X3Hn2RbubWvYiSnBii7y5xM+Xy5IAcLz3S6SMmPVWE2ySW+u3rZQI61PQkdTnIub6oPz
         tMQBwgs0uve+XPyYNAeCzJ+o17+2Eyv/Kk7u6CsjOp8ryX6Lg5ssyE0WubRfSuJukQsl
         ilLKJOesoWKzKoY7LZVJUuYjeM3yHEP65n6ChrbRJs8/+ndldOOtOZCYc9M+xlD/DILr
         Y+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=p6FARsIiGBayh7RXc5GwZS41ZyR7vGfiSOuld2zxCBE=;
        b=IDB+9UY1RHlx7cluQDZF/o/KIwSaBvo60DdHpib7TyDYKI7cJGh56ypTdSiP7/WNW4
         evwoVTc4tVvsodol3RvGprVNWSvIjP+uhxStuVV2O5COPrerUNkS5TNwnRp6Zxt+fBSf
         IeWfFzGslPURjO7VFTVRSirbM6fxoMSs6WAq7EPhwnrWAsrfh6yXxUNkWyPwnwnkUkXc
         CAntfFoq1StKdo1lIR24iYXXlJeQab7ptUwxQAwj2RKRsKGf+rhSr9bhK8Lu/KkvCOpf
         3QsL0Y+c3uXisArqOoQjxL7GiB5Fyr5Sp6tHyuGI6PrA/vcxFev4JaeP2CohabgYUU87
         fFNQ==
X-Gm-Message-State: APjAAAVFoyjYQM44wM2N/z0btF+qZPqCQye7+NsOtDKmzY4smx/Zsc/d
        WIu9EIS/73JNUTZDO3i0S1NFIg08fQ==
X-Google-Smtp-Source: APXvYqxYIxi5BT982tdcmSjbDznbmmJ33SgIX7+uyaSHq83eT1eiNYF4HhQey3Qf9qHg8KeaxTnaCw==
X-Received: by 2002:ac8:529a:: with SMTP id s26mr537944qtn.341.1567638017859;
        Wed, 04 Sep 2019 16:00:17 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id n8sm140201qtr.81.2019.09.04.16.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 16:00:17 -0700 (PDT)
Subject: [PATCH] lsm: remove current_security()
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Wed, 04 Sep 2019 19:00:16 -0400
Message-ID: <156763801639.13084.2856415198922787618.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There are no remaining callers and it really is unsafe in the brave
new world of LSM stacking.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/cred.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..98b0a23ddd23 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -384,7 +384,6 @@ static inline void put_cred(const struct cred *_cred)
 #define current_fsgid() 	(current_cred_xxx(fsgid))
 #define current_cap()		(current_cred_xxx(cap_effective))
 #define current_user()		(current_cred_xxx(user))
-#define current_security()	(current_cred_xxx(security))
 
 extern struct user_namespace init_user_ns;
 #ifdef CONFIG_USER_NS

