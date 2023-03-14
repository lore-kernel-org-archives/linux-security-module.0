Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8561C6FD1C
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Mar 2023 10:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCNKCc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNKCb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Mar 2023 06:02:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09592907B9
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 03:02:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z5so15378304ljc.8
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678788148;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qeEP04IXCztCg3s7heuc0ELnGHTVh83eDIO1/g1HU/8=;
        b=LjT2rdp9Z/qKZL5M0SanKI95kQgk4mXXoSoG6cmmbx0JpNQhg2Z+0GRnW0vo6ycXjf
         ccz1nSfYGToVUzFsYN0qDofepD4+ZTFmLjBe3xGADca+v0T+KimLYXokfv85YrnLpR0I
         s8GJTgQcC30qUr075RjcW7E0/zyHlNRc7LaSKjqJHS6YnY3sdpwiFtr8BFrEm5TZycff
         h3XA3+Ws1MiBtRVGCZhD9B3qq7taJg9cFdgCStPwtRApA3tryGivWRPROVbEjyuTYOkP
         Au+2dO01fzkCyw2sT7Wrq7VtFC8k8YpMKDayMtak/OI8Boa9MzCwrUY9sDt4H6LxkQsW
         zzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678788148;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeEP04IXCztCg3s7heuc0ELnGHTVh83eDIO1/g1HU/8=;
        b=08Y/Bqu8Mk1tWlLtlPGmWTN0KWo30B0OC1tOtybxZzvV7sLATS1cnVUUhz3vnjb2oP
         UvV6pR3elbhWjoIDseWrD0Js0Z2PmfCSCmVq9wpOjQwYAHn9O7VCaUog2zOXLFZGyttr
         +ek+VxR+tAuQrfJdfpeHMaAf3BiLzF3OvGUKeLe/ogCzeWkIyGE5GrlwaYajIodg23nd
         0zoQnrksbNQ0/q3sWEuIHt+4m0YDajIzu6+MUGxODRJVxXQamDtVTyq0C0+7RUCP3SuU
         /9xwcHGHz6/hxakOIlYPZaNS4fl/lNB+QJp5xOVxPq8bzXuOqpfPGevpwQcYyWDEhJyF
         43+A==
X-Gm-Message-State: AO0yUKVESxf56LrcnqXzruo5qeGuqmFAsYI38QyvcipVVZp0YBlZ7fST
        DRY/G6tqbcFBBxnSKO/tNzkqufqpIBpAp1/+UZ2JQg==
X-Google-Smtp-Source: AK7set9PPuq1Gq/1rRACNjG29zFhnHXldG0SFA+FSqaCMM1dlGZMIzQsWQtIlVks2zPPCZdJeLc/6TCuiFNsaINVNHw=
X-Received: by 2002:a2e:a268:0:b0:295:a8c7:4b36 with SMTP id
 k8-20020a2ea268000000b00295a8c74b36mr11839212ljm.8.1678788148116; Tue, 14 Mar
 2023 03:02:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Mar 2023 11:02:16 +0100
Message-ID: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
Subject: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        nathanl@linux.ibm.com
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Lockdown maintainers,

We don't enable Lockdown integrity mode on syzbot during fuzzing, but
we would like to. The main problem is the restriction of debugfs,
which we need for fuzzing. But we do duplicate some of its
restrictions (e.g. DEVKMEM=n).

It come up again recently in the context of discussion of memory
corruptions when a mounted blocked device is being written to by root:
https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgWN1s6A+0Q@mail.gmail.com/
It looks like this restriction of writing to mounted block devices
should be part of integrity lockdown (but I am not an expert).

What do you think about the addition of a new level that is integrity
but with debug fs access?
LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
of "fine for testing".

At least for us it is OK if it can be enabled only via kernel config
(no cmd line) and named accordingly
(TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).

If we have it, we could restrict writing to mounted devices in
integrity mode and enable this mode on syzbot.

Thanks
