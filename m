Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7DC2BB3F
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjKTTj2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 14:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKTTj2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 14:39:28 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AA91
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 11:39:24 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYyWG3Q49zMq9mS;
        Mon, 20 Nov 2023 19:39:22 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYyWD3xyTzMpnPf;
        Mon, 20 Nov 2023 20:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1700509162;
        bh=S7tvFdtUlfllu2Pvo86NVIhyAbvrQA0adZ48mojO6AE=;
        h=From:To:Cc:Subject:Date:From;
        b=i9cyMyub6MsrFiUe3TO9v2Bm1xEDsaj4Q1abi1/osZtQU6rlEIjvR436sIsjAhes2
         dTC6fvNxxhbTFzpFtRhx64yrh0o1hJvyiiNlzFqDJ9R/eETVWcXl8LQRb8YYatUzdG
         HPxOr2p33+/s/nxToZrlKMNLrGLzWtH6PcXeRVR8=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/2] Extend Landlock test to improve rule's coverage
Date:   Mon, 20 Nov 2023 20:39:12 +0100
Message-ID: <20231120193914.441117-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

These are new tests to give more backward compatibility guarantees about
rule's access rights. This might be useful for changes happening in the
access right handling, especially with synthetic access rights:
https://lore.kernel.org/r/20231117154920.1706371-3-gnoack@google.com

Regards,

Mickaël Salaün (2):
  selftests/landlock: Add tests to check undefined rule's access rights
  selftests/landlock: Add tests to check unhandled rule's access rights

 tools/testing/selftests/landlock/fs_test.c  | 52 +++++++++++++++++++--
 tools/testing/selftests/landlock/net_test.c | 50 +++++++++++++++++---
 2 files changed, 90 insertions(+), 12 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.1

