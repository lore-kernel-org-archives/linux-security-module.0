Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD6C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Mar 2022 17:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiCaRgo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiCaRgi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Mar 2022 13:36:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75286212A;
        Thu, 31 Mar 2022 10:34:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so702461ljr.9;
        Thu, 31 Mar 2022 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2yUjqyfP6+h+Mes/kvWfMJGMKSWOnhuqw368qWMi+A=;
        b=KtCpp8D//XHdYHlTlc/9tVmnBQuT0b8Nsp16rK9T7MsX/94S/9FjQvlz8ChWz35cLW
         e+9yYcmeao2VYcJHb1EhNJ2xjYbA5TpiOCR9QoKq+FY+sR8HwWpmJExLQxCBCJXkvBMK
         Dxc/ZUx2t9dPIkedXA1H8FkwQMx0ncZYGwY8JTirazwscEjRV9pFe3f1+H0vWGSzXUK7
         qo0L2hVtppzk/tjzlxwmxhdhXHr9eVXtOLFZKlo2BFEtF3aqqUuQgdqCVEiuZf3tPux/
         z/TUDvSiIr1hynrWg2LM+vyI8EKSLgFJjmUQ0lNtTS2t+guNX06kO4z7w+XR6K/wQSq3
         h/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2yUjqyfP6+h+Mes/kvWfMJGMKSWOnhuqw368qWMi+A=;
        b=0hRdtMuXSeHbjUfMZma8KTs7XK5DvgyXBS8HPGQmK+SgjrP8c6q6l33x+WF/QioXsH
         b4bidjxQreXCrxFJCS5dfbheQ/sK1+O3OHkv3zDluNVEfgDFGwkb90FLw6V31reyBpS/
         YdkTIGaoCwIsVrtyIyp5+t03daQehkCBs6Mua61RRfeIX+gi9h/5jpNmKCj+Gn+N8LJ2
         9sRk8naKttrY1PsIjq+AoH5pTKFAZPORLu/3pmzb61ENjDW/vWau+04mzBiKF3sfDGpH
         DrN3TzRcxQbbPFt1Cfd5Pq6jfFmPfJBqjHnyGDpQruO/SsvsyjrYBPjrnF2YnpqIxwlq
         6r6w==
X-Gm-Message-State: AOAM5325oxd4mkXPYiax1ThogQyOFcF9ix/dFc/cEEN2M/bGVMzghMq8
        vh0aw3GT7c0DO0CpZ5NC6/g=
X-Google-Smtp-Source: ABdhPJwYonmMN1vUChjs1jBBB/Dd7M1us26z7440MKCuJVGcRWRU7iJmG1lNC0cu0ITx+Nn7h29YJg==
X-Received: by 2002:a2e:bf22:0:b0:247:da0b:e091 with SMTP id c34-20020a2ebf22000000b00247da0be091mr11141258ljr.489.1648748080313;
        Thu, 31 Mar 2022 10:34:40 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b00247fe29d83csm2746992ljb.73.2022.03.31.10.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:34:40 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 5/5] smack: Remove redundant assignments
Date:   Thu, 31 Mar 2022 19:33:58 +0200
Message-Id: <20220331173358.40939-5-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331173358.40939-1-michalorzel.eng@gmail.com>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 security/smack/smackfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 658eab05599e..9e61014073cc 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1192,7 +1192,6 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 			rc = -EINVAL;
 			goto free_out;
 		}
-		m = BEBITS;
 		masks = 32;
 	}
 	if (masks > BEBITS) {
-- 
2.25.1

