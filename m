Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A07C2B9F7
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA524613D1
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 18:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhE1SMp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 May 2021 14:12:45 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:63019 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE1SMo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 May 2021 14:12:44 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 14:12:44 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-03.nifty.com with ESMTP id 14SI37Pl007109
        for <linux-security-module@vger.kernel.org>; Sat, 29 May 2021 03:03:26 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SI1haG022124;
        Sat, 29 May 2021 03:01:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SI1haG022124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622224904;
        bh=2kZqwL1JQt5glLFuW6WR3qf32xQUK04xmZfKd8g1NcY=;
        h=From:To:Cc:Subject:Date:From;
        b=E3oPsiWNYKDJybUlRh+1jWhmLju0XfZ5nsPJwOGTL9eH70T8taHVoQQgeD+BVpLd+
         gqFe9fFuxRPp7siI4jst5EV2+xLfiLOpxUZWJ+pHP1aNpYwJ8xgxMjPkFh0JCJ1GMt
         a96oQCP1k1zimzGrNl7ChC2NsldurW1xrJj9dUXkcJH+5XHb0q65oClMGVrtCqZIDJ
         8li640STUWao1UI1Kyvmz7zkAQBaN67jIEpiUKMNicAyfdeZFFoY5fbtLOgne3H5P1
         Hzgkt4HYDNBu7/KRdsCLAXmtyDXEc68hblH5uWhvDqSByexmw15DsHbBAM9mT5nvWV
         ooHYctkP6MC9g==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] security: remove unneeded subdir-$(CONFIG_...)
Date:   Sat, 29 May 2021 03:01:40 +0900
Message-Id: <20210528180140.176257-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

All of these are unneeded. The directories to descend are specified
by obj-$(CONFIG_...).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 security/Makefile | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/security/Makefile b/security/Makefile
index 47e432900e24..18121f8f85cd 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -4,16 +4,6 @@
 #
 
 obj-$(CONFIG_KEYS)			+= keys/
-subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
-subdir-$(CONFIG_SECURITY_SMACK)		+= smack
-subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
-subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
-subdir-$(CONFIG_SECURITY_YAMA)		+= yama
-subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
-subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
-subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
-subdir-$(CONFIG_BPF_LSM)		+= bpf
-subdir-$(CONFIG_SECURITY_LANDLOCK)	+= landlock
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -36,5 +26,4 @@ obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 
 # Object integrity file lists
-subdir-$(CONFIG_INTEGRITY)		+= integrity
 obj-$(CONFIG_INTEGRITY)			+= integrity/
-- 
2.27.0

