Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D7C19F2A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiHDQfE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiHDQfC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 12:35:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C091CB37
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 09:35:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f22so327124edc.7
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rqaulu7H6cbAAFa+EeBtTzKSO174IAzVyd5jN0Jcuz0=;
        b=nEpPp2VPcWyetoDFnxbeoIhoxZ2UFj/5l4iwjQiDbZ+nksoS3VEihKmIi22fBrJuyn
         znG4TRYzdIGFatNUWEQCRUmsR2wGqWP1S6uCt9jS29PqtoIpuIA37URoojvjGJ5CIyUq
         FPzDeaTpANBWnLo3Np3U/79honlLIi72pXcd4b747T4r9Bt8YOrqYrZrso562HSnNyX7
         lbz7fzUngq5V9JeAe/6+jbXx6RUxhuCKiYGqvqN9Qv+JB3HZMqZ4NxjUQlDqudBRwfia
         X2Kb90lXlgEpawrDlB2/UXUZ4lYsykbpq7z/Dj2d0GonYQjIJzkXCWc4A7Bid7VQPZga
         noIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rqaulu7H6cbAAFa+EeBtTzKSO174IAzVyd5jN0Jcuz0=;
        b=iM0sj1nMZKvrjiRywXImfOBbVIUH2nK14VL7gAzoZFw3mq/VewMGJC7zFWLX/hspqY
         NIVy0QXhFJ9IBeHnbEQ6g8fVG998lJSwmblbfYW+9x5TpZvOGEKOivZXykThSQSrdcya
         e8CIgLfWPd5Q/u1bq5a65s0zXN1R9T+1IgGYvNZOaJlEuLfBD50nM8ieAk/yskJastwC
         tM6Mn0+vCX5gGxfY7vCHZnpfXMZ1CZzynJaT8rPX212b3GsERbHhltkeVYmbYEGV1he2
         eI5kewqzGshLyzoCe8cquzx4ub/2xN5IW1JWaEa2mbftpNMZIxotZDcPAf25bqmJLyyI
         r0fg==
X-Gm-Message-State: ACgBeo14NLdcrvhAzJPT1e0sYdUUlRSN+mw4a+fOA1SzHy1SZytRCcjr
        No+z7bgR9z5D4XJ6GF9MscsFp0Zc+K4=
X-Google-Smtp-Source: AA6agR6t8WlI8NbwXiX7x+xxlnoBgFhYHhu0wrBSx6zHOk0ilXSWKhQ21Fwqtpb6sA6KUUt0mO+veQ==
X-Received: by 2002:a05:6402:42cb:b0:43d:bf29:cf89 with SMTP id i11-20020a05640242cb00b0043dbf29cf89mr2833210edc.400.1659630899436;
        Thu, 04 Aug 2022 09:34:59 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906300500b007262a1c8d20sm525212ejz.19.2022.08.04.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:34:58 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:34:57 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 3/4] samples/landlock: Extend sample tool to support
 LANDLOCK_ACCESS_FS_TRUNCATE
Message-ID: <Yuv1MeHMLLK0ICIp@nuc>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-4-gnoack3000@gmail.com>
 <a300def1-587f-a770-2c3a-045e4da8d56a@digikod.net>
 <731b40e2-a95d-5eef-077b-375a50061a11@digikod.net>
 <62c37433-b9bd-ce7d-0b45-18ecfb15b248@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62c37433-b9bd-ce7d-0b45-18ecfb15b248@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 29, 2022 at 12:43:47PM +0200, Mickaël Salaün wrote:
>
> On 29/07/2022 12:38, Mickaël Salaün wrote:
> >
> > On 29/07/2022 12:31, Mickaël Salaün wrote:
> > >
> > > On 12/07/2022 23:14, Günther Noack wrote:
> > > > The sample tool will restrict the truncate operation if possible with
> > > > the current kernel.
> > >
> > > "Update the sandboxer sample to restrict truncate actions.  This is
> > > automatically enabled by default if the running kernel supports
> > > LANDLOCK_ACCESS_FS_TRUNCATE, except for the paths listed in the LL_FS_RW
> > > environment variable."

Done.

> > >
> > >
> > > >
> > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> > > > ---
> > > >     samples/landlock/sandboxer.c | 15 +++++++++++++--
> > > >     1 file changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > > > index 3e404e51ec64..4c3ed0097ffd 100644
> > > > --- a/samples/landlock/sandboxer.c
> > > > +++ b/samples/landlock/sandboxer.c
> > > > @@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
> > > >     #define ACCESS_FILE ( \
> > > >     	LANDLOCK_ACCESS_FS_EXECUTE | \
> > > >     	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > > > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > > > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > > > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> > > >     /* clang-format on */
> > > > @@ -160,11 +161,15 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
> > > >     	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
> > > >     	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> > > >     	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> > > > -	LANDLOCK_ACCESS_FS_REFER)
> > > > +	LANDLOCK_ACCESS_FS_REFER | \
> > > > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> > > >     #define ACCESS_ABI_2 ( \
> > > >     	LANDLOCK_ACCESS_FS_REFER)
> > > > +#define ACCESS_ABI_3 ( \
> > > > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> > > > +
> > > >     /* clang-format on */
> > > >     int main(const int argc, char *const argv[], char *const *const envp)
> > > > @@ -226,6 +231,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
> > > >     		return 1;
> > > >     	}
> > > >     	/* Best-effort security. */
> > > > +	if (abi < 3) {
> > > > +		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_3;
> > > > +		access_fs_ro &= ~ACCESS_ABI_3;
> > > > +		access_fs_rw &= ~ACCESS_ABI_3;
> > > > +	}
> > >
> > > I think it is a good time to start replacing this "if" check with a
> > > switch one:
> > >
> > > switch (abi) {
> > > case 1:
> > > 	ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
> > > 	access_fs_rw &= ~ACCESS_ABI_2;
> > > 	__attribute__((fallthrough));
> > > case 2:
> > > 	ruleset_attr.handled_access_fs &= ~ACCESS_ABI_3;
> > > 	access_fs_rw &= ~ACCESS_ABI_3;
> > > }
> >
> > Well, we can just mask ruleset_attr.handled_access_fs in this
> > switch/case and after mask access_fs_ro and access_fs_rw after.
>
> In fact, we can remove ACCESS_ABI_2 and ACCESS_ABI_3 (which are only used
> here).

Done (all three).

--
