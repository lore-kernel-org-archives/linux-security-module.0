Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EAC10F14
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371B2084B
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNl6S5Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfDJRrx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:47:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36272 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfDJRrw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:47:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so2547083oia.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xlE/MeMOtkOYINoGZHz3neKDjYf8U0w+oX0KimhL0M=;
        b=sNl6S5Xm+ncHqGdUrDXvRpnv5j0SicAivew/0GWGSHgG26qfemamEHUuBb9wPUyGuU
         U7poZFGmgupywj0K1C7bfpKXiRrOBVH0uzC+rQTDXxh/g94gztys8/cWxckz6DcPhLny
         h7NxDdT7VRMOdfba7fI7rUizbJA0qq5RDdR47BLU8ls9g+HX+mxXLHJyjmFNf5X8wPI1
         a+hCs/kwxYbHLt8xY4osdXAhdaAVguyqvrkNm5nu3srzq6B3/2sZkHyif+KL6clAJ1or
         FHJa+c5e5Gbatm6ZfM2s8Rjrc9KEnZGy8HFV+1J5AzPyzJE/7bfUZAT8E7uX+h3KfE6l
         sojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xlE/MeMOtkOYINoGZHz3neKDjYf8U0w+oX0KimhL0M=;
        b=VGMdBaV3rwpnRT3R3VgblcsiOuIAMxKTaEpqCS09+GxJEvpMJl30uMePwpNHf5k0db
         EgVOlIRy7scQnCrGyyXmc7pq/nNtN9Mre/10F0tYV4JbuXT/Qh0ggqHVvdQPIJK4u9IF
         OxD7suE2jdR2BsRAkK6bANxZiYhy6Z9sALBzNLvi14HTRIHGwLMV6nqsaqWYM2AL4nIF
         Z22c4XYE14GSBJgE+zPx9LgcnXz+rq3/NoPjGeTVKPA11kjaaRGYVe/7X938QT7bK+4P
         Mjxnv3Um17tCrfmh8lkFureyRLcsxFhlf3KECdTupuO1TngkC/wsZia5wnnP7Y9mub2e
         /luQ==
X-Gm-Message-State: APjAAAVnpSQijV5z/NV+iHnUORvqaAmbEV8ri0mcuQCSzS5pzUPtIHU5
        CDabR410XWPm/sXPkZKKCU11MUvZ4Ji0QAkFxUIiIQ==
X-Google-Smtp-Source: APXvYqwVD2o9qNviNoYWbdvXBEU8INtXbtED0HBCJDK7QzJnmvZYPK1BC+VTcU62WTf6oxIVsAt+bvxHUDn+sV//O8E=
X-Received: by 2002:aca:e18b:: with SMTP id y133mr3678223oig.157.1554918470749;
 Wed, 10 Apr 2019 10:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165605.211749-1-mortonm@chromium.org> <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
In-Reply-To: <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Apr 2019 19:47:24 +0200
Message-ID: <CAG48ez0a6iyw_TCF2aY4ADbiveaAy+tZeiKjT0j7+36qC6W_og@mail.gmail.com>
Subject: Re: [PATCH 07/10] LSM: SafeSetID: rewrite userspace API to atomic updates
To:     Kees Cook <keescook@chromium.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 7:24 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> > From: Jann Horn <jannh@google.com>
> >
> > The current API of the SafeSetID LSM uses one write() per rule, and applies
> > each written rule instantly. This has several downsides:
> >
> >  - While a policy is being loaded, once a single parent-child pair has been
> >    loaded, the parent is restricted to that specific child, even if
> >    subsequent rules would allow transitions to other child UIDs. This means
> >    that during policy loading, set*uid() can randomly fail.
> >  - To replace the policy without rebooting, it is necessary to first flush
> >    all old rules. This creates a time window in which no constraints are
> >    placed on the use of CAP_SETUID.
> >  - If we want to perform sanity checks on the final policy, this requires
> >    that the policy isn't constructed in a piecemeal fashion without telling
> >    the kernel when it's done.
> >
> > Other kernel APIs - including things like the userns code and netfilter -
> > avoid this problem by performing updates atomically. Luckily, SafeSetID
> > hasn't landed in a stable (upstream) release yet, so maybe it's not too
> > late to completely change the API.
> >
> > The new API for SafeSetID is: If you want to change the policy, open
> > "safesetid/whitelist_policy" and write the entire policy,
> > newline-delimited, in there.
>
> So the entire policy is expected to be sent in a single write() call?
>
> open()
> write(policy1)
> write(policy2)
> close()
>
> means only policy2 is active?

No; if you do that, the first write() sets policy1, and the second
write() fails with -EINVAL because of the "if (*ppos != 0) return
-EINVAL;" in safesetid_file_write() (which already exists in the
current version of the LSM).

> I thought policy was meant to be built
> over time? i.e. new policy could get appended to existing?

That's what the current API does; as I've explained in the commit
message, I think that that's a bad idea.

Are you asking because you have a usecase where you actually want to
"append" rules after loading an initial policy?
If so, I think that the simplest way to do that would be to have
userspace concatenate the policies and then shove the result of that
into the kernel. Otherwise:
 - you'd need a way to distinguish between policy replacement and
appending to policy
 - to securely replace an existing policy, userspace would always have
to concatenate all the new policy fragments anyway
