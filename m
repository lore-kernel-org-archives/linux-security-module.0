Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EDFE7D0B4
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 23:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIUX3j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUX3i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 19:29:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA68F
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 16:29:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c127ac7255so24431931fa.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695338970; x=1695943770; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMggTAfGNFGXjxKJt1wg6jNgFr8aapVARuQaiT0jkvA=;
        b=K/Qg2EdX/ZIv2tGiQ7iXg0HkOsYdf2PdzedRozFVDC/vyxX2/smEscNz/Yf7kdijad
         yn9eJTC/5TuFv3ZN5pplXvjc5416hmCkt7Ue3VqNmqq97wnByRK6rlaMKHQSGNxQoWET
         g7AS9ClUnmO1qUXV/k/gvswz5IFh2ZAeiTTOXVWVtJ/a2+B/n302+bQfe0G6M37a6OjZ
         3ERE570WzY0TO1YjKYWYWWVrDG4q/akToRtP4Xsql+DHt11lhJ4uWNjT5HwVnWCpgT27
         BujMa5nhpGWpORyKYijUIVSPGPPTf2kEEfg2nJWtJ4vFChVnN2vZbq6qyqlvLETjmXi6
         B0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695338970; x=1695943770;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMggTAfGNFGXjxKJt1wg6jNgFr8aapVARuQaiT0jkvA=;
        b=ACQbK7blgm+kVqqQfbenislo6CDL4Df0lf7K2+P3hZzGqWldLqI4qBDBg+EtYqRpEy
         duhIk4Krl3b4YSmC21mSJnVn6F9szqwsLvpP6hmz6SZfDydSrbx3i3NXIiHI5Jim0dy4
         y/Lt1wRAZ7DmKf8tu+zEg4uieIsbt1s0/OEdyPEfHConiOK2EerZ70J8752M9cASX0a3
         7LCsMlBgQ0t938uGdiFj/ocOzVSd4G6BXKbZqJ78kbWNZXWbmb/nibn+XmWwd4QN/V8G
         N6c4eULu3IPANTjdpOFuj3e7Rf16LBgWhq/vds5MLg2rbDxVtjtVAJkmEMY9yXNb3QBg
         IDCg==
X-Gm-Message-State: AOJu0YzRtOnVRa8OZovrtkBXJYUZqAYtMlkobLwYpwTP8k3YeG41oVbY
        nZJViRk/RoVTWNG5yzgkjlaz
X-Google-Smtp-Source: AGHT+IF+ugMQqBNBA0uxr5vgjIORPC3Xv0X6MthEzVBv5udxLHG+sgk55eID+CKfPRXt2nu+mHXsjQ==
X-Received: by 2002:a2e:3511:0:b0:2b9:f13b:6139 with SMTP id z17-20020a2e3511000000b002b9f13b6139mr5875357ljz.20.1695338969895;
        Thu, 21 Sep 2023 16:29:29 -0700 (PDT)
Received: from localhost (60.red-80-35-249.staticip.rima-tde.net. [80.35.249.60])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906614800b009828e26e519sm1701009ejl.122.2023.09.21.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:29:29 -0700 (PDT)
Date:   Thu, 21 Sep 2023 19:29:28 -0400
Message-ID: <d96d63446c1548ea284eed7d383ccedd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cred: add get_cred_many and put_cred_many
References: <20230909191932.3187633-1-mjguzik@gmail.com>
In-Reply-To: <20230909191932.3187633-1-mjguzik@gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sep  9, 2023 Mateusz Guzik <mjguzik@gmail.com> wrote:
> 
> Some of the frequent consumers of get_cred and put_cred operate on 2
> references on the same creds back-to-back.
> 
> Switch them to doing the work in one go instead.
> 
> v2:
> - add kdoc entries
> - hoist validate_cred call in exit_creds
> - reword commit message
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/cred.h | 59 +++++++++++++++++++++++++++++++++++++-------
>  kernel/cred.c        | 26 ++++++++++---------
>  2 files changed, 65 insertions(+), 20 deletions(-)

Merged into lsm/next, thanks for your patience Mateusz.

--
paul-moore.com
