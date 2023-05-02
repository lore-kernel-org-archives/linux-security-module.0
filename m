Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CDC77B73
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjEBOTt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjEBOTt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 10:19:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB595
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 07:19:47 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0B783F235
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683037183;
        bh=YEbt8fJaJHySlZTdZRpdSbFwcXzeFhKie6WmHehZH00=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DKVJ+Zur1RXebmECPN8zKujN1W7Z+zyKs5JZkbep/04ljj6a8tHRn+Ha9tfFYtT3m
         /ODtKG5LnGXbNXNVl1a5urwdQHq6R8a0cSSGW+0PUngZj45518GuXnHrKeGl2C5yNh
         F4z5HmM6UpnIDWceuj0ssVus40G9jLkFKe1owrWlmOHQMd0P5TqMh5jdoTTeq4FHKc
         ObD51jGVNAKtU5oEKaG1je47tPRFEjRyoGpjC4/hMKZFEZq85AOmah5ASg9hsaAopQ
         USL7FaJf4X1RdiaTkA09xjqXS/qYAJETEhg2jA3h/zhse4j7hl64L//udFrhPReOlJ
         rHWG/B0KwgrRQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-953759a9d18so385006166b.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 07:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037183; x=1685629183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEbt8fJaJHySlZTdZRpdSbFwcXzeFhKie6WmHehZH00=;
        b=NVVIFqzWdT+BDkr8SyaairkrzewkvSt/mnSDOCqTp3NADQYDNJIDc3taN4Iqns5Auh
         1057TmNq2z6lKMbhJmcYGfasbUfmu2Pb1j5qrui3KPfzIN9oAFIw2U+d9Ze1dGgyaUA3
         r4z0mqQjKNykGiC3UVsNX8lSHT2T6bE5hOMT0140DeJF0r9FQpjIZEvtMXPWAGQTbnXv
         3SwL5PFnaMfpr5037lmOthVsnCUb7JuXaQ4OGCK6PksBQJZebhD4XmnEeAQHpooB7TU+
         gDQAKsv2fzFchhq1qh/F64DkJmMHdXie7Vy4ZydzY8B62P3wedYLdlqBBT1J0saiEGMm
         knQQ==
X-Gm-Message-State: AC+VfDxanEuhJgwvaGDIKpp9ClFdBhdlUBqbYyBCDmgCZYg6ESZiwMmI
        nlzDJKSFRAtfzkss253hTyZADwmIg46qj1wr4aG5yQKIuAB+b/JcEVGds1TbQrRdPEbntIhDD4+
        YMegpR25ZxXkSdqfCnNgZy3sTvLmJRSFdXCKmx6YAPurcRgOEpJB30w==
X-Received: by 2002:a17:907:36c7:b0:94f:6025:be53 with SMTP id bj7-20020a17090736c700b0094f6025be53mr82666ejc.50.1683037182993;
        Tue, 02 May 2023 07:19:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DXO/3B64V8bJw9amh7S0N0hZheD2NW4YD1COF7NlvNtn+ZJpanfL+e6CluGemZjs9V5YXTA==
X-Received: by 2002:a17:907:36c7:b0:94f:6025:be53 with SMTP id bj7-20020a17090736c700b0094f6025be53mr82651ejc.50.1683037182694;
        Tue, 02 May 2023 07:19:42 -0700 (PDT)
Received: from amikhalitsyn.. ([62.168.35.11])
        by smtp.gmail.com with ESMTPSA id tk5-20020a170907c28500b0095004c87676sm16000802ejc.199.2023.05.02.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:19:42 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mortonm@chromium.org
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] LSM: SafeSetID: fix UID printed instead of GID
Date:   Tue,  2 May 2023 16:18:32 +0200
Message-Id: <20230502141832.217234-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

pr_warn message clearly says that GID should be printed,
but we have UID there. Let's fix that.

Found accidentaly during the work on isolated user namespaces.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 security/safesetid/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..6191e5ba0f70 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct cred *cred,
 		 * set*gid() (e.g. setting up userns gid mappings).
 		 */
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
-			__kuid_val(cred->uid));
+			__kuid_val(cred->gid));
 		return -EPERM;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
-- 
2.34.1

