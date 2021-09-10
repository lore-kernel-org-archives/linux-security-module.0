Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC993C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Sep 2021 22:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978536120D
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Sep 2021 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhIJWh3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhIJWh2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Sep 2021 18:37:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A3C061574
        for <linux-security-module@vger.kernel.org>; Fri, 10 Sep 2021 15:36:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q68so3115434pga.9
        for <linux-security-module@vger.kernel.org>; Fri, 10 Sep 2021 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hRvD55AlzDiLkgU8O9lPB5ydkM58COgww4lK+xPKNA=;
        b=dpRA7ez275uqyRkLGORHUCTMk/8G0HtxdMZkxlxRihNXrl2ZoTus5twwsplRPDAJGq
         LPRu7cpDcaVy7m5FDm9DYofpU6odEqix822/WDwSYAbS5+izVmB5NG08olewAx98uUjX
         oMlP334dbBmyMTPJdUObMj4BH0XxW5cRc2qH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hRvD55AlzDiLkgU8O9lPB5ydkM58COgww4lK+xPKNA=;
        b=30DikD83merQyhTXgmMQhSD/XrEwhQ8E9rtLqO1i89eUKp6nVNH3rP26ITkeVSbc7Y
         ZDQYHKOvkYxui7mElBS7WSVeD6kFAD2RGlTrM9MfoJATIQ7havSd5HO1Brap4QemycZe
         bfK6mkvPmh23QsybhcppW2xuYWEup/82q82396VLpUf5q4QM3gKqLOpwCdpeaD9M1pYW
         b3WGmk2WrTYNL+p0MwXv42ijTk/pzQncdg7Mh/5jwATNG4z/tJlQuGSUEe1TD3RHfGZr
         1rUgv0QSsLrKKgZuACIjXxr1ov052FYWVQAESTjgc3zNZnBx5ITTuCVMratv9G65mOVQ
         7iyQ==
X-Gm-Message-State: AOAM5337hpvncma/bGhhvsJo8NXNCPGtiNr6ASi8T/0UWR+6ML46fohD
        NJWhghA6ch/cSAunO0vOi816NA==
X-Google-Smtp-Source: ABdhPJxx4Wit0Qftq06uh3Cat42JuEm3a7XOFH1pu3N0oC8WjAG8iOMSri5ZckEHwBjtsymKIQWpuA==
X-Received: by 2002:a63:841:: with SMTP id 62mr4745pgi.354.1631313376938;
        Fri, 10 Sep 2021 15:36:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m64sm6192774pga.55.2021.09.10.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:36:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] landlock: Drop "const" argument qualifier to avoid GCC 4.9 warnings
Date:   Fri, 10 Sep 2021 15:36:13 -0700
Message-Id: <20210910223613.3225685-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; h=from:subject; bh=iSCHjkob/n8sXCvfeWoki7FcCa2YHoXRmVIzTgHXdDw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO93d+UF0sB8wKqxFZeWzbz/6fQSst1worP6xVvlG h7cEzeaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTvd3QAKCRCJcvTf3G3AJp9aEA CpQq+EIq1+kfJ3pXfrc9dJ8SmatIREczqwN8997WehcYNz1Xtzx3/SgFfdS7/N2AQIhmGBgqJIaG7Z gp9/7r6HtpzGNaUZ2SsI2n14SgDEonvySHwGoAB3W8ItzUT640UDajRSEKrGwRsEiPFKpkYdQDJ373 OvCO6JKKqJ6JBvw/5mmRRgU/nMdbYiJ7E3LTJ91OHF6abPQObupwZ/rMt9CP+yAVpxivC4BiJkE7Ds BG+oCo94uVEwxB/oTNSb6iK+GcRic5Mp3vGDfN7BG8eWCVD594codlePQFQh//j6bNfPVsnbuaGrW1 UPjO9CRiu6WFHFb0Kt3jYpQnQZPC71THlZ3z5N+mFlRfjU+LzAxwgOMhwpbMW83Kh0lqj+RYxP0Ipf ls/7VXgxj3jEJbxtV9nLSLObcmHSUyBL3fil8eKL7Jx76nbSqllTTc26OPHMmOGV9X6KyvwlCQWD5n xnQu23MO66kwIZPcio9W+HI+XgiW4H6uHxHBP0bWSIvnnxG/5lZYsGfNg0920PCyl0tSvoEwIwhhRx QgcH6FViLYp1mM2lzHftz21HiQzXtaGrsi8xFy5+SEin7hemmFD7Vv9C1Uw8w/xbkoTSubmwYpqfVK mMM0EPNLgcl51mLx2gDuoR1wJ5yMyxJwW9t4WV9Mq2GumgFwBuxZj6aLJIew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When building under GCC 4.9, the compiler warns about const mismatches:

security/landlock/ruleset.c: In function 'insert_rule':
security/landlock/ruleset.c:196:34: error: passing argument 2 of 'create_rule' from incompatible pointer type [-Werror]
   new_rule = create_rule(object, &this->layers, this->num_layers,
                                  ^
security/landlock/ruleset.c:69:30: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[]'
 static struct landlock_rule *create_rule(
                              ^
security/landlock/ruleset.c: In function 'landlock_insert_rule':
security/landlock/ruleset.c:240:38: error: passing argument 3 of 'insert_rule' from incompatible pointer type [-Werror]
  return insert_rule(ruleset, object, &layers, ARRAY_SIZE(layers));
                                      ^
security/landlock/ruleset.c:144:12: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[1]'
 static int insert_rule(struct landlock_ruleset *const ruleset,
            ^

Drop "const" from the function definition.

Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/landlock/ruleset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ec72b9262bf3..64c37af88ee7 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -68,7 +68,7 @@ static void build_check_rule(void)
 
 static struct landlock_rule *create_rule(
 		struct landlock_object *const object,
-		const struct landlock_layer (*const layers)[],
+		struct landlock_layer (*layers)[],
 		const u32 num_layers,
 		const struct landlock_layer *const new_layer)
 {
@@ -143,7 +143,7 @@ static void build_check_ruleset(void)
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		struct landlock_object *const object,
-		const struct landlock_layer (*const layers)[],
+		struct landlock_layer (*layers)[],
 		size_t num_layers)
 {
 	struct rb_node **walker_node;
-- 
2.30.2

