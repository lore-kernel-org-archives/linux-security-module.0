Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE396C433DB
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A202A64EA4
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhCDA7l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453092AbhCDApc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 19:45:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305CC061756
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 16:44:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jt13so46049368ejb.0
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 16:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2lURl+ATX2YUjr5q4pNGyS+/f3qF3dd8poyz9I0yIQ=;
        b=Xyfk5/Fcb12V6kDmD7W7v+gn0U2UIIxqZUvsgdHMsg9weJrveD11LiLFqGMLnoZAWY
         d797V0gSBEPNHGBPm3H/ZWJ5iwWaCboHKbBlrJC5HEG54LhvHpzrbloG7JmQDSjtB5+3
         1ho7voJZ0VyS6Vai5CSjlx4B23Xn6866mmeta+7073sgM6V++JYt0Wu3zCwHfAs9JFTg
         dfgzqFT4qD9gtde4ET4GgARvqYmuKCq692BfAzL17C7BSaoH5TNYBEkQnz++yuWfWKl5
         9Qbo8ohGynx4Kl42iGMw5p5hc38c0bysHCCVqvGarWTEeN/5g1xptbxCKikxkWa6zxHA
         8Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2lURl+ATX2YUjr5q4pNGyS+/f3qF3dd8poyz9I0yIQ=;
        b=DrMz0mtCr18rnFUFla+tvq08LH+8m/R+Yjj3Rd6pvyJhbvY4XcTwM/wrWbstfDXd5h
         MDejvNn6OcfeEsrQuEFcQ8XNqWABHZ4Wil+GU455O3JleKPKEhC+S7P2bki6Q23pfvgU
         g1z81asParjnQE2z/WOlivkX4ud19eWtuBFMr0WaXDuEp9r38ercpmuP12eQCIu6qwng
         TBkvisexXHdgFOnxc2EkoWbNG/vZTlvN1Ureg644j5iRNz2rbgNYdZPEWdWtOI/teTmP
         ebHYf0TzCHQpal0sJOA2mMVrL8LJHdshApEgc+fzmuvY6WpsewNG6/1twDASZ2zPUpFX
         jmcw==
X-Gm-Message-State: AOAM533zMcI9gDZgahArWtGbwfuCzHodenjhgKvmEEz6XxSEkkpFJvJE
        vtxRknorb/wmSGxq4+Y6seaLyuOYKTeM7YMwJdt6
X-Google-Smtp-Source: ABdhPJwMWPIfRXVxIBCOjcbnyugYHup2arm1/+oo2mo11V8E1LS5uXyCS7vTs7sOAcv3T7QPJc0OjZwXwqq4GYlQLJs=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr1388093ejb.542.1614818690832;
 Wed, 03 Mar 2021 16:44:50 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
In-Reply-To: <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 Mar 2021 19:44:40 -0500
Message-ID: <CAHC9VhTn33cSX=n7a6kr-5=TKeEx8iRbTY8-2XGxG0YC+GhvaA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 21, 2021 at 7:51 AM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/19/21 3:29 PM, Paul Moore wrote:
> > Of the three LSMs that implement the security_task_getsecid() LSM
> > hook, all three LSMs provide the task's objective security
> > credentials.  This turns out to be unfortunate as most of the hook's
> > callers seem to expect the task's subjective credentials, although
> > a small handful of callers do correctly expect the objective
> > credentials.
> >
> > This patch is the first step towards fixing the problem: it splits
> > the existing security_task_getsecid() hook into two variants, one
> > for the subjective creds, one for the objective creds.
> >
> >   void security_task_getsecid_subj(struct task_struct *p,
> >                                  u32 *secid);
> >   void security_task_getsecid_obj(struct task_struct *p,
> >                                 u32 *secid);
> >
> > While this patch does fix all of the callers to use the correct
> > variant, in order to keep this patch focused on the callers and to
> > ease review, the LSMs continue to use the same implementation for
> > both hooks.  The net effect is that this patch should not change
> > the behavior of the kernel in any way, it will be up to the latter
> > LSM specific patches in this series to change the hook
> > implementations and return the correct credentials.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> So far this looks good. I want to take another stab at it and give
> it some testing

Checking in as I know you said you needed to fix/release the AppArmor
patch in this series ... is this patch still looking okay to you?  If
so, can I get an ACK at least on this patch?

-- 
paul moore
www.paul-moore.com
