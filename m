Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8825C4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CAA20820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0MOEVgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDDAcz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:32:55 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41970 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfDDAcy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:32:54 -0400
Received: by mail-pg1-f201.google.com with SMTP id v9so357933pgg.8
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y6V235ExOHhz04rZCHOgAR7JNFI4IiG20YTZkaOAY/c=;
        b=i0MOEVgf+dILjVvzgO3iuR3khF61WwWfwF0fHopUpJvEacJVpDUygiaZcktQd3pB4l
         rcIYdT/8zgZ5Ih2U03BCrI14YR4JzzW0C4AFrFc1nCpIb88pJ4Bv6e1US7MeoJODEjMP
         2FEd9WdMUOew41mhqorZ0BEAd7MsUBZ9/lumjBl1ZB2F+8HjTSWIVyDW+/oFB7U6wd+h
         A+wANYlD20pYtTXJFH5l6b1fMjOuBPitiyTmtg9waG4To++KJQIXNlDdu/3XCuVivtVA
         QTnNa0cfCsUWnBBe8/69qvJIg/XxmSecUd3L+MrO8gjFny66doS9f4eNwfXoEm9o7kgO
         SX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y6V235ExOHhz04rZCHOgAR7JNFI4IiG20YTZkaOAY/c=;
        b=gqqYvtmBNJl9RBV2eD7KbrK9jOh5Cir5SOnZAx04MDWImreoY5C+4RBsNHwXh4pP4S
         bCLSntbruvHd6eNxFkB9P5ZmehiMsNhffFpJjuTOCg3Infb4tlZDs/1BIOnwv2v8MrJD
         O9UvFnxSpGlJcdhpkdeAIlLpK1Bs3tfA5M2wqkbopHhUgp4dqhYYKHCdwTCYlfGEllCz
         6IDMrVvkqCNcHdCdJj7DJTMI1M4VbMM1dao1euIbKSrTkafQ35DzzHwruRwvYn5w+yAQ
         o/NvArjqZgxVFAuQ5gAt0UVWpIht2qSwaWD5yKmnOr8IE5UClyf5GLFBaUzrTml6+8Te
         3jsw==
X-Gm-Message-State: APjAAAXBUkHy4Ie/D2V/gpnv+lN2cxD/O6DIMAP6x/j6UPcoKHZkL/hi
        bC6n2LDTIRSJk4eg1VlVC+7aLKz1nZ06OV/lx1hnJA==
X-Google-Smtp-Source: APXvYqwEpI4mlJCZEaBikS6qmGFc2PDIiHYjzSWr40rE9qXgajTOP/YAJESlpdjURno+qIKWQhzAJfXD2hsvBj6gJoFvJA==
X-Received: by 2002:a63:6b4a:: with SMTP id g71mr76248pgc.141.1554337973835;
 Wed, 03 Apr 2019 17:32:53 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:22 -0700
Message-Id: <20190404003249.14356-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 0/27] Lockdown patches for 5.2
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fairly minimal changes since the last set: tracefs is restricted at
Steven's suggestion (but could do with a once-over, I'm very much not a
vfs person), debugfs is back to Dave's original implementation. I've
also fixed up a malformed patch that resulted from me getting confused
during rebase, and added some further documentation to the initial patch
in order to give a reference for the design goals.


