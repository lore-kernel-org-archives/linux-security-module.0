Return-Path: <SRS0=mR5W=EB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDBC4363A
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D5324640
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLTTOozd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773165AbgJZMwz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:52:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773184AbgJZMww (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id t9so12347265wrq.11;
        Mon, 26 Oct 2020 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0gmvrMUzC72B+CAyGYJyfJZQvA9bjmnTdDkchdX3yM=;
        b=TLTTOozdQuIiXIUkSQHkqWWwtKNLSCnTV4RZLOYBln0SppZgVk3l3ivXp73SejYMRe
         E2RAa/toEJZfhywr55KPYPtHm9PbKlyI6EuASEdHZLHT2hr4oE8iaH1S0jlYykb0f/5r
         2+P00YklMUrC0KOGpsLCldPJXY/8tD4uJx9kSDS78Ze74U9GIX+FNTNQ7/8dNbDFhh+O
         lPgOaUdOxeMOKWmiKbeHZgwMHVeY1l4ogFum8o0V745ehV9ql9O7IntexkJqx61NCm20
         APUnRCNTVALaL7BQDxgH0N3wdUtKH+QCK4ifVEKFEn37Roep53e8vyECqIrXzrdP+T1H
         yvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0gmvrMUzC72B+CAyGYJyfJZQvA9bjmnTdDkchdX3yM=;
        b=SkPlBqyV63/5ocRuQpFV2V+1Mo2KpfdNKHSfIGuGfmQfwZb76XV7iiC/8UqYlWDFIC
         WvXG0aALgFBVCV3/T20K8IpjTSjCn7WDPBZm1sczaI7UB4eVOegWjuwhLsMmrnnhlfXO
         dV1tG+sY3Te4IflT8agQ+9Dat/fXrwxAVq1FAAIYZlN0/naOIph+/h+8LxCEHdY9IruJ
         XT5Aek65klp39cVDg9Xu0gBM2p5mW4/6SnG8Azge3HPmj5WhLKbRvmgDXKXhvJplRa32
         pK56npMgbldKirPPv3GUA1DagY+2DUA4wsBL+r69qZTwU3H32KENPMvRuhLseF03Yl94
         eHVA==
X-Gm-Message-State: AOAM533A2UG6MafQgAaYekCUphZ6yAVn9zmXZnxkaiFvTaAZW3Bpl9Av
        c8wb/EWg0z0Illa5bNUYZ9M=
X-Google-Smtp-Source: ABdhPJz/XNSfDtRiRcgaWVUielBdRnriuP93dzWgNzX9ZhozIxOcieRuGA7H62t8IEQP7EkAP+/7VA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr19020823wrp.394.1603716770202;
        Mon, 26 Oct 2020 05:52:50 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a3sm23551139wrh.94.2020.10.26.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:52:49 -0700 (PDT)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [RFC PATCH v2 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
Date:   Mon, 26 Oct 2020 12:52:27 +0000
Message-Id: <20201026125227.54520-3-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125227.54520-1-a.nogikh@gmail.com>
References: <20201026125227.54520-1-a.nogikh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Describe fail_lsm_hooks fault injection capability.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
v2:
- Added this commit.
---
 Documentation/fault-injection/fault-injection.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 31ecfe44e5b4..48705adfbc18 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -48,6 +48,12 @@ Available fault injection capabilities
   status code is NVME_SC_INVALID_OPCODE with no retry. The status code and
   retry flag can be set via the debugfs.
 
+- fail_lsm_hooks
+
+  injects failures into LSM hooks. When a fault is injected, actual hooks
+  are not executed and a code from /sys/kernel/debug/fail_lsm_hooks/retval
+  is returned (the default value is -EACCES).
+
 
 Configure fault-injection capabilities behavior
 -----------------------------------------------
-- 
2.29.0.rc1.297.gfa9743e501-goog

