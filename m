Return-Path: <SRS0=ULH2=5W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B6C2BA1B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA1A206B8
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RF4PSQ9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDFSvQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:51:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35378 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFSvP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Apr 2020 14:51:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id r17so363182lff.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Apr 2020 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhtGc2NWi/8OTbqNFI47F+sBa8PMVgXlDImrvNA4WeI=;
        b=RF4PSQ9c4jPFn4H6RVBhebbVanX6GFbOLrOG5+Unj/WUoFPubwZM11fvBIKGAYwftJ
         Zgm2/O4v03W3DbXDUVS5ljY+yaztJk2uzRBoyCkU0mLc6LU0jSv0IOXAuA1GEq8rg9HK
         ld0K+E7Oks5lW3gbwj/gxVyDwi/yekrFAjEvo25NCwULZylzAHMP6WrFLp0ZhZIZ4OAq
         bM2zu1Wlb/74JizmfMIZwlN4iMv8M4LBl9PVzlCAc1iBmukHpwtb1U6BTlmT5igQ6C5P
         CnFUZd4WJEv0u/3EViJf+WnVIozV4rPWDXauNMMUn13fLREesEcNaXKQ3gkLbo7ZcMbO
         1G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhtGc2NWi/8OTbqNFI47F+sBa8PMVgXlDImrvNA4WeI=;
        b=DxU3pSw+RMnF/AzoklbQvSHGzymKxuEzP9U7Sbpn3MGDb1QvnUUZ++UKpX6WGUjV3X
         4k7XRXqJ3vaCIYK24GE1Jq+qtxfoQw+/bp8Q9lpHH0WeHE8FuZc6SWHZr1z3/SIEC8gI
         ZNZbOWjfdHK8V8wXIGddBxmvDDPRNT5QILgub4uZnWnYIbCOp+xy7tuCQntXsGTZJ6OB
         xt5a2DXt4nxXRb5h7wJJ68N4RHglVqIUnK3AWIaEWoBwazPe4y7MSRdIGB8JlR+KD07f
         PO0ExNlsdYgMDsHj8PQsUCaljNWSyObhjapQYR0rJBeOvpXvkqgCAIPIVEb8zdTw5StH
         Ve1A==
X-Gm-Message-State: AGi0PubfoqbkrBcC+NAqdu6NJw81liZ/ooSpaPbvN5wN/gw6MqY9tOQL
        Ik2EnjTrjiYHY0NNeL8UuSGwCaWdybFTow0F4zMyFg==
X-Google-Smtp-Source: APiQypKCNJNdNFC2PRonEgYGyMcSGGcujUHyRc434pzWMUoZss+1QGGz8dv1ab/TAjDHReQ3qA2uS582dsE/9/zblCs=
X-Received: by 2002:a19:c850:: with SMTP id y77mr13013340lff.45.1586199073198;
 Mon, 06 Apr 2020 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
In-Reply-To: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Apr 2020 20:50:46 +0200
Message-ID: <CAG48ez3JV-tzjRLdcys6Fz9LKYaB1h-1GaeAzkUYtY1RgxsB6g@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
To:     deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 6, 2020 at 8:10 PM <deven.desai@linux.microsoft.com> wrote:
> Overview:
> ------------------------------------
> IPE is a Linux Security Module, which allows for a configurable
> policy to enforce integrity requirements on the whole system. It
> attempts to solve the issue of Code Integrity: that any code being
> executed (or files being read), are identical to the version that
> was built by a trusted source.

Where's patch 02/11? lore at
https://lore.kernel.org/linux-security-module/20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#t
has everything other than that patch.
