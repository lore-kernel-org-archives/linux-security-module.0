Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C657C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A12A207D3
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVghkgRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgFOPru (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbgFOPru (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 11:47:50 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50CC061A0E;
        Mon, 15 Jun 2020 08:47:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so16258067oiy.13;
        Mon, 15 Jun 2020 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ylGNwumtH93sk6ap1x6lmEE198yuK1dm1zAaklJl8g=;
        b=jVghkgRp7hdCYHS8KXn7SZaSC/jlmZ79a/kvSQjohVUBd9++iecOfILVZYG0ToEFhu
         EHKv+4HyTiQfFmvXrvDEoEchH7dnwJSoCcKE7lH1e8orud1FKo1m4DlEoDCZqAh3BvSf
         1SC7+Lg0nynjxJ1hj8JopzoDLH9WFpug1Sll65n/zbAgAepcub06FI8fNHwmhBRPw2Id
         bokYp6rDR/caWB1NUJxZR5zxopPtL2WRW4sA7ddlGVllErbkB+57mxQeog/hlDTZtlS6
         IZVOsZj42fpwZTDhXQ9D8fM1CYQA9z4LhHPwiULVnkd8Nal7ovcPTe+9qxtiTZplsw8P
         ux1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ylGNwumtH93sk6ap1x6lmEE198yuK1dm1zAaklJl8g=;
        b=b6YPBADJRR8WgDM5v2rCfxmwI4hv49+O+kXrFIkIQWctToEhiuHWHKGc4AG8+W59VD
         yxIJaE3h4DJJDPZOQ45ukuDBugqpi7+mArbx/GlWTDhgR8GyrXwOHquh6bm/d+FBHPc3
         wioutkb5uhFF92veKipNcdhttXwA/I2KLUjQT6wdP7vLkeKJcp65CGbHxdGCK6esV4S6
         kvdn2gMAPZxDi4GrHHHv1KWt2bhmhaK5zBwvweosHizLo6SlbGw+ujlLjmIxvvHARL8/
         GUlYSVcn/wIvJe39jqzPoDMO8cN7d2RiXFIPlE2/0C7kBznWzp6sLBwyxuMjvRBt+FKO
         kmwg==
X-Gm-Message-State: AOAM530I1ohmJzptIYq/O3Z/1vp1wN3A0fylLO7TosgKqik0kGkBretz
        wthBzt9LAj5wTRJl9MPt+AmtXOSoXcptCao+jkBj7OCN
X-Google-Smtp-Source: ABdhPJzxziUB41Y3/haG7lsP77O+nHBwMLgKjRaJR0MctPtx2C+lF3qC3uOpgy+nLbeH6Hg5QeSNQUhRRpYuamctHNg=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr8900951oib.160.1592236068457;
 Mon, 15 Jun 2020 08:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-6-nramas@linux.microsoft.com> <CAEjxPJ7v5Lu-vzqg0ZVh8zJ9uZ=odN3jt_5+9d9x+RydsNWK0g@mail.gmail.com>
 <1592233145.11061.129.camel@linux.ibm.com>
In-Reply-To: <1592233145.11061.129.camel@linux.ibm.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 11:47:37 -0400
Message-ID: <CAEjxPJ61dup9HDQny_TAb7we-vcN-sM17y4x0Pos3d7ERaab9g@mail.gmail.com>
Subject: Re: [PATCH 5/5] LSM: Define workqueue for measuring security module state
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 15, 2020 at 10:59 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2020-06-15 at 09:33 -0400, Stephen Smalley wrote:
> > On Fri, Jun 12, 2020 at 10:42 PM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> > >
> > > The data maintained by the security modules could be tampered with by
> > > malware. The LSM needs to periodically query the state of
> > > the security modules and measure the data when the state is changed.
> > >
> > > Define a workqueue for handling this periodic query and measurement.
> >
> > Won't this make it difficult/impossible to predict the IMA PCR value?
> > Unless I missed it, you are going to end up measuring every N minutes
> > even if there was no change and therefore constantly be extending the
> > PCR.  That will break attestation or sealing against the IMA PCR.
>
> Even if it attempts to add the same measurement to the list multiple
> times, unless something changed, there should only be one measurement
> in the list.

Is the PCR only extended once?
