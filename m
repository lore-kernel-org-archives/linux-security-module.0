Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95618C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCAE2083B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dvQDAhfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBET6t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:58:49 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34050 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfBET6t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 14:58:49 -0500
Received: by mail-lj1-f175.google.com with SMTP id v14-v6so1209796ljv.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCrWgjb7nbrMK1S1ftd6oG77h2t71Kr4nKoXfhqIMiI=;
        b=dvQDAhfZAtmArHhp1F0FpTCo44eamUe9Esbypix5lS1YpDGPjkQV02saGufqtYFmgN
         G+JvXHS5GpLkE6oTJPhXc22olyBFU5Wle+hBKLAn65CYCVrFtMPSivvH78LHujJKSf6Y
         tgcXGGFnVyWQ/mriFXsay3FbLRLsfhTLh6wWFm4Ya6FQaVz1BQQLjXsTcaYsSfjSwbYS
         3YNwJ755ma2OXEsp8W1Rkz2iFwfT/7DDmq5hX15gbNKMoHwgno/Oa7aBzsi41paT8qA/
         4E0pWm6rCmupepcojCx9WOxDkdYMTSQzHdr4Wy0VQORB9bnJMn44Ndzu/ofFNuhBKUJd
         c1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCrWgjb7nbrMK1S1ftd6oG77h2t71Kr4nKoXfhqIMiI=;
        b=RLnF4im0LQ3hg2fJ3A6rmG2CgNnCx+RQT7d9+7rJDFUQWM1u/JcGVrpq4cUkps87mm
         Ef+gGmbCllodarPKkwzD73VpjtD7KtBnEzRcKCyLivsWtDa724HI66dXqFR1+iMGDx1t
         8x7wB2BLgPG9P9oiGcLYeLujfbmtsBPIr2fNiVOMmy+5FtOWv3rnsMmOJIYnqc31RHx0
         aH1e2mVK2qBWoxfOhevkUvc7kcG9JH/U1Myrd4gIBCwzHugVMYqqtvrDLg+8xD/h2Kkp
         ZILlDE+DN4IPW178ObtYlmeqDVAe96hp1j6WTOYOEyOP1d58/KMvTPJoY1TEG4ihoDMH
         keoQ==
X-Gm-Message-State: AHQUAuaS/JLcljWWK7xPtfqHZRSRH/NIRvUNH0lhbtr77omaHQ6swbvd
        AbsQvg/zbmzTUbc8Xoza0iaMZ+aW5Oc/jJ1KaMfWaDY=
X-Google-Smtp-Source: AHgI3IZEPh2UNfVQfnyWnBoiNUV3jMRO86Apv4/yKQW6J5y8kfPdNcWem1zj4IxECDZvUhdFsnSNnYaqH20peGOrbYw=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr3960443lji.57.1549396726942;
 Tue, 05 Feb 2019 11:58:46 -0800 (PST)
MIME-Version: 1.0
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <000001d4bd80$8b9442c0$a2bcc840$@211mainstreet.net> <c15e8f04-df2e-40f4-d227-754d03de3dd0@schaufler-ca.com>
In-Reply-To: <c15e8f04-df2e-40f4-d227-754d03de3dd0@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Feb 2019 14:58:35 -0500
Message-ID: <CAHC9VhSdktacjbxSXA1k9Hqj-NpJca50UtE-9Ado-R9mB35j7g@mail.gmail.com>
Subject: Re: New LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Edwin Zimmerman <edwin@211mainstreet.net>
Cc:     LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 5, 2019 at 2:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/5/2019 10:28 AM, Edwin Zimmerman wrote:
> > Here's my suggestion for starters. According to kernel documentation, new
> > LSMs must be documented before being accepted.  Perhaps we need a
> > similar requirement for LSM hooks.
>
> That would be handy. The documentation would need to cover
> the purpose for the hook and how a security module would be
> expected to use it.

We have a weak version of this now with the comments in
include/linux/lsm_hooks.h, and as far as I recall we've pushed back on
people who have changed the hooks without some documentation in the
comments.  Whatever we end up doing, let's try to keep this going as a
practice.

-- 
paul moore
www.paul-moore.com
