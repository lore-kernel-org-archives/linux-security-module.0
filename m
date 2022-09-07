Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD2C6FA86
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Sep 2022 15:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIGPne (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIGPnc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 11:43:32 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662AB14CA
        for <linux-security-module@vger.kernel.org>; Wed,  7 Sep 2022 08:43:30 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1278a61bd57so18453947fac.7
        for <linux-security-module@vger.kernel.org>; Wed, 07 Sep 2022 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ts8sD/IHVRi9k1jlgev4IpnFvduczDySAkqNIh9sCNA=;
        b=ZFzHmP4gyBWljJarZlRpu44+Pdi+JKXqO/0pufgx2cv1qQeVP7usq2OgS/NkxEm1ll
         glxywrekpB3t22xSgkeC2+74lMc0DvIjfsghlhRqrUpKFjNZ/WvnPdUt5W4f6kUFOxqG
         O3CRZ5x0hNwfl4ZNqQsRURuOEUDrHZ4CGeFQYUCVUYUgYI+c58K5Vi4+4xLWdGg/h2On
         JgKQ6nlp4x5DIq/rMfAnjKLJvUZkQSSKUaLg27XJc2cW0RJQzj6n6IA3Da4N6aZM1lVL
         PMX4EmHIseF9Z7eC8jiD6w3FTljr0Xfmk5IK8emS2Wmt8WSrIJkS+dRM0vWvs8W3G65o
         8gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ts8sD/IHVRi9k1jlgev4IpnFvduczDySAkqNIh9sCNA=;
        b=T2fuHOyk7SiyH38Gf9KZybPq0f/2nYviyUfzMw+TK0dyytCe8dDZYx0ISW6DVTX6l0
         cSG/CY1syOnepIbkLkVDcGwYvwKeKlGubHM/t0hiP6gEdPfxvE9KinUm0OqN0Zp7j+GC
         4Bp1uOBSTumYcmVHe5KlHiU2GwTfPdfbnCH7vwwjikOLJ2E7fY51yhzRBgyC5R8xWcn/
         zqnvtot1UOb5l9Bge/DUiAtQ+IKZ3sjWO+WBZ0AUpBH9idcucAClJnIBvsGb6s/yKJQw
         2z7oMp/HbSK+hrdv4606NQp26AJuzOsKnMS29oUCBoAJBlwlLM5xZysdWUP84pCdeNq3
         mLAg==
X-Gm-Message-State: ACgBeo2MXtClaYsN8y0eQfsznnGFq2qgpYNMDgurVTpPEvHpcmrnrLJr
        nnHxDya4+LUZ04+APlrbVhk/Qcp0IOYycMetoncy
X-Google-Smtp-Source: AA6agR6CsNX5pCAqd4MaFpekC59h+BsiSmuZ8ycl+hLYfqJYWrzqBDDG02upFEfnosFFzJPjemisB1neBKzVTee58aY=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr12565813oie.41.1662565407848; Wed, 07
 Sep 2022 08:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220907121230.21252-1-vincenzo.frascino@arm.com> <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
In-Reply-To: <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 11:43:17 -0400
Message-ID: <CAHC9VhQytyFMvq-M0YrqzKxJDyj58KKG0XDjBfTV02sYCzeALQ@mail.gmail.com>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 7, 2022 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/7/22 05:12, Vincenzo Frascino wrote:
> > The declaration of keyring_read does not match the definition
> > (security/keys/keyring.c). In this case the definition is correct
> > because it matches what defined in "struct key_type::read"
> > (linux/key-type.h).
> >
> > Fix the declaration removing the inconsistent __user annotation.
> >
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Note: This issue was discovered during the porting of the linux kernel
> > on Morello [1].
> >
> > [1] https://git.morello-project.org/morello/kernel/linux
>
> FTR, I have sent this same patch 3 times.
> Good luck.

David or Jarkko, this patch is both trivial and obviously correct,
please merge this into the keys tree for the next merge window else
I'll take it via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> >  security/keys/keyring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 5e6a90760753..4448758f643a 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *keyring);
> >  static void keyring_destroy(struct key *keyring);
> >  static void keyring_describe(const struct key *keyring, struct seq_file *m);
> >  static long keyring_read(const struct key *keyring,
> > -                      char __user *buffer, size_t buflen);
> > +                      char *buffer, size_t buflen);
> >
> >  struct key_type key_type_keyring = {
> >       .name           = "keyring",

-- 
paul-moore.com
