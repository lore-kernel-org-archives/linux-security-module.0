Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D7519929
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985157; cv=pass; b=hN2HiB4SKqGLuQYFRCoVgt6ecU5NN/79ttz5xU1Z23olGWOiZTqv/46MSKI4097ntWIZf3/4RKUeV0dX/j21z6+ZCP0beR3gOYpkVMVKx2VXEn28rTxVYHAMnQFXYTMT6XpSJUIsFJMcLueJygCoMfrpRjjHmxHonTKU1WN2ij0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985157; c=relaxed/simple;
	bh=Do9GJSHJpFcW9ngUtQfrvC4whS6LlUvXOjfDqOxXyQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFpfvOLzjRlT5HrPciEFodcelR1yOQU0hepA0OjIwKqA/o/4Ge26d9eb50RN8jVCKE1npAfSA1m5nkDAIjBF08tru0jyZlupSIiGutu9hu+08S5YNwKVkLlIJd5dajSWpMzFkNdrXfrPGVCZ38+NbeSe5N6EVaFbXf/Ro3CYye4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bsUJng8f; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bsUJng8f"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd623dfe420so734813a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 06:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791985154; cv=none;
        d=google.com; s=arc-20260327;
        b=jQXpRU9opeaSvamOtQqLKo/kFO5pB96QlxLCT9bXZlU1/Csgcr9HMQwPz4I7MkBHxC
         Llv4IRcxd59WOr5Pk2KYJhjQM/3FjR2h62X9BKrSmP/GYAZ27h1B4ssoR/DpQdb9CnwZ
         Pz4IQ3H8gX8XwSVQcoHyDnEkHA790i/9S5NoaoRg3Wg9fmAWTmO+PB+UAZvkkRzvIJSt
         BXFxDmQT6NFSHfzaufEYlXTkFgZAK95aMkdapBA+pVoa6YFurI1zj5cJ5rT5m4LzNWRX
         UfnCUnr6/ReRMyYBmS2sE4gdoB1z4Ie/9FUH0ls8h0Kz75EC3PRtuG9alcSPqInt0RfH
         e8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        fh=3ld2VWLZB6CEj93ihLESOjraLEP7HNgF7t5Ie3R0IbY=;
        b=MkXFeIz3DcFKjBxEMzfUDOgx4+ECgUHByJdnjIKyEEqjMKJxhJeuq/4ix7pAK/woOi
         uxTBnR9ugv/kCiLMQpqdmhuts2b+XffWPqV2aoMJJdMopnUvmn2Yr90fk+SUtMMR4m6K
         7HD4gFDOSFxSOrkMOX2PpzDMOIK/MVS7jqZ5sVuf2yWJznCvkNWtLsHKa/moS7R6vVaZ
         dn86r3Q8J3bvswMDwCIupulaaS1tVJs9v4QTa/g6GBxn+wNKDaoOdvocOFpSKlk8NKA5
         GGw8k/53MgbHThr3kMWle+gnEGAwHLpGS3QzpDaPvs2Aw/juVeM1PWIx4BGWgDj+U0Us
         j+Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791985154; x=1792589954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        b=bsUJng8fo75NW+TwhgMn7IXbnaGuxJUj/DzLdXIRsTOkzUhRlb0miBllApn+jC7sYO
         NIZmB4xscWSrlWfMSPobPRec37vaHr8is1m23CWShH7H9HGkDTVRjG8g2WMniPWYaYwi
         QvdAtvhuvhIo4rv1xQkcVy55c5d3jz/pBfp1zXSVKPlWwZD2ggaNJ/VKbAzX+wEWFCIm
         i0EXhPU7Kj3bHxzxqptRMIhqLrpuJUPNvTIOAEa0ZRg/R/hIb/hRzaHNSU69oPX4FJ72
         /esPO+kTWs+crdZ5CyEnYIPxCRLyQIlpZOpFUeKD0RXhmjVU19GmOZwjogWSMI+hZAxA
         Azbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985154; x=1792589954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        b=ckSxp6EsMb8/tHn5b7Htbhx3cz8CqF5EWYT5Ja++BlclovwKG6Tyvg+xqvSosoGoJ7
         8v6ytaOAWDhdpZ4vBbFTTQAMmuxAr+MVx+I+sJlLnldPI1ik93XNMlE4DFg4xSQt2OkH
         mxgg/brPLomvLaabelVLhZBEMEUCCIpbYVOkkOiJPwcliqqCoFN2Fi0/CWHvRcLvi/ei
         cC+C1K02z7X0BJJocQ98wa2LjqlrSah2A8d0lk+s8zuI3rvGbdWPgT6/pyWh7jyBPASm
         7xr4mWnTj4prhGAPwockC8+eZ0EuEslIq9Ps+A5EhgEkyZD7LBfOE3y3RfwqQsWoXZYL
         A7wg==
