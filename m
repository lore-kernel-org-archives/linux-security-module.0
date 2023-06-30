Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EFEB64DA
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjF3TZh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3TZg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Jun 2023 15:25:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE72D60
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jun 2023 12:25:34 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b7474b0501so1939411a34.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jun 2023 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688153134; x=1690745134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gpECuJ7B/oHgM0G5tTsdxp8JiLaLnKkaaSpTs/cHD0=;
        b=K/3dqCtGxNEsijpoqhiifr6iykPDEHFiM3YTbAm83ibBgltHMVHKiqUOQRr4DJPXd1
         qk5qxLHitjpk1qX7ISYaKq36Mg3D8ESAnLiki+7n5uODPA/Imk0PkTl8IaGeGkiqPzg0
         JyDwNmDJNrajGB5m+z8nPTudFH/17IkPOiIihDlIO9dC60EzaUef/ibdUSTna9xk/ZXD
         n+CBOQTdzFNMLwm9LTXyZWkhxKBneQgYrMpQJYs9bIHsiVVI+mRa/a+lsTGkj66YT3j9
         2j/+f02KSovgvipx26nOIzG+dD9ohI5bwFr8wTpklPvtEnvtWv68/YLssF+lEJj5J0zM
         ihhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688153134; x=1690745134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gpECuJ7B/oHgM0G5tTsdxp8JiLaLnKkaaSpTs/cHD0=;
        b=EZp988FCasAuR+oI70Hx2U3gI/uCuAJTXqG68yX9sIvLVdvk4q0dr5gn5c7d6mqznb
         ZoeN0WNy57kHS1hZxUP2K/AJuU2ILghDE1Fgta1AY1FSijMdMTeDPjsh7Fl4SJe8I7hl
         zDddcJA/p82OkOsdGRqvGx9ZAh2BZrA1p8CfbgZKAU6yPJ9M05m3hlwiaNH1mWk41dul
         WU33S//rz4uhCGu6tARS6Os0FsKN/GS3RoCbPYKpqOqTEWNnE+/uK+yRVMP8PraBqkII
         FT5Hka3QPS7LIOCT+XI7xc9ia7QZ/qSDkcFfhYWz3dR+4Kpv+cLB9TrA/aS7rFq0gMqx
         BRcg==
X-Gm-Message-State: ABy/qLawbcnGf/xtyE/P+lM4AS0Q8u5KaxYiCzM/+ftABFRH1XqCofMM
        tF20+sqe0DoCSIhS+Pw/R4C2oooPsYuiKpulTg==
X-Google-Smtp-Source: APBJJlHwCaVGs2X4HeKULegRhwjTZwhQRsBZVJytO7Tb3jOa2Fp++Gbd00mnGyYTlhhB1tjO3Kr8YA==
X-Received: by 2002:a05:6358:f4c:b0:133:b42:69ca with SMTP id c12-20020a0563580f4c00b001330b4269camr3339069rwj.18.1688153134007;
        Fri, 30 Jun 2023 12:25:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id cj25-20020a05622a259900b00401e04c66fesm5777304qtb.37.2023.06.30.12.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:25:33 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org,
        Micah Morton <mortonm@chromium.org>
Subject: [PATCH] MAINTAINERS: update SafeSetID entry
Date:   Fri, 30 Jun 2023 15:25:27 -0400
Message-ID: <20230630192526.271084-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=paul@paul-moore.com; h=from:subject; bh=C7G+GZfHFkXxji8GlOwVI0PehwLBkhVA0O0axNl+UiI=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBknywmJEo1ukaX4v0RN4U7Of1/ttZSsFXlSzTwU 485qCsh1jmJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZJ8sJgAKCRDqIPLalzeJ c/dJEACtdOXOrfY7CVKuwkeYpk1YrgtslMcHshk/+jJKpg3qLwLgI0R1Q01rGijIyFlaKhCLGzX VeMaMY9oILgE3kvEiw2pw0O6VelW7oYE4+4jC0pmn7oLKlhlUbo7OACsrUicQjoV3YMLyNE7a6F GeSDgHx8muBT/DPun+099Zn4ALgndKSUptnsefjssVkErrnNuhwPG+FJqpCwuJzY7xwnxIOVoAI ThLV0mvAYuOsfRR5FDlqKOGjnR8kvUyzvjB69uP3sxrJD+cVPHL8RW3Dssdt3nzXEzIzvEI19+Q ys0Rvi9qThFZAgMyf0sPJsqv7o13gJ8YD6cM0P+NZlyOC+bXlZjMWvackfsuzZWeLd6YmcFprAF SfEJHo95iIOPzeswqPdiS5odHyHdn+z0WyGXKyjSMDiNmHRJJadSZDAKMVSPhZi4j8wsIYBQxCa GxtTenS/vKUawAcG5sC+GW1t4fjbgacFsFIxX9ySTBAvh4Ke/VWQSvMrPRgiI40EXnBEo/LqSso /yzFwWq3x7Qzcib37ms1tR55P4OZtWt1ysp9cGbRtrIvfT2p/TE9t69aYiTi6ZE1gq5gTy+amVU E7MG3nhSX+WwHCqKKBJeZjwDQFSHUMF+9UOqkj3n7Ez8+q2CfX7mZSB4UycDQiBt6VdK1MYnt54 DYhJZHrmF5YfHpg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Micah Morton, the SafeSetID maintainer, last posted to any of the
public kernel mailing lists in early August 2022 and has not
commented on any SafeSetID patches posted since that time.  Attempts
to contact Micah directly over email have also failed.  Until Micah
reappears I'll plan to continue accepting SafeSetID patches via the
LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
and add the LSM mailing list to the MAINTAINERS entry so that the
LSM list will be properly CC'd on any new SafeSetID patches.

Cc: Micah Morton <mortonm@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35e19594640d..ad910c462cd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18599,7 +18599,8 @@ F:	include/media/drv-intf/saa7146*
 
 SAFESETID SECURITY MODULE
 M:	Micah Morton <mortonm@chromium.org>
-S:	Supported
+L:	linux-security-module@vger.kernel.org
+S:	Odd Fixes
 F:	Documentation/admin-guide/LSM/SafeSetID.rst
 F:	security/safesetid/
 
-- 
2.41.0

