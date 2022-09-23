Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FAC6FA83
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIWVDU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiIWVCy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 17:02:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555EB11D0E6;
        Fri, 23 Sep 2022 14:02:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z13so3100631ejp.6;
        Fri, 23 Sep 2022 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=VKZTH+Io4cV6sl5rrCGea2z2/wkx+/IsG1EnC+sYkFQ=;
        b=BgyQk+x3yhCpoPMwskTNTpkJTg92SAVrbG+O7SH08cTikz1+XOVEpq85b4bbs9Pnc1
         KHdKu3HTvB57q9R0VQ3Mhdsl0wWtdw7RpnbACSvBJ5AYjznvqJjBhAMzLS5XlTYMmNAt
         eeGSBPCvI0m0ZFP53RWRGubsmI+ubvIoNDkoB1tqOK6W4ng84A0tucszo/g9RYlH6R3n
         aEH3/7RtDiSD0hAS5c6mNkj0GUIF2Km87bvb+8Mt3txQj4GeUTwyiamfNekHZxFipsId
         Mp5XjNiTgu6sczBXFsdEozQQF9zEjAN8IqxGdsIHzTRN4O+nXyCWRRE7eCJgDYu4cXA5
         rkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VKZTH+Io4cV6sl5rrCGea2z2/wkx+/IsG1EnC+sYkFQ=;
        b=MearxsXz6j7LjvB5/ITsUHo/wbO0TWhC5J3Wlohd0eqR7CKJwA6+n9vtdXcjDaoVBx
         YyqAe2bKjqjKbys9AjtvKOxfoBHyfiXJPIBjZVoXrScwj9NuEqA2Kg6SQcQSKLtyVt+K
         AGBS+KmM7ik6zH9ekOf8qhHkAjNl2S47l/mmJqBRRlIm/NwI9V9T36hG/wz+HJzFBWNo
         VpjPhOsBx7Brp9sq3ZPr2PaNmeU3GapTUTJ6+YXpeWq189ntGPUyb8MNl+rI+7PzOSIE
         u7egNRCw/7F08BMf2+HpiTlntSdM5FGQJAelgxCsmHxCsdSnrpe6wRKGK9eGkDie10ia
         qo2A==
X-Gm-Message-State: ACrzQf2YNmOIa3QO1wnj+B4U/n0LdO7AvqlHGGkTl4IsvjvkALDp1pno
        BWFN0atJ4IzjXI6CE0r8ikU=
X-Google-Smtp-Source: AMsMyM5mlFUgZouerKyNqEfmd7hoz5QNx9ae6GvCyC3/HMiuULVo4WtuwxeVOR5Ko8/BWs0NfkFxTg==
X-Received: by 2002:a17:907:728e:b0:782:8e91:64c8 with SMTP id dt14-20020a170907728e00b007828e9164c8mr5424036ejc.36.1663966932675;
        Fri, 23 Sep 2022 14:02:12 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b0073dd8e5a39fsm4434163ejt.156.2022.09.23.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:02:12 -0700 (PDT)
Date:   Fri, 23 Sep 2022 23:02:10 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/3] samples/landlock: Print hints about ABI versions
Message-ID: <Yy4e0nTiO6dv/Eif@nuc>
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923154207.3311629-2-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

This patch is a strict improvement over what the sample code was
before, so that's fine with me review wise.

I still think it would be good to point out more explicitly that the
"refer" right needs a different fallback strategy for the best effort
mode than the other rights will do in the future, as discussed in [1].

In many "best effort" scenarios that people need for their code, the
part that is actually fixed are the access rights that their code
declares that it needs. So if they actually need the "refer" right for
their programs to work, they cannot use Landlock on kernels that only
support Landlock ABI v1, because under ABI v1 they will never be able
to hardlink or rename between directories when Landlock is enabled.

The way that the sandboxer example is dealing with it, it just gives
the user a smaller set of access rights than they requested if the
kernel just supports ABI v1. It's somewhat reasonable for the
sandboxer tool to do because it doesn't give hard guarantees in its
command line interface, but it might not be negotiable in more
practical examples. :)

[1] https://docs.google.com/document/d/1SkFpl_Xxyl4E6G2uYIlzL0gY2PFo-Nl8ikblLvnpvlU/edit

—Günther

On Fri, Sep 23, 2022 at 05:42:05PM +0200, Mickaël Salaün wrote:
> Extend the help with the latest Landlock ABI version supported by the
> sandboxer.
> 
> Inform users about the sandboxer or the kernel not being up-to-date.
> 
> Make the version check code easier to update and harder to misuse.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220923154207.3311629-2-mic@digikod.net
> ---
>  samples/landlock/sandboxer.c | 37 ++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 3e404e51ec64..f29bb3c72230 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -162,11 +162,10 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
>  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
>  	LANDLOCK_ACCESS_FS_REFER)
>  
> -#define ACCESS_ABI_2 ( \
> -	LANDLOCK_ACCESS_FS_REFER)
> -
>  /* clang-format on */
>  
> +#define LANDLOCK_ABI_LAST 2
> +
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
>  	const char *cmd_path;
> @@ -196,8 +195,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			"\nexample:\n"
>  			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> -			"%s bash -i\n",
> +			"%s bash -i\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
> +		fprintf(stderr,
> +			"This sandboxer can use Landlock features "
> +			"up to ABI version %d.\n",
> +			LANDLOCK_ABI_LAST);
>  		return 1;
>  	}
>  
> @@ -225,12 +228,30 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		}
>  		return 1;
>  	}
> +
>  	/* Best-effort security. */
> -	if (abi < 2) {
> -		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
> -		access_fs_ro &= ~ACCESS_ABI_2;
> -		access_fs_rw &= ~ACCESS_ABI_2;
> +	switch (abi) {
> +	case 1:
> +		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +
> +		fprintf(stderr,
> +			"Hint: You should update the running kernel "
> +			"to leverage Landlock features "
> +			"provided by ABI version %d (instead of %d).\n",
> +			LANDLOCK_ABI_LAST, abi);
> +		__attribute__((fallthrough));
> +	case LANDLOCK_ABI_LAST:
> +		break;
> +	default:
> +		fprintf(stderr,
> +			"Hint: You should update this sandboxer "
> +			"to leverage Landlock features "
> +			"provided by ABI version %d (instead of %d).\n",
> +			abi, LANDLOCK_ABI_LAST);
>  	}
> +	access_fs_ro &= ruleset_attr.handled_access_fs;
> +	access_fs_rw &= ruleset_attr.handled_access_fs;
>  
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> -- 
> 2.37.2
> 

-- 
