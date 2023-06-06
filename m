Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72494C77B7A
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jun 2023 18:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbjFFSus (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Jun 2023 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjFFSus (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Jun 2023 14:50:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501E83
        for <linux-security-module@vger.kernel.org>; Tue,  6 Jun 2023 11:50:46 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69E163F137
        for <linux-security-module@vger.kernel.org>; Tue,  6 Jun 2023 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686077444;
        bh=ZBMK+DdZXFCRFi5Z/MVobjT4mwItd0TF7QfSBIyRNYM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ahe4+ZB76jfNXrV8iwXte6j+FKe814hC7FwYR+Lsu/ugljxjLXb6GZQK2pwH7d4E1
         iVXKIT/nHa/qpWJb24hz/UagXrg+9tYkTbx2nAgtE3gaCttTLu02A4oP1hx3+g347p
         /Si6lbo0jHbgCZJBaEi5ZkDYw3nXb/YJQw5GyLvylQuJ6zlaQTx4GxIDgcmYEZdWpi
         B2Z2bsZDM+DGfPPNwJPq86/LpUs0ieuh36+JaSoFMUwhGOz9yXIxRf2L6jEH78zOTf
         d8R0HqtWL7K9/jSlLt07FitFtfQFt5QPBVRRAW14z+R8x0u/hnkFnqbY5Tzh9x3u9s
         6SBkRC9LDNf2A==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5693861875fso96436407b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jun 2023 11:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077443; x=1688669443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBMK+DdZXFCRFi5Z/MVobjT4mwItd0TF7QfSBIyRNYM=;
        b=M6sZ9jLZhRLy07oiAAX5iE4DHhPMeMF0NRnduGkdxpdvPkx1z5HS0fQTuGd83+NhC6
         I1ThEhlYW6aDhcmXqaBRltfiemXuxlbsVqkZ3e5z1jsFX4T08/3qNgPGGbTIODOENkBF
         gUxV2iXdyMx7kBUfZpE91yEEwxG/tW0JKrFOOTNhT9DRE1wrx2wZT/uiqZuNsi9b6A5X
         VNEWh9FkM6V7xeJYVW8hy9Gff4HPFL/usNlXbgK8i3krsuzTRCjz6rWdFc61q+fR15sH
         EVDc5PJITaYjFe5vkbTENDGqm5kYjcw4o7qfjFvnsy0sG+8FN6i9JVyS3RcFdUblix0E
         Sxqg==
X-Gm-Message-State: AC+VfDzg6SdIacN3iGtHfsrApng1aG+nr9C/Cdebgw8EJjJvVVzyi6tY
        6f3K+LewsU0upGI+FX3412vixpaNsVzr/igO0zJjW+ibIUsq0ciRqc0hboMhxsJGvZDpndl3kdP
        QBzIdCo1hiEYQCkcqBFnUtF7s4kaHtwuWB0DlID3qYY79JIS5dRJlZGCPuI6eIO58N0TZ/Q==
X-Received: by 2002:a0d:df93:0:b0:567:2891:a2ec with SMTP id i141-20020a0ddf93000000b005672891a2ecmr2847091ywe.22.1686077443445;
        Tue, 06 Jun 2023 11:50:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eG8FXdCtl3Jo2AHE6KMXFNu+4hALAAsTlXcmSnAR6Is4KRsx+SE5FovsuMWhsnejikrGXFCTSV6j866OLXwU=
X-Received: by 2002:a0d:df93:0:b0:567:2891:a2ec with SMTP id
 i141-20020a0ddf93000000b005672891a2ecmr2847070ywe.22.1686077443171; Tue, 06
 Jun 2023 11:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com> <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
In-Reply-To: <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 6 Jun 2023 20:50:32 +0200
Message-ID: <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Paul Moore <paul@paul-moore.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > pr_warn message clearly says that GID should be printed,
> > but we have UID there. Let's fix that.
> >
> > Found accidentaly during the work on isolated user namespaces.
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v2: __kuid_val -> __kgid_val
> > ---
> >  security/safesetid/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'm assuming you're going to pick this up Micah?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Dear Paul!

Thanks for your review!

Gentle ping to Micah Morton :-)

Kind regards,
Alex

>
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index e806739f7868..5be5894aa0ea 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct =
cred *cred,
> >                  * set*gid() (e.g. setting up userns gid mappings).
> >                  */
> >                 pr_warn("Operation requires CAP_SETGID, which is not av=
ailable to GID %u for operations besides approved set*gid transitions\n",
> > -                       __kuid_val(cred->uid));
> > +                       __kgid_val(cred->gid));
> >                 return -EPERM;
> >         default:
> >                 /* Error, the only capabilities were checking for is CA=
P_SETUID/GID */
> > --
> > 2.34.1
>
> --
> paul-moore.com
