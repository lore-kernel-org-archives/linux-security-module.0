Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988ABC636CC
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBPTsf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBPTse (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 14:48:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E53A853
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 11:48:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v13so6994880eda.11
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=coFEcwOcCn0uU680rNr5fBKBq7V1thyj3WuBBIVdy48=;
        b=UZbr8THHMYagZn65bBhFWCeATYrd/tcbRnKK0xTZTj6iqgFNZ6uQaDg+fKKfgtL2bQ
         FHRDxsRAMdPZiqD6lBgnGexO73yDvEzCUvX2m0qdeDldO4C7vfbun4MR1B9wdEbLF67p
         x10v2OwP4bXlqm+zjU+TwKYmHsBvs7+Y+wyB7TKrBA0l25sERMu2BNDo6E1WpFjPKn44
         1Q2PX2Oy3JXocf6M1NcSdIbaaXkaD4X4dkMV9QH2R8swqgbqa8KjbvGJcrtGI69Ygm/I
         U6srmCXYN6Xee9X9wceU5I874JZiUslGTeFoo7iOJUPoCil7Yh1ss7oZrXNCFhTL6QlV
         5o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coFEcwOcCn0uU680rNr5fBKBq7V1thyj3WuBBIVdy48=;
        b=DBoJpSgUKWhiSvgKZ7AYZZS1lIE34Ymj3rZ2/Qphk0wIo2oIdP9FGUTyZ352Sw8wJi
         GyduyzQ3uKAqXEjHa01dMI3AFEzAjUMD6N2kIMrfFCVA8L5TGwUC3pfvu46W80NQOYyY
         uA1du7ooyTAfGrfTbIiZ90909YU4ajvu+zAi/JQ4wuve0eZwdDof53AEOMYgcSRowjpE
         8Nk0gyhvMuTUhAGu4O5gpAx9l5lnlGDb1V1xNSSI6cs8D103F6LVY2w7awfBkG88hW6k
         D9iwxAvHOkGRowoyW2bc4TOFtWuor4uCPhpOqpl6PCqQoQNpb1HaAHSnqOK7rHL3zUgd
         vsEQ==
X-Gm-Message-State: AO0yUKXcpt+JjEv5HSH5mPoYpDrTHOsRNGLsbavtfcQKCYyJaKwXxgFC
        XC60JMgQS1KDIobQYznjxZQ=
X-Google-Smtp-Source: AK7set9x29O+KLIZSooVZL4Jxe84DC6WyZZpztYl3BWu1Tv2jo5ujS2j1EyVL/dYPIm0HdZ+mRjYiw==
X-Received: by 2002:a17:907:3da4:b0:8b1:7fe9:162e with SMTP id he36-20020a1709073da400b008b17fe9162emr573053ejc.47.1676576912201;
        Thu, 16 Feb 2023 11:48:32 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id j24-20020a1709062a1800b0087223b8d6efsm1184138eje.16.2023.02.16.11.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 11:48:31 -0800 (PST)
Date:   Thu, 16 Feb 2023 20:48:30 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v2] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Message-ID: <Y+6Ijsa7bXgf/meQ@galopp>
References: <20230213210115.5150-1-gnoack3000@gmail.com>
 <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net>
 <Y+0la4VBbkV8rlkD@galopp>
 <Y+1BxwRbdY+PZXNA@galopp>
 <a66bb3f7-9d8d-f2da-9b92-be489780c67b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a66bb3f7-9d8d-f2da-9b92-be489780c67b@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

On Thu, Feb 16, 2023 at 07:42:51PM +0100, Mickaël Salaün wrote:
> On 15/02/2023 21:34, Günther Noack wrote:
> > Sorry, correction (+ABI, s/to/for/):
> > 
> >    This access right is available since the second version of the
> >    Landlock ABI.  This is also the only access right which is
> >    implicitly handled by any ruleset, even if the right is not
> >    specified at the time of creating the ruleset. So, by default,
> >    Landlock will deny linking and reparenting files between different
> >    directories, and only grant this right when it is explicitly
> 
> and will only grant…?

Good point, done.

> > > Both valid points. How about the following phrasing which is
> > > formulated a bit closer to the actual goal (not creating a loophole
> > > through which you can gain more access rights for a file):
> > > 
> > >    * The reparented file may not attain more access rights in the
> 
> s/may not/cannot/ ?

I think "may not" is used when it's about permissions, whereas "can
not" is about ability. "may not" seems more appropriate here, because
the process is still free to attempt it, and we are explaining the
consequences below.

> s/attain/gain/ ?

Yes, thanks -- apparently, "attain" is more used for goals whereas
"gain" more for resources, so "gain" seems more correct here.

> 
> > >      destination directory than it previously had in the source
> > >      directory.  If this is attempted, the operation results in an
> > >      ``EXDEV`` error.
> 
> Better too!
> 
> This is becoming a bit difficult to follow, you can send a new patch with
> Alex in Cc. :)

Thanks for the feedback, I will send a revised patch.

–-Günther
