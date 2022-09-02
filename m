Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C8ECAAD2
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Sep 2022 00:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiIBA4s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiIBA4r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Sep 2022 20:56:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5FA1D5E
        for <linux-security-module@vger.kernel.org>; Thu,  1 Sep 2022 17:56:46 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12243fcaa67so1355316fac.8
        for <linux-security-module@vger.kernel.org>; Thu, 01 Sep 2022 17:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Cm8x//sfvFO0babHLgWXLn4siXLBDZJX/lciSTmWoI0=;
        b=oSDLIJxsI5ChGICF8Jf9BYn83bl3RcvSrjTAR0iYGMxbQEr0oDA3dB9yMIngbU7+vJ
         xb/DV/8v69ZoGz7x9EdZzzG5WDzz672FT54380iLB/hg3BkdbiekUqmFWam8wvwrsNZH
         P7cg9GdwlBK3WIjBiU1XAtVqWfj35QC0h+WaicBle49DWLZv/0wu6Npjob9DQzOj18Pk
         LOo20UFp229opfl0R2OC25bWbrp2vBBnvNSkdwjzzGl7Nr9CDYIvbwtQamGTAZTFZ616
         xYKuIs6FzC5s0n5Ui8W2ZbR1UYgiOu55g0FHVoB3DOeq+H/6ODogXBH11hdTjzLrS5i2
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cm8x//sfvFO0babHLgWXLn4siXLBDZJX/lciSTmWoI0=;
        b=zg/O4bkxDyNnsoFKMloR6RvyIfeKI00ktjmSvUHNCH+QKu25qQJci7bjCQh2fBIhpo
         G5HaS9Gps4d3b+EetXbqOCVFSsag5s+PxkPiXINsAqWSTsxt3Kirt864Sjz/cVFLJHUe
         Hr6DHO+HAMgmHI9m2Rzp+imiuv3qKZfuE+hZtRIAtebEJtpsEC31pvUnCen/rtmPvQje
         c9wbNU9FC82v+yiAOWbLkDnEdiCnRWl0Ui4XP05O00Vswo8e+8cuw9kQCN8h5JOoJ3zx
         +MqBTbyiG1seJIlff1bFjCdhO5PGWqwXKGipdLt2UcDCZiyyXx1bP+qU06KdXdoXvS+/
         OLXg==
X-Gm-Message-State: ACgBeo1vIhAkGDYCqQw/vYlL5n5f8mFCG624/0127M2jJN+W6aSZmrci
        V63DogfHUqoV67MVuhKSh1wE5OvYR7Dmw3I02sfJ
X-Google-Smtp-Source: AA6agR4wv7A4tIt2g3FPjtd3yPWz+7nAm93lFsMZOgdbY8OzdcPuiV9mw53vup71hnUT8Rg1icEFppKe/k6N9861Wfs=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr885471oie.41.1662080205317; Thu, 01 Sep
 2022 17:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-8-cgzones@googlemail.com>
In-Reply-To: <20220615152623.311223-8-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Sep 2022 20:56:34 -0400
Message-ID: <CAHC9VhS8ASN+BB7adi=uoAj=LeNhiD4LEidbMc=_bcD3UTqabg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 15, 2022 at 11:27 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the interfaces `capable_any()` and `ns_capable_any()` as an
> alternative to multiple `capable()`/`ns_capable()` calls, like
> `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
>
> `capable_any()`/`ns_capable_any()` will in particular generate exactly
> one audit message, either for the left most capability in effect or, if
> the task has none, the first one.
>
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability will create an AVC denial.
> Using this function with the least invasive capability as left most
> argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
> to only allow the least invasive one and SELinux domains pass this check
> with only capability:sys_nice or capability:sys_admin allowed without
> any AVC denial message.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> v3:
>    - rename to capable_any()
>    - fix typo in function documentation
>    - add ns_capable_any()
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h | 10 +++++++
>  kernel/capability.c        | 53 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)

...

> diff --git a/kernel/capability.c b/kernel/capability.c
> index 765194f5d678..ab9b889c3f4d 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -435,6 +435,59 @@ bool ns_capable_setid(struct user_namespace *ns, int=
 cap)
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>
> +/**
> + * ns_capable_any - Determine if the current task has one of two superio=
r capabilities in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given sup=
erior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one aud=
it
> + * message, either for @cap1, if it is granted or both are not permitted=
,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. =
CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on =
the
> + * assumption that it's about to be used.
> + */
> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +       if (ns_capable_noaudit(ns, cap1))
> +               return ns_capable(ns, cap1);
> +
> +       if (ns_capable_noaudit(ns, cap2))
> +               return ns_capable(ns, cap2);
> +
> +       return ns_capable(ns, cap1);

I'm slightly concerned that some people are going to be upset about
making an additional call into the capabilities code with this
function.  I think we need to be a bit more clever here to take out
some of the extra work.

I wonder if we create a new capability function, call it
ns_capable_audittrue(...) or something like that, that only generates
an audit record if the current task has the requested capability; if
the current task does not have the requested capability no audit
record is generated.  With this new function I think we could rewrite
ns_capable_any(...) like this:

  bool ns_capable_any(ns, cap1, cap2)
  {
    if (ns_capable_audittrue(ns, cap1))
      return true;
    if (ns_capable_audittrue(ns, cap2))
      return true;
    return ns_capable(ns, cap1);
  }

... we would still have an extra capability check in the failure case,
but that's an error case anyway and not likely to draw much concern.

Of course this would require some additional work, meaning a new
CAP_OPT_XXX flag (CAP_OPT_AUDITTRUE?), and updates to the individual
LSMs.  However, the good news here is that it appears only SELinux and
AppArmor would need modification (the others don't care about
capabilities or audit) and in each case the modification to support
the new CAP_OPT_AUDITTRUE flag look pretty simple.

Thoughts?

> +}
> +EXPORT_SYMBOL(ns_capable_any);

--=20
paul-moore.com
