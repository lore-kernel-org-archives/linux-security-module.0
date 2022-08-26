Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FBECAAD5
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Aug 2022 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiHZOkL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Aug 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHZOkK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Aug 2022 10:40:10 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DC357DD
        for <linux-security-module@vger.kernel.org>; Fri, 26 Aug 2022 07:40:08 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11e86b7379dso1026873fac.10
        for <linux-security-module@vger.kernel.org>; Fri, 26 Aug 2022 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7guLPm3X5Q0eIlOwpatTFO5PrEcmfo8u/iXS0E0f4GA=;
        b=62jCvxExkccJ0z9Nt3e3QApnehYgFwr8aPWqkHZ1tyNar1hDy4vwf9xVRQ/8PlqJIG
         7gNXFO/4hum2hxAKfkEbKNNlUYuqQagYDURLatl7r2EmYc/1EMgOHh+TLbSl1rpOIAUS
         Pjq/a7Z9lhvPFHf6afvj8jjOX222WVJsU3SnFTfDrXdxDA8yIMXm1I93IaU9mMrvh9cC
         H7QjvvS3Bl5kGbQmDwc6PAFLq7V/o3MSwgi7PWE5LTTJtjusTazJUNUW0XyZrsRsNfUo
         jIR3qI8W/w6v+WoT92B8zGZSkzMchrE8X84X8iENpSH027s+H0iUmbhR9K3rexIYyOcW
         lUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7guLPm3X5Q0eIlOwpatTFO5PrEcmfo8u/iXS0E0f4GA=;
        b=efEmJKwtDnNOXiAD/hIc10wVGcbxO5fZqZ3pl/aJIK1YWwiNtHh+v3hnbZf0G6R+jr
         XNrvTGTEpEo6UzhtP3ZnZJx3STe1Q7IhzPAd5D+M8VT1Ipin+lW8IAlvYyZ4dFELhuEy
         NQ7rBee9iO5SyDk0VSe2A5BBYEPfFGsTcfCte8LjHGCwp/nuwPzvOewdKkWN/WgqnLB9
         +S9PoEDcmyFI+YwH2sVJbUo7NcygjRI0K8CPL7i61CHJoK5/JILd3a8fYYGnmw8HvM8U
         jr0yAE7nJl0mwam0qdynDdwoD0WhBHidT3caWJHdb9qo308Sww5AXPsGBBT3ON7Dkpoa
         I1pg==
X-Gm-Message-State: ACgBeo2u1wCwJbmQ2DTDLFdpYe2UrF+ZV77RUns3wdqv0Oe1yxopm3hJ
        GOS5BDhuVXpn/SPpRmeA2S2vSw4z+v8Jj0awGH+/
X-Google-Smtp-Source: AA6agR4ECHzoM+hQmIYoK2QVSXFx1jvLOI26+sl4NI2ZlkW0hDmF/aBGeeR7c+GFILahrxmzs9LYqtZTDyuv3Pf5tBI=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr2039337oae.41.1661524807522; Fri, 26
 Aug 2022 07:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220823144123.633721-1-mic@digikod.net> <Ywf0okWNl4gRXTYL@nuc> <bd085c93-5814-e701-bdcb-54e9d5fbe8db@digikod.net>
In-Reply-To: <bd085c93-5814-e701-bdcb-54e9d5fbe8db@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 10:39:56 -0400
Message-ID: <CAHC9VhQy9nf+v0hp3fVofPvf3vTsWWor-fexqXLi+42CKSK=gQ@mail.gmail.com>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 25, 2022 at 6:27 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This patch fixes the (absolute) rule access rights, which now always
> forbid LANDLOCK_ACCESS_FS_REFER except when it is explicitely allowed
> when creating a rule. Making all domain handle LANDLOCK_ACCESS_FS_REFER
> was may initial approach but there is two downsides:
> - it makes the code more complex because we still want to check that a
> rule allowing LANDLOCK_ACCESS_FS_REFER is legitimate according to the
> ruleset's handled access rights (i.e. ABI v1 !=3D ABI v2);
> - it would not allow to identify if the user created a ruleset
> explicitely handling LANDLOCK_ACCESS_FS_REFER or not, which will be an
> issue to audit Landlock (not really possible right now but soon ;) ).

I like this explanation much better!

--=20
paul-moore.com
