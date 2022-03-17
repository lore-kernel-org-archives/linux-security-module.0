Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17041C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Mar 2022 01:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358357AbiCQB3T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358382AbiCQB25 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218E1E3F1
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:27:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t1so4830830edc.3
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOxKsTGlBiXPbLWsRjfTqw/sHWeUi1uspD6WChZvBGc=;
        b=LNQndeOSXW/bAWh7JNokNGhZ5eqGvlPxbUsfct7uX8e652+AZTZFl6ZnbKhzWsZnR1
         F98RG8Wz1O2VsVCedS3lzBDewtqbBDLRgtzBBR4D0o7EZvQZNJjxyuAKcQhdfpXgs2kj
         KIIyEkSMSMqcOZyYfIPhbZTyng29T83GGHYU2CJJoH9IK8oJWnuaI8G4WSTUQr7ENP5L
         TNY2t+1Q1U69nlq1sH6hKoMoKg1JCpnaIZSqb3up1G95PvRLagrF6NifKl20EyuOChZ9
         J7dAHfJVKkdxD77XohB1NZlmtuNEsAZkWX2IGX4KCaGAcTbIRASL5NQ6BYDQFt4YerPo
         B6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOxKsTGlBiXPbLWsRjfTqw/sHWeUi1uspD6WChZvBGc=;
        b=xj/n2aSeYqjWZTCbiT5z9/12/Q8iydku5S+cSpesBLE/E4SLh76vE8pfM4URYjW020
         E3XtZm9YaZ1nMK6ka9u93DFpxFiC8Bntlqp2+sM2AvlsVcNrY5diRwtBp4CPLBQS8g7t
         x/MBefThuIUQlLtvhdSxqq/81j8kPtuqC80Q7BjwXtt+WZBIYCJsvC8lYf8Atuf5wZg5
         4t/D43mtHOgvcOinlXXj4MMYDR0lZwD02JzG/sUwW2eu1MFnSE7YvMWwAFf3OSPZtrib
         u7LytBhgafl8b2fr3pVvpGFr6aVpn2vUXrOE64Z9yR+cxb15SYBioHFW9jBlg8Cs+AsW
         ayYg==
X-Gm-Message-State: AOAM531rxXDUBX2BWpTt4eA+8OTrOAlN07tJD81mF8ZvojXJUNxsuRiQ
        i3WgBCJRYH+kylFEUQ8TcJAGLpQwK5BywVu6hZSU
X-Google-Smtp-Source: ABdhPJzKzxlZ+0pm3CY5Kl7j8CFXMcoRrP56pFWJh+04iR0sxvt0PPoz+ZQBE4MeZ3T3Tg/mmXPL96Pxy2osfTaCu6E=
X-Received: by 2002:a05:6402:1746:b0:418:d816:14e0 with SMTP id
 v6-20020a056402174600b00418d81614e0mr2016945edx.340.1647480439041; Wed, 16
 Mar 2022 18:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-11-mic@digikod.net>
In-Reply-To: <20220221212522.320243-11-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:27:07 -0400
Message-ID: <CAHC9VhTSTkOLx_CfB9DsG1GqZm87o2Ds0urZv+gS+sA4gMjfFA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] landlock: Document good practices about
 filesystem policies
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-11-mic@digikod.net
> ---
>  Documentation/userspace-api/landlock.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
