Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B89C19F2B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jul 2022 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiG1Qf3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiG1QfQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jul 2022 12:35:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D88DF87
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 09:35:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l23so4072910ejr.5
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WuvoJ90b2lCyCsNl1uoWkwZZ34W9Zu4j6EvkcDdXVwQ=;
        b=jvQqyGbQc9RYesbut9vgjY0VzhqNEBnF3cfsQbiO2p4n6Mzc2nJb2+y8eY2mMiOcZD
         VltXGjkq3ui1UvSrfncIGFRJviK9WRplIBZ9tT/01bLoKwiNfLtrSoIEFs/XyOyS7JmS
         n+tGv2wwMpCYk7ehwo72EG/nqoP044Oca6p2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WuvoJ90b2lCyCsNl1uoWkwZZ34W9Zu4j6EvkcDdXVwQ=;
        b=uAOBJ71myYuww79GrLN0XtJFcW9FmhH7L3VHFT5gTqKVDQwGCxK3c5F/sRwBG9X7bB
         yas3dmbFYRsDEu4af4N3j7zLTD+DbKJf6KyjEBDFfvDRAIYq+LpLEq9FVA4zBsycxfgg
         ozAXs5FeY6sGbLl2MtlXiUGzMuEobeor6BJrgEQJC3FqlHMCwA3jVxZcE9t7IRYYwJ+o
         jhdR9AzoHQ6KfdpwRiLzjAlnTOvY9IaOAZefD8f2xH4hYrjQow6d2eWQme+6C4ggF6Bu
         NZaIJtZoQaOc2kR7LpjwIhGC5QpsaPjzrYtBgWAMHZLQIxW8XVduvUwmdczfxWTKkHwf
         d3KQ==
X-Gm-Message-State: AJIora9RUhtrvaEXUjK8bfo6QKK0QeZDGiuhLsQUSJ6iOemXvZrfAgF4
        HBZS+JPJejpKuo97/FGAELaBkVJ3FdPBEPFo
X-Google-Smtp-Source: AGRyM1s2TNRbBXFlRckvf8xstEoVwT05d5dBkKTGSGtbcEFi1xYZNDsn2EO3LPWDIrE5oAWeEF+Pkg==
X-Received: by 2002:a17:907:ea1:b0:72f:4443:d322 with SMTP id ho33-20020a1709070ea100b0072f4443d322mr21484049ejc.240.1659026112856;
        Thu, 28 Jul 2022 09:35:12 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056402291800b0043b7917b1a4sm958299edb.43.2022.07.28.09.35.10
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 09:35:10 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id b26so2936812wrc.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 09:35:10 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr18613494wrn.138.1659026109819; Thu, 28
 Jul 2022 09:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
In-Reply-To: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 09:34:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UR+DhWuc555q8dde7MJwgkvG-s1rWYXqQ-afdo3q80pw@mail.gmail.com>
Message-ID: <CAD=FV=UR+DhWuc555q8dde7MJwgkvG-s1rWYXqQ-afdo3q80pw@mail.gmail.com>
Subject: Re: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>, linux-raid@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On Thu, Jul 28, 2022 at 8:54 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
> wrapper") in linux-dm/for-next removed the function
> dm_table_get_num_targets() which is used by verity-loadpin. Access
> table->num_targets directly instead of using the defunct wrapper.
>
> Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/md/dm-verity-loadpin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
