Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B4C4332F
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Nov 2023 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKEXYe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Nov 2023 18:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEXYd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Nov 2023 18:24:33 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A37CC
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 15:24:28 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da30fd994fdso4236443276.1
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699226668; x=1699831468; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpbld44w3hWg2EgU4TG3EohhXbrCClYElOzSlri99lk=;
        b=AvEFqM0DgHMeKOE/rQSRmHY08KYHmzmWOOh9itvw+e7xnYV75ZwoH0EU12bjrflxE4
         M/4dFc1Ad9EOdSdPIPuuO8qLojA0gpbuJB/oZFS92NLLoVrYelU4KMNM1O8gW4vjdYOr
         uQhURlCz6MJMVEIbAHjF1MuLr094Ng+VN9Ej27/gHCJcwzNONYnTLeZBY+iYJOXGOJCP
         GwCa+maB906bZKn65wH2++inVRYJaar0UHi2hyYwNRC3W6eHDb/8XUWAGKeGfsm4tUSB
         +ZR2Lvccq7jdHaIKBdhctMSOrX20Ap5vOS04MOSRBEdfSu+B/CsYMU/CQx13Aqr5w64E
         4g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699226668; x=1699831468;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpbld44w3hWg2EgU4TG3EohhXbrCClYElOzSlri99lk=;
        b=Q7w/7sCccYcaxmXZ2jLyFs8FOupg654iUnuu5RmPp0gctDZ84pRslMbHDSP/xkya1D
         0oU9DI0oyqN8L07VqmgCtYxtRRc3GPhQ1Kfw4jc//Ynr7HnwvzP+uUDKaOgWHBSeh7I8
         Kzkv+tSxrHFkvAXqP02pqEnprsN4xo9wp5a7TPIDpJWMhcxl6aoy70ypWNbtmmdCIoZp
         MYrQnqgvNnJFquAqor5bNAizNNw9Sg8Iedzra3M7aZpnuur0GS5LTBVWbqXbQaLiZ+jk
         HrVY1Vh0ZlqBUc1Az2MQ1xb0yJVm0UWAZSPOLGxZqL48xo7j2+vASivYwVko3Ga/wQom
         jHKg==
X-Gm-Message-State: AOJu0Yxk6DPQgSILD2mK3uN6qWUAA9/lb2LoiUWHkNX+p3HuXbgH6X3H
        iBMnH6JjzTmiHVpr2/h6A6FsjXigbO8zOT2Vm/XiY3J2hin7948=
X-Google-Smtp-Source: AGHT+IE7DSnroJam8N+C7MgslfwrWeezrxfF1yd6C2pACrsl9PIOKccUgsfroEGmXRTy4VQdhwtXCh8jke+PR+byI7w=
X-Received: by 2002:a25:9105:0:b0:da0:7fe0:dc6 with SMTP id
 v5-20020a259105000000b00da07fe00dc6mr6746150ybl.14.1699226667720; Sun, 05 Nov
 2023 15:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20231102015337.510827-2-paul@paul-moore.com>
In-Reply-To: <20231102015337.510827-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Nov 2023 18:24:16 -0500
Message-ID: <CAHC9VhQk+t0XYXfLrpTWEjLOp4-Dvxt5Qv2ZC=--J7PH64J4+A@mail.gmail.com>
Subject: Re: [PATCH] lsm: align based on pointer length in lsm_fill_user_ctx()
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 1, 2023 at 9:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Using the size of a void pointer is much cleaner than
> BITS_PER_LONG / 8.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev-staging.

--=20
paul-moore.com
