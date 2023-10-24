Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE0C07545
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjJXVPm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXVPl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 17:15:41 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537010D5
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:15:39 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2f2b9a176so3341331b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698182138; x=1698786938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdtFuGk8CPbNW9+HXho4YZLow9fq4hF5ePPpvT0YjW4=;
        b=NThrgrShwiduU8sKYvLv4dPj4weDsNgmjQm11lT0BSWxiNo9LkcLNXA/rHehAekZ8K
         j0I8kmWwK35hcn6ldh3KpHJZOGzow4sT5Fcj76yp5l+G5Q47/UmUXIwZatDzDj2RCFCf
         g0eHo2LYCkk5GTfXiUZYFQbrNB7xCwTnY3TSfOMhwDFUQuab/04TzGXxTpBHATLnnrtS
         g79lAaGzP9IxqP7RgQI/YiX5UNDAlSR8I4ugDB+pftShsFAZwo32Mqr1KCCLS7NUp3p3
         MCV2lDfmIc0ChhW50eD1zU0r9a0kIFeQXUgyewv+NioPZip/eXtX9SIOYafW26bJgCxg
         HPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182138; x=1698786938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdtFuGk8CPbNW9+HXho4YZLow9fq4hF5ePPpvT0YjW4=;
        b=GF+uINJGWWwCzVcyiV0nJHhyT4Hx2hdlQJJ+j8vZbI5QcCGaDIHLFerPc0N7fP746C
         uFt6l8AAjVUQvUoc+z8dn0IzHSj1ry3foGv1hl5D8Bel+blLC1ebUbQTt68G7B8RUWM3
         feaBTHyoWk9OV5cJP9/ivipZLVFTks46pbG77X71DnrlPXkKsFJStOaW8Ta1ptezuYKP
         jxQxC0CP+c/KIQNJpllA6ZpYD4nT5dN+SJ9OqyQTp7p7A7F/MND9Ve/9IPrkbM3wjZb4
         wf2/Y8wHNgT6oq52etL+/KzlTtvuYbZ4rskftmfx3Ven0oJYehJz5eKNeeVhr1zpP8jF
         nRbQ==
X-Gm-Message-State: AOJu0Yy4kFy0Gf2L6jV1bPd+4rd46+iiTTBJdiYQ0oVKJpxvsSqCHHIN
        y0SgxGChVOLE+g99y97k9fnedHYqbTPsqqaMQ2wL7mfR5bctPOsCFg==
X-Google-Smtp-Source: AGHT+IEgNLatnXnOxdmw7JiSJdRYU+oMdRa9x32RWYrDUtRgUP7l8hhI+fM9LIkb6yPE37VoW6JNxnxGeRjcBxTUoaI=
X-Received: by 2002:a05:6808:2109:b0:3b2:f270:c689 with SMTP id
 r9-20020a056808210900b003b2f270c689mr15818968oiw.23.1698182137961; Tue, 24
 Oct 2023 14:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com> <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
In-Reply-To: <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Oct 2023 17:15:26 -0400
Message-ID: <CAHC9VhRayR7utthY8Bu4AbM33k4TA4Pbc57kZcYg955CwS7bQg@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 19, 2023 at 4:08=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> > When IMA becomes a proper LSM we will reintroduce an appropriate
> > LSM ID, but drop it from the userspace API for now in an effort
> > to put an end to debates around the naming of the LSM ID macro.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks.  I just merged this into lsm/next-queue.

> This makes sense according to the new goal of making 'ima' and 'evm' as
> standalone LSMs.
>
> Otherwise, if we took existing LSMs, we should have defined
> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
>
> If we proceed with the new direction, I will add the new LSM IDs as
> soon as IMA and EVM become LSMs.

Thank you.

--=20
paul-moore.com
