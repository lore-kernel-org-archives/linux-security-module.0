Return-Path: <SRS0=Cnd7=VT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5F3C76190
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403821985
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 22:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IJngLW6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfGVWat (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:30:49 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36259 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfGVWat (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 18:30:49 -0400
Received: by mail-lf1-f46.google.com with SMTP id q26so27869383lfc.3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2019 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AiaXD3U1auZ1486GxBr4ufJjN1xzy+PJm8wSfZTpiA=;
        b=IJngLW6jceZ5XlRkGFJ+atHpEnUk3gBCdO1HB19R8Tjv55JMtKniQNYz52SGNSY9my
         BIJH1Rqa8HV/03WAp09IhSNVwgaTy/9IpaL/+4U97x4BF/d3lNhsAefB5RUTmsUqwpmw
         Wo101Jyb7sHEFw7i+SE6dj8yTWyMO5tWct/leXN6+5nGLWlRfRhv8oRh2QQs1ZH/zwuZ
         rXDNYRQ1fdBThbise7ZX714BvnPARntfyXJOZDoixnx5xs5yD+8rMnOM9vuMy3H6inL4
         fbTwbWE7bUV3h5q6/YjfJEd9EGtlfm2SjI7O1y0OOtnBQnerKFEeKTtQYSHm+ZuoUXbq
         tM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AiaXD3U1auZ1486GxBr4ufJjN1xzy+PJm8wSfZTpiA=;
        b=l56/YikzUJxRGd4JVq0SifO+0iziMMOdEPnaE8VkGhvfdRuaki8TkoF5UCHlpTipbG
         qwUZkQWMPISbrYny7yzciD+U/DKbioHq4wLFp8vF06PnjIljPtxuU/c1S9f8ov6uCebM
         3Q/Otjl9KRlcIhS7SUgItr7WtHo64CVlKrCVl/CF6szMIsrAdIUDBqeDmjPwXzK2BHHn
         ahmPSceVM4oob+KSuc8dN+B0ny8OuAmy/DxPwcYaIDIhQFrcklsRDLiS7HtdK1BemI+Y
         n/i7PMrTxKECBLIg443eqAjb78drOqylyiIWh2yYYqpVnesly4CMMWYupqTB4B4THErf
         gnNA==
X-Gm-Message-State: APjAAAUEcGn8ooCCS1sgB2BetjRhbD10kk4W0J0WMFNOVlDIe5tEQNhS
        W/81BimICFCF1K6LWPh0uaxRkyYz8OXsNNLauQ==
X-Google-Smtp-Source: APXvYqwlGoXpZwxfgO/t/CjwBYYUj9u/rNilXIAAyazjWiXI/o083lCsGSopA1Fq2OuvHxyEr6uIkkI/lkm9spiOWfI=
X-Received: by 2002:ac2:4644:: with SMTP id s4mr32747861lfo.158.1563834647239;
 Mon, 22 Jul 2019 15:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2> <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com> <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com> <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com> <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
 <alpine.LRH.2.21.1907230649460.18217@namei.org> <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com>
In-Reply-To: <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Jul 2019 18:30:35 -0400
Message-ID: <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 22, 2019 at 6:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/22/2019 1:50 PM, James Morris wrote:
> > On Fri, 19 Jul 2019, Paul Moore wrote:
> >
> >>> We've never had to think about having general rules on
> >>> what security modules do before, because with only one
> >>> active each could do whatever it wanted without fear of
> >>> conflict. If there is already a character that none of
> >>> the existing modules use, how would it be wrong to
> >>> reserve it?
> >> "We've never had to think about having general rules on what security
> >> modules do before..."
> >>
> >> We famously haven't imposed restrictions on the label format before
> >> now, and this seems like a pretty poor reason to start.
> > Agreed.
>
> In a follow on thread
>
> https://www.spinics.net/lists/linux-security-module/msg29996.html
>
> we've been discussing the needs of dbus-daemon in a multiple LSM
> environment. I suggest that if supporting dbus well is assisted by
> making reasonable restrictions on what constitutes a valid LSM
> "context" that we have a good reason. While there are ways to
> present groups of arbitrary hunks of data, why would we want to?

I continue to believe that restrictions on the label format are a bad
idea, and I further believe that multiplexing the labels is going to
be a major problem that will haunt us for many, many years.  If we are
going to support multiple simultaneous LSMs I think we need to find a
way to represent those labels independently.

-- 
paul moore
www.paul-moore.com
