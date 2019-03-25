Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8FC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD202075E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFLwckKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfCYWKW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:22 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39145 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbfCYWKW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:22 -0400
Received: by mail-qk1-f201.google.com with SMTP id w134so9947248qka.6
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xS16JMOxZwcG/rVliMetOoh+ZZR4mUKe0/mNdxJ1B6I=;
        b=rFLwckKvnZaBZEGlLyTz4YcQ5TpfXquDDLFv8EpNBBi8bl0H0aSpKbKlPmFsmJzv88
         3s6m1iSnNGuRtAX7+GNWd2g9ka8O638ik4FPSJBJV5pRYd6bDqXfhUVknENqAjwj4phg
         ZBeThTpXCyvDIvKExlijnHhU7emouiyrTRHxYNNujKIPbNen6HUgDtriMiWILJkoVwSA
         VVGV8s5Vdp2kHgLsYghn2sBzhcQ4djG3Mg4picl1KnN4fEcpD276WFgQ7ohf4Qa5elqa
         AgffeNZduS1YSvn0RL82wvaNQg89a0p0VKGWQ4w6kG9QkJsl5oAYX7uvYcn10rHNeQC/
         FZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xS16JMOxZwcG/rVliMetOoh+ZZR4mUKe0/mNdxJ1B6I=;
        b=j+LCP3jp7XyybYiKBOXJGBilDddwayedgkRyvJ6hFZKstT2gjJT82tCqhAtydEuaGM
         BfW18g2o0cUEhv0ghj4IECw+MlBdevS9tEpShfwR2sgRblXj9XFumLSzJAyN63XcTsRm
         9PBuBUy0wdi8dL3n1VT7BdKFrefOfVQZHw2HM78IOTMim9vsaLlnVwbCMvFhvD8QvYlo
         I/NrDYHxyauBoDDTlFRiQaPfT7KrpI4VSCVKmhcl5IdxYJM0wxWMVxQUEdzV5IS+HoJX
         +/oG/Re6LtXhbbfs6XANTZXDfQdK4mymGZZqy9xpsTf/B3PPa88BQu0W0OtFBz3Mg1eg
         Y1MQ==
X-Gm-Message-State: APjAAAWl3jAXrGfEHGPencm+J90g5AI6enAMITXLZYvlGZ6yJ74pA/Cv
        lRYiMbFusXNnr+Jc7yye21IBt7+90Dj/c3aaMci93g==
X-Google-Smtp-Source: APXvYqzfwaoEvZ9qoFwlYj2A15EF/8fYD/EBKL5NEF9CZBOvMhdvlUypidpDWMgq04f0j1uGmMifcELa/DdB3HnIghzi7g==
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr23012965qvv.247.1553551821400;
 Mon, 25 Mar 2019 15:10:21 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:36 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 09/27] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Morris <james.l.morris@oracle.com>,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..0305d513c274 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot"))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.392.gf8f6787159e-goog

