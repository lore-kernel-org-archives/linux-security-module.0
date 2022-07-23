Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A62C43334
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Jul 2022 14:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiGWOaR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Jul 2022 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiGWOaG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Jul 2022 10:30:06 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4187E17E04;
        Sat, 23 Jul 2022 07:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658586576; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Cdk5zB8spFUck32lES6ymvWOW49Nk2dX62Ga5BzHiEMuUVqsF+VOY0B6Xd8XbFfH5G56ExBvuWYOSsk5g+HWOyjIaF7xqmwNNTz6f/r3tUYOJlmBaxKm0LEEAbEAanSYrU8oskEZqNdQIv+UWUBlbPnq4V4G5ds0OGP7xcLRPgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658586576; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nrLqE1VQZTfewo+huIJiOECXb8Z/AkxV3GsY/VPoroA=; 
        b=TGXEGLyCPRw7jo2oPjtSaayeHmx0mwu5QPW9yhNoVwvYF6agE0ruM2srciLqk0aR+OB+ZFhst6wJutv1gI5Sg53KTnryGX+XS4/rPstaBIPgejnD4vPPbBdb484yXGuvgVctvF96UIyRpDFVacRDFbxnY+ePUhN89MD8h/32ck8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658586576;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=nrLqE1VQZTfewo+huIJiOECXb8Z/AkxV3GsY/VPoroA=;
        b=HAwK2u2fVT4U+qrBKk2SJpEACflR3vDhV78T1rrMbXVDqo/6SCTTmQFzR1+X6ppZ
        MUq22UDFeKpknOEywseYLkVEs53BkHwqtlfFE76BK8v0IWOkCjp4pqBO5H8TK8J8aZy
        ootDBrMvSQQuZ+LPAGFVwpYPC4KAhKwC/cwPXLx4=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658586563873727.0268161715809; Sat, 23 Jul 2022 19:59:23 +0530 (IST)
Date:   Sat, 23 Jul 2022 19:59:23 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
In-Reply-To: <Ytv/4Tljvlt0PJ2r@kroah.com>
References: <20220723135447.199557-1-code@siddh.me> <Ytv/4Tljvlt0PJ2r@kroah.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 23 Jul 2022 19:34:17 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> Also you now have a spinlock held when calling rcu_read_unlock(), are
> you sure that's ok?
> 
> 

We logically should not do write operations in a read critical section, so the
nulling of `wqueue->pipe->watch_queue` should happen after rcu_read_unlock().
Also, since we already have a spinlock, we can use it to ensure the nulling.
So I think it is okay.

Though, it is my first time encountering a spinlock and an rcu lock together,
so if I am wrong, please do correct me.

Thanks,
Siddh
