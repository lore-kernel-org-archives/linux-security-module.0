Return-Path: <SRS0=Z4XS=RB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A18CC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63B21850
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2AxKg7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfBZRqD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:46:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54962 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfBZRqD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Feb 2019 12:46:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so3296627wmh.4;
        Tue, 26 Feb 2019 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jxqdKoqoHk++Fasy44wy1pcXX6u9HWTWH2yxj3SDTG4=;
        b=s2AxKg7+BD6jPlIVJ1xuJXyM3J6D8ucVfa5f2NM4mE9jYYrUKaLelOMFgt+UbJnmxa
         ZIzb0vucG66AZnj2QQhyBTIwMUPVfb+VG2YEbsGmb8KFqAJbEEaiPt8Xu5RK7TCSdnFA
         K5+QD46kOeQ6ud4INw0D3JKuPrlTws2l1mhZ6OiLeZ0D7+2ViUKJhz60s+0NLIePuwPx
         q2vh4hJ6OXQm26Q3KPbHNib178vviVOR3Bj7HNh8hWiMzt4fxeLSqoiEJuMhpeR35dl8
         lXgH57AB2qiWPkGQuQqmb+WNyzA6bzOsTTGbRCXa9ALvIdddo8XRpjycLmBwaZUSqy1V
         b3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jxqdKoqoHk++Fasy44wy1pcXX6u9HWTWH2yxj3SDTG4=;
        b=YXSWnLz+Z4VStb9nlKs3S1yTAyKcYveXkXMgRdlS/0EryvqisrTjW4Z70hg13DS96b
         SLfdCFaZZgux67J6si8UB8i7ULKFMcm6RXFxdCWjHbhTmsJmsDi/TID7vQ2bmEPZ4wwB
         r3oE1LMaqM7hhcrxawZi4hzR2zYcExbPk4OIQZbniZEUN8VoH0RThhLITuHpNh0H1EXI
         3IqvY+DCBTOuMZ9NEOxeJIadQgCJNUg3Bsa8F6AnywXhQwYyhmeh3cAom22uZfb6WnFn
         8mzM73g4LrEGrKS8H/7PlrzOs129sC6VCwCPpjitOCvXl6sM0ijV/QP2sZ41Xcy4JqYN
         3fqQ==
X-Gm-Message-State: AHQUAuZhgcrRlc6c07iviumfiw6TgIPCSQz9gYgsk1G2bW/mj8eGEqW/
        o/uHtcEzFuIlNfOtHS040wq84N8g
X-Google-Smtp-Source: AHgI3Ib+w3BBKGn6iEoPfaRql7NaQbGswnToLFHQdF0Ox2TM2ecQwHjb54j6bnBPsymA5JU2yysrZA==
X-Received: by 2002:a1c:d049:: with SMTP id h70mr3398711wmg.81.1551203160476;
        Tue, 26 Feb 2019 09:46:00 -0800 (PST)
Received: from [172.16.8.139] (host-78-151-241-71.as13285.net. [78.151.241.71])
        by smtp.gmail.com with ESMTPSA id f13sm140127wme.4.2019.02.26.09.45.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:45:59 -0800 (PST)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 03/10] teach move_mount(2) to work with OPEN_TREE_CLONE
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059612649.17079.7287713053194562461.stgit@warthog.procyon.org.uk>
Message-ID: <df9dd587-8d13-50d4-37ba-e7db47b1229c@gmail.com>
Date:   Tue, 26 Feb 2019 17:45:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155059612649.17079.7287713053194562461.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 19/02/2019 17:08, David Howells wrote:
> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
> attached by move_mount(2).
>
> If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
> to handle detached source.
>
> That gives us equivalents of mount --bind and mount --rbind.

This is a bit ambiguous.  The two cases can be understood by analogy to 
bind / rbind.  But it is also seems natural, to think it could be used 
to implement the exact same thing as current `mount --bind` / 
`--rbind`.  I think it *does* now provide a full equivalence, right?

I was thinking about the case where mount propagation is enabled on the 
source tree, i.e. it is not a private mount.  Suppose a new mount is 
added inside the source tree, between open_tree() and move_mount().

In the previous version of the patch series, Eric suggested there was a 
NULL dereference in this scenario.[1]  This version should be safe.  I 
think the new mount will be propagated to the cloned tree. Furthermore - 
due to the way this version uses a temporary mount namespace - the 
propagated version of the mount will not be locked by 
attach_recursive_mnt().

[1] https://lore.kernel.org/lkml/87bm7n5k1r.fsf@xmission.com/

It looks very neat now, with the use of the temporary namespaces. 
Congratulations :-).  I have finished looking through these patches 1-3 now.

> Thanks also to Alan Jenkins<alan.christopher.jenkins@gmail.com>  for
> providing a whole bunch of ways to break things using this interface.
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells<dhowells@redhat.com>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
>
P.S. I guess Al does not need two Signed-off-by lines here.

Thanks
Alan
