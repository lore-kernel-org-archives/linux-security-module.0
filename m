Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F370C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E612087C
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cuvbwz8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfCZS2y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:54 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39971 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfCZS2x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:53 -0400
Received: by mail-pl1-f202.google.com with SMTP id q7so2641173plr.7
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=Cuvbwz8H/UPT74uyS/N/4qnzLflOCWavMy5nGUSyYS7YEzjkinR90BjdsCrgcJkE3I
         nx4KbkC9dnoe9GkBObKBMRpDYEdqno8HqIh6XA2YCeqV6CvG7JzzRNQF6q8pd5BERf2L
         RFxm3yO2wG89tTrr53Mp5FuBliWeQ+U4jl6R2mVmbyq/irL9EVf0dyxEQAXY+gsnOrUa
         sjp/qtKV1gEMDqiY5H2Ik89SIJ7l/HNOQiiyV055Dk+vHQVGGJnndcLvaKRB3EJIEJ7P
         b5O2WEtybYZzvX3/wEfbV1lJ62nVHR0Vg+h1YgKtbRZ41TCuXQBY+ohnhrP2W4Cl8SFS
         GMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=udc8bkA7IcIKbArcy7aPzXy2+fgOf5Yn54gQKzu1vNBdYkrWMGWO8hmLj9NU68L5L9
         NeqU3c+jDZaWFXB/wpP10zaoZWoVvNvJSdGZkjd1RsphpaKbozP0PQBdism0xuAUXI71
         Za6p97Tj+faRyu0sf3ZI0/hTZOciPVYlNrV2++46E56PAPh78lnY19Dt3rfP9gq2p80Z
         jQol4/wQIV475w9stip7YrQ6fx2dqoixB98P2Vs69DmabzNVM2/iFooc+PfhuT9jcjjd
         NNdMMFO80qQYkpi1jNoKN6svMPV6pcyZlYMd5qBfYW1so8CbWJja8fok3DZgCOYCgvRB
         gw0w==
X-Gm-Message-State: APjAAAXuSIvloF3vq3U7XUFbtjaABD4129j6822uqdDtnisbMNWBLiAo
        qeyGwXnQ8wLB/a/fFOfwAOTvC7jRJm4uMQotmtryLQ==
X-Google-Smtp-Source: APXvYqwphmFpi3T6TN1vNeRaZ63APL0Md38wVERg+esYXiBHNy7zUZ/YoDtb9yiRRaTqqwrQlnsrIfBnrwPddl2w0CiOFw==
X-Received: by 2002:a63:f146:: with SMTP id o6mr29796370pgk.360.1553624932579;
 Tue, 26 Mar 2019 11:28:52 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:39 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 23/25] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..6ad3d83c091c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10461,6 +10461,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR",
+				  LOCKDOWN_CONFIDENTIALITY))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-- 
2.21.0.392.gf8f6787159e-goog

