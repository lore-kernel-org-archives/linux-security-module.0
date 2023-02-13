Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E0C636D4
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Feb 2023 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBMUsH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMUsG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Feb 2023 15:48:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619941EFFF
        for <linux-security-module@vger.kernel.org>; Mon, 13 Feb 2023 12:48:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id fj20so14709353edb.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Feb 2023 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bEF0Uv4nqzWYArArCXmrzwiFeQwIfY9NU5mdanXZIz4=;
        b=cV/nyaiFZoYmhGXc0Sk/WPslOmokbAk5nVSGDfKDhhpuzJS3XAIq7alG8gDozpzH+S
         gCNNaGf/iBRQ9R+J6hvMSWFMODslj9LrGlDG5nvEOB47HIuRG+3rsyNvnACRCiuS32rB
         NWxguTTyrssX4gyabNnhTv5j8PtHiAYDDcWbKCS4lVAL5j5nXXVVlBkiP++rehH+9H8f
         KNPORpamVdHxeQ+NXOxAZLHhNmzRHIw7TMmUFPyNOctvz0L79hxTWa7w8zOzYgqQ2qJl
         YJkQIZlbbyGMYkI3PIzEE4ALE96L0umWL4yiA5gx9kPR7ySP6/cbeCkfHCOH+Hgsi9n1
         yr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEF0Uv4nqzWYArArCXmrzwiFeQwIfY9NU5mdanXZIz4=;
        b=B1Le4qlr1WtNa8IiaJIf7JUzohQqDK27OsWINATMDp/+edrZXytvGjLLx9In4TqAma
         weMHkphcxavNY6AhFG9qXtN397cpZrRZ2fgvxTppKL3xB2LkFXznyHIuemFVazUti1b9
         a/OUYQYvsHk6RpUPKmKKU/O5LKaihJaaetoIziV0GRtJgiWK20RulwTtjE/RU8nP1j6T
         I1Qf4JJk46l9UJJoksazQrQMKxuxeXD27JPr2J+Ffx54CoLK+HtXjlybOL9y52NtJHCv
         VtDU7Gp4aRrlrymdbjOfZ7ydXZTFGy93hCGse95a9tIvKD5VV00vmVKEtJDNhbs2EFF2
         0ixg==
X-Gm-Message-State: AO0yUKXTUrkUgUly+m+d0z1mInE8sj7011gCDQ/jPnkTy/Yw8rpQ/1X9
        k1c+BTXuckkM2QrGjC/5NVw=
X-Google-Smtp-Source: AK7set8pay9QiEyTsmg3TI5Wk2ykIJJCfS79GFwRTcGbuh+JtjojzrHcyo6PB+zixXDH21uRRWDRBg==
X-Received: by 2002:a50:d081:0:b0:4ac:be53:178e with SMTP id v1-20020a50d081000000b004acbe53178emr66447edd.6.1676321283879;
        Mon, 13 Feb 2023 12:48:03 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id w9-20020a50d789000000b004aacee2728dsm7140285edi.19.2023.02.13.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:48:03 -0800 (PST)
Date:   Mon, 13 Feb 2023 21:47:58 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Message-ID: <Y+qh/jm66gMzd865@galopp>
References: <20230202204623.10345-1-gnoack3000@gmail.com>
 <29b06bf8-cca7-f815-2e22-255297bf39cd@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29b06bf8-cca7-f815-2e22-255297bf39cd@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Mickaël!

On Mon, Feb 13, 2023 at 08:14:27PM +0100, Mickaël Salaün wrote:
> Thanks for the doc improvement Günther!
> 
> On 02/02/2023 21:46, Günther Noack wrote:
> > Clarify the "refer" documentation by splitting up a big paragraph of text.
> > 
> > - Call out specifically that the denial by default applies to ABI v1 as well.
> > - Turn the three additional constraints for link/rename operations
> >    into bullet points, to give it more structure.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
> >   1 file changed, 26 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f3223f96469..0cc58e0361f 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
> > + *   This access right is available since the second version of the Landlock
> > + *   ABI.  This is also the only access right which is always considered
> > + *   handled by any ruleset in such a way that reparenting a file hierarchy is
> > + *   always denied by default.  If left unspecified during the creation of a
> > + *   ruleset, linking and renaming files between different directories will be
> > + *   forbidden, also when done on a kernel using Landlock ABI v1.
> 
> What about:
> forbidden, which is also the case when using the first Landlock ABI.

Applied, makes sense.

> > + *   In addition to permitting this access right, the following constraints
> > + *   must hold for the access rights on the source and destination directory:
> > + *
> > + *   * The destination directory may not grant any access rights which are
> > + *     forbidden in the source directory.  Otherwise, the operation results in
> 
> "forbidden to the source file."
> 
> Indeed, the check is done according to the source file and compared to the
> potential destination file. For instance, the parent source directory may
> not allow to execute the source file, but the link will be allowed even if
> the destination directory allows file execution in the case of the execution
> right being tied to the (linked) file itself.

Ah, I didn't notice that, thanks for pointing it out! Changed.

> > + *     an ``EXDEV`` error.
> > + *
> > + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
> > + *     the respective file type is required in the destination directory.
> > + *     Otherwise, the operation results in an ``EACCES`` error.
> > + *
> > + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> > + *     respective file type is required in the source directory.  Otherwise,
> > + *     the operation results in an ``EACCES`` error.
> 
> There is also the RENAME_EXCHANGE case when we need make and remove access
> rights in the source and in the destination directory, but it would probably
> confuse readers to specify that.

I'll leave it out for now, to keep this patch focused on rewording. I
feel that adding it now would open another can of worms better left
for a more dedicated code review. ;)

–-Günther

