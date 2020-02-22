Return-Path: <SRS0=jUed=4K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84FC35669
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 04:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240BC208C4
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 04:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WbIUIWw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBVEXE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 23:23:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33544 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVEXD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 23:23:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so2753547pjs.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 20:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sj8CQVSI+XR7Um9F3+oX5kyZ8ufj2uz32S5QnSkl8nI=;
        b=WbIUIWw19p2K2eTy6btqRA0hRhGmFBu5LIhJBDehwobrUKrAznBqiLvZYsjd6Z7HaR
         vHze/JEuw4Ek/ZFX7VqoeOKryl2Bn/uNxlvs64FGC99dFHpjp1ADrFxQqdZH5VzNecBY
         0LYVEespIJc3kfSbcYi/+iuH035Rgi6fARsjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sj8CQVSI+XR7Um9F3+oX5kyZ8ufj2uz32S5QnSkl8nI=;
        b=Isn1tEMvIYG7PIWrHBJ/9xQwJT/PTuvPbXMnrY6OuuTkJ0Cklr/C4JBMXxZGkrnBmb
         Z2gjIXodPLryEAm9vMqO8yNVpiId57tzHcwUkr70lGya/W/rUIr9hgdN8S6t8lBUE93h
         NRDCRTuDwo86FF6j60qQVXKJ7guKiEZPiYvFNcY1gWTLm/OQR5Vqa0n1xqvDDCGlRcqO
         Cwjgh7tg0J828FcMpRx0BM6vdLdsj1/HuTmKf3lBrfm4tBagnAW66nztAtkD8H0HxMfF
         6vmaLpRo8G+IaUdmWqJo8iQ6PQF0FO5GbmEi7JhBp3z290PNjEIrfp/eX2JEau/QLIxF
         430w==
X-Gm-Message-State: APjAAAUOOIKlInyuBzCSNmlwVFV7alTJuAK+So8IyfdE9svPALECI6s8
        qemzFz5R/gEXiPG03nQfs0OxNw==
X-Google-Smtp-Source: APXvYqwl0wb5CrweSL5pMD4VOtn8tqiqcUhm53HOTl+wJjtOKlFhN1GBrqKziehHryVuUgUBJ4QtPA==
X-Received: by 2002:a17:902:14d:: with SMTP id 71mr35871887plb.162.1582345381707;
        Fri, 21 Feb 2020 20:23:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm4055057pjx.10.2020.02.21.20.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 20:23:00 -0800 (PST)
Date:   Fri, 21 Feb 2020 20:22:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202002211946.A23A987@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 20, 2020 at 03:49:05PM -0800, Casey Schaufler wrote:
> On 2/20/2020 9:52 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> Sorry about the heavy list pruning - the original set
> blows thunderbird up.

(I've added some people back; I had to dig this thread back out of lkml
since I didn't get a direct copy...)

> > The BPF LSM programs are implemented as fexit trampolines to avoid the
> > overhead of retpolines. These programs cannot be attached to security_*
> > wrappers as there are quite a few security_* functions that do more than
> > just calling the LSM callbacks.
> >
> > This was discussed on the lists in:
> >
> >   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266
> >
> > Adding a NOP callback after all the static LSM callbacks are called has
> > the following benefits:
> >
> > - The BPF programs run at the right stage of the security_* wrappers.
> > - They run after all the static LSM hooks allowed the operation,
> >   therefore cannot allow an action that was already denied.
> 
> I still say that the special call-out to BPF is unnecessary.
> I remain unconvinced by the arguments. You aren't doing anything
> so special that the general mechanism won't work.

If I'm understanding this correctly, there are two issues:

1- BPF needs to be run last due to fexit trampolines (?)

2- BPF hooks don't know what may be attached at any given time, so
   ALL LSM hooks need to be universally hooked. THIS turns out to create
   a measurable performance problem in that the cost of the indirect call
   on the (mostly/usually) empty BPF policy is too high.

"1" can be solved a lot of ways, and doesn't seem to be a debated part
of this series.

"2" is interesting -- it creates a performance problem for EVERYONE that
builds in this kernel feature, regardless of them using it. Excepting
SELinux, "traditional" LSMs tends to be relatively sparse in their hooking:

$ grep '^      struct hlist_head' include/linux/lsm_hooks.h | wc -l
230
$ for i in apparmor loadpin lockdown safesetid selinux smack tomoyo yama ; \
  do echo -n "$i " && (cd $i && git grep LSM_HOOK_INIT | wc -l) ; done
apparmor   68
loadpin     3
lockdown    1
safesetid   2
selinux   202
smack     108
tomoyo     28
yama        4

So, trying to avoid the indirect calls is, as you say, an optimization,
but it might be a needed one due to the other limitations.

To me, some questions present themselves:

a) What, exactly, are the performance characteristics of:
	"before"
	"with indirect calls"
	"with static keys optimization"

b) Would there actually be a global benefit to using the static keys
   optimization for other LSMs? (Especially given that they're already
   sparsely populated and policy likely determines utility -- all the
   LSMs would just turn ON all their static keys or turn off ALL their
   static keys depending on having policy loaded.)

If static keys are justified for KRSI (by "a") then it seems the approach
here should stand. If "b" is also true, then we need an additional
series to apply this optimization for the other LSMs (but that seems
distinctly separate from THIS series).

-- 
Kees Cook
