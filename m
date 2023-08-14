Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F22EB64DD
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Aug 2023 17:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHNRn2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHNRnN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Aug 2023 13:43:13 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449510DE
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:43:12 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-993d7ca4607so282618066b.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034991; x=1692639791;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yoISyQ64yysqfY92+HZOjBkKIpcZsGK9+9LkEvhrw=;
        b=pDDxmnJuJphVE/sJZALK5OGNZ3ZNSMbmOe7luKDdwlPs3yHOnrCeUAjq2sJzM0Tcgo
         c/9tuMb55fNoz4BCziiFo9IwZiRHNksxib2OEEgL2BjNH5MF5mzJpbgygd/ErtejAuka
         VOFQtMep0JuXh1qt2BLamq7kDia6o9xZq+eopkvAg7GiTGVADklvj/zjOxJyVp/wUA1w
         s4n2mVadNgv8Xdak8z3Zsbg/OHZS72X+ud3siE7OnkN8pjZG6npKgt0v3O2yu4OTqRcH
         JgQ57PTEtn463julHPI1+Z7qOirhveKVrNXv3HngbVyYiY2j/rWWBGG+Fz5dr6DbXgxn
         3Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034991; x=1692639791;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u5yoISyQ64yysqfY92+HZOjBkKIpcZsGK9+9LkEvhrw=;
        b=a2TNlinwRSpOsZP8ojiWk8/JgfbD9pGmo7wywdWsZZJVR+MDXjcIZAe/nrw2/euj0l
         H3c5mlJgh1aR/osGDL2Bxuxjrx7S7bUlY5ND3rsT65ZjAUr+LhOdU8WqyNYTkyF6XkBj
         xlLBXygV7ueOqKTMl712CpQzHUP2itANwLxEZBHej3WLpB3L3/doaSvVKbbwK1rRswyr
         VmrQ73lITBSydD6a+ajF30iHLKr20AIL8zvy0bakTqr1Kk+AjbmKh+Moi875SnCy14Mz
         YS5DnBecrH9uDb5Z20FMV0/QoprlUR186TFSNF0y3QVvCnGpE9zI2yWSyuN6N24SKsrc
         HNoQ==
X-Gm-Message-State: AOJu0YyRF5Ta+STklQmQZnR1/bDqDeqgKZ1MuV7LDy1OmEiqLUYK/hUS
        raRXUVv3dVd1tZcWLJ42zDb4Dsb8cF/cREErP1oFXVnZfntBRASDPXSmPrD/TOlXjwxA2oPNjNw
        N0VwnJ05qy+BkSK85srkJX40f8e0HefY33WWMAApv8kF2Xgd2VmbMH82H4vQBUkZDl0wsgMtUQC
        sOYtA/kQ==
X-Google-Smtp-Source: AGHT+IHOPYwxghdHox4XDWyIW4BUui9QEosU4h7y5pPSzt1awMxCLmFAyPMyZpEs53hZS6we0ZdK3v3+vVQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a17:907:8715:b0:990:fb:b91a with SMTP id
 qn21-20020a170907871500b0099000fbb91amr44134ejc.8.1692034991003; Mon, 14 Aug
 2023 10:43:11 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:43:08 +0200
In-Reply-To: <20230814172816.3907299-2-gnoack@google.com>
Message-Id: <ZNpnrCjYqFoGkwyf@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230814172816.3907299-2-gnoack@google.com>
Subject: Re: [PATCH v3 1/5] landlock: Add ioctl access right
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

On Mon, Aug 14, 2023 at 07:28:12PM +0200, G=C3=BCnther Noack wrote:
> @@ -1207,7 +1209,8 @@ static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL;
>  	const struct landlock_ruleset *const dom =3D
>  		landlock_get_current_domain();
> =20
> @@ -1280,6 +1283,36 @@ static int hook_file_truncate(struct file *const f=
ile)
>  	return -EACCES;
>  }

About the error code:

The ioctl(2) man page documents ENOTTY as "The specified request does not a=
pply
to this kind of object".  It does not document EACCES.  EACCES would be sli=
ghtly
more appropriate semantically, but existing programs might be more well-equ=
ipped
to handle ENOTTY.

Do you think we should return ENOTTY here?

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