X-Forwarded-Encrypted: i=1; AKwUvByr54YQBMnCIRqCy7tg0Uq3+E/9TMIcQXlqjPrP/mIrqh1vQlmwnjsPagUssKT9fMrDC1cXMutWOBHKILWaQ3T/WnAeEMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMBNlidBLqJRYVwpyICgn0ykP2YfLDpvNcmKMJ7YIEeWxPNnWx
	ZcodIZND44arImegFilvqoe+lJB3xfKfONg4Gid1TJZ37z6/i+khOVE3WNgP9HMDJEWu1SRkeDr
	jep0eO+RTt/mvYFL3CYN51y1aRioZCRJ+4SX+sZOg
X-Gm-Gg: AYBFou0a6PrkrOaYqv5wuuK0o2QK6rVOhuDjm52v8BR1OkieQi4LAd4AUf2WbeOM+PR
	sBpZ3Hh5DkUB/HLUccQ+TCOmV5lUXSTl2+UAytqMzXDhAsiBxjca5S+vf2NVNxOEFWDKLRyp8h7
	40VXQo9RSAr5aLpLC3Z9vdeibtI6H+4rEhyyBlakggnLmwh869xpO01FzSNSJVC4pglgsk+DWNk
	YgxTxGLzG5wlufgfSVL1qU1u1WaX93cOOyWGlw+Tz/GvrnlaPjLamZYlOQBmUjVkM/ahLy+Y8Mr
	rE7DVQKXl4j+I58dzyRjCDRNzehkeqJRIWp6c1oKwpkfnAJbYb3k2W3uTC1hLWXwh9MptsCVxn/
	N9J1g8hZmjso=
X-Received: by 2002:a05:6a21:3a93:b0:3de:4662:16f3 with SMTP id
 adf61e73a8af0-3e16bed388emr12712043637.50.1791985154402; Wed, 14 Oct 2026
 06:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.16292613517250896744@gmail.com> <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
In-Reply-To: <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Oct 2026 09:39:02 -0400
X-Gm-Features: AclHuK8AkUpNImhF-LHJr3XzRnL-uuVSv_ZOVg-oORi05OKdAiHssAdOH-8pRvA
Message-ID: <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
To: Eric Dumazet <edumazet@kernel.org>, Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le mer. 7 oct. 2026 =C3=A0 17:26, Joas Antonio dos Santos
> <joasantonio108@gmail.com> a =C3=A9crit :
> >
> > calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
> > extension header, or the whole extension header if CALIPSO is its only
> > option, and pulls the skb by the removed length.  It never updates
> > ipv6hdr->payload_len, so after a successful removal the header still
> > claims the original length.
> >
> > calipso_skbuff_setattr() already adjusts payload_len by the length it
> > adds; the delete path was missed.
> >
> > This is reached on the forward path when a packet carrying CALIPSO is
> > sent to a destination mapped to an unlabeled NetLabel domain.  The
> > forwarded packet then has a payload_len larger than its real payload
> > by the removed length (8 to 264 bytes), and the receiver drops it as
> > truncated.
> >
> > Adjust payload_len after the header is moved.
> >
> > Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff direct=
ly.")
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> > Assisted-by: Claude:claude-opus-5-5
> > ---
> > Found by code review.  Compile-tested only (arm64, W=3D1); not runtime-=
tested.
>
> The analysis looks right to me, but this means removing the label on
> the forward path has been broken since 2016 for every packet that is
> not resegmented later (SYN, UDP, ICMPv6...).

I'm going to follow-up with a review on the v2 posting but I just
wanted to add a quick comment that while basic CALIPSO labeling is
tested via an automated test job, this particular code path is not
part of the automated testing.  Improvements to the tests are always
welcome.

https://github.com/SELinuxProject/selinux-testsuite
https://github.com/SELinuxProject/selinux-testsuite/tree/main/tests/inet_so=
cket

--=20
paul-moore.com
