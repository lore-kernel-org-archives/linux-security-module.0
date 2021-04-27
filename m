Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DEFC433B4
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Apr 2021 18:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5493613F8
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Apr 2021 18:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbhD0Sis (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238822AbhD0Siq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 14:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619548683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4VuZQSuryR31hzWJ615ODRd3rogZxavth8Va+pMZREE=;
        b=VcOyhZGQvu+ratEKdNSHTyFiUg1P46s/1Y/21b24oz+oNjz6/Etw55pyGRkBV5aw7ogYWx
        8pv/ZKGEv+710RxMiqKdA96NrQtKIUMfT/SNS4qKNF0Da8L/1OfirnCyNgjqiGuEPueU9M
        oiuYEVpQIdfNNchepfEzj1SxqyqCstc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-9gGAZwiiNnWShNlwPNnSHQ-1; Tue, 27 Apr 2021 14:38:00 -0400
X-MC-Unique: 9gGAZwiiNnWShNlwPNnSHQ-1
Received: by mail-qt1-f197.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so16064302qtw.7
        for <linux-security-module@vger.kernel.org>; Tue, 27 Apr 2021 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VuZQSuryR31hzWJ615ODRd3rogZxavth8Va+pMZREE=;
        b=VLYrEF45zmV1j89eXvsDZWLhJxDAb2e6/2y5fUzkRoW6GmoMAMXw7K5iZ3Otf6dkXh
         FhqEg0WycZeiQziWWlUV+wuU0TrVUNQfVLYQnJNX6kuzIkeaiPsiuH7OCULENuquOBjp
         600sTifNNTU1Fsr0it91YY+vPA+eljyR2UJMYFgFw9HQWNs7wZGMXGnoDrz2Mct2UrKg
         fggU+c7yZEDfPVRSdQinOmZ9Kz3gQBxcoxrqMRad3+FS9R2dvyb2lZpMFBUjElmHMpfG
         lHYK7jawfJD7gGjKnVqKhtayoW7qxIJz9Kd/obDUZ89lsUL6TC+Bzfeg/nEKbqLROtc+
         BscA==
X-Gm-Message-State: AOAM531DfLb86H201CRfosXXxFbtJj9a/pW1GFdf4gpGFEMjcFnZVxnV
        EU646x4XdfrL9VzWsXUh70H1C+X0C7YbVFJdGQUzdwT8kbP0CVMT3BaeXH/t2k90uLYiVNukkbJ
        cZvK/UlJiwyzdQL7e8lIRuzIJWJr/YjRghk7c
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr23398298qkj.457.1619548679881;
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHmo+tFoQV0mUdGbTaCoTFEnkBuus13gSDjgfQyCZ3EXJ0VwKiP/wenE08m3y4BKI265nlZA==
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr23398278qkj.457.1619548679727;
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm478118qtl.37.2021.04.27.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
From:   trix@redhat.com
To:     mic@digikod.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] samples/landlock: fix path_list memory leak
Date:   Tue, 27 Apr 2021 11:37:55 -0700
Message-Id: <20210427183755.2790654-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

sandboxer.c:134:8: warning: Potential leak of memory
  pointed to by 'path_list'
        ret = 0;
              ^
path_list is allocated in parse_path() but never freed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/landlock/sandboxer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 7a15910d2171..4629d011ed61 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -134,6 +134,8 @@ static int populate_ruleset(
 	ret = 0;
 
 out_free_name:
+	if (path_list)
+		free(path_list);
 	free(env_path_name);
 	return ret;
 }
-- 
2.26.3

