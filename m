Return-Path: <SRS0=JRQQ=Z3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E1C2D0C0
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A3C24249
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575565989;
	bh=oZ5H36jNKq0pZIeYVK4xdJP/LLG6BLvyweF1TGeLSPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F8ZCxYjDF5I8rjpuhmFcngawuLc05TlC2l2tU00tTyf6q/taStgNWT30TuvMy5D6l
	 sIOxISIkAjhgh54+HagYyWf8rfsUX3vdYC1cq8UJ2ErXFG7MlIeZII+ayuqle1487q
	 s+pHm2K7QEbigD+jtot7+ScPwAOQzetSHJgLdLrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfLERNI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:13:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38441 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLERNE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 12:13:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so4464225ljh.5
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=Q0FUaDCgejnj2j913m9DkZ5BcPyxfvWCsvBxLXqstFY2bocRU9mYGGdVT6TyixAaF9
         S2hdwaxlIrLjm/VudylZUBLif/OSS4AVyaDGMpzqZdSB/9DnkfX4SEUoI9oj/pbE/ewR
         2kNMP8DNxG23lhz/9/1l0TfZQjJpzTexlyrHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=mAF//O5avKatiAusls2FNfp+U/PibIu9R82HtEClspb+lXQGS1StFvTo+SA/hPKlfL
         X4Nyvu7JWzNb8l6r5xYZnWQTuVvn+z1kx046DJHH69eBzGwZHNTWznb/qq7P+AP8yNJd
         dhe5PbEdjAHJ/GrnuujhZl1OmuIpoEq1w5v8w3375o53B4d7gJ+qGCewGSF5a9B4a/+w
         ycdR8SOTyK1OrbK2j/dvIPKChADZmMd45k6Z8GrwymMfKZcU/Wz8Ba16eALmr4qE+9WQ
         73q8iCkNq4yryF2Iv//iVfrQyLyq57NfFnzEy75PfE+P8QGD+GUVrSK5HMpYSXxjoGSc
         qqvg==
X-Gm-Message-State: APjAAAUE2bHRt59pVDtjgrhvo14g0hATNJY9+hFONdKaElE+QxZQnzwB
        RDDGN6AqLOaa0S+NPBHvtOA9LCb6ZbQ=
X-Google-Smtp-Source: APXvYqxL9t5H/t242XQ/5z62UF6Zwxciy5mh3gm5hHB3F1yeJnrYnpJ8EETUYGh92NQrL8O9J1ENrw==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr1778830lji.167.1575565982383;
        Thu, 05 Dec 2019 09:13:02 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 140sm3370842lfk.78.2019.12.05.09.12.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:12:59 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b15so3077728lfc.4
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 09:12:59 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr6095833lfj.61.1575565978909;
 Thu, 05 Dec 2019 09:12:58 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk>
In-Reply-To: <1593.1575554217@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:12:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 5, 2019 at 5:57 AM David Howells <dhowells@redhat.com> wrote:
>
> David Sterba <dsterba@suse.cz> wrote:
>
> > [<0>] pipe_write+0x1be/0x4b0
>
> Can you get me a line number of that?  Assuming you've built with -g, load
> vmlinux into gdb and do "i li pipe_write+0x1be".

If the kernel is built with debug info (which you need for the gdb
command anyway), it's much better to just use

   ./scripts/decode_stacktrace.sh

which gives all the information for the whole backtrace.

It would be interesting to hear if somebody else is waiting on the
read side too.

             Linus
