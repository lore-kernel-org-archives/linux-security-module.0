Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4834EC197A0
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 10:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjKQKwQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 05:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQKwQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 05:52:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F311F
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 02:52:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b1ff96d5b9so25407107b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218331; x=1700823131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVbUiclfv/LBpx5USXusisaeNMmKJ9RM6pmhgHqWsWI=;
        b=xDW+ckKo/ealQSFF3svsoGZ8IZoxfgPDffGGPJPs84pLxj1dK0jbhMRHEQHyPEMqw2
         LncQjbG9qdVx+aGbWgYUWVmc7xwJuY5YnD+HRB9MWZILELkhS2konUlWFl+ZOAaPsWAm
         bDzIyL6J94eK+c8npMno0sWY2SbhmrojVtGG8bvonZfT78ySoqbt1U8syypfSqbzpkmn
         eOPb5j54Y2HhEvr7zyc5R1kAN+gMQF7G4Rv8O9xqEW2gkO4rvHBULBI6hFKprMCXykIG
         2bBySna3khs12PTQwdEG3Fzkqwu9imSEmsG7WpKgivOuFezgnieYVfZB0uL4y/oLYPAj
         M0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218331; x=1700823131;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cVbUiclfv/LBpx5USXusisaeNMmKJ9RM6pmhgHqWsWI=;
        b=Mre7Ea0ntqXMwc3TkZIBZVxRRxBsoOCzRqVT9L6QpMyHgx3mlWZvh8srY/coaLLyJw
         IaG+KsGW3S5uVeTFkxU8imLHwVCHzW+cxFRw0SsPE/ej7V26o5co4vzhKDVAURyH+BdF
         Z3UBnpJCtGnvqfwUtnh43dvVMRYgHLbEw9nzSIxBeVDYSao/Hx1LCZPeN1ZHalWQF5Ns
         nC8XFa5/AHVLjnmV2mnzBV38Lu19YXf6C9wC8OGhXEDdgiEzCu3T0V4JLmeo4CpeKzYc
         dXlhocFZOnoDOiEA4heMDPRzyiI93YT6YegPloasGxQ+O30OdhvN491ZhDMAT27xw2R9
         9mMw==
X-Gm-Message-State: AOJu0YzMPjH+qEwO6/WnZ0MsS/osY0wbxtYgXL43Tzc/c+KUgtyosEux
        ZD6hjyLDa3G47Crid9itXo0nrHKV84k=
X-Google-Smtp-Source: AGHT+IGOMaaGpIhtMNtTmSNCS3V3Cq0J7GN0OkmZS4fkGfl9rHJWZHClHsnqcdWTYfhkwebFYim5TjH1sYc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:9e0e:0:b0:d9a:5b63:a682 with SMTP id
 m14-20020a259e0e000000b00d9a5b63a682mr480664ybq.13.1700218331714; Fri, 17 Nov
 2023 02:52:11 -0800 (PST)
Date:   Fri, 17 Nov 2023 11:52:03 +0100
In-Reply-To: <20231103.zoxol9ahthaW@digikod.net>
Message-Id: <ZVdF02XuV3B86UlE@google.com>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231103155717.78042-7-gnoack@google.com>
 <20231103.zoxol9ahthaW@digikod.net>
Subject: Re: [PATCH v4 6/7] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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

Thanks!  (I see you fixed these two on mic-next already.)

On Thu, Nov 16, 2023 at 04:50:03PM -0500, Micka=EF=BF=BDl Sala=EF=BF=BDn wr=
ote:
> On Fri, Nov 03, 2023 at 04:57:16PM +0100, G=EF=BF=BDnther Noack wrote:
> > Add ioctl support to the Landlock sample tool.
> >=20
> > The ioctl right is grouped with the read-write rights in the sample
> > tool, as some ioctl requests provide features that mutate state.
> >=20
> > Signed-off-by: G=EF=BF=BDnther Noack <gnoack@google.com>
> > ---
> >  samples/landlock/sandboxer.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.=
c
> > index 08596c0ef070..a4b2bebaf203 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***c=
onst path_list)
> >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL)
> > =20
> >  /* clang-format on */
> > =20
> > @@ -199,7 +200,8 @@ static int populate_ruleset_net(const char *const e=
nv_var, const int ruleset_fd,
> >  	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> >  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> >  	LANDLOCK_ACCESS_FS_REFER | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL)
> > =20
> >  /* clang-format on */
> > =20
>=20
> #define LANDLOCK_ABI_LAST 5
>=20
> > @@ -317,6 +319,10 @@ int main(const int argc, char *const argv[], char =
*const *const envp)
> >  		ruleset_attr.handled_access_net &=3D
> >  			~(LANDLOCK_ACCESS_NET_BIND_TCP |
> >  			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
>=20
> __attribute__((fallthrough));
>=20
> > +	case 4:
> > +		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
> > +		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
> > +
> >  		fprintf(stderr,
> >  			"Hint: You should update the running kernel "
> >  			"to leverage Landlock features "
> > --=20
> > 2.42.0.869.gea05f2083d-goog
> >=20
