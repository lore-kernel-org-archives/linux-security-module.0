Return-Path: <SRS0=jfU4=RI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D4C43381
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2BF20684
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVpIA3PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCEPrL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:47:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36671 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCEPrL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Mar 2019 10:47:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id 189so7298503ywi.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2019 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zl2wXv9U83HvmtfM5EtBgJ+oEQh6N3gC1Rl21trvG3M=;
        b=TVpIA3PDSr/mYDljxBmfK51byL8UFvWUdAouHN3B0CVfMpKk3A3i11ySqFE+hiSBfW
         nmr+uNhTsL4nWYt4dh/73+qyCmtOhAIuUAFiUI1tph990GrVAmZ80S7PLLcVjxCGgv9t
         SzEAitAUifdHYyVLQgSbUaHHQGzSHiclz9WK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zl2wXv9U83HvmtfM5EtBgJ+oEQh6N3gC1Rl21trvG3M=;
        b=UZ1JuEwrmEa4GBtZ1vuLU5nA27dn9OfuY6Bp8DNjCE9ja45Pvq00eD+8R1BgSnjVeo
         QFrq72mX8Hvgg0KVgY37zRJvlnoGjWcK/YQqJyu39OdWsg+F3dpQ6Cdf55zv/3XFHmKy
         8e5Qf4ERMQM49VCXOY1WacaytBoVCu0WQvv4iC7Si6AwUWgDJlKtRDqq2iW0QlqRCLjr
         RS/Zc50OBEP32ehqXKO7Lx1MEcwsm3PnVoMz9JuYjYqMjt2/d+WjYndJncIuFpXgTnqj
         CZNHJlyRK83w6l0xMGzU7+RfMjSdoBNCul7t3vdUSC2NCog7XSIhuKpgQb4qHDgI0BzN
         TToQ==
X-Gm-Message-State: APjAAAUN1Ur3aMbbjzaG2KGW22xjwij28WF+Ijf1RoDSgdyjCgDhSiQP
        vMd51/IvksDvJ0q8vIE+iN4Mhin/zURDW603Ek6DC+mt
X-Google-Smtp-Source: APXvYqzgUerJpOb2/HJXWs+w+doLROrYJfz2lOW40zg9vaMYZzYPHzt4M5SPwLjHmzZm0l8jRtoDDo5ePsMmMVEEJYI=
X-Received: by 2002:a25:e80a:: with SMTP id k10mr2676692ybd.140.1551800830693;
 Tue, 05 Mar 2019 07:47:10 -0800 (PST)
MIME-Version: 1.0
References: <5552a810-8072-e0fe-4a4c-76f937f0c3f4@schaufler-ca.com>
 <20190228235534.248869-1-mortonm@chromium.org> <CAJ-EccMu97tZCWXTakcTwqFwzXdzVDedgc3jWaRvaJu-duH6tQ@mail.gmail.com>
 <alpine.LRH.2.21.1903051429300.20560@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903051429300.20560@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 5 Mar 2019 07:46:59 -0800
Message-ID: <CAJ-EccNXrTH-0N8=AQNcf5y0o3DhiFnRxqCgE5FVaDFpJrZN4w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] LSM: SafeSetID: gate setgid transitions
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Yeah, sorry I actually fixed that in the last patch, but probably was
hard to follow since I haven't been starting new threads like you
said. Will do that from now on.

On Mon, Mar 4, 2019 at 7:30 PM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 4 Mar 2019, Micah Morton wrote:
>
> > > +       case LSM_SETGID_RE:
> > > +                break;
> > > +       case LSM_SETGID_ID:
> > > +                break;
> > > +       case LSM_SETGID_RES:
> > > +                break;
> > > +       case LSM_SETGID_FS:
> > > +                break;
> > > +
>
> These should be collapsed into multiple case statements with one break.
>
> Also, please start a new thread when you post a new version of the
> patchset, and include all of the series in each version.
>
>
> --
> James Morris
> <jmorris@namei.org>
>
