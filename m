Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A5EC43332
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Mar 2021 03:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DF764F62
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Mar 2021 03:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhCSDpJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhCSDpI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 23:45:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08777C06175F
        for <linux-security-module@vger.kernel.org>; Thu, 18 Mar 2021 20:45:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l18so954100edc.9
        for <linux-security-module@vger.kernel.org>; Thu, 18 Mar 2021 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gH56y5tN3VhV3eYESuoxK3YVZdnW4Sq8fSdr3NNrHfc=;
        b=U8xUdDsLT+UKtYiLtLPw63ZUTkHXjqeX5LTd33Z6Gat5rHugfVPokjSIJfjRFPLJPi
         B8GFu0B0aB7/Awg2L3/8bjSgAT22kr+OHxLTndCm0wyWutlD7uRJqSLsgUgNP9vfIB+z
         aorf/2i+0NYY5E0o78bhRfjLFEM0s1WAfv4VWKUQN9u6S/czaSlNkZBFcwPDKh8mBZbk
         JQUVMp/SbAuSMlxgrHOBm/b+Lc31WyTDoZsBZux7LkXRplOHAzqYMBbpUXYiZE4pMjOZ
         ETQPtKUcmPDQqRkE6xvyXyG+KE3xdtPkTPJdOJrnIl2xssF47Vqda9FVqMVUTfGWvQAE
         nQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gH56y5tN3VhV3eYESuoxK3YVZdnW4Sq8fSdr3NNrHfc=;
        b=omw3D6JbA9K1doVdstsVrW+eP7rzcCUrBAQn0t9cblikH/QwkX1sU69f/oI/CZguHE
         mPoyI5mdajkySeU/1lFNp8L8RMTzZujz0DsLxxPkVfUPRbpCLMNAESfLZVs3aZhbxcDu
         LcDt18eufFDSU5u9RPAEh8wr3Ag9Af7saR2wT2rgAolEIJqTAXrkqaz0STOB00QMdCb1
         Oq9me7InYFdYLjWzl+3/NC2CkvcKeEaDZaZbLgAElMT12woT56jQSggyHJB4xUttOLGG
         9cWoPRbmrnoKyk86+88mWYHAw7WBe7E2meGndCjDFQJwBPDMM0o8GslCGBB/aEHs0wla
         V80w==
X-Gm-Message-State: AOAM53099AelE2ZhpbFRbk/3i+rAt1MRPbJj2Ctrjtn0kCoqSP33VJZK
        pmYUsd57YvVy46FwSMf+aLAw448MGdt5UCGrt1Jg
X-Google-Smtp-Source: ABdhPJxRyakmRDyGmvBwmQoGkXrWod+YzXFuUXn+rynv1HOHXui+p7xRL7K8A/WglEYQgJKpYoxDFJRDgdiwWC//Gx4=
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr7272432eds.31.1616125506563;
 Thu, 18 Mar 2021 20:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <161609713992.55424.6906498317563652734.stgit@olly>
 <161610014360.55424.10461367636187076938.stgit@olly> <a3ec6fb4-d0ef-e0ae-d91b-8b92c4d81fbc@schaufler-ca.com>
In-Reply-To: <a3ec6fb4-d0ef-e0ae-d91b-8b92c4d81fbc@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 23:44:55 -0400
Message-ID: <CAHC9VhQEoZVMP9kc224PMsGjkEt0OfYtyr_7D8AArM2xX4U8VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 18, 2021 at 4:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 3/18/2021 1:42 PM, Paul Moore wrote:
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
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com> (IMA)
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

-- 
paul moore
www.paul-moore.com
