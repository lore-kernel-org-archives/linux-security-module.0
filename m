Return-Path: <SRS0=E2Uq=NK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1EECDE44
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Oct 2018 16:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB682081B
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Oct 2018 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ht93vtln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB682081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJaBcO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:32:14 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39783 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJaBcO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Oct 2018 21:32:14 -0400
Received: by mail-yb1-f196.google.com with SMTP id j9-v6so5300159ybj.6
        for <linux-security-module@vger.kernel.org>; Tue, 30 Oct 2018 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZoNZooRaqDzEWaRLEKdrKAAKC6uL0sBgSFjdygxcXA=;
        b=ht93vtlnvVM4sJvsrLS/XVPam18FZGYWOuKhoG7tTU9zDVRzID1jFV+Pax7TEqCHVT
         dD2GI13/VwJzNEyXB7/8NzOxJcAEhXibtqz87TwTH8gKYu86BY5LT62L3bfaUl77oj3n
         iqMPDW4MiC0cW8YiHyGJXjeza4kPQeL5zjHnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZoNZooRaqDzEWaRLEKdrKAAKC6uL0sBgSFjdygxcXA=;
        b=i+Z3I0sS5eHC5ZUCzT7SO0/wPMYirJM8Qj8taPEqpysUi7cS6APcnUumpd1GIQzSfN
         xNc+mr0xpp8IHY81kb74OJd0TNwXGSo0mTTB8aJnGR+AnyFb5vBvlENMRC0RaZKNZXhb
         Trsc8mdgxfvj1yz/u0ZwztNsZE96vTzbslomD6xfQyJgyyFKguacXe2sxnLLVR4JiJVi
         uH9qMrSZUjdQ5FitDWUVlKcGIMHog+hRgzGAKBkmO84mXPANEsiILpl2erwIhLmVmJdg
         8+S64xgLBLFS6rbk1cNW9x3UzVyvdJQt7/dLT7UXfP7K7NcwHkD58Z6HjhvSIxQP0E7p
         qzeA==
X-Gm-Message-State: AGRZ1gKvu2zDS/qIvAKq3y+IuXJEoOycsLIhr1YZkHSkHlnXuDGuLa5r
        ZxeO68jxMVEQXWG/0hsFIkJ8KAuP1tU=
X-Google-Smtp-Source: AJdET5f4mB4Ou+VDQGDou7QYXP6rVVWYdjV4U5GnX0+YPZvZerwz/nweYJ4x48YPFBj+wIrzUzvUCg==
X-Received: by 2002:a25:b78e:: with SMTP id n14-v6mr18942010ybh.510.1540917480933;
        Tue, 30 Oct 2018 09:38:00 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id 123-v6sm5987692ywx.15.2018.10.30.09.37.58
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:37:59 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id l2-v6so666492ywb.9
        for <linux-security-module@vger.kernel.org>; Tue, 30 Oct 2018 09:37:58 -0700 (PDT)
X-Received: by 2002:a81:813:: with SMTP id 19-v6mr3464914ywi.168.1540917477794;
 Tue, 30 Oct 2018 09:37:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 09:37:56
 -0700 (PDT)
In-Reply-To: <20181030152641.GE8177@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 09:37:56 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
Message-ID: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 30, 2018 at 8:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> I suppose the 'normal' attack goes like:
>
>  1) find buffer-overrun / bound check failure
>  2) use that to write to 'interesting' location
>  3) that write results arbitrary code execution
>  4) win
>
> Of course, if the store of 2 is to the current cred structure, and
> simply sets the effective uid to 0, we can skip 3.

In most cases, yes, gaining root is game over. However, I don't want
to discount other threat models: some systems have been designed not
to trust root, so a cred attack doesn't always get an attacker full
control (e.g. lockdown series, signed modules, encrypted VMs, etc).

> Which seems to suggest all cred structures should be made r/o like this.
> But I'm not sure I remember these patches doing that.

There are things that attempt to protect cred (and other things, like
page tables) via hypervisors (see Samsung KNOX) or via syscall
boundary checking (see Linux Kernel Runtime Guard). They're pretty
interesting, but I'm not sure if there is a clear way forward on it
working in upstream, but that's why I think these discussions are
useful.

> Also, there is an inverse situation with all this. If you make
> everything R/O, then you need this allow-write for everything you do,
> which then is about to include a case with an overflow / bound check
> fail, and we're back to square 1.

Sure -- this is the fine line in trying to build these defenses. The
point is to narrow the scope of attack. Stupid metaphor follows: right
now we have only a couple walls; if we add walls we can focus on make
sure the doors and windows are safe. If we make the relatively
easy-to-find-in-memory page tables read-only-at-rest then a whole
class of very powerful exploits that depend on page table attacks go
away.

As part of all of this is the observation that there are two types of
things clearly worth protecting: that which is updated rarely (no need
to leave it writable for so much of its lifetime), and that which is
especially sensitive (page tables, security policy, function pointers,
etc). Finding a general purpose way to deal with these (like we have
for other data-lifetime cases like const and __ro_after_init) would be
very nice. I don't think there is a slippery slope here.

-Kees

-- 
Kees Cook
