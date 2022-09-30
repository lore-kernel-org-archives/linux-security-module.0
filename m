Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD36EC4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Sep 2022 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiI3NBi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Sep 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiI3NBh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Sep 2022 09:01:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963C10EEDF
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 06:01:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hy2so8859495ejc.8
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rp0BnqbKwjG9lV6J/Ph85TR4tMAevzJG6WiMgOhpmug=;
        b=pT0ssIu03xvv3jvV0fx6jXVbVLxoiVjnxkCqGNCCqBKh7QlPzjyzY/PXMCu5jyX4Ma
         2RPiuodk64PGsecSuvkaGIHvzuJJMMXRfgbJSe4Ho8K8HMdgD9kQuqZI7+5maAveCauC
         cvhoJC9BNQHkDurnQm+Yvhn/6hzB6MvWFAXcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rp0BnqbKwjG9lV6J/Ph85TR4tMAevzJG6WiMgOhpmug=;
        b=ZezCRgMrcu9onhYq9M4L/yFIISYOpth5kHCd+DMJ/wg8CnIXTyWs28IbVnpBHuAc9Q
         5LW6zaKGu5fwm0+mdJD+xVibbj0kV8jtQ0uw6Q3e/QMyIE9GlNR/Qwd7+RcN00nSwa4n
         1XnoAcpqDCcaia5fMYew2HhdGp3J9Ut/xbifu6oRcbVqM/UUCU/C9IuDhfVPZrJk4f4w
         P3bI9RLJ42dTdTrFNI1dzqyeyiJqJW88wOK4ISAltwB29xO19nF+xSux8nOaiUWyHN3i
         v8W8FTrb1j4AGlykuJzMooCaOo0ziCeZOZdBXkGnxJY6ZjX6kgVkI/o5kFTueepkT7VC
         5azg==
X-Gm-Message-State: ACrzQf1zmrZOCWTvTUO0+xg3rJGoEvfJ/MdDE7gDZIHm+PAwdhzlP1dR
        YuUXePFPQaprrFCUaMQz6wPb75IdQx0kOaimsLfMTg==
X-Google-Smtp-Source: AMsMyM62iCWPdnNsF6dG3Wf9BL4+iOR0yxbvKa+bY7kj2X4bZFqDIRC02kpTT/KqFsUGCjAWD3wXHAtTMzMUEz9uzK4=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr6094773ejc.255.1664542893721; Fri, 30
 Sep 2022 06:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <20220930100557.7hqjrz77s3wcbrxx@wittgenstein> <CAJfpegvJUSowMaS7s_vLWvznLmfpkEfbvZbb_Vo-H8VewucByA@mail.gmail.com>
 <20220930124948.2mhh4bsojrlqbsmu@wittgenstein>
In-Reply-To: <20220930124948.2mhh4bsojrlqbsmu@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 15:01:22 +0200
Message-ID: <CAJfpegtyboFs35Qy67iuKNVEV75924Pdqejh9QZR1R4OB4WkAQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 30 Sept 2022 at 14:49, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 02:24:33PM +0200, Miklos Szeredi wrote:

> > Maybe adding the check to ovl_get_acl() is the right way to go, but
> > I'm a little afraid of a performance regression.  Will look into that.
>
> Ok, sounds good. I can probably consolidate the two versions but retain
> the difference in permission checking or would you prefer I leave them
> distinct for now?

No, please consolidate them.  That's a good first step.

> > So this patchset nicely reveals how acl retrieval could be done two
> > ways, and how overlayfs employed both for different purposes.  But
> > what would be even nicer if there was just one way to retrieve the acl
> > and overlayfs and cifs be moved over to that.
>
> I think this is a good long term goal to have. We're certainly not done
> with improving things after this work. Sometimes it just takes a little
> time to phase out legacy baggage as we all are well aware.

But then which is legacy?  The old .get_acl() or the new .get_acl()?
My impression is that it's the new one.   But in that case the big
renaming patch doesn't make any sense.

Thanks,
Miklos
