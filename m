Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019CC433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BB064E08
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBOSPL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBOSPK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 13:15:10 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C32C061574
        for <linux-security-module@vger.kernel.org>; Mon, 15 Feb 2021 10:14:25 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DfXLR4Y2kzMqHtk;
        Mon, 15 Feb 2021 19:14:23 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DfXLR0jkKzlh8TF;
        Mon, 15 Feb 2021 19:14:22 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/3] Kconfig oldconfig string update
Date:   Mon, 15 Feb 2021 19:15:08 +0100
Message-Id: <20210215181511.2840674-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

This patch series gives the opportunity to users, when running make
oldconfig, to update configuration strings (e.g. CONFIG_LSM) according
to dependency changes.  This helps users keep a consistent up-to-date
kernel configuration.

This second series fixes a build error reported by kernel test robot
when building without any LSM.

This patch series can be applied on v5.11 .  Previous version:
https://lore.kernel.org/r/20210215122513.1773897-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  kconfig: Remove duplicate call to sym_get_string_value()
  kconfig: Ask user if string needs to be changed when dependency
    changed
  security: Add LSMs dependencies to CONFIG_LSM

 scripts/kconfig/conf.c | 37 ++++++++++++++++++++++++++++++++++---
 security/Kconfig       |  4 ++++
 2 files changed, 38 insertions(+), 3 deletions(-)


base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.30.0

