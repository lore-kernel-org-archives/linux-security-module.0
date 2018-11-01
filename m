Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9EC0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 01:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C4D2064C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 01:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOsPlqrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C4D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeKAKNn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:13:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35638 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeKAKNn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 06:13:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id w135-v6so5067427ywd.2
        for <linux-security-module@vger.kernel.org>; Wed, 31 Oct 2018 18:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kfZv1noKDNsYODE6bbzMlrs6X6ZlKzXF3RZ/uRtUZc=;
        b=QOsPlqrN8kPdUtwrqmkqWVuLYY+9PLDtI0+70sqY0a+HytmFzdQga5BlUS7JNVrldY
         nvckUWXeej5hL8fJovqa9eCtJENx7yxGMIQZaFVoOxuBiNUgkJ5bSi6HU7gAToN4ZzL4
         LFp4XyL0yvUsHMTgd+Tcm8pQY4BL9DG80JdvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kfZv1noKDNsYODE6bbzMlrs6X6ZlKzXF3RZ/uRtUZc=;
        b=jfF9AcHx7lFTuF8nBzURR9Tp9S9dg4S4mUJCKMvoNakSZ/uVEQrIofIMW3vgcBe+3E
         UZVH5IcV4ghLm5RmSybR0wkkcq/S+c2f6y/Exd49/ZvyhqYzbDToEKf3lhBtOOfL9JC3
         0PSwzntskNNM+HtURAF/eO5VyLm9UIM17YogSYaXIvkiy6GJeZgNdnT4RfL9Ls3pyrEf
         2K3fW/dM9OGVrRnPlJ496FPqGeX354I4F5s9K7ZAh7kHxor/jj7XjmwW0Lppd8bxKpa6
         1rizDWMg0wJrEej9Hxyfn9hN9hdKjtvd9nLHist8FocyAWvvIvHJeGIM1mm6pcOobo90
         kRug==
X-Gm-Message-State: AGRZ1gKvMEOsqcjkXfT+gN/fWUsfvi8WBVdvVh7q3SGpLhXc6ilAHK3D
        BMKSiy++bl4J8hJHNnVxI1FNv6cyGmbbqLOYp+PGpg==
X-Google-Smtp-Source: AJdET5f6rXmbBGm+rI0Knz6EJV8MAMewkDwu0d/zg2rG5JgKaBZ5mm0qkmWXzuCcivYOSP6FB+OSjptfyoOMGWdCP9Y=
X-Received: by 2002:a81:34d0:: with SMTP id b199-v6mr5357662ywa.322.1541034777590;
 Wed, 31 Oct 2018 18:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com>
 <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com> <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com>
In-Reply-To: <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 31 Oct 2018 18:12:46 -0700
Message-ID: <CAJ-EccPCxi1Fn-TVnGHBADKuoSi3XC0_UAkXRk49+iTjoLoecA@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     casey@schaufler-ca.com
Cc:     Kees Cook <keescook@chromium.org>, serge@hallyn.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 31, 2018 at 3:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 10/31/2018 2:57 PM, Kees Cook wrote:
> > On Wed, Oct 31, 2018 at 2:02 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> Just to be sure - your end-goal is to have a set of tasks which have
> >> some privileges, including CAP_SETUID, but which cannot transition to
> >> certain uids, perhaps including root?

Correct, only whitelisted uids can be switched to. This only pertains
to CAP_SETUID, other capabilities are not affected.

> > AIUI, the issue is that CAP_SETUID is TOO permissive. Instead, run
> > _without_ CAP_SETUID and still allow whitelisted uid transitions.

Kees is right that this LSM only pertains to a single capability:
CAP_SETUID (future work could tackle CAP_SETGID in the same fashion)
-- although the idea here is to put in per-user limitations on what a
process running as that user can do even when it _has_ CAP_SETUID. So
it doesn't grant any extra privileges to processes that don't have
CAP_SETUID, only restricts processes that _do_ have CAP_SETUID if the
user they are running under is restricted.

>
> I don't like that thought at all at all. You need CAP_SETUID for
> some transitions but not all. I can call setreuid() and restore
> the saved UID to the effective UID. If this LSM works correctly
> (I haven't examined it carefully yet) it should prevent restoring
> the effective UID if there isn't an appropriate whitelist entry.

Yep, thats how it works. The idea here is that you still need
CAP_SETUID for all transitions, regardless of whether whitelist
policies exist or not.

>
> It also violates the "additional restriction" model of LSMs.
>
> That has the potential to introduce a failure when a process tries
> to give up privilege. If 0:1000 isn't on the whitelist but 1000:0

As above, if a process drops CAP_SETUID it wouldn't be able to do any
transitions (if this is what you mean by give up privilege). The
whitelist is a one-way policy so if one wanted to restrict user 123
but let it switch to 456 and back, 2 policies would need to be added:
123 -> 456 and 456 -> 123.

> is Bad Things can happen. A SUID root program would be unable to
> give up its privilege by going back to the real UID in this case.
>
