Return-Path: <SRS0=6wZ9=XW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC4C388F3
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222A2207FF
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569608402;
	bh=nixqikW0YVjyRXTXPZ0OQykyrHovBq2poqnxlZ2w0Xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2SFudVU6GuG/V2QsZ3VGqs5MgUEyWX62Fm9mgqDkZG7yt8DnqZ7+LHTsXPn3Htbqi
	 XHwalMeA+1Z77Mb8J1tgirShMvY5uAoy9vpWo9JlK98uKKcHbeRgpRjyZNmOYmOGXG
	 nmK/KhTrLWhxMW0SOo2xXdME+tO7rmDTzGYPS5NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfI0SUB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:20:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39308 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfI0SUB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Sep 2019 14:20:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so2605243lfh.6
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2019 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tehHftnlIZpuK7bFKqc+5WjFB+mT//aLNi+OsMfiEtY=;
        b=QLf7L0LguMNURN7cmZ8SzPczLJx0nHvbuzjXD2HCo2gMYHnYf7c+bP+/Hfh9MKZIic
         cB/dy3RBKY3e+GPCukLmg90dkAaOu76XTBJeSZC3tKQbBgHO55QHDU9+bS+EsZOYVWnB
         n70YIM6HULzAXopOzej3WTpMpZSPeE4pcO9CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tehHftnlIZpuK7bFKqc+5WjFB+mT//aLNi+OsMfiEtY=;
        b=pHVZDBqjTaYsdCd0z2wbJxqB0n7LG1UjjJUbVm3agwC+PQb7WtXSgZ9qgV47A1ADD1
         4CzCuSs8jiBaATphRumDB7CAUgrJcpVOtEiiLqblp8aHJpr2u34vAViF4dhNJvEQRAwV
         eEL2dh+AA0mmeptCg2lM933hD2Q7bS/BiS4T/x68AAGcR+BRxjkhEiU/8nJ61+RrSfjl
         otNvIHWxjqQ7/zCjGROi4BSbw1BkRxX8fw4MozqhYle7khCeLI721h0miTPwk1bmcPnL
         LgudtO1ElZW2SYClhbD6hh22Z5cohGZU7ohry0QOAX6QPe266nsdIz0JuAJXTXYcf+B2
         Y1nQ==
X-Gm-Message-State: APjAAAWG4pHdBpg6NNlun2cmjdUOVgMW1N8KDvxW0DIa5+n6nNsOGfLY
        tE5vYvAbSLIREEpydyEpCcoRGAzpJtA=
X-Google-Smtp-Source: APXvYqwn5XSjtkrJu2RS2o+yKCLT21MqXYisdZbpOfs8ygKX+jtdBS/5YGS9sa/Fu+j6Jh6E16ZWvA==
X-Received: by 2002:a19:2207:: with SMTP id i7mr3753900lfi.185.1569608398477;
        Fri, 27 Sep 2019 11:19:58 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b19sm604413lji.41.2019.09.27.11.19.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 11:19:57 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id d1so3368230ljl.13
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2019 11:19:57 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr3912648lji.52.1569608396991;
 Fri, 27 Sep 2019 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1909101402230.20291@namei.org> <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 11:19:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
Message-ID: <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
To:     Jiri Kosina <jikos@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 25, 2019 at 7:54 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> Seems like this didn't happen (yet) ... are there any plans to either drop
> it for good, or merge it?

This is one of the pull requests that I have to go through commit by
commit because of the history of this thing.

And I've yet to empty my queue of all the _regular_ things that came
in this merge window, so I haven't had time.

                   Linus
