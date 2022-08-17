Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8141EC25B08
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Aug 2022 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiHQQbk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiHQQbk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Aug 2022 12:31:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2A1D4
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 09:31:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y3so18211279eda.6
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=/z+amWs5Y19nHNsrgD6uXVP7BrXdeNRmLAJE6tXV704=;
        b=g1gQqRNCfIDKpBKCsQYDCzhmWiM1FcqXei0h6TaW5q9KPQfY4v/kAs+0ZMfjEU8sTD
         +iq2FF938Z6195G+DGw8/P4PZQzJCmwONdOhc8k/oyEdiAde2ePP0yYtDcATwcs3VqAA
         Bf7sZh7TZ2ooL7BrBmYDO5ja/Fk5h6/CRjUIviKfjhzT14XdL6Oa6WZmxuTIkdqYeXHU
         rxD5T2oDYd061mxXM0qc332AKWYlwn6Rl/OFEsv53d/G78e6vYbnPF2WekdWCgDgC1nc
         Pda4/Wj6S10WZYIsJZJwMeBtm4hq+HFf/NWCfiY4XZPceGUOXdO4xDESlAj9IcIVV2pD
         Amkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=/z+amWs5Y19nHNsrgD6uXVP7BrXdeNRmLAJE6tXV704=;
        b=4WGhGYzN/u23LThLvH2P0UP1vO2zJ0AvOj3YiF2HN1liNfYR6IGWw2PxRuo5LaW4Gg
         BPqwreZp1xmqdnKmD9EaTcoz/K9cePVV1cwr1IKXYX2MBm993R9UwdpxXD7XpBQuMIfh
         X1i3SKcaWx2+rhwMh/yFoOk+PMBkTzA03G3jjdBG1ZmtLDnukOuR/8ZpBOptcyWF1xSE
         sGn+tGxQayvzhvegZ7V0e5Hjj2Lk2ZX7HEwdimqQurvUKLS2AGOPUXP1waEGMZXIGB2C
         Hhj6jIlnxy3lY475P/Lotp41fyWb42wu47OfhQA+aKRnL3U5sOQeU051xOQDau83qXmt
         lq9g==
X-Gm-Message-State: ACgBeo2oDWrFjQ4hJR4RqcNARwJApYYlrsoNY8LRuaSHvir/SwLUJxao
        gq2s6PwTU7KkUtWHdicU1Hc=
X-Google-Smtp-Source: AA6agR4HsE72Xr6ALhwI6WQqm+kDihGD7B9sepp1wGrtl/l69TN314KgXpIdzZ2DhWMVpy51mpyXMA==
X-Received: by 2002:a05:6402:2756:b0:443:4a6d:f05a with SMTP id z22-20020a056402275600b004434a6df05amr21985554edd.396.1660753897300;
        Wed, 17 Aug 2022 09:31:37 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906210200b0073100dfa7b5sm7038901ejt.33.2022.08.17.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:31:36 -0700 (PDT)
Date:   Wed, 17 Aug 2022 18:31:35 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4 1/4] landlock: Support file truncation
Message-ID: <Yv0X52lix7PrFtaK@nuc>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-2-gnoack3000@gmail.com>
 <90883a01-4d32-c3d0-4334-563ba9a5a39d@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90883a01-4d32-c3d0-4334-563ba9a5a39d@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 16, 2022 at 09:20:06PM +0200, Mickaël Salaün wrote:
> On 14/08/2022 21:26, Günther Noack wrote:
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b8ea59493964..6648e59fabe7 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -380,6 +380,16 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
> >   Previous limitations
> >   ====================
> > +File truncation (ABI < 3)
> > +-------------------------
> > +
> > +File truncation could not be denied before the third Landlock ABI, so it is
> > +always allowed when using a kernel that only supports the first or second ABI.
> > +
> > +Starting with the Landlock ABI version 3, it is now possible to securely
> > +control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access
> > +right.
> > +
>
> This should be in the forth patch, below the file renaming and linking
> section.

Good point, moved.

> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..a2fef267bf34 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
> >    * A file can only receive these access rights:
> >    *
> >    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> > - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> > + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> > + *   you might additionally need the `LANDLOCK_ACCESS_FS_TRUNCATE` right in
> > + *   order to overwrite files with :manpage:`open(2)` using `O_TRUNC` or
> > + *   :manpage:`creat(2)`.
> >    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation APIs
> > + *   like :manpage:`truncate(2)`, :manpage:`ftruncate(2)`, or
>
> s/through file truncation APIs like/with/

Done.

>
>
> > + *   :manpage:`open(2)` with `O_TRUNC` or :manpage:`creat(2)`. This access right
>
> :manpage:`creat(2)`, or :manpage:`open(2)` using `O_TRUNC`.
>
> With only one "or".

Done.

Thanks for the attention to detail in the review!

—Günther

--
