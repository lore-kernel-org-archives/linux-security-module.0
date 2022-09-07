Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A357C38145
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Sep 2022 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGUpl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGUpk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 16:45:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CACAB053
        for <linux-security-module@vger.kernel.org>; Wed,  7 Sep 2022 13:45:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so33147844ejy.5
        for <linux-security-module@vger.kernel.org>; Wed, 07 Sep 2022 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DdrorN8aXBAdiS3MQc998BdyvYtD7repapkoq0D0eU8=;
        b=Z3CwM+F2x6Pj0jOEQZdrJ0yb8c6cYyZ9KR/7RWvfR51MpVGAfqiXsWrHSoEDs8im3f
         grPlJvXctP1dtxa2ttTtoR57/jHgw8y5RP29Q/wG7ljsz98uKmLZnWHdqDZAGSeH3c8n
         kCIYM6muoLkvg/JqKdZRyMZRr88eX82rEqeD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DdrorN8aXBAdiS3MQc998BdyvYtD7repapkoq0D0eU8=;
        b=yB/1K/Svq2sCUuEWq267KSiMvPme9n2QA9ETJ74pTEtF9tnhFJ2Zs7O4cnNf1UVrrd
         h9t8d3kKnDFNyUMJlECF7DU8NN75Ars700Q07jmIlQs3cTCDj2nwpxrA7Vuvunykem1O
         qepQOop6STbewQfWl1FAiX1k045cocV7Vkm4qXx7OlnQEsAoqSlbC5cmRcbGoUQdoeBP
         AJAVGpQrXSDvH88NLMO/PPrcZMDZLQ9Gd3t0tMYLdrIm1TzR/aU90mGdJTmYNiZ3KO9p
         4E8HMsiv4/8Ey1GgM/o6e8qFW7plEk3LWx3STfcdfY+Tm0q+VrJTkJpsNbeGXxNWeR7T
         PIVw==
X-Gm-Message-State: ACgBeo0mMzy4C+ztsdHorKuLau5485M3hhIE/o21UZ7xuSTsqwXQWuiF
        7qlSgJ1A5IEUiFuqt38C2uMFpzv3Q1t1y87FIPsYWA==
X-Google-Smtp-Source: AA6agR7glr3HucH/VZYjAUKr/udgssJHsGTtsTHekQOvZu/bzF4bOvxYZj2rAX15RMN86ZNXydD1dStdQNu08HWuSQo=
X-Received: by 2002:a17:907:7605:b0:73d:cdf7:d8e0 with SMTP id
 jx5-20020a170907760500b0073dcdf7d8e0mr3617692ejc.430.1662583536042; Wed, 07
 Sep 2022 13:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
In-Reply-To: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Wed, 7 Sep 2022 13:45:24 -0700
Message-ID: <CAG9=OMPAP-BS=vqr3FmPn-antqJJKjkQc3Q0GGJRmbHkUaYmTw@mail.gmail.com>
Subject: Re: [PATCH] dm: verity-loadpin: Only trust verity targets with enforcement
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

On Wed, Sep 7, 2022 at 1:31 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Verity targets can be configured to ignore corrupted data blocks.
> LoadPin must only trust verity targets that are configured to
> perform some kind of enforcement when data corruption is detected,
> like returning an error, restarting the system or triggering a
> panic.
>
> Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
> Reported-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/md/dm-verity-loadpin.c |  8 ++++++++
>  drivers/md/dm-verity-target.c  | 16 ++++++++++++++++
>  drivers/md/dm-verity.h         |  1 +
>  3 files changed, 25 insertions(+)
>
> diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> index 387ec43aef72..4f78cc55c251 100644
> --- a/drivers/md/dm-verity-loadpin.c
> +++ b/drivers/md/dm-verity-loadpin.c
> @@ -14,6 +14,7 @@ LIST_HEAD(dm_verity_loadpin_trusted_root_digests);
>
>  static bool is_trusted_verity_target(struct dm_target *ti)
>  {
> +       int verity_mode;
>         u8 *root_digest;
>         unsigned int digest_size;
>         struct dm_verity_loadpin_trusted_root_digest *trd;
> @@ -22,6 +23,13 @@ static bool is_trusted_verity_target(struct dm_target *ti)
>         if (!dm_is_verity_target(ti))
>                 return false;
>
> +       verity_mode = dm_verity_get_mode(ti);
> +
> +       if ((verity_mode != DM_VERITY_MODE_EIO) &&
> +           (verity_mode != DM_VERITY_MODE_RESTART) &&
> +           (verity_mode != DM_VERITY_MODE_PANIC))
> +               return false;
> +
>         if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
>                 return false;
>
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 94b6cb599db4..8a00cc42e498 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1446,6 +1446,22 @@ bool dm_is_verity_target(struct dm_target *ti)
>         return ti->type->module == THIS_MODULE;
>  }
>
> +/*
> + * Get the verity mode (error behavior) of a verity target.
> + *
> + * Returns the verity mode of the target, or -EINVAL if 'ti' is not a verity
> + * target.
> + */
> +int dm_verity_get_mode(struct dm_target *ti)

nit: It might be cleaner to combine the mode check above into this
function; eg. dm_verity_is_enforcing_mode(struct dm_target *ti).

> +{
> +       struct dm_verity *v = ti->private;
> +
> +       if (!dm_is_verity_target(ti))
> +               return -EINVAL;
> +
> +       return v->mode;
> +}
> +
>  /*
>   * Get the root digest of a verity target.
>   *
> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index 45455de1b4bc..98f306ec6a33 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -134,6 +134,7 @@ extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
>                                  sector_t block, u8 *digest, bool *is_zero);
>
>  extern bool dm_is_verity_target(struct dm_target *ti);
> +extern int dm_verity_get_mode(struct dm_target *ti);
>  extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
>                                      unsigned int *digest_size);
>
> --
> 2.37.2.789.g6183377224-goog
>
