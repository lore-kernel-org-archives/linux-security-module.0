Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B3C433ED
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AB16143F
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhD1Vjp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhD1Vjo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Apr 2021 17:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619645938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ySnh0a0AMi/WenqtYhk3zr8l1sB+1deE0YxwC1z4yQ=;
        b=Osc9wCPVzvyKXyWhEwWuZ4qCgXwxAIR+3j88KLtOybe4pqG/USflSjJQDMAK3/tuSbzdu1
        eZE43vWdjc5xlND9Q2kwNT39uZ5RcS4nfx6fv6jjQJC7CrpDfKhmtRZYHVT802BVX6veAG
        I867pKG1iNq+6NOZsZ7kg2+/Ie2pN0E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-47VMpbB3OjulM4UKrNRwdQ-1; Wed, 28 Apr 2021 17:38:56 -0400
X-MC-Unique: 47VMpbB3OjulM4UKrNRwdQ-1
Received: by mail-qk1-f200.google.com with SMTP id s143-20020a3745950000b029028274263008so26469553qka.9
        for <linux-security-module@vger.kernel.org>; Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ySnh0a0AMi/WenqtYhk3zr8l1sB+1deE0YxwC1z4yQ=;
        b=Sv2Ed0LwGA8tjXA2oJl6Li/dou8uG87WbBYlWYVtzDLm/bijDQcrfNPR7ACpQLOn0A
         8Sb3pxPeC7iGigWi7oi380FivV/mUSR4xNGN2JPVxRutS9VGk6B5sQjLBvRWdH0QkhnT
         ldnzl7KgzgFe6Hv7WvZ/mnxbSIygp/MITF4vODVQyd9DLDUXv4TNiJRZjRZOXu99FzV6
         2NgPKzW2oHf2f2ICN0uXwgSxuPQZ1gXDKrnoVTBPEGwhp/OGGA5mIE5nP2954U9Larft
         vPyZq6Qlt5fcfO2zDcW3JIjWTe86dgIgBX+SomtC7y+jxYPf5z2MKoiNgEbwkHvL5wQc
         Y52A==
X-Gm-Message-State: AOAM532MZKzSpbt1iZ8WBfL7TLpvzy9/qIzV/6Ps+/D/2DgkNHIkhqwH
        VY9qPpPhestMX3Iz79b/U7HCa7dX93AW3XELjPqyy0xQ9iH5g2L4WNGEIO+zamwKWXdCu+xkZwi
        kR67X2+mcpr4I8RmiBAwn5kHcAIh0YzTj3yv0
X-Received: by 2002:a05:6214:246a:: with SMTP id im10mr31110815qvb.7.1619645936486;
        Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9+jqad9GKeMFzz/PInGfcPx0yhu0vao99XZF2CIU6KE5Ec+7v7AnOjT/Zkc1SVcVUaBQdcA==
X-Received: by 2002:a05:6214:246a:: with SMTP id im10mr31110794qvb.7.1619645936274;
        Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r9sm897899qtf.62.2021.04.28.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 14:38:55 -0700 (PDT)
From:   trix@redhat.com
To:     mic@digikod.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] samples/landlock: fix path_list memory leak
Date:   Wed, 28 Apr 2021 14:38:52 -0700
Message-Id: <20210428213852.2874324-1-trix@redhat.com>
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
v2:
  - Remove NULL ptr check
---
 samples/landlock/sandboxer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 7a15910d2171..8859fc193542 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -134,6 +134,7 @@ static int populate_ruleset(
 	ret = 0;
 
 out_free_name:
+	free(path_list);
 	free(env_path_name);
 	return ret;
 }
-- 
2.26.3

