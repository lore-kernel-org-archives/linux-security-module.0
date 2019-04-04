Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E27C4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88982147C
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4X9nbNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDDAeb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:31 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39902 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDDAdt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:49 -0400
Received: by mail-pg1-f202.google.com with SMTP id o4so363558pgl.6
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J18ALo3LueGVhn7lBcFJjxgV6Duc6Nrvg9c6IUw3gFk=;
        b=f4X9nbNHfY4KPoiY2rsTDeZzZS0xVYDSJh48T/INc5xcxO6l06XtPToGB5Yf4apcsF
         QO9MOn/GG22R7EaKsFZ5VoOMO2fyeDZ2nLv5NFyTUIcChYQg+eLUp5gALnVlBXrYfTQp
         RPpFDlg7gyi/RfbU/aUNdvCAMzBbq4Ux9qoL8qcq3qckUGaWWU5ehr//0EPmpZuM51fH
         rEXxgeXSu9SkJgqz7FnM2j66Vm7PfIenJp7rjiBnINO41wb0GMcbfQdm+vCGGxCVXqra
         UAy733GzeE5eTRjvF98IFUyGNKiT5Sa5nKXo2vH8rdjB/GkvJoZbfYLJS/M4g3VQ751b
         SkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J18ALo3LueGVhn7lBcFJjxgV6Duc6Nrvg9c6IUw3gFk=;
        b=bIkbR14gcxFDSqoCrVqfXN8PzP37nQyEDNdX+qJnpbavDl8NGwY34ly0N/J1Te1/MS
         xGn0b9NaqR3vz2aej6ODFgB1q5BJCM20nt62X5d+q+Q3pE4Ukv9QWy95B5qtwZFN6LS5
         Aw+TLg50U7LvQ330s1rx11gPt4E8UctbzS4bD7NLOTXBZ6GNDflFh7CCNcRvBcyQhJgG
         MejzjY7WifWTh9V3uBJ36kw/mP/ZV7CrGlwSHZ1/jl7qXNfvw0+ymTE08U0QDfKs9VZ4
         vE0fIwfy774Y/c/6KHRF5vZVc1AHjNy7m3iJ8gJwh38SlwE3v1QyBJx/FGpUj5VKOoAm
         6Vxw==
X-Gm-Message-State: APjAAAWz8357AIARxialBX2coLrXyPbP8c7qoKQyltLlU0Bm8i6wUbwr
        +99ODc4iwRhi3Pyu3znOgpCHOwBD6z2KqWSalsuMTw==
X-Google-Smtp-Source: APXvYqz4j3QeuhcSeCpssrYno1HhWQWSUHEQbxzBBQkzAYaBEuGhtUI12IUFX6VGtthFChJDwz6dBYHGr0vkhfKiuAft8A==
X-Received: by 2002:a65:6483:: with SMTP id e3mr60177pgv.12.1554338028850;
 Wed, 03 Apr 2019 17:33:48 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:43 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 21/27] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d5fb09ebba8b..5c70acd80344 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -420,6 +420,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	if (kernel_is_locked_down("Use of kprobes", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
-- 
2.21.0.392.gf8f6787159e-goog

