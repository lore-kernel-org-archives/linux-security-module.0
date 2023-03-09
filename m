Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EABC6FD1C
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Mar 2023 22:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCIWFE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCIWEt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Mar 2023 17:04:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD6CE9805
        for <linux-security-module@vger.kernel.org>; Thu,  9 Mar 2023 14:04:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n5so2444976pfv.11
        for <linux-security-module@vger.kernel.org>; Thu, 09 Mar 2023 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678399483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TecKA/qLSHNqUo87Vcc7qjzuRFiAfxthOVOs0V+b0QM=;
        b=RuU/Na1W7qpUoL0bigHIn8nS2Z+Hcew0Ku9FRR4C884/3Jw/wMgVzgk5zInztj06tD
         s6nRE5O82D14CVVl58idZ4WLfb3YbU4Di5rFigQdFbrsOSTiKgr/FUM1GD6Y8Px2SPt3
         Pt7vn5WPvWxi3QoNSbOjomztL/Qoit0FuoIEnmymOr+cLwru8TItVF9idBaGJ6S7t/35
         dWNkG16eTgVR/o+9iCwKEjYhONLq7MALqYhoXvBAnPuFfYCYnTftnR+N46uXINHIkkiW
         OVzZNsNvonZxBk2c1u35bJydlmkmZ3xAxe7npIwp9x/z0zFgTriWZSw+aRUnmNQdE5MB
         CNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678399483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TecKA/qLSHNqUo87Vcc7qjzuRFiAfxthOVOs0V+b0QM=;
        b=aBgiRmkeMgIfAHR+wzpxy6EKPfHwS/IwQww3g2je1LrC7+SGlzsGcGSM7z2uotE/Eq
         C5GlO4Toclc4LegiXtCzTMLJwS6czj5ROZInfecxKvAfb4oDfOe4WA0RHK2sCu0uu1ii
         EYFR8WcveGjJghEPKDX+Vy4x6qqAou9PBlUXLWSRtXeZPAcChERv/BCgcTEBmzpaghGJ
         ArDbZM/bK5Cq/PeLG8synl418JjdZ3Ftn9FL34b6HUu+YoIxuCSb/olchU/No5Xu0oO3
         skV1Gjq5pX6o31Ri5xUFGl2NGv0MZuHzvzUfNoVlAgqWfQbZEnIk70BY6/X7sgn40wMX
         mZzA==
X-Gm-Message-State: AO0yUKUTrBGxDqtx6oBx5Zfq5SR90z6a38CplBzEAWw+wm/xtiYqfKjY
        vDUK9QicnNmebIV34NmlfaWrHP9V3HC3Q0ccnh4R
X-Google-Smtp-Source: AK7set8bKYOJHSfTo3V36f2sVcFEqHiyfmKQ2F1unir5j8GMf0wWI3fvuuhPCS9zXNc+lm8Vuuq+UCQ/qTAM7wPhaDU=
X-Received: by 2002:a05:6a00:14d6:b0:5aa:310c:e65b with SMTP id
 w22-20020a056a0014d600b005aa310ce65bmr10450213pfu.2.1678399482624; Thu, 09
 Mar 2023 14:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
 <20230309085433.1810314-2-roberto.sassu@huaweicloud.com> <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
In-Reply-To: <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 17:04:31 -0500
Message-ID: <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 9, 2023 at 8:21=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to=
 be
> > last, e.g. the 'integrity' LSM, without changing the kernel command lin=
e or
> > configuration.
> >
> > Also, set this order for the 'integrity' LSM. While not enforced, this =
is
> > the only LSM expected to use it.
> >
> > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabl=
ed
> > and put at the end of the LSM list.
> >
> > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if =
an
> > LSM is found, regardless of its order. In this way, the kernel would no=
t
> > wrongly report that the LSM is not built-in in the kernel if its order =
is
> > LSM_ORDER_LAST.
> >
> > Fixes: 79f7865d844c ("LSM: Introduce "lsm=3D" for boottime LSM selectio=
n")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Warning: procedural nitpicking ahead ...

The 'Signed-off-by' tag is in reference to the DCO, which makes sense
to add if you are a patch author or are merging a patch into a tree,
but it doesn't make much sense as a ACK/thumbs-up; this is why we have
the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
'Acked-by' tag as "I'm the one responsible for a chunk of code
affected by this patch and I'm okay with this change" and the
'Reviewed-by' tag as "I looked at this patch and it looks like a good
change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
tags much more as it indicates the patch is getting some third-part
eyeballs on it ... so all you lurkers on this list, if you're
reviewing patches as they hit your inbox, don't be shy about posting
your 'Reviewed-by' tag if your comfortable doing so, we all welcome
the help :)

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

--=20
paul-moore.com
