Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8EC433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8D610F9
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 17:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJMRdT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbhJMRdT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Oct 2021 13:33:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925EC061570
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 10:31:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so2361082plb.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stHyXTiMOoD7piHsq5gSpAvQZs8ZLbpI4dQLsTzc/s8=;
        b=DQyccFak9W+HHVS0jN3SNFAcP9nmOiYmmATMBRZTJ+JuzbOgEOcr1ttcYIBSAfRiqn
         Lz4JUkAmI842pKVjUcAR65yzW1Q2Bqa7rMxpcuZWWK/deSzwtgD2ABIVN79sLsh1xrLY
         L4N6hqUD1rBTVAYU9+wkk1BSrfKWne8+sim5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stHyXTiMOoD7piHsq5gSpAvQZs8ZLbpI4dQLsTzc/s8=;
        b=7U40ETtnzVS2ulaNxD5NXH54cWq9HuO142++mcKWRQFArUkyOIzeTxqlYqn1Y0kgrq
         cO8LSclgmL+jnp1D2Ctvp+mjHewu6WcWmmbCoZt1xwJRe0cOSYHejPD5li44zIcIi9/p
         YHrBiMwh0LNc0Do/xBzrcSZuvE7fRZOHzfVWe48As8TtStU2Pf6vhj6Dzy/aseOz7Qk6
         Y7klZTQKfH/AQ19askXs+VjMYnNVuYq7NeBw1yaYdG31ga6IewzZjZB8DZLXD4J5+2uO
         lqQF0Yc4zjqm9E+3FNjMyA/zVXpCk+4Ls4JnYRxVWja6bTXlnQRMA1BYRcw4NS072dj6
         YmTQ==
X-Gm-Message-State: AOAM533ZtqxxTgx4zODdyGOj0pP0fo+tMCxY5Xztl7m+axBivod4ourQ
        NhUutRgJ7Fkz88lJ86tLBT2YsQ==
X-Google-Smtp-Source: ABdhPJxCmUitcOaunWwIz1uT+vrqsMZlpKkH4k1LFnoUcQVy6JXfNA+72u3QYh4Ml2B4Vnyvv0zalA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr667890pjb.100.1634146275121;
        Wed, 13 Oct 2021 10:31:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x35sm161664pfh.52.2021.10.13.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:31:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] LSM: Avoid warnings about potentially unused hook variables
Date:   Wed, 13 Oct 2021 10:28:48 -0700
Message-Id: <20211013172847.1196305-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; h=from:subject; bh=LcQThCv4yG6dBsiN2R0V8pX78rE7KrdD224PvV6t8ac=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZxfMASF8Im7S+/H7DmFA5FYXENvqZbCwPV4BosIK 3hO2hZyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWcXzAAKCRCJcvTf3G3AJtRcD/ 46Wah2rQa6Cz9vARcUj3izpenVsSBEaeuEyoKQZAGD8czXxlEtI8ovV46ySz2lD7T4/br/4QgtfLrh 4T8woNw3ybe6zKEQay2uI4IX2U58EBtnxkwygQpvq+ZN04ZcC9nsubw+RMAvSbkNOvMOqh/ttpS90P y7cRP5ZXSzZ7Vi+a3Cq2DGAiPCkbupTl/PcbpS73gj60T6mzLEajMez3ll+Ic3z3aB61Ivu1ASziWQ 5u/ZytW6WHTyOaNhnQ98hxjMgkeQPGjOy8KPwnUJF/qQXowvatt1HpydQXxz/4lNrESxWseW0pQk8n 5N5daJ35C6xe09ETUj7SaWrvBT7TyH/NnaTl4ZWZuknhZTZNURiS1QGf6DNtaupnLtVcVuLCjkrTL+ 5/u7xcsgQQwtY0qRNKtvb4m18WCyurYESc5Ih9S5BxFTla3tzPPLQwr+TXxg/JPtkuJXcqp/WULiXh /oHYuLJutOT4Zprn/MjieN4+hoXgOQg9OpuKQvMCqbY5ho06Glff2f364W0bYLiKj0H3q0EMymLaqU R/WMCi84e9KmmPQclpPwXLOD3qUsW95L1Q3lYDjZTLLCPgr8nH12UW4E/EhOp9MSOE6kbh40wnJgoU +HHb6nQfH4unwy1QeA54wlOGbYNAjI4NjtFCtTWAjgjU6h37OMc5t+YetnDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Building with W=1 shows many unused const variable warnings. These can
be silenced, as we're well aware of their being potentially unused:

./include/linux/lsm_hook_defs.h:36:18: error: 'ptrace_access_check_default' defined but not used [-Werror=unused-const-variable=]
   36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
      |                  ^~~~~~~~~~~~~~~~~~~
security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
  706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
      |                                ^~~~
security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
  711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lsm_hook_defs.h:36:1: note: in expansion of macro 'LSM_HOOK'
   36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
      | ^~~~~~~~

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: linux-security-module@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202110131608.zms53FPR-lkp@intel.com/
Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 9ffa9e9c5c55..462f14354c2c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -706,7 +706,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
 #define LSM_RET_DEFAULT(NAME) (NAME##_default)
 #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
 #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
-	static const int LSM_RET_DEFAULT(NAME) = (DEFAULT);
+	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
 
-- 
2.30.2

