Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D561C636CC
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBPVqz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 16:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPVqy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 16:46:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57013B3E0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 13:46:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a17-20020a256611000000b00889c54916f2so3345313ybc.14
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 13:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeJ/i831fZ5kAy+espuOwX8AfUdOmtVE2TcvY736jvk=;
        b=qW8i1E+fsL3o+Wi7jVsPsuVLJ5aokRhuBslw1BaK10OE8um/wwn84xqTRu21n1+CCO
         EDAJ+rL7QXmGy2TXpMUpWIofRcFCE6UvdL8xVrUIl8/xmnJ/AOFev6Z3Cn4PC//mNtln
         qFH7PGZqXN3Ppq+dVs/48+5leqrnkOTlCh20tpZioZPcv8gJxNauJbx3sunRwaP5PF/W
         mF6NzlDnuMcWz3BA+kRaF2H4rpEz7xZafcm2Y7hmOeCu+Rrf7gFcAqMLWUikgfSLSV6z
         T6dmYeVVNY4wGQNk2SbAtsKj008WFWzuzc1FZ4SlbxaA9Va1+/eXn3rtmOQeCqhvOWiC
         7ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeJ/i831fZ5kAy+espuOwX8AfUdOmtVE2TcvY736jvk=;
        b=uNw3Vk0orUj3HM9MHLn/zqaX3n+rGUL3eWiliBtfgPvc0KBTHoGSSHwA3f27nOcx0K
         pd5iHB6cB0NDoHM+l5kInZ61wc3NDrOKqrro+jW9xsOf1Gb0hjaN9Zp9U3Exro84Jt2w
         ytGIy1PFGjIV6QQdGR2NWtkdat73mUgASW60t8T/H1kqh9lRKqV19QQWQWxfn/Zsq7AJ
         BscInlSekTJ5kghuRiOJNr3N1+v149Y19QhRy9t8kY6QqKJwPjMAhkjtt+4sa2mHDhdZ
         uiYkFsQSmwzzWpxib6NpP1SOX79jNeuFJIRz94tIdQ2yTfmsXos5WRT0moe68UGDBUaw
         2WWA==
X-Gm-Message-State: AO0yUKXLwfJRmJPM52jO74waa0YsDtN9hvW2sUFDTkuTlj3KAp1RRQZZ
        QbzE3548AdPQ/M03BijHDBHjO1PCWoRprw==
X-Google-Smtp-Source: AK7set9ut8O736jOD+iPZJzbsFACDJU7X0FuffY4U2ygYSxgiFaWbj3beWLv6HyXGcDJ+FLsskHCzRhqqsaNJg==
X-Received: from aaltinayspec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:7fcc])
 (user=aaltinay job=sendgmr) by 2002:a5b:8d1:0:b0:88d:b4c7:f161 with SMTP id
 w17-20020a5b08d1000000b0088db4c7f161mr25721ybq.73.1676584012884; Thu, 16 Feb
 2023 13:46:52 -0800 (PST)
Date:   Thu, 16 Feb 2023 21:46:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230216214651.3514675-1-aaltinay@google.com>
Subject: [PATCH 0/1] Cover letter
From:   Anil Altinay <aaltinay@google.com>
To:     john.johansen@canonical.com, linux-security-module@vger.kernel.org
Cc:     aaltinay@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

We were informed that "git status" takes longer sys time(9s vs 1s) with ker=
nel 5.10 when we run "time git status" on a container with apparmor enabled=
 on a machine with 96vCPU and 384GB memory. This test was performed on a la=
rge project like chromium. We think that the commit: df323337e507a0009d3db1=
ea25948d4c7f320d62 which landed on 5.5 started this regression. We tested t=
he attached patch we found at https://lore.kernel.org/lkml/cfd5cc6f-5943-2e=
06-1dbe-f4b4ad5c1fa1@canonical.com/ on 5.10 and 5.15 and confirmed that it =
fixes the regression.

We did not have a chance to perform the same test on the 6.2 but confirmed =
that the kernel builds using the arch/x86/configs/x86_64_defconfig with the=
 following configs enabled:
CONFIG_SECURITY_APPARMOR=3Dy
CONFIG_SECURITY_APPARMOR_HASH=3Dy
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_LSM=3D"apparmor"

Anil Altinay (1):
  apparmor: cache buffers on percpu list if there is lock contention

 security/apparmor/lsm.c | 73 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

--=20
2.39.2.637.g21b0678d19-goog

