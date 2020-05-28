Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7187CC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5284A20723
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693031;
	bh=dAS4DXwHNeuhzpvWEgC5d100yXjW+kGcXfbxsRlTvG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VlJ5ef35poczwK2oZNucfGrE7NudoGIbY26iX3koARJ5hh0oyeSh0/ASuxiI8l2TP
	 HobNy4r85L0oa7xv3mmm3BXC/Rb7xzN1PH8/XZKE6usEXI1chLlJY/uMA2baHdEg4x
	 ZS/lxGquLCP5KCYFMT0uvXUWOJ3ipsn9SMK0UovM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406222AbgE1TKa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406096AbgE1TK3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:10:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3101C08C5C6
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:10:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id be9so985483edb.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmGmOOl5gLGli7OvUQS4McOy7NB6xPaIApbCKtCeXYk=;
        b=f8/b3x4fYWIUj58vxbwcT1zj5CSOCsV5h++6plCNXoHkOlz5+HIWFBcJy1hj9Iocmy
         Q6KvNGUaf7Ktx8T3H3MKSb0yiSTTXPOtIV4i3w5okfxXhRQn9jfimGy2D5TlehUTq6Ly
         3gZ8euFDfy2U4nl63gvxc9icwAuOlc7jkm8dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmGmOOl5gLGli7OvUQS4McOy7NB6xPaIApbCKtCeXYk=;
        b=Ubx076oVpBYyjZIrsqMqOgGfS+p2dDZItshhOhqwlqbnmUWcyK7pVjg+lnBpvKfRIa
         Qz9Y46DOZHn6iYNKrJC9XNssqaBNIGCffo8tbdD+pHIYuxeOuhBA5u+x1XGHZgf3Erg/
         w9TfgWtizlkxpnpMe3VieEtwr2BbLMkQJLwBH/8Y0aWzTweJAmHEOVZQySY2ouS9Qre7
         Jbz3qILTptUgOIxTBmAoUUWMvK7E1eulbJbfJMbEPX4jUU1V2jrbe22iY1mPby49+TdC
         zGY9HYIaoYXIIrnzHrLWW4Zlkj3lA9RNP19oPW8uVY8F0QqyPfi+8W+A8RqNOLX+ZzAp
         qo4Q==
X-Gm-Message-State: AOAM5326h51YID1xuIs/nnmUItdlJUu1GM1iaABGhbYr+LNK3uT+jPZq
        tMJEY0ZQyN8R3HYCDW7Zd3m1/6XAEpw=
X-Google-Smtp-Source: ABdhPJxKF6GPFEVgxmLlcZNP69nnBJ2G8E1VsxNtGrCedm+I7z2ShycovzNwyKtSW4irFtbLD2xDfQ==
X-Received: by 2002:a05:6402:1481:: with SMTP id e1mr3034373edv.113.1590693027074;
        Thu, 28 May 2020 12:10:27 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id s13sm2454308ejv.29.2020.05.28.12.10.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:10:26 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id h21so1151301ejq.5
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:10:26 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr2405859lfn.10.1590692668401;
 Thu, 28 May 2020 12:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:04:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
Message-ID: <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
Subject: Re: [PATCH 01/11] exec: Reduce bprm->per_clear to a single bit
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

On Thu, May 28, 2020 at 8:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> -       me->personality &= ~bprm->per_clear;
> +       if (bprm->per_clear)
> +               me->personality &= ~PER_CLEAR_ON_SETID;\

My only problem with this patch is that I find that 'per_clear' thing
to be a horrid horrid name,

Obviously the name didn't change, but the use *did* change, and as
such the name got worse. It used do do things like

               bprm->per_clear |= PER_CLEAR_ON_SETID;

and now it does

               bprm->per_clear = 1;

and honestly, there's a lot more semantic context in the old code that
is now missing entirely. At least you used to be able to grep for
PER_CLEAR_ON_SETID and it would make you go "Ahh.."

Put another way, I can kind of see what a line like

               bprm->per_clear |= PER_CLEAR_ON_SETID;

does, simply because now it kind of hints at what is up.

But what the heck does

               bprm->per_clear = 1;

mean? Nothing. You have to really know the code. "per_clear" makes no
sense, and now it's a short line that doesn't need to be that short.

I think "bprm->clear_personality_bits" would maybe describe what the
_effect_ of that field is. It doesn't explain _why_, but it at least
explains "what" much better than "per_clear", which just makes me go
"per what?".

Alternatively, "bprm->creds_changed" would describe what the bit
conceptually is about, and code like

          if (bprm->creds_changed)
                  me->personality &= ~PER_CLEAR_ON_SETID;\

looks sensible to me and kind of matches the comment about the
PER_CLEAR_ON_SETID bits are.

So I think that using a bitfield is fine, but I'd really like it to be
named something much better.

Plus changing the name means that you can't have any code that now
mistakenly uses the new semantics but expects the old bitmask.
Generally when something changes semantics that radically, you want to
make sure the type changes sufficiently that any out-of-tree patch
that hasn't been merged yet will get a clear warning or error if
people don't realize.

Please?

           Linus
