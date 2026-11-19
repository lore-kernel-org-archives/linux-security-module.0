Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109458;
	b=12tl9ydspMXzyOUxIFZX+LeJl1LycNXRIrNKd9zGl2vtftDP/2EFC4F+5RDyDcrByxr5
	 Aheb53oV8L9F0sCEiQzxH5vLqckhPdy7B9o6gwnCdLDsN2ceYIGZ5yn9EmLk18IMmhFM3
	 kMlJj5tDNGxMLSH5EYhJ+ak1IjRp8RyBtHBq4uTrZ5f99jr4FwVOxUcvtPyxnYWqdB9N4
	 eYcvIQzXyCldORIut6rNa0orwPX6m1i1P6ZtAQETYjoBr95NtBs54nYfh1krKtIIm586E
	 7funqY+I5ZUvqAjq/8YQiVosY6pMX8tfLd1ZmMxAs7tH2iRBelGKhf2BT3rgHsE8zgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
	b=4KdiT/Z1ZROXvP1Tg1wx7Izbb3XVI1umcC/kXqrUiQmh/T6xsSGm9MfoMfGT5OkJ4aEW
	 nu9AvqM1Lk3Nx0dddmVTuxM8DudmeLdMlpgnuHhApR/4Jm8BmQe8HVWhiyczk3aXnbWJp
	 tyEz44oposhElLTySxUCMVhgEL0ESU0YRsiTKNFbL6HAmjVumfsQR0mknGRRfY9KCHKi2
	 1Js3kp7D2bQSfZAv62G8rN2VGVjhS5p/yZ6GnVTen9rvXAsVZqa/dUDxzj6p+GFPwmfuq
	 pwO0eThfFadS8tdq6TET5OR75E3wtFunv46MgSt8r8N5j20ZAo6/47ziz8UFGECYjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kcyODoF4;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA52606A326
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA52606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kcyODoF4
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso791426d6.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795109457; x=1795714257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
        b=kcyODoF499MEItXJuafpVcnzdrYkl7/sScpUZDNuvzQ8x8TeBmZDqdks69cwQJPENI
         9iFlKy+JKSRnJ43XkhGYbKr6s8nEbIsy4qEBpMjCGf/q7zUHm+eoySF82h8iB9DE2E+6
         x6E285TcglmPmUWPzBeIw5GGsOfgrTK54KwCO0dY+Gad/9rpkfmJp+Fzuv7FM12rO3cW
         oVa7V3SRTkJyyHdCmKYhiZ0iNHkbMSf2mGIbRMegzCViN1JkHDoqRPAMPCRKMsFhAncg
         tqPk2hQGV6zgzsjM3kKOt4MztPrYgP6ISE5NoJeIoBzovYoyXvuYXpAuHCmOYhEhLB8f
         9Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109457; x=1795714257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
        b=Au8uudikxPW07eICZhJqls/QotT5dawbsa8AkTNk6sdCLHqZhBsIlpeU2+demJsP3s
         1qEW447rYkE+b6HGVQ3mj4F2++oLM8OXZWFrCFsunj2JTdtqyENbN+FMyuFRYlTNOhO9
         fOYNDfYpH5Jcf+s/tzF22zoYLrOx3T6uh5UZVLfPTsxwjPaYwhohx9nqTxcHB6YTDiAq
         nO/J6v/bxPbqNLPDnQPbU3G5I2rbFef+LOygKeuTLDFxV00NqMAd5ELXE2Mju0xYs02I
         s72FupTbk6qy6b69PxZ1w0/Mg7mm+Y1FPHqpU6mgfCUs8Zb5IQZWbfiujkNl6YLT33G4
         JtXw==
