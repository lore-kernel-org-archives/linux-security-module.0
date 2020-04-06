Return-Path: <SRS0=ULH2=5W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53472C2BA19
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 11:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2117B206F5
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKJsvcpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgDFK77 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:59:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFK77 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Apr 2020 06:59:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id 142so7350854pgf.11;
        Mon, 06 Apr 2020 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=76mGlpp6BFJSmPDHJW6kprv/8C2HQ3fa7ORMT87pipU=;
        b=XKJsvcpo7Y3eIsvwt+slK2It9/UwJptza1whwFfWJeSj+Tk+KPPzWRnlV8RzFZnRco
         /y7P0QfbJX6+uyw/ECZSlNemCC0/iajDr+1ag30GCLMMRu5NcpKvX9FkOA2gYmQZI698
         NHwzj58/n2FvYzGWfXQMvk+h0znA13zDb/EZuCDh94XdXGJYTJiQw0ILMoO5sLMAePcA
         vaAVOnzoTiiSNsWCJVKud051c87X5fZ2jUa/FtqGx2Asx2VGORgUd7wMw2XAlPwydg/+
         SrGwQPAkrr9goYq8UrZDdBGT2FeBGd/7ZJLVvTxDRZwkeZhXyMGxpuHt9BOGKWHq7Xl8
         N2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=76mGlpp6BFJSmPDHJW6kprv/8C2HQ3fa7ORMT87pipU=;
        b=CmAadlBZ25hcVGYOPKOizSV9QjkVYyy+QiMBybhyUtKTNQY9ByYi6E14iw4093Y3EJ
         mb0WCPhQla3T32nVuKdy5TNR45XlTKgaGR9MTqCDXSZ/3WAmJO2Gr9PwXUmHj1z33fD1
         HTo0G3DZKVv2YzcC7Q2YQPp2iyukKQ6x6Btuds8GlfziNNrOuxv4vgXtppGiU46M5rFW
         kDmQaqvzgyEz7h2013pj3BeVCAXL2yLD+VuiQ9O1dIK/QUK/0aQvtFOTzET+4SjDM1Bl
         TG2V5P7u+eaxuy3/9OeRMgjbYSJ4imXE2pbPdmf5skhj0keEDPTm9c15Qn1XrxHJJxVk
         Uh6Q==
X-Gm-Message-State: AGi0PuZpjTtQr78Qz6mihnvi9fjcWvNjEPeqCXuhHTXVklRBcLrFFT6S
        If8gdyYjudd/jAjBk7SDWYE=
X-Google-Smtp-Source: APiQypLo5R6aTgUFGFSStDUnpE8fqAAl3q8UtUXqjkfX8M/Kws53j2EaC6qi929TvME8Gj6oK+ylkg==
X-Received: by 2002:a62:7911:: with SMTP id u17mr20215835pfc.305.1586170796382;
        Mon, 06 Apr 2020 03:59:56 -0700 (PDT)
Received: from workstation-kernel-dev ([103.87.57.178])
        by smtp.gmail.com with ESMTPSA id x68sm9955214pfb.5.2020.04.06.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:59:55 -0700 (PDT)
Date:   Mon, 6 Apr 2020 16:29:50 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-security-module@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
Message-ID: <20200406105950.GA2285@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

exceptions may be traversed using list_for_each_entry_rcu()
outside of an RCU read side critical section BUT under the
protection of decgroup_mutex. Hence add the corresponding
lockdep expression to fix the following false-positive
warning:

[    2.304417] =============================
[    2.304418] WARNING: suspicious RCU usage
[    2.304420] 5.5.4-stable #17 Tainted: G            E
[    2.304422] -----------------------------
[    2.304424] security/device_cgroup.c:355 RCU-list traversed in non-reader section!!

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 security/device_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 7d0f8f7431ff..b7da9e0970d9 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -352,7 +352,8 @@ static bool match_exception_partial(struct list_head *exceptions, short type,
 {
 	struct dev_exception_item *ex;
 
-	list_for_each_entry_rcu(ex, exceptions, list) {
+	list_for_each_entry_rcu(ex, exceptions, list,
+				lockdep_is_held(&devcgroup_mutex)) {
 		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
 			continue;
 		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
-- 
2.24.1

