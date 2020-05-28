Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB5EC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F95207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590692907;
	bh=s9D2lFfhQRK79z+tGsuVgLXmSvOc7unABKdMunJCWy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gku3l7mb50808RiDJ0ym7yf8HuUFpBjJO1JHQ8bIncFcbsQTe9X3J+5bDGR9rshzh
	 aFmrQtZT/g5safd3EipceSZd4F/yKrEqwWcJM0gHGSZt5GACb2WmAOn0hP9vXZl0x9
	 QieTPe9KEfkejqHTmjeAIt1pB20xlBkmC/IYc02w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406128AbgE1TIZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbgE1TIY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:08:24 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCEAC08C5C6
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:08:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so17235598lfd.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=aFMSYB2ECpaxe8CY18ljTFJv4xRZ5bv1Zi4GWChAC1vehbJjLJ6zd3EKxvcmaiQMve
         SRJN/ivKuQqNVzeGQp3DjmIyYFrTa8FYINcRjHaUHAuPfavRik3b9xZHsSgl1vMIU6Gg
         uFypusNji8uKclzDC/fRxY3b+szIfbFvyasjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=Qa9yXuUd0O/PLw/Pt0gVGk2aT/CnkzeVHVy3Ng/kpSpr5722zN2lgQCfvhBDCkhSx5
         hFhm7jR28vWctRBMYzT6ZEA9EGzwUUG0QKrWO8FFbK9v8xNaTUqFcqr66s4hA93ieP8p
         9E9gG5TFwpzV4HemeuCHI1hkBzJdgi+7sos4xlu84et0j9CbH3kkRt2uQ21FZi4S5NMO
         A4nK9Iv+a3qENtcCqAPZBVCOUDyLz7VWqj0PXGkuF+ABJEs9m0ijWQMJ9EtyeSsVo7WU
         IA/8glNRaRUbZ+S1pTjJeTPoG47mkEXIEOfZq1CCJ1rFHrWAVvL5b1ZsVWJrxDCqdQrC
         akpQ==
X-Gm-Message-State: AOAM531iPbuRkmRIfgPbd/IF8Ug0MjLj9GQae7dZkP3FwxWbYWeNWWtZ
        9rkDHPzZYTL4igJPX0HXFAVcl9Nuv/M=
X-Google-Smtp-Source: ABdhPJx3PQ/Wm1p/+/ohktFiWkWLi/RHDyuBb0yGsynnR1hUIMYp+Hywda8PQ3BtDfKtUmQC9IWENQ==
X-Received: by 2002:a05:6512:20d:: with SMTP id a13mr2432420lfo.36.1590692900857;
        Thu, 28 May 2020 12:08:20 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h2sm1813883ljb.45.2020.05.28.12.08.19
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:08:19 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id o9so3114865ljj.6
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:08:19 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr2157651ljd.102.1590692898773;
 Thu, 28 May 2020 12:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Subject: Re: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when
 honoring suid or sgid
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

On Thu, May 28, 2020 at 8:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It makes no sense to set active_per_clear when the kernel decides not
> to honor the executables setuid or or setgid bits.  Instead set
> active_per_clear when the kernel actually decides to honor the suid or
> sgid permission bits of an executable.

You seem to be confused about the naming yourself.

You talk about "active_per_clear", but the code is about "per_clear". WTF?

              Linus
