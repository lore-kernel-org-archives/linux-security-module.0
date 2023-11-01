Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F21C4167D
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Nov 2023 01:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjKABcH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Oct 2023 21:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjKABcF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Oct 2023 21:32:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A0F4
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 18:31:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d865854ef96so5761543276.2
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698802319; x=1699407119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAtbtXoeyQL2kI+3xh8JmxZpodoQXPkbKDeMUcyZ+DU=;
        b=IFPouKtcWELcNlKP5qKaVshNtxWTHbkG3zwk8ABZaxtlbjnOFhQNp2viGMbxi5rhkq
         hHXDH2S9f3d7ZYAsjNyV0CDUIDshEBsw5Z2PMX3HEQBrLPdq7wZGz9bnY2Pb1BBue6mj
         Ibtk7bdGInN1E/mhln1clpqrsNO98O9S2xazw4CSEuAjg6X/exyOn3m4HGw6LTuCyjNJ
         OJ6z7OsudloLlwgrsFsahpH0mdThXAcdxF5IvhHc/2a5jPLevROo1HGl4q/3cbWu/unu
         nyJfRfIgNFrMKWD01cHrQTBE5vNqIKPQyyxxhW4y7iPVRkVHFEOLoWiKyWcdb6I0hd4x
         I7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802319; x=1699407119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAtbtXoeyQL2kI+3xh8JmxZpodoQXPkbKDeMUcyZ+DU=;
        b=DMFy432zD0d8m1m2THoCpzKHT/xVnVPqs7D+a9Vuu/yTQTFeiDAf1J0KmwTWEPESNC
         NKzJFeX1sw/xh9U4DlOaxMXGuqXvwa+UCi+1dIiuIWFcanthRVD0mGmwnVPwsSoITdvP
         2daVedVw4MWuh+27IxgArpQ+31taRguQTS4WsHdV2bZZftSk4VgCG7cJRaNWRGA59vZD
         vyYS1R7wzLX4LVsJ17CNEi+uCAielamx1x/ogwXHWFp7mcjQ1/3VpEFq9c/Ob5KmA8hA
         a4oqS3Xs0096mW8AUPjoGHa1/RkLA/AyWpbBOfSdC1pRgNUr5uwbY0jh0Pzaq8WcZczy
         K6Kw==
X-Gm-Message-State: AOJu0YytMR5jghHnkLBvH41vt6tbNqB//0HkJDCDA2JsQC7GbL9h5dOY
        dTz64DOseVSMKWC14HvHonisHA295oVshAX9ngxn+X2nH0iht8g=
X-Google-Smtp-Source: AGHT+IFaty8q/YU9+RKjuTi/K5RqkTtKBa9esaVDZXsopmxgTuyR6pQ67IqImVBTbPpnJ2KaQP7urzV337kh2Od/6Ko=
X-Received: by 2002:a25:8243:0:b0:da0:3b7e:6ad8 with SMTP id
 d3-20020a258243000000b00da03b7e6ad8mr12576282ybn.10.1698802319135; Tue, 31
 Oct 2023 18:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com> <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
In-Reply-To: <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Oct 2023 21:31:48 -0400
Message-ID: <CAHC9VhQs9H-f8qZbwMgcF=LHEwspxvdJSNhhjwGu5K-ExYjPZw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20231030
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 31, 2023 at 2:13=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, 30 Oct 2023 at 16:16, Paul Moore <paul@paul-moore.com> wrote:
> >
> > * Use a better hashing function for the SELinux role tansition hash
> >   table.
>
> Bah.
>
> While the old hash function was garbage, the new one is quite expensive.
>
> Maybe it's worth it.
>
> But generally, if you find that "oh, just doing a modulus with a power
> of two drops all high bits", the first thing to try is probably to
> just do "hash_long(x, N)" to get N bits instead.
>
> Assuming the input is somewhat ok in one word, it does a fairly good
> job of mixing the bits with a simple multiply-and-shift.
>
> Yes, yes, jhash is a fine hash, but it does a quite *lot* of (simple)
> ALU ops. While "hash_long()" is often small enough to be inlined.

We probably should do some performance measurements of the various
hash tables in the SELinux code and use that to drive some decisions
on what functions we use.  There have been some in the past for
specific tables, but I don't think we've done anything comprehensive,
or recent.  This latest change obviously focused more on ensuring a
better distribution, which can help, but if the digest calculation is
too slow it probably doesn't matter.

> I also note that filenametr_hash() does the old "one byte at a time"
> hash and partial_name_hash(). Is there any reason that code doesn't
> use the "full_name_hash()" which does things a word at a time?

Likely just a matter of no one looking at it and realizing it can be
improved.  I'll toss this on the todo list, it should take all of five
minutes.

> Probably doesn't matter, but since I looked at this to see what the
> new hashing was, I noticed...

No harm in mentioning it, feedback is always welcome, but you know
what else is even more welcome?  Patches ;)

--=20
paul-moore.com
