Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F051C001B3
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF2VFg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjF2VFb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 17:05:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633830EC
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 14:05:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so3297a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688072727; x=1690664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtqC5U06rpgElL+2bahbcyOiaEJkZ6SnNFt7jo/MOuI=;
        b=rOm8Rha28FTOFOHSJ4pnBUfd88CBGxDDkHvCX9orLeRV9Nhd/sglXEJd9xFznwQwHd
         5VlVBjdmO2LahD1b6cH3urkETtnXQfY/PbKiucJ5ryGf2a6JyzHzZEvRRXX4lmUUj7Yt
         3Ua2g9qSC0sJjbtn1YD0JRohiBcpvGdV38pmMwau+r/H8ubR7PjdpvEeCKtsU6Yjwqck
         XqKuFnhUZod82aios1qhFvFAHUziSU8mO29aziPIaf34KZcJJwoSdwZr/EOzJ6YOYyI7
         j1sqKAOtQND52d+TYHNgKyFWag50AjMTuFYSYOL3uOXYYoV7VSCOU/H2qn6tiR53l3n6
         9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072727; x=1690664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtqC5U06rpgElL+2bahbcyOiaEJkZ6SnNFt7jo/MOuI=;
        b=dNUhDZI24UDRqbKR7lnxXPSmVE8jeeaZhmmt/B/vWtVd/wVN8sSrp+/Xks8ZEVxXVl
         5cUiNDHQ1qeOJGENeQMTwqPvuRvRzjOUfU+YFIWyfno/3sjRn04V7qcD+tbILX8E4SMf
         0gBBnaUj4UxIcjangdVdP4NkAWs3lqUGRL9MJ97d7durd3z+LEOs33yELLgDLtUxmCkV
         /d7EUQepsBXIUTVwssOUP1bt0K+orLUTa7zoYIJXSGpM80eSVz0A+iUl6bTV8e14hDbb
         4mmuf3vzV6pT6w/2MIej/ogUoHWbt800a/hofR9TzZGtYKI/P5I3c2cRo8S5A7xahfjJ
         TNdw==
X-Gm-Message-State: AC+VfDwlpGDBQDiIA/UVO8YVKQk17vAGKJThvQsgQVrvSmBYWlyXBplh
        Zrp9MpMti8gVnBjJxeM8NuW0Gw3Kir0njy80wSWcTw==
X-Google-Smtp-Source: ACHHUZ7GbEWD4nWGsAzJazQOkKf5PEoLuhvKRiEGkpHOQkEqtf1+QVWBi7bo8ZkwYTh5iQe+Oky1ZmARdNPs7TuWi+w=
X-Received: by 2002:a50:9f85:0:b0:51a:1d77:e69d with SMTP id
 c5-20020a509f85000000b0051a1d77e69dmr166118edf.3.1688072727376; Thu, 29 Jun
 2023 14:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221215001205.51969-1-jeffxu@google.com> <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org> <ZJyKeeqRJxzwlMhk@codewreck.org>
 <CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com> <ZJ1dGvWkJVAbBPn7@codewreck.org>
In-Reply-To: <ZJ1dGvWkJVAbBPn7@codewreck.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Jun 2023 14:04:50 -0700
Message-ID: <CALmYWFv=bmO3_SfojE0W0Lt4ZS6M-t3=sswncq+gwD7w8HLNhQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Xu <jeffxu@chromium.org>, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello

On Thu, Jun 29, 2023 at 3:30=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jeff Xu wrote on Wed, Jun 28, 2023 at 09:33:27PM -0700:
> > > > BTW I find the current behaviour rather hard to use: setting this t=
o 2
> > > > should still set NOEXEC by default in my opinion, just refuse anyth=
ing
> > > > that explicitly requested EXEC.
> > >
> > > And I just noticed it's not possible to lower the value despite havin=
g
> > > CAP_SYS_ADMIN: what the heck?! I have never seen such a sysctl and it
> > > just forced me to reboot because I willy-nilly tested in the init pid
> > > namespace, and quite a few applications that don't require exec broke
> > > exactly as I described below.
> > >
> > > If the user has CAP_SYS_ADMIN there are more container escape methods
> > > than I can count, this is basically free pass to root on main namespa=
ce
> > > anyway, you're not protecting anything. Please let people set the sys=
ctl
> > > to what they want.
> >
> > Yama has a similar setting,  for example, 3 (YAMA_SCOPE_NO_ATTACH)
> > will not allow downgrading at runtime.
> >
> > Since this is a security feature, not allowing downgrading at run time
> > is part of the security consideration. I hope you understand.
>
> I didn't remember yama had this stuck bit; that still strikes me as
> unusual, and if you require a custom LSM rule for memfd anyway I don't
> see why it couldn't enforce that the sysctl is unchanged, but sure.
>
> Please, though:
>  - I have a hard time thinking of 1 as a security flag in general (even
> if I do agree a sloppy LSM rule could require it); I would only lock 2
>  - please make it clear, I don't see any entry in the sysctl
> documentation[1] about memfd_noexec, there should be one and you can
> copy the wording from yama's doc[2]: "Once set, this sysctl value cannot
> be changed"
> [1] Documentation/admin-guide/sysctl/vm.rst
> [2] Documentation/admin-guide/LSM/Yama.rst
>
Thanks for the suggestion.
Yes, it would be good to have some documentation.
I will send patch to update Documentation/admin-guide/sysctl/vm.rst

>
> Either way as it stands I still don't think one can expect most
> userspace applications to be converted until some libc wrapper takes
> care of the retry logic and a couple of years, so I'll go look for
> another way of filtering this (and eventually setting this to 1) as you
> suggested.
> I'll leave the follow-up up to you and won't bother you more.
>
Not bothered at all! and thanks for reporting the bug to improve the
quality of memfd_noexec !

Much appreciated.
-Jeff


> Thanks,
> --
> Dominique Martinet | Asmadeus
