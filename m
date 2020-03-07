Return-Path: <SRS0=CcHb=4Y=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D337C10DCE
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Mar 2020 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5311F2067C
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Mar 2020 02:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="a4uiYIZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGCOt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:14:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33933 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGCOt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Mar 2020 21:14:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id c21so4778255edt.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Mar 2020 18:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgA+GvZHpxvqH3AlWIOKDGZc5EP123kI9OgSbOMqtU4=;
        b=a4uiYIZFMxKAVY9caf6/FpeTpmWiKGsYh2zhBSXh2tjTxcvnQZDh1k1jPiqpt9nhmd
         dcNE7FVI7VYb/nvWpVcD2L7UTGlcuRbagmv9CwDIvgTBuhfkVjItugNluzwURXEDCe5E
         znHHI48tbJYxxPIEykXI5oorZrbUWUxYzjnulx099xdAABSJD7llM9J8mTEfwXRZMUH9
         rkXrSiZf7kG0VXDCkN01hIDpztQ2SOtAheJPMhESjQKN+c20rXEldCKAHhb7LhDJ868w
         S0SPWizxGIzlEvw3ilmTNiBhl5L8dteEVu/PuZyo8mqeo82A9ZvYxIkR8C37YnBeI/e+
         xDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgA+GvZHpxvqH3AlWIOKDGZc5EP123kI9OgSbOMqtU4=;
        b=UL5eX06EpXBmGHjpx/W3FUBwe1gFk0dZNG2tTfQXrFGMOsBy/BZiPeo2KEJbGdTQJf
         Z3bVLJaT5GM1aKnOE3oBdBVu7dTvTwPgP5YxuzDlIu0bH5UjCiUWJRBxBJeLF4+qTdCo
         nxubkilqgSIgtYk2dz5poIvaCExPmOlHXBW9/HT4LqiAPIRw0LEHgFkjN3Tv7xvx3Y/T
         6yRHGZdY+RKgM+O0nQuj/QUFCpsVatDLKoqmxWjOKwu3vdXax+6o2tT8Qykyfw1XiOJE
         OX2fZ2wjuNgSd+sYGOMQmYEPn9/QvsvWKaCihVGaCV2yDn11FuBW3l7bsv7T2K31Vjyv
         Ja7g==
X-Gm-Message-State: ANhLgQ3Ibe/oaGHzEdR8NfQD5F57mj7XnkYrB25Kua8wm3lgobVuaQTO
        l8VK461KZ51yvF7qFuFbGtssUSffxndD5z4QSOiH
X-Google-Smtp-Source: ADFU+vsLgoAW6B9s9yosK5UWrnm/hMReRrYEzZF6nV3yNR9ckjGMUDJe3X2Yp1ar/5qpmDzKMknrG7Xsm98SZHuY4X0=
X-Received: by 2002:aa7:c1d3:: with SMTP id d19mr6310409edp.12.1583547286144;
 Fri, 06 Mar 2020 18:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-19-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-19-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 21:14:35 -0500
Message-ID: <CAHC9VhREcdFNtJkXkUrwtbu8GA_h2T5CJ9hAQCU0PSpd5yLGgg@mail.gmail.com>
Subject: Re: [PATCH v15 18/23] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 14, 2020 at 6:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Netlabel uses LSM interfaces requiring an lsmblob and
> the internal storage is used to pass information between
> these interfaces, so change the internal data from a secid
> to a lsmblob. Update the netlabel interfaces and their
> callers to accommodate the change. This requires that the
> modules using netlabel use the lsm_id.slot to access the
> correct secid when using netlabel.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/net/netlabel.h              |  8 ++--
>  net/ipv4/cipso_ipv4.c               | 23 +++++++-----
>  net/netlabel/netlabel_kapi.c        |  6 +--
>  net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
>  net/netlabel/netlabel_unlabeled.h   |  2 +-
>  security/selinux/hooks.c            |  2 +-
>  security/selinux/include/security.h |  1 +
>  security/selinux/netlabel.c         |  2 +-
>  security/selinux/ss/services.c      |  4 +-
>  security/smack/smack.h              |  1 +
>  security/smack/smack_lsm.c          |  5 ++-
>  security/smack/smackfs.c            | 10 +++--
>  12 files changed, 59 insertions(+), 62 deletions(-)

...


> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 376882215919..adb9dffc3952 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -106,15 +106,17 @@ int cipso_v4_rbm_strictvalid = 1;
>  /* Base length of the local tag (non-standard tag).
>   *  Tag definition (may change between kernel versions)
>   *
> - * 0          8          16         24         32
> - * +----------+----------+----------+----------+
> - * | 10000000 | 00000110 | 32-bit secid value  |
> - * +----------+----------+----------+----------+
> - * | in (host byte order)|
> - * +----------+----------+
> - *
> + * 0          8          16                    16 + sizeof(struct lsmblob)
> + * +----------+----------+---------------------+
> + * | 10000000 | 00000110 | LSM blob data       |
> + * +----------+----------+---------------------+
> + *
> + * All secid and flag fields are in host byte order.
> + * The lsmblob structure size varies depending on which
> + * Linux security modules are built in the kernel.
> + * The data is opaque.
>   */
> -#define CIPSO_V4_TAG_LOC_BLEN         6
> +#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct lsmblob))

This isn't as bad as the sk_buff.cb limitation so I'm not going to
worry too much about it, but just to be safe I think we should put a
compile-time check to ensure that the local tag is within the bounds
of the IPv4 option limit.  If we don't put a check I worry that there
is a chance someone could get a very rude surprise at some point in
the future (yes, this is highly unlikely, but still possible).

>  /*
>   * Helper Functions
> @@ -1467,7 +1469,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>
>         buffer[0] = CIPSO_V4_TAG_LOCAL;
>         buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
> -       *(u32 *)&buffer[2] = secattr->attr.secid;
> +       memcpy(&buffer[2], &secattr->attr.lsmblob,
> +              sizeof(secattr->attr.lsmblob));
>
>         return CIPSO_V4_TAG_LOC_BLEN;
>  }

-- 
paul moore
www.paul-moore.com
