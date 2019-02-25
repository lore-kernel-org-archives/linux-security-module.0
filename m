Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFACC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C77213A2
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNhYdUjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBYWRT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:17:19 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197]:51504 "EHLO
        mail-qk1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfBYWRT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 17:17:19 -0500
Received: by mail-qk1-f197.google.com with SMTP id h6so8808684qke.18
        for <linux-security-module@vger.kernel.org>; Mon, 25 Feb 2019 14:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+Ffk1f/LNLI6QFI7UedzZxiEOH9uDzBXldmlBOknquc=;
        b=CNhYdUjRpCUQneY+7ub9/XpTJVU+UdNTriYFCygIH2xgDW6rdPld2DuaRDn762khLN
         K56cHM7kEJb0pS+UQhbiKml9bd0vPtFl7aoVehK1k8C8BqnlwJBZPVHOY0U78arMYaqG
         5ZtdBwsan6FRxXzQbl0T8R7LzrkV97wQjcigA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+Ffk1f/LNLI6QFI7UedzZxiEOH9uDzBXldmlBOknquc=;
        b=HbrTWO1Ob2nJX97LpgtIWjeeCG9RhKeFRzPhlL34eDKRSAVf/JXyfYEe8NsRCKcFca
         /gWwSOJL/icZktpGsW+2L8hwp/a7eEDXa6EWktR8WK6YtUL7ytxKFMvE3qlRHO7YPFF/
         ZVFDpxizwbMMwsRqtsV5YhSRdCq5CuK5AaE/grfjAsLNUvzIZracGQ4n38nWXPX4V1tA
         8+lgesreRSdxRgMXXrlDXfhiAxLyQqeFVa2iKG4z4mc1PH63WDL+K4qBSwUca4Q4O8pg
         Pi4SFOxFhGEmGKjFCTowzpKr07mIVhQpBdltIULDXrlyGqvK6bhzsC0N4JEt3Zld2oIK
         g/mA==
X-Gm-Message-State: AHQUAuZr8CnJYTcStNmdmHTdQ85APXAARVDeyXQHU9WiXudrCUVh20Tk
        TuR8L4fAEeIY9sGFMSP5W8DRr+x58hnrslhH
X-Google-Smtp-Source: AHgI3IZnwVjCgAS0e5h1RWzZ9+P6X8OydZzUreoo4JQLlqJHxqXYNne7xHjiRDEUWuzIVu69WZZ68KjKu0kIJwK+
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr12217478qke.50.1551133037943;
 Mon, 25 Feb 2019 14:17:17 -0800 (PST)
Date:   Mon, 25 Feb 2019 14:17:10 -0800
Message-Id: <20190225221710.226552-1-mortonm@chromium.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] LSM: Update function documentation for cap_capable
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

This should have gone in with commit
c1a85a00ea66cb6f0bd0f14e47c28c2b0999799f.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 188eaf59f82f..f1d117c3d8ae 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -57,7 +57,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
  * @cred: The credentials to use
  * @ns:  The user namespace in which we need the capability
  * @cap: The capability to check for
- * @audit: Whether to write an audit message or not
+ * @opts: Bitmask of options defined in include/linux/security.h
  *
  * Determine whether the nominated task has the specified capability amongst
  * its effective set, returning 0 if it does, -ve if it does not.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

