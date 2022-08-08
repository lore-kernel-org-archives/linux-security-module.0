Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDEC25B0E
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 22:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbiHHWrh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbiHHWrg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 18:47:36 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7F1929A
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 15:47:32 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10e6bdbe218so12139266fac.10
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xgr1zcvVw2pumc5i5OyXUSrHvFDN2EKwHe94fGDtFRc=;
        b=SpIxuRBySHLiJnzlZCqbG6d10oLBSB6+sdgZ2x0xGqg9Qwam4ErXCCwXAKSMe60/qQ
         LXKVAHne5E6sMcti6T8BzKOmUlluVg+91nYIVsD/0Gx3/1Rh2GpuPw9yoGoFsgMlDreE
         Hyl7ji9Dex0sOxkL7gyZ6yKDSJMbl0988qMpWHJVC/avb0dk6uwrDgie4XTtnptBThSh
         Up1jSUYskmN+BE7RpU+76YeIe2h9UEMKds5itTlwRZM2KUpbnrIwFoatEQqlk2f3vpqS
         XUCZ38YIDNDrGV3oUTW23sBHHU+JWpi09zppu2VYozxXeu5uN48iLjgdfOfOEWtu5/ZA
         oTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xgr1zcvVw2pumc5i5OyXUSrHvFDN2EKwHe94fGDtFRc=;
        b=m3ASqmLe4gp2gI5iZfXCFKhEyFZpX3H/YYBvMrEdBENBudbrnBZ8vG/DTRml/jKo+U
         Q2ehKW3hYTmDaOTouR5t7eiogVlO/3Hxn64tJVENnlhHdIAlf9BjU0HvE/zeXEp1b8Mm
         Izd1PmMOgJX7vC65WFinP5WaoRh8N0pE/Qad4YBJQOCBlrPX3+hHqXGerC4D7BAuQOWg
         B0h3OU70pt5WuarSi/RhmtGlfeDDL9WuY32zvSU583QDXhHThftY/+RpNZwQ3EtH9RTS
         795+3wMJ+AHKdV46bBECxC9A9cnQNcjOHnZf/5yMKI3fpJvGt3EBQRjsElA5gOdG6up8
         pcTA==
X-Gm-Message-State: ACgBeo0r/QN1SJ/XK7Wrl1UQhMZCbl4DiN+DzKp0bw2raoX56GPXV/YN
        DVjHQgMgSGICwuKTlpXeOPf/gVggvMgQKnmPRDA4
X-Google-Smtp-Source: AA6agR4xuYwVmCC3J5R5EIaV2vMNU+sZEdEaDmuaoGD6OS/1cZ5bdac1//FK/Z+H/JjLJ5ZJ0b1/X9olSD/ppX1e9zM=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr2571672oap.136.1659998852083; Mon, 08
 Aug 2022 15:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
 <87wnbia7jh.fsf@email.froward.int.ebiederm.org> <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
 <877d3ia65v.fsf@email.froward.int.ebiederm.org> <87bksu8qs2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bksu8qs2.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Aug 2022 18:47:21 -0400
Message-ID: <CAHC9VhTEwD2y9Witj-1z3e2TC-NGjghQ4KT4Dqf3UOLzDcDc3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 8, 2022 at 3:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> >>> I did provide constructive feedback.  My feedback to his problem
> >>> was to address the real problem of bugs in the kernel.
> >>
> >> We've heard from several people who have use cases which require
> >> adding LSM-level access controls and observability to user namespace
> >> creation.  This is the problem we are trying to solve here; if you do
> >> not like the approach proposed in this patchset please suggest another
> >> implementation that allows LSMs visibility into user namespace
> >> creation.
> >
> > Please stop, ignoring my feedback, not detailing what problem or
> > problems you are actually trying to be solved, and threatening to merge
> > code into files that I maintain that has the express purpose of breaking
> > my users.
> >
> > You just artificially constrained the problems, so that no other
> > solution is acceptable.  On that basis alone I am object to this whole
> > approach to steam roll over me and my code.
>
> If you want an example of what kind of harm it can cause to introduce a
> failure where no failure was before I invite you to look at what
> happened with sendmail when setuid was modified to fail, when changing
> the user of a process would cause RLIMIT_NPROC to be exceeded.

I think we are all familiar with the sendmail capabilities bug and the
others like it, but using that as an excuse to block additional access
controls seems very weak.  The Linux Kernel is very different from
when the sendmail bug hit (what was that, ~20 years ago?), with
advancements in capabilities and other discretionary controls, as well
as mandatory access controls which have enabled Linux to be certified
through a number of third party security evaluations.

> I am not arguing that what you are proposing is that bad but unexpected
> failures cause real problems, and at a minimum that needs a better
> response than: "There is at least one user that wants a failure here".

Let me fix that for you: "There are multiple users who want to have
better visibility and access control for user namespace creation."

--
paul-moore.com
