Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E36C54E94
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Jan 2023 17:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjAYRL5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjAYRLn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Jan 2023 12:11:43 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E11C318
        for <linux-security-module@vger.kernel.org>; Wed, 25 Jan 2023 09:11:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jl3so18466939plb.8
        for <linux-security-module@vger.kernel.org>; Wed, 25 Jan 2023 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ypZpvs8t+ah2+7CS58iyRxO8rfL4b3yK7iRiyGOgkRI=;
        b=SqB+4KFVPnZDxTftBviccWDNEZbt0/IQ5Wftz/GUJmI9gTQhWKbKuoE5Z3srDsvcke
         HPJQXAtBj1WMiCHFZChJHrUjLIkrCk3L4I/8MF0phXwdv7GsTeGi2TRWEX7QOxZ5nepn
         Ap2Z/KwLB4TjVHIO8wlGmwpW+/uVBpFl+fet7eQK9yXqFb3A0kgFDRSD7LCz9T3IVCZw
         yOFSTwzWsIcIB6q0DIjj8a5MgWGzhunfXOZeORlyJ2qo/npbjeCFjmEIf4zvnjP4AFm+
         Da/vz1RUdmEGsDvxJ2SzTGpyYUIt6nAv2UFxH2Yhsp7FgzT3oh61TLsQNy8NOUDDqCJM
         exPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypZpvs8t+ah2+7CS58iyRxO8rfL4b3yK7iRiyGOgkRI=;
        b=UVBXMFEgZb0xhWPvxe18pLarQvnYAqaB9VkREiwF3cziFaRW+MEYyJdTjh0JEDookM
         XdUS8d8PN/rI6LUS+HCa8/46JSJi15TYJFWjaoYuB4H4WCfDkthfcqzHiCpAG+e4NOkM
         WfvCZrJTLvuPK37x9/QdAexEJlORYmCpml2M4mBcmH6jSwhK8Gks/afgu5SR2Pvm2y+Z
         HRORESpuv1twjCj3YPL0owM5kzoL8Ml3VL4zz9Ex07bxuONwZPD+6vU21E6UTCmxl69/
         Ggl67RvdSzxSYxDhGkm9/7raOyuvKWJjsOX3K5FsjQwb0G6jiYPH73HLa/3opFpIuP49
         Osbw==
X-Gm-Message-State: AFqh2krWLhw3ze9fnI4O3l7j6o6CBKtWC8MzjlHZBi+BGcpzaToEhN+s
        zQLEyzgej0j4rhMZSBPNFYCNcrX+lDBkE+H5D2Ct
X-Google-Smtp-Source: AMrXdXtFfqeRhZW/zOLDggy19BiitwNk/LdYtMGsZagQE79iAnGzkr+nEZtRet993qCwaRR0/psxLj7EzffVz6gvxls=
X-Received: by 2002:a17:90a:c784:b0:227:202b:8eaa with SMTP id
 gn4-20020a17090ac78400b00227202b8eaamr4020652pjb.147.1674666671726; Wed, 25
 Jan 2023 09:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
 <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com>
 <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com> <CAGudoHHkeF-ozA-A+7ZcJP-Su02PwE4rfQ79VgD0zw8zS84YwA@mail.gmail.com>
In-Reply-To: <CAGudoHHkeF-ozA-A+7ZcJP-Su02PwE4rfQ79VgD0zw8zS84YwA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Jan 2023 12:11:00 -0500
Message-ID: <CAHC9VhTOeGXqqsbfuWXoe+od4YvfCoPPCwyionRGOj2ZaTH4mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 25, 2023 at 11:17 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> So I posted v3 with the comment, you are CC'ed.
>
> I'm not going to further argue about the patch. If you want to write
> your own variant that's fine with me, feel free to take my bench results
> and denote they come from a similar version.

Once again, I see the back-and-forth as more of a discussion, not
really an argument in the combative sense, but everyone reads their
email differently I guess.

The comment is an improvement, thanks for that, now it's just a matter
of hearing from the VFS folks.

-- 
paul-moore.com
