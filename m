Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49486C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjKMEJW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKMEJW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:09:22 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9CBE
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:09:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9cbba16084so3927637276.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848558; x=1700453358; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QamZjASyN2onPWlI/DeG+XAWnLKpbLpv5VcVHrZ+5I=;
        b=c/Bo9HHY3Pf/1NDzFhEhC3B3Y00lXwz/UgzlET5kS0zvemDrdzqJ+be0uwV+b23lSI
         KNNZQx3CE48YMRmfKH32ZvFkcRhOjHXUmmfBix2AUf3VooAhJJFBtOYVc2d+nUSw4Qjs
         cvXzw6p8UTI+S2jeJemisKzohfIAzaf9kT/x+MK0wv2RQVApbxqqAChmWoNwpTIfb1oe
         YObv+pECUsKRA07ZC+OznCk89Pah/TywFZJT7qKiXuVfiWrAbW95ZCzzxpRasxT8UzJe
         l5/0uTxWodU+GOtIkft26UnGMze25s8S+q0y/FAcdDzdjTK2msyV2L5Y1aNRhga6Icwo
         PQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848558; x=1700453358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QamZjASyN2onPWlI/DeG+XAWnLKpbLpv5VcVHrZ+5I=;
        b=cOa41WVLHvAOyb4goCDY0aAGFFtQAsTP3WJk6eVDye6aPx65x9jzKV3stk7OrOBP+W
         y7lh0dtMnVVaYOT0EaDG+OpjEzw15KndDZU8W4t8/z1h019k2tynvYwPkByuEbPDOWiF
         r6LLwYap5ocfrQcsbM+oZQbhiqbKvyb5WRRw0A4G+bNNGdcS1g2QINXaIOqgQG5WvOq2
         DgWVVDpiV/pS4nFXmhGr8S+uET7VQvMMVzdWMI8o0t2pb0EGViMzFZzQSqi55/Dr8naP
         BOyXa979EL0XFmmITmv5Pe0mJiBfHDog6rYqPKQyiLyuOdkFdHYEHF5iR34D428BWYZm
         KJZg==
X-Gm-Message-State: AOJu0YyebjSzrgxy2LohSv/9g9BNWES8zW4cdjTSP4tPsABoGCKV1+/G
        In0iwQ1zAs8zzzm7LJqWTNKex+94Hr2KJwhrIuEc09aUOELj2sI=
X-Google-Smtp-Source: AGHT+IEqUKK/GvBSqohx4nURkiZKLxVDsaJrnC/yh9+dlirsfWN6oD8/5HQYIo2iZFKgLOE2yQGMtlEHHtek1IoLZcI=
X-Received: by 2002:a25:14c1:0:b0:d9a:64ca:8fbc with SMTP id
 184-20020a2514c1000000b00d9a64ca8fbcmr4475970ybu.46.1699848558206; Sun, 12
 Nov 2023 20:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20231102015354.511078-2-paul@paul-moore.com>
In-Reply-To: <20231102015354.511078-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:09:07 -0500
Message-ID: <CAHC9VhTOooBNBLX+-JxP0XfKHLU+VK2UHiBvOomta1P8rNVO6Q@mail.gmail.com>
Subject: Re: [PATCH] lsm: convert security_setselfattr() to use memdup_user()
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 1, 2023 at 9:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> As suggested by the kernel test robot, memdup_user() is a better
> option than the combo of kmalloc()/copy_from_user().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310270805.2ArE52i5-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Merged into lsm/dev.

--=20
paul-moore.com
