Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31751C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195DF2078C
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406347AbgE1TV0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:21:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54248 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406320AbgE1TVU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:21:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeO5a-0000xN-0J; Thu, 28 May 2020 13:21:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeO5Y-0002Ld-TF; Thu, 28 May 2020 13:21:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
Date:   Thu, 28 May 2020 14:17:19 -0500
In-Reply-To: <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 28 May 2020 12:04:12 -0700")
Message-ID: <87pnanvphc.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeO5Y-0002Ld-TF;;;mid=<87pnanvphc.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Syvr95fcCE2Yrct5NG1ay+23m265eGRY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 01/11] exec: Reduce bprm->per_clear to a single bit
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 28, 2020 at 8:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> -       me->personality &= ~bprm->per_clear;
>> +       if (bprm->per_clear)
>> +               me->personality &= ~PER_CLEAR_ON_SETID;\
>
> My only problem with this patch is that I find that 'per_clear' thing
> to be a horrid horrid name,
>
> Obviously the name didn't change, but the use *did* change, and as
> such the name got worse. It used do do things like
>
>                bprm->per_clear |= PER_CLEAR_ON_SETID;
>
> and now it does
>
>                bprm->per_clear = 1;
>
> and honestly, there's a lot more semantic context in the old code that
> is now missing entirely. At least you used to be able to grep for
> PER_CLEAR_ON_SETID and it would make you go "Ahh.."
>
> Put another way, I can kind of see what a line like
>
>                bprm->per_clear |= PER_CLEAR_ON_SETID;
>
> does, simply because now it kind of hints at what is up.
>
> But what the heck does
>
>                bprm->per_clear = 1;
>
> mean? Nothing. You have to really know the code. "per_clear" makes no
> sense, and now it's a short line that doesn't need to be that short.
>
> I think "bprm->clear_personality_bits" would maybe describe what the
> _effect_ of that field is. It doesn't explain _why_, but it at least
> explains "what" much better than "per_clear", which just makes me go
> "per what?".
>
> Alternatively, "bprm->creds_changed" would describe what the bit
> conceptually is about, and code like
>
>           if (bprm->creds_changed)
>                   me->personality &= ~PER_CLEAR_ON_SETID;\
>
> looks sensible to me and kind of matches the comment about the
> PER_CLEAR_ON_SETID bits are.
>
> So I think that using a bitfield is fine, but I'd really like it to be
> named something much better.
>
> Plus changing the name means that you can't have any code that now
> mistakenly uses the new semantics but expects the old bitmask.
> Generally when something changes semantics that radically, you want to
> make sure the type changes sufficiently that any out-of-tree patch
> that hasn't been merged yet will get a clear warning or error if
> people don't realize.
>
> Please?

Yes.  That will make a very nice change to the patch.

I think I will go with bprm->clear_unsafe_personality_bits or
something to that effect. 

I would really love to have a bit that means creds_changes or
privilegeds_elevated.  But right now we have 2 of two fields that mean
essentially that (per_clear and secureexec) and they don't agree on when
they get set.

I will make them agree as much as possible, and this patchset is a first
step in that direction but until we can actually make them agree, I want
to keep them both grounded in what they do.  That way it is possible to
have a reasonable discussion on when they should be set.

Eric
