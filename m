Return-Path: <SRS0=Ziay=YI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46276ECE58F
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9452064A
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178069;
	bh=rkQXlFDsFSyesOcjvZcFxgz+cNH1rBDwoJ21bgZxyKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AGBRwmpblh1qXzeMznSIuuhHc2sA4plPjUbGTW5EKrtncCLVnxI7PHPvsKATlJ8Bn
	 NDQ9G13d+SvPYV/7wVaL7j2/9aiJqxRL6DmEWVChsO37bLAKombHqOFy16AX0awLQU
	 xyWrZbWK3T67+EcOAQzke12uhpbxqGdnJllQ4oNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfJOWVI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:21:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37493 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfJOWVI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Oct 2019 18:21:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so21915186lje.4
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LIYdbK/WEFGMNdD+uIGw2BasCdPDikOSk/1C31c/6KJAoWeweWvBbkEnJF4PHN8TkH
         BgZdUCf/ZYXj115hlOqd/koyMkdZG6Il9yGalmukOiV4kTIOYCVZSlLQpLqR2NWtyVYg
         nGZ/n1OZmV0DBw+aQ4pzCSwYlzFEdDM+SUZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=c/5cr90clMH+0JoV/P9+FY8aforf2+/Qb8vftucAK4azWbk2py9DT38WERPiWQFpwY
         D3QcBVTSEYj2FzK+NlgSUt4QIDc6DC70z/yaE+2DV3hinIyi2avq7yhu+74GYJpxtej6
         hpHBzvOG9WsqCU1isDptcGe3cz6xTCjWN1XYzxs22Op4+AVF4xqyuhviexy/vnGqKjuQ
         kgyPj/fgeRy0xHuq5yu0dpPBLoEGYSHtkM204ww1YKsu9hHDT3bCFuE+2njFp0vWnVCl
         Dndt+xSEy60ZFSz3FzOoIlUeYEjCg482SsI5wQBfW1DS6CgNoo6tdzFqtyrtRo0VcTi0
         odPg==
X-Gm-Message-State: APjAAAWM1tx7ISzIcWJlCzUcQYQM0wZiNqvLjghZG5/WEDJpmc+xJJO/
        TcWyCN5bO9bDoPbnCje8jIvzghAlqVk=
X-Google-Smtp-Source: APXvYqzhQBv2Qx13vUJ1XAs3ysR3rJfO8PyKOtnJ1ioIZu3bpIv/T9b8dOLAnwDyy5+Xjd1Q6/UNNg==
X-Received: by 2002:a2e:1b52:: with SMTP id b79mr23996731ljb.225.1571178065822;
        Tue, 15 Oct 2019 15:21:05 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x30sm5416445ljd.39.2019.10.15.15.21.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id a19so2833050lfg.12
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr22573654lfl.134.1571178063150;
 Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] pipe: Check for ring full inside of the
 spinlock in pipe_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
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

On Tue, Oct 15, 2019 at 2:49 PM David Howells <dhowells@redhat.com> wrote:
>
> +                       if (head - pipe->tail == buffers) {

Can we just have helper inline functions for these things?

You describe them in the commit message of 03/21 (good), but it would
be even better if the code was just self-describing..

           Linus
