Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D368BEE01FE
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Sep 2023 18:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjIMSBJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Sep 2023 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSBI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Sep 2023 14:01:08 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544619AE
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 11:01:04 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-450f46861edso75130137.1
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694628064; x=1695232864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vAzLmGMAp2tLkE5jF8uMDyOlDhTRpufcEG/UTA0iE4=;
        b=Lqk+6MhewheZV/HnSCFxNfB+Cv5CQtLIZ4jL6mXZFRAjMOg0KrI5DNoIowWRXMJslV
         0z7a5sF5SAVrINSzQTtTIcwJ98fQQ9eHJ0yEjMsq0p/IqRoozr+9OgHafqdJHWaw9qoJ
         06NySlexI1bwxuh0Wsb6RcIUgXvYYBMTa2TWTdBQwbQhUvwBvW+Lv0T2KLPcgLmYbMmi
         v3vZON5li/didHu7yNvEnb5QfejnHTSXdsv7kezdJv11uJUHMhbUCE7ngUWjJi3wa/Ri
         FaXHy9ob4IzN8CVbK8Ib0nYAqutiGfqRsal8BnHS4n2hbVqCu5QkWPUXqoGsFznjY5Jp
         Q/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628064; x=1695232864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vAzLmGMAp2tLkE5jF8uMDyOlDhTRpufcEG/UTA0iE4=;
        b=YLqevybL2+SZc5D8wRNdYdOvrvBIJmAOJGgTdeuAKHZpfXjZP4hn4UHV8Rrt8RNaSu
         2P7FzJEHWy+l6IuV4kBl9Be/PcBJArbwhf9fbNwbKstfvXeKyQrgg1OXGKQaoCgZh4UE
         3DgP//P6nD9LZeXRr7myWfGKJcfDvWbpncL0Jli7WotuS/A5Dtfgt3eGCSdPiwRaG+xC
         TA1ZmzNkxJ40wj2bfqyV6qr957S7L0oORn9JFgDKQI0pjYVs2+elA4BO7Z6YFPE7SuoP
         BajyNuKp29Ywv28orcFN9NAdQBYi0m06hZ4RKZ/FmqM7ErfmFM2/8YtahFxoJz8qj2NO
         Howw==
X-Gm-Message-State: AOJu0YyatMYSgWEJQfpuvPjB/o9qO2zK0vvPdRVdlf5nlAp4y7rj1k/Z
        WS9lVFagSqUw8XbI+yG120hGbwkNFGytXL+UD25U
X-Google-Smtp-Source: AGHT+IH07JbseX8uP3kiuYtDXMzC+h6hmNtycAjFH0PiWnxFgz9UZIkNt1kSn4BNdb1k4n3piH8drftpQj1UGeBnCsw=
X-Received: by 2002:a67:e8ca:0:b0:44d:626b:94da with SMTP id
 y10-20020a67e8ca000000b0044d626b94damr3287173vsn.32.1694628063809; Wed, 13
 Sep 2023 11:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230729024026.32228-1-yuehaibing@huawei.com> <CAHC9VhRW0Jt0pitVx1cw-zJGWfTmvTU4RSmOFKANYJA7CeEF7g@mail.gmail.com>
In-Reply-To: <CAHC9VhRW0Jt0pitVx1cw-zJGWfTmvTU4RSmOFKANYJA7CeEF7g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 14:00:53 -0400
Message-ID: <CAHC9VhSisEfQd0KCu7f8yKBwnrduFOPhP2SzWDfXiuvGh2g13A@mail.gmail.com>
Subject: Re: [PATCH v3 -next] keys: Remove unused extern declarations
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     Yue Haibing <yuehaibing@huawei.com>, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 7, 2023 at 5:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Jul 28, 2023 at 10:40=E2=80=AFPM Yue Haibing <yuehaibing@huawei.c=
om> wrote:
> >
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > iterate_over_keyring() is never used, so can be removed.
> >
> > And commit b5f545c880a2 ("[PATCH] keys: Permit running process to insta=
ntiate keys")
> > left behind keyring_search_instkey().
> >
> > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantia=
te keys")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > v3: Add Fixes tag
> > v2: Also remove keyring_search_instkey()
> > ---
> >  security/keys/internal.h | 7 -------
> >  1 file changed, 7 deletions(-)
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Jarkko or David, please merge this or explain what is wrong with this patch=
.

> > diff --git a/security/keys/internal.h b/security/keys/internal.h
> > index 3c1e7122076b..471cf36dedc0 100644
> > --- a/security/keys/internal.h
> > +++ b/security/keys/internal.h
> > @@ -109,13 +109,6 @@ extern void __key_link_end(struct key *keyring,
> >  extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
> >                                     const struct keyring_index_key *ind=
ex_key);
> >
> > -extern struct key *keyring_search_instkey(struct key *keyring,
> > -                                         key_serial_t target_id);
> > -
> > -extern int iterate_over_keyring(const struct key *keyring,
> > -                               int (*func)(const struct key *key, void=
 *data),
> > -                               void *data);
> > -
> >  struct keyring_search_context {
> >         struct keyring_index_key index_key;
> >         const struct cred       *cred;
> > --
> > 2.34.1

--=20
paul-moore.com
