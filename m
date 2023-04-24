Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B998C77B61
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Apr 2023 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjDXOvG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXOu7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Apr 2023 10:50:59 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022B7ECA
        for <linux-security-module@vger.kernel.org>; Mon, 24 Apr 2023 07:50:34 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Q4p2q52H8zMqFVh;
        Mon, 24 Apr 2023 16:50:27 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Q4p2q242tzMprKC;
        Mon, 24 Apr 2023 16:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1682347827;
        bh=pm7CzBY3TDqgD508osSxkkTUXHwO97PGBPTVdyWPKPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DlS5MyfvgylNLnwlbk1YeGLok7yI5CLpy4DgxkanGgYX0yL6rlDrpwCnHOl8C2vO3
         7/hXcEnAkeDM9Xjdepy8b9Flo1e+Kl/JjllsqyyEVUrZ1BPycquXvVZM2mkhs5+nOS
         fl+4Pe3TuvnQtpQvs0JazSacFRwySzylUqQUe7GU=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.4
Date:   Mon, 24 Apr 2023 16:49:43 +0200
Message-Id: <20230424144943.135041-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This PR improves user space documentation.

Please pull this Landlock changes for v6.4-rc1 .  This commit merged cleanly
with your tree, and have been successfully tested in the latest linux-next
releases for a few weeks.

Regards,
 Mickaël

--
The following changes since commit 1c1ea1c3e21d5ba0867f84f6ad04090bd477df25:

  MAINTAINERS: Update Landlock repository (2023-02-10 09:41:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.4-rc1

for you to fetch changes up to ed35e2f2f0ded15df313ae6f8da21e85c8e1e493:

  landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right (2023-02-21 18:15:59 +0100)

----------------------------------------------------------------
Landlock updates for v6.4-rc1

----------------------------------------------------------------
Günther Noack (1):
      landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right

 include/uapi/linux/landlock.h | 46 +++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)
