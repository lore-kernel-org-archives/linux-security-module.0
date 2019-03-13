Return-Path: <SRS0=LsZi=RQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E90C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE82087C
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 13:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XRIyjPzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfCMNSL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:18:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35281 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMNSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Mar 2019 09:18:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id t13so1533100lji.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 Mar 2019 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKJ17L++T5ftdGVG4TjT+kkEUH2kIFIEXGfSeLVM4Vo=;
        b=XRIyjPzZTC6J511h3V5tBcD3CjJsZZIVf0k3TcwLLuXL9+7ein9Att5RRUkMUHdQGP
         kLP7A9X376i1i+gZ3QfNerUuCoL8ezc89M9vC4CEbuHwjsm+PnB0T6nmj0kJ7NidP9uc
         YvfTPFftt7hoUsDi7M7FgHST1NyLqKt+jJOi5AXwZIq7vHcggbee53EQv1pZJnebErer
         M1K8XUCl51yywwc2G7nuKxow8hnumltabDLYJqE5oLPQVpItOTYIvWAjOA/9mhud0mEp
         nP+tk2JJoQlZYQc4UsN404WFV7OFAxCyL/GhjWE77sKcseC0m0EUEQLK/D9fJPAqSS9z
         R9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKJ17L++T5ftdGVG4TjT+kkEUH2kIFIEXGfSeLVM4Vo=;
        b=CwZD/qGKAXJ+lkRLAtflH59FBfBmEflZTAZoCwu+lIbQkbc5kU2KnPPDv888G2RCYC
         Vjqu+D7eQknlitGCppU/VSKs8yh8RlwE4faUQ1GYvb//Ji2rQt4SOPtbFNOQri0qzu8/
         QeVGkEsjg9V40kbSciBg4uCMroZzdT2BlT1TwylLRKmWZu7nTSacuCpF5htSbBFmRCdY
         jm0sfjA7HjhC8npASThPMg46WKl8BzPW9HljDqSQ4QcKV4zrhyRcGzadqjHUmL04hgyI
         Vv7iW9UoMOZRHj3Wnt5YxHEHJf6S3x/b+ttkJtqvRL52F9g+ICG0RZb2XB7+/W6BUYLE
         +AYg==
X-Gm-Message-State: APjAAAW7fs6yL28HmAuGkzZvo7CE4hreyBvNBDfqTR1PtPB6Ui0IEsn5
        sZfBhlUwlF2J5v2C0cCkBchChiEu3uAReCiOiMMx21s=
X-Google-Smtp-Source: APXvYqwWo4gxYSvPTUZm3JpBI8oyuWeJrALtkxJP+96kyJsMRThpmQy7kwe96fsGPZJHadoKft9dCmtMWHMt0e9w5no=
X-Received: by 2002:a2e:9001:: with SMTP id h1mr23285528ljg.5.1552483088538;
 Wed, 13 Mar 2019 06:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1903130519440.27366@namei.org> <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1903130821250.2172@namei.org> <8c586ed0-e9ee-a450-df06-3257cdf657ad@i-love.sakura.ne.jp>
In-Reply-To: <8c586ed0-e9ee-a450-df06-3257cdf657ad@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Mar 2019 09:17:57 -0400
Message-ID: <CAHC9VhRMcdk5yAc0xoJ1nMfj7KAcktKmQ1GSYP2C4yRzqS9PFA@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 13, 2019 at 6:29 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2019/03/13 6:24, James Morris wrote:
> > On Wed, 13 Mar 2019, Tetsuo Handa wrote:
> >
> >>> I don't understand the logic here. If the cause of this is no policy
> >>> loaded combined with running out of memory, shouldn't the no-policy issue
> >>> be dealt with earlier?
> >>>
> >>
> >> This patch is for automatically loading minimal policy at boot time
> >> in order to address the no-policy issue. By applying this patch, syzbot
> >> can test TOMOYO module without modifying userspace to load TOMOYO's policy
> >> when /sbin/init starts.
> >
> > If syzbot is trying to test Tomoyo and this requires policy to be loaded,
> > shouldn't it do that?
>
> SELinux has disabled/permissive/enforcing modes.
> And syzbot is testing SELinux in permissive mode, isn't it?

I've lost track of what syzbot currently does, but in the beginning it
ran with SELinux enabled (probably in permissive mode, but that isn't
important here) without a policy loaded and that caused a handful of
problems which we have since fixed.  While it is not recommended, you
should be able to safely run a SELinux enabled system without a policy
loaded.

> TOMOYO has disabled/learning/permissive/enforcing modes.
> And syzbot will test TOMOYO in learning mode.
>
> This patch is required for telling TOMOYO to run in learning mode, by
> loading minimal policy, without asking userspace to run policy loader.
> This patch is easier than asking syzbot users to update their filesystem
> images in order to embed policy loader and minimal policy into their
> filesystem images.

-- 
paul moore
www.paul-moore.com