X-Forwarded-Encrypted: i=1; AL+hErHyjYU+BjPbtuCYxI85PNsnGtOz3VzWe7iFL2FlHwJCqXJtsBk0PJKkPNCTKRpPTXpq2zBbfVsclrB3dFVEVAZZY95g9wY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sk9fqRGOYFaW3xoQbBdBpHQumvgLB5T6CpK3mjVzijocEY34h
	eFrZ/kc9CzwmPv6ljEQYS8NbZKJK74UMrUlHta+bPmFsHYrswEAflq5Nhbf9PAQjXnA=
X-Gm-Gg: AZFdTZc0TCpJTdAuEzQSvlblH74I2dC7vzO8qm4FBFA0nMtuaOtnt3igFDsTW2Dvjek
	Nc3HuUp0b7mjwgTLehw1iZU7QpUDGtRCWtJ2/2Q0od/jGruyUw19VEFC5G3sM9gmQvJudraCkcw
	EjQDOTXI/MtizazKBirghbJYT2jsuUBG7X5wDJK3hGqC9TtaPxTuCc1N1qeRFxTW4vRO6uF72Ol
	i3aHjb8craPKQqiGkqxTW5RtqOta+94S7suLXA9KVt0Vhycrqn51AFYoPHiXdLN46kc4k7rZxkg
	3pmmRi2cbiplZvCRTOdXzpoZiSU8PYpFW5DowEVD7z9NQOUnsMuLrI5wQA+ctN+WXF5mScHkAlF
	wz0uEEFGaowaP7OPB9mt4DKsNjD78RfuUY0fzTMK+xf4Ftynjyq2A1vpbBHpKYn4MzmCaXWG+VL
	4tW5Ir0yqgFNieaWhPFAu8f39oEBchFYO5ucA/iwqcwtOPf7nUjEcitfRwx5HnFE1mykivuRcHq
	0LUVZkmYWaq5TpNvYAypt+QvzmhcmDofXhclAFdB6jrnUm+M/Fx/asX5z58sBGVBtkQVS07Xype
	UOTiokuaMg3E76ZhnE9JToqpPlPqKXDVTJMn8D76eqHw6Q==
X-Received: by 2002:a05:6214:3d0f:b0:921:2f16:4714 with SMTP id 6a1803df08f44-921349cdc5cmr6310486d6.7.1795109456756;
        Thu, 19 Nov 2026 09:30:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ec64csm3556376d6.28.2026.11.19.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:30:56 -0800 (PST)
Date: Thu, 19 Nov 2026 17:30:55 +0000
Message-ID: <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Howells <dhowells@redhat.com>,
 Jan Kara <jack@suse.cz>,
 Serge Hallyn <sergeh@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
In-Reply-To: <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org>
 <av3bkDnwmjunTleX@kernel.org>
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> wrote:
> cells: The dance where I create an anonymous mountns, mount stuff into
> it, and then attach it to the cell is cute.  But I think the userns
> interaction is wrong: you are making me assemble all the mounts in
> *my* userns and then clone the entire tree into a fresh, non-anonymous
> mountns bound to the current userns.  And that clone operation is not
> free and serves no actual practical purpose.

The copy buys us nothing, agreed.  That's just what the mount API gives
me to work with today, it's not something cells wants.  If I could make
an empty mount namespace and fill it by fd I'd use that, the "root" slot
takes a mount namespace fd already.  Extending the API for that makes
sense to me on its own.

The mount namespace staying with the builder's userns is on purpose
though, that's what keeps the cell from mounting anything no matter what
capabilities it was given.  The builder sets the tree up and hands it
over, so the cell only ever has what it was given, and the mount code
isn't something it can attack from the inside.

> cells: I find it *incredibly annoying* that one generally cannot put
> new mounts into an existing container using most existing container
> managers.  I hit this on a surprisingly regular basis.  You seem to be
> baking this into the whole cells design.  Why?

By design.  Allowing changes to a running container is what causes the
problems.  If you need another mount, tear it down and build it again.

> both of you: Can we please make it possible to do the parts of this
> that oughtn't require privilege without privilege?

Agreed, we need to come up with a design for this.

Thanks,

Josef
