Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24530C19F2B
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Aug 2022 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiHAT5o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiHAT5i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Aug 2022 15:57:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180930F49
        for <linux-security-module@vger.kernel.org>; Mon,  1 Aug 2022 12:57:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i4so14285285oif.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=7nBsqduQUZ/m9LmrCg19crZdlIsq4ddtugVePpBzyvM=;
        b=w8vSDodTrVqHxywHNW/ITcBvaB1i42MsKjgSRUzIEUMRZ+Dq38yLsn42lcDWncoZ53
         /YDRvINZHFpWL4we+DjwbE9Ay+uSzwB8XWHotcotf7RNHAfaNY8OnPD/PimKEJLQCXls
         eqcE9U/pqnabJgRQD2m/M1Adkno7D4I8gg5eTmWQ/H22weKCqKDmAsyksYFHrA5NRnRA
         ipB0gqE/bSOVny1Vcir206bN6TPVdkd+6xluMdoIoE9dc9ShXwh7sOqy+ppYRDocCoev
         4cnU4J5IQGvw9XRtPT/L8eVoeYChryR0i4U5IPEeZRNV/MpBjVXKaXr0MI2opES3raoW
         TugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=7nBsqduQUZ/m9LmrCg19crZdlIsq4ddtugVePpBzyvM=;
        b=MbZmgflD/6lY8kg6EX4JW5m96Ck01sQxR1zaMTuXXCtkLys8/1QBa1snUxEUc3KM3s
         dyetDu/bhnzu+kdS6Fy0sOm+SVxRi0/OvrFRbgvsHT0oHLLFTB9xYDiR2Qhc4QlQUy/1
         a8YQf6b69YZz3Kn8kstPaXqjc/CTgwtQ0Rv8rKZknK9X6SfzH8AoUq8sFQmhG8mTp/qg
         tUH89il2BUCjv+e7Hj0n+R46PLH9hpGbfrxvQn0azkUv/einhMveXClPlG5pgtwQ8ij6
         W7ltwnrF+CMLjz+YEL6VFDr3uD80BQelSe53i8lXLZs5Aq5SFKQwePuDdRMDaV7E4XV2
         eJ0Q==
X-Gm-Message-State: AJIora+jiL5rVh+5Zrxdqoa9nE0WeSDkd+KsRppOKL2PAVCWw+XZ/zck
        4ig1zIfDmlqxtnZ3o/PZ0HqJm9LHNgWhxrj95b9uQSfjlUhi
X-Google-Smtp-Source: AGRyM1s/Et9t0mhB5pceuIdoER0mhlq1MyQWHAclx35gRodiSajBL5fswUi3BwAUhKRD4aGjMUXh2n4HVYXMdAYtfRM=
X-Received: by 2002:a05:6808:3087:b0:33a:a6ae:7bf7 with SMTP id
 bl7-20020a056808308700b0033aa6ae7bf7mr7537369oib.41.1659383857261; Mon, 01
 Aug 2022 12:57:37 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 15:57:26 -0400
Message-ID: <CAHC9VhRS+4oUSeThUghGt7wYuEG3ro1kP5zbxz0DeERz1wDK_Q@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Morris <jmorris@namei.org>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus,

A maintainer change for the LSM layer, James has asked me to take over
the day-to-day responsibilities so a single patch to update the
MAINTAINER info.

-Paul

--
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

 Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20220801

for you to fetch changes up to ed56f4b5173efba00e3dcd736c18bce43255cf7a:

 MAINTAINERS: update the LSM maintainer info
   (2022-07-08 16:23:11 -0400)

----------------------------------------------------------------
lsm/stable-6.0 PR 20220801

----------------------------------------------------------------
Paul Moore (1):
     MAINTAINERS: update the LSM maintainer info

MAINTAINERS | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

-- 
paul-moore.com
