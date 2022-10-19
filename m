Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F63C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Oct 2022 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJSNhT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Oct 2022 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJSNgm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Oct 2022 09:36:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60FF1974CB
        for <linux-security-module@vger.kernel.org>; Wed, 19 Oct 2022 06:25:24 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-357208765adso167486627b3.12
        for <linux-security-module@vger.kernel.org>; Wed, 19 Oct 2022 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mfibaF6aKr49AkDi2NV5TQ0Zst4gwNZkFki5993X6jc=;
        b=h3NbhrMbCBwk0Hnr9XMowhAoSHk5InhwthULv50BE9mYT5F17Lx9M0ckIuX3HBgzQ2
         +JEgoktMxs9YSHukWtDoCJXCitF2kwpRStUkBELKkVjUD2stj+jIiZ52fSfBlKJ1r7Z7
         Tk2RD2nqzHpcp3roC8CqsmkRFAgeIoENs6O7ng8Zg2/5keZSCaX9eOOlVPhsOlIjhY1+
         7w25KBYB+LmjtS8/4PO+QxDeOZvu7tvMujxxkB6wvZvRW2OcYbWTZ+MlOK3MIzfADWxv
         PX4PGP4REuut9aF26GmTDaDLwE4GqrY5FGUmdGNohGyoaHP6AGgPvFQVYJ1FXfsyC7nB
         SkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfibaF6aKr49AkDi2NV5TQ0Zst4gwNZkFki5993X6jc=;
        b=6M0Db58ieBxt2DoHqU2LCkGPOHVdFoMDffpVtUducF4VB/suHrqd8BpUOJ8ReSMDRX
         W3KrN4Fs/Y1j/RBEUYloCpZVmw66TslU10OBEgcBLm/acYDbsdjxgynEyS13pzIkCwtx
         of7o0rSKPS0cIdem2ouevCGuMGsuaF0ecVaSHhq133WnYVhrujLbIh2RQIoIEvPzEOP/
         Fb7DBvBjIF13tLQEYoQMh5SPnZV28cGgMok3PP+tyuuPdjUo+V4rl7Fs9P2fwLfheZym
         Z72FCYtlCyEN1H4JVCPRT0rtrNhjDOsh2Cl8qR0HHenYt92ZwsPR+C8CLFZBH1GNJqsH
         vTJw==
X-Gm-Message-State: ACrzQf0hI2/11uXZn5MEXy8/NjUHsibeE7vJHtHn9UO9AlfIiUGothRI
        r2Wi5zEmDyugiHzSS8wTJ9MHBz4GY4b9kPZPmipV+V5MwEfF
X-Google-Smtp-Source: AMsMyM6lCCWTmm+6IikuuDS5cfpN/BQL43j+d8hclavgvII3F6vQdSnScxwCLjAzSdMdKtkE68LNCzqRkGxXESTHTZQ=
X-Received: by 2002:a81:f84:0:b0:357:c499:44e6 with SMTP id
 126-20020a810f84000000b00357c49944e6mr6660650ywp.51.1666185868743; Wed, 19
 Oct 2022 06:24:28 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Oct 2022 09:24:17 -0400
Message-ID: <CAHC9VhShn01qD5bYFtNEhAA=5w=+PYuoPq1tdY4b6S-wrs+xPA@mail.gmail.com>
Subject: Commit 9fdb079fb28e ("pstore/ram: Set freed addresses to NULL") in
 linux-next has "bonus material"
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

I'm sure this is an honest mistake, but commit 9fdb079fb28e
("pstore/ram: Set freed addresses to NULL") in linux-next appears to
have your "LSM: Better reporting of actual LSMs at boot" patch
included as well.  Please fix that when you get the chance.

Thanks.

-- 
paul-moore.com
