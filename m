Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CACC4360F
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836D32086A
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POH4gM/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVU0O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:26:14 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:54361 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVU0N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 15:26:13 -0500
Received: by mail-it1-f202.google.com with SMTP id v125so2916093itc.4
        for <linux-security-module@vger.kernel.org>; Fri, 22 Feb 2019 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qkm+YSoL0/VSoGOz06+I/5bKVlnzyr29pkKRgaQyoHs=;
        b=POH4gM/PwrNXkELWPtEXM6reZRfzzWVnJQmA/yjOUDCnMXdY/H2HYRaZV+gRVk0mui
         tCFdcCpqTABeRcBFygFFewnvmjzvvQO5qVseIT99+a+ikjGB0+wTfoJ7YBzhile0Sb5f
         PnPaA6Y/V+0dkXYmkKTEEVsmGPMFiAa4KHZnkCFtoW0U5htUQGFHN/0SbqEF4vUC35U2
         B3qfwXQUsADWKlGJWv7+N8bhMpwahWee9q7PwwvWFAwEWPuax7tHytAlj08zgFgzxM9d
         gnn7830d5QjHiSvJFfeBuEguen1xDCkh4iWv13hO+qyNc5KcP60EmbR/KyWlAWmC9d/w
         5mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qkm+YSoL0/VSoGOz06+I/5bKVlnzyr29pkKRgaQyoHs=;
        b=Cxy/lX58f7T/nTkvWXozV8ejGjRlNzsVXb0RGL8G6qX2g4glbvFfNF8QOijNg/EJMW
         VnO1ivXhRIQKBWrAsJTd/WMmEdhtWC20/CpyiMsVUHtY9M4rPZ88xQdsvL7tYZO7dl+q
         ribkMSs3r1tgG5iQH3zmnmtKimU2vMpWMZQGCd+s8gAob4Hl2M6wPKsbCrBxOp45ieig
         E+zaVA8C4xveELPh7WVXLjaREY2TzvatZJrAEIEUM1/Ei2Dbu8Nn9lXJTLnRd2t6Z6F6
         tNBetffaYcZvaTCclch0cg1NCHNAK7tKmHUee6qwKIrG7M8dg1hoGlXh/USnPHxPxapV
         SghQ==
X-Gm-Message-State: AHQUAuaM9vzdop6IBL07YjamvZ8B1Kuy1cZLg16R3Oz7QdkQWWmKT+MT
        zeO4J3lIYjqNf431fBOP/ocM5kT8wu9gXWOgFART8A==
X-Google-Smtp-Source: AHgI3IZffoBm3X4hvB/wX2UaNP/GSPIwB8rbXxfxYTXRbBG7OVwpA+htBCc9WRKcwQLKhqzo/ej/MBjm/heFAb2LGJt7nw==
X-Received: by 2002:a24:654c:: with SMTP id u73mr175907itb.16.1550867172589;
 Fri, 22 Feb 2019 12:26:12 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:26:02 -0800
Message-Id: <20190222202606.160816-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH V4 0/4] Add support for TCG2 event logs on EFI systems
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patchset adds support for obtaining the TCG2 format event log on
EFI systems, along with support for copying up the final event log to
capture events that occur after the primary log is obtained. V4 is
identical to previous versions, except for tpm_read_log_efi() in patch 3
being reworked to reduce nesting.


