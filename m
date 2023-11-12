Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF1C4332F
	for <linux-security-module@archiver.kernel.org>; Sun, 12 Nov 2023 18:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKLSue (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 13:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjKLSud (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 13:50:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B5103
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 10:50:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507c5249d55so5702276e87.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699815028; x=1700419828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=toLQxGAKGjPQ+cmef0067ZoK5B9j5w9kF9znNCM+IOg=;
        b=EP6hiRyTauU6wmoXJZSX/w2H+tKn01xMgJIE0/7y2TSC8WpY+KzLvrbdUtD+BCCoeP
         GFoDXR/ObTP8Szni04Y8dYNZ1GoqxXf1zyABzH9dgrzVHmVq4ey2HKlaDphURAVZ5rjC
         cevKlR93kPgv50Krmwyvdw8ZOSi8NSFBJWHwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699815028; x=1700419828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toLQxGAKGjPQ+cmef0067ZoK5B9j5w9kF9znNCM+IOg=;
        b=mHGs9Idc5lXbl0jR8SQC8w5LX6nDR2sEjsCut9xxUQ40jH2OcklJ9caRAfZTFUyff+
         90XKhiW3IGQD4LqltDLqj7yZ4kZYV1e0n3Rlq9/8UO5UPa68WU5O/qSNPawvinedWeWL
         9fV3q/6uAtWi3kSa/w6mQtv9d8hnuWaRCXnoZjsz7qvOIi+bvXKS0YSNgZces8nwSaJQ
         JDrl1k7jc8DNf0f2FxzoGzsh0k2qDrf43bAeCZRccrqCnUYGvSASwGVgh/E4CFOZ3CUm
         jfeL7QW24GDXnq4zYX7/MxvzZa/1A4HUydp/6vhwKuFHMmCZRx/0FiIHBVi9154zOFUo
         CBGw==
X-Gm-Message-State: AOJu0Yx9VuvnbSXgjszwN/H7rrtIDjQrBmdMYx0iK+WVIc/Dh4mJRAfn
        UQndl30P+ACtGitnMTu9yjJ/q+ms6AV+gYke4KMM4Lm1
X-Google-Smtp-Source: AGHT+IH+eNZXvCV+AR55MyzCF2PmrY+sT9QF8vZnU3G21gWWkR188Ndk9okEHdmqa4Vg+8/YyBuPHA==
X-Received: by 2002:ac2:5dd8:0:b0:507:c9d5:39a9 with SMTP id x24-20020ac25dd8000000b00507c9d539a9mr3012407lfq.52.1699815028399;
        Sun, 12 Nov 2023 10:50:28 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d25-20020a056512369900b005007fc9ccd0sm698298lfs.113.2023.11.12.10.50.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 10:50:27 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507962561adso5718829e87.0
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 10:50:27 -0800 (PST)
X-Received: by 2002:a05:6512:3051:b0:4ff:a8c6:d1aa with SMTP id
 b17-20020a056512305100b004ffa8c6d1aamr4427793lfb.48.1699815027222; Sun, 12
 Nov 2023 10:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
 <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com> <20231112154424.GE35991@mit.edu>
In-Reply-To: <20231112154424.GE35991@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Nov 2023 10:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
Message-ID: <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jasper Niebuhr <yjnworkstation@gmail.com>,
        Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 12 Nov 2023 at 07:44, Theodore Ts'o <tytso@mit.edu> wrote:
>
> How about adding a flag MLOCK_ZERO_ON_FREE used by the mlock2() system
> call?  The number of pages which an unprivileged process can lock is
> already capped via RLIMIT_MEMLOCK (or else mlock would be it own
> denial of service attack).  That way if process dies from crash, the
> keys would be zero'ed.

Yes, that is a lot better as an interface.

However, it still needs to also make sure that the memory in question
is not file-backed etc. Which the patch I saw didn't seem to do
either.

End result: as it was, that exitz patch was not helping security. It
was anything but.

              Linus
