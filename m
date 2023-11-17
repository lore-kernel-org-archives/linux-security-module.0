Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B6C197A0
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 10:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjKQKyp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 05:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjKQKyo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 05:54:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15B11D
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 02:54:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c59fa94f72so19817727b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218481; x=1700823281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dLg6+mVmC37ssrB4Zlh997BM9umW3Bgu9aiwvUHj+w=;
        b=qCBBUpL5DV1tsTJv7vbDyjTxC4GTMyshkCIH9gJRQEL2jB6/rLE4GSLjp3jB/UzF7q
         go4gkb44lnx2MoLcXvP+B33jOzeIpvGPUJWwRO2VAZlIAiYKj1CPCdGCY/4QNnfFDLAA
         il2h/blqeDBACvsItxonjWdJ/axaAvxlcmQG5v+lIPCFik2Via7hi+bc6QG3caSZvtxL
         nNGNd/gZrZt7DKL0WGOzZsmw+c5dXvCLfyfghBZ7o1ISFBl3E//Y44cyU9VKuZ7woigX
         18gJa1BiST7KNe+JhICPxCIFGME4jtXw4cpzFiRC1oMW1DAypK1CNiDjjeD3Jq/+m4SH
         Nvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218481; x=1700823281;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5dLg6+mVmC37ssrB4Zlh997BM9umW3Bgu9aiwvUHj+w=;
        b=fxiOjKC13Cw20lKOxH0I7U/PrJXmBt8qWWq8clZSGt7bR8PuDKodmS9UB4ilRDBlvR
         M/nYMNmq2dPg8xih4lhWFPoXtMnAjU1zqDk6Q6qZByPAJj3XeqRfbDWHu7l8hO1Po+1D
         6rzNmBJpBMt0wHmb39tdcIEZSH3PNmQSujIIR83KnZqa5kviVwt51UNvc/pyxlKkz3Zl
         gMY+NTKu7Cn3ekldEB7ErstivDSzh6TrQPkjMo5gy8wJiQYomOVsmjTXQz1NUtKPdrfY
         jJ6Xo5V1M0xOAcxNf7YYPluwzQvT/8aUCmIDXtBV3yKrjGGDawYiUSZ8uFf4bJkmfadT
         8vYg==
X-Gm-Message-State: AOJu0YytZlxZDuFvq7KF33Io9GLosiRvinKFe/v0yeUXJi6hVvmsL+ZD
        jSGjtlhcSaVhnisR9ErCOTt+StH0LdA=
X-Google-Smtp-Source: AGHT+IEe+qh9ywWNkcjvpXZE5ZCy9d0SF9AarStWTxoVHohoAA3VMfSn0NnV7FJXSjK2mrVZKB+wUIx8gMU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:8912:0:b0:d9a:fd29:4fe6 with SMTP id
 e18-20020a258912000000b00d9afd294fe6mr495356ybl.3.1700218480830; Fri, 17 Nov
 2023 02:54:40 -0800 (PST)
Date:   Fri, 17 Nov 2023 11:54:31 +0100
In-Reply-To: <20231116.iho7Faitawah@digikod.net>
Message-Id: <ZVdGZ4kMY7GnoKKs@google.com>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231103155717.78042-2-gnoack@google.com>
 <20231116.iho7Faitawah@digikod.net>
Subject: Re: [PATCH v4 1/7] landlock: Optimize the number of calls to
 get_access_mask slightly
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 16, 2023 at 04:49:46PM -0500, Micka=EF=BF=BDl Sala=EF=BF=BDn wr=
ote:
> On Fri, Nov 03, 2023 at 04:57:11PM +0100, G=EF=BF=BDnther Noack wrote:
> > This call is now going through a function pointer,
> > and it is not as obvious any more that it will be inlined.
> >=20
> > Signed-off-by: G=EF=BF=BDnther Noack <gnoack@google.com>
> > ---
> >  security/landlock/ruleset.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index ffedc99f2b68..fd348633281c 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -724,10 +724,11 @@ landlock_init_layer_masks(const struct landlock_r=
uleset *const domain,
> >  	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level=
++) {
> >  		const unsigned long access_req =3D access_request;
> >  		unsigned long access_bit;
> > +		access_mask_t access_mask =3D
>=20
> You can make it const and move it below the other const.

Done.

> > +			get_access_mask(domain, layer_level);
> > =20
> >  		for_each_set_bit(access_bit, &access_req, num_access) {
> > -			if (BIT_ULL(access_bit) &
> > -			    get_access_mask(domain, layer_level)) {
> > +			if (BIT_ULL(access_bit) & access_mask) {
> >  				(*layer_masks)[access_bit] |=3D
> >  					BIT_ULL(layer_level);
> >  				handled_accesses |=3D BIT_ULL(access_bit);
> > --=20
> > 2.42.0.869.gea05f2083d-goog
> >=20
