Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7EC54E49
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFD7214D8
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589055602;
	bh=BY+9H3Ohx9j5ATTOyBORFnwojITRSe1G1ubOQsQy6Io=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ycCsO4RVTQfj1WCLWS5AD9zy6FnaHlMAUTtxgrCVSpGyiaeMhgWWZ0shOuxxGDGg/
	 CcHZFXSvVJcDTaZcqgPrMIlGApTpZsWcHmUi+cLYwKNZBmRxR1XbC2l2vr+GGAOsUb
	 t4/a1irAOJCclUVWYYiV3Njd47GBaSMztyHldNxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEIUUB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgEIUT7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 16:19:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E620C05BD09
        for <linux-security-module@vger.kernel.org>; Sat,  9 May 2020 13:19:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so5306187ljd.3
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=J2julx2hs6owd62n+pd2JYhe6q2QsRo1OXAtwsVsruYMJBpnQ8uiFOlguFDfLik7YZ
         rMAAv0+dFxD8QskYZi9nLX3zKberv3nFnMQyidnzE4Vpn2PvYCSA06ICHQfTj4koWuUf
         oYf9h4WDijg//VNKhtCcE35X/HOZG3u0J2S3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=qTuh6s17C2TWwB3Ti5+Eji+hjOV+hP6KEsLy64WIFb5DYMZ65Xph5rMDgUbI6TgqQo
         vVGeXbTofHkwKDFUKkNozrRZ1F9kSDf06BkOSx7tgWx8YfzeJuEH+06SWUh+J++BuQyy
         E0SRd+yOWmF2/fPySUYKJFdXwWsJbzrhvQChryqrAIVg0vj6+ESwGg9V6KcK65GQFqvg
         s95m3SXIkfTaSy+5bwpsTtrMsUhSVS4hn7klgN1qTCjje8zTF8773lEJgtzqkft+DqCo
         7csma7L/D5pM932v/4KMRMjAn9xdU6k++Rs4ODXqXkVieSo+l33kQ4FI8Czvby3H8Bre
         9VlQ==
X-Gm-Message-State: AOAM530tmhBu2Q/1d0Q9Ne4sSjywTRDw/cu64K/Ins1H21+8a/fW+tlt
        xQSniDhA1X+1E8cYG64vbzIjJ4NTY3s=
X-Google-Smtp-Source: ABdhPJxeTDUFxrTOtXI4fyDfxH7Vm9xsaIcq8sp1OtH/5ax8bZ9ksgBSb9kSNkzmv0FxzzTItVJ8Bw==
X-Received: by 2002:a2e:a287:: with SMTP id k7mr4386718lja.76.1589055596865;
        Sat, 09 May 2020 13:19:56 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h20sm1225860lfj.26.2020.05.09.13.19.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:19:55 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a21so5274712ljb.9
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:19:54 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5609189lji.201.1589055594669;
 Sat, 09 May 2020 13:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com> <878si0yijd.fsf@x220.int.ebiederm.org>
In-Reply-To: <878si0yijd.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 9, 2020 at 1:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I agree something needs to be renamed, to remove confusion.

Yeah, the alternative is to rename the capability version. I don't
care much which way it goes, although I do think it's best to call out
explicitly that the security hook functions get only the "primary"
executable brpm info.

Which is why I'd prefer to just rename all those low-level security
cases. It makes for a slightly bigger patch, but I think it makes for
better readability, and makes it explicit that that hook is literally
just for the primary executable, not for the interpreter or whatever.

               Linus
