Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681F1E88C
	for <linux-security-module@vger.kernel.org>; Sun, 31 Mar 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711897393; cv=none; b=qcKs9YiVf6htqv0gR2EmEtnVmfb19lrDBG3tklccd/mZiPn2Ub5WjoYJSVBvUqw/imfKQwb1M3jrpjJAIN+4WjiZchw6TBtU8BqbW0uSYqWGSnMW0xc/pmUPGq5CqWAEkcLF9JYWtG69bbCc2zZpcA/nGig4YRA0jxstLE/qVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711897393; c=relaxed/simple;
	bh=wd3S1GKm3EQx2MyTzApZ40q6B8t1yo9vlOLMoGmEix4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw7CDFt0gdtndEO3SYF1GLob2atPsPr/tnQKsHhx0c3AItkqHpLTPkIQuDZ69uhW5G1nDqwB9G9D2uvR3m+Z/q+GmQQEiLAD9+r05kap5esktnDeFIDoJRwP8/a86dEb5UcOrGAM8FYjYQcBZN+s/7FWXpFrc3AflwKCjIQG4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IIoPh4zH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IIoPh4zH"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61428e80f0cso14084197b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 31 Mar 2024 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711897390; x=1712502190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqEmQMERPqKaD75Kv+bYKSwJAmpAvfbMfp0f5zArilk=;
        b=IIoPh4zHrXD9gbUHmtaA4mrgZUE6YRtn4gcT77Dewea6bJZE/L7EO07GAPTEIp0h2i
         9pwE+0WmcHCvT6Yxugx3z/fKhaNobDKLzSfI1O26Z/OFWfehC2UYWQKe36RRbZYhT5Sc
         V9R0s3QQJYyTcBIEesvv7ulzaEM0q8E7wv9V3JV1e4AVmuwmXRladcR/GYXZRnVxoInL
         tDgFTwNEArppFJ40qpcPTf0XjpD55vYgMC8eDHeQZh5v98AObix9jze7iHXg4Pj8KByi
         Wat24Ie5KWyRwF892+SNDQ/JKzkOqS+mSh2f17JfZ74s31IQvj6EFkB1/9yVFw5Hw1gY
         oNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711897390; x=1712502190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqEmQMERPqKaD75Kv+bYKSwJAmpAvfbMfp0f5zArilk=;
        b=OKsCOd6bh6tytDXQpDpZ5DkB17T692u27qvYi8ThxEehsRdSmFkhPbxbGMp/JPHX1d
         t4xsSa43Gd7di1PvZ/bBlmy1AaXxf/Uxnsm1f9W+hcpYqYheLr4DfA1GHaFHABHlyt1y
         PYpR193k5AHmf99GIU3MFyGsMBt2ENFepew/KwqpCAVw7E6hGdmAXHzYjzUT6xk2NQGu
         Ljl4bMGJozBmDdF2n3dt2KtsMMll0Uyt6BbatVy9jcyMm/+xMGMLnLPQOpsQWM8+peUu
         7FmUiJekuh8jMxjGbglUAykPECX1H/Q/JL12FWBHot/TteuTKOG9A6y0DmvINVRHZiHj
         LalA==
X-Forwarded-Encrypted: i=1; AJvYcCWt7G+JwSgkWMmrlldYDPwTHjeeS5U1n6eFL+FIfajJqVAzGvJoTIZwpbYwNQuqKS1E7wltXPlPHPMi+zHtdqA1OJyXbbrCMhzwN4SwMxecxG+nupk6
X-Gm-Message-State: AOJu0Ywx/RULM8/Ud52+MC6Pu+D8yF0VeSNhsHV8ROHCjMMw238BJ/3F
	Z7+wsIkpTtDEy9wWTKKm0qHOQMKWM5mrWuSpS5Cx6OxNChcRW/i3uDSiSGQ5o3/ZagBMqtw0veT
	rNhLi8ZtGt/bHPlywFpSa3T+jGrGCkc68gYNve22j2IK+xeM=
X-Google-Smtp-Source: AGHT+IFTUACZym5/9bUXYGpMAaTI6GtxPR1LO7hXTS1zckQRGePAprZ1RLGYrfcZkOYVQDB+/HthWynkAWjjpj5qZX4=
X-Received: by 2002:a81:5c82:0:b0:611:1a56:d3b7 with SMTP id
 q124-20020a815c82000000b006111a56d3b7mr5444784ywb.43.1711897389948; Sun, 31
 Mar 2024 08:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
 <20240328153800.GA17524@wind.enjellic.com> <86c7477e-260f-419a-8aea-ea527a344877@schaufler-ca.com>
 <20240330201425.GA5453@wind.enjellic.com>
In-Reply-To: <20240330201425.GA5453@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 31 Mar 2024 11:02:59 -0400
Message-ID: <CAHC9VhSwpJHZunGuP_C0YsK_DNLW=UtHSvD74-m+Qow0LiwaeA@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 4:14=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
>
> It is now perfectly clear that the LSM maintainers don't consider the
> possibility of breaking upstream BPF to be an issue of concern, no
> doubt an important clarification for everyone moving forward.

I've said this before on-list, but I'll repeat it here for those who
might not follow every thread or email.  The BPF LSM is a bit of an
odd case as while there is a very simple structure (framework?)
present in-tree, the actual implementation of the LSM is out-of-tree.
While one could draw some parallels between BPF LSM implementations
and other LSMs with loadable security policies, there is an important
difference in that the conventional LSMs with loadable security
policies separate the security policy from the enforcement engine code
and maintain the enforcement engine code in the upstream Linux kernel.
The BPF LSM maintains the enforcement engine code outside the upstream
Linux kernel and because of that it is impossible for us, the upstream
Linux devs, to do any meaningful analysis of BPF LSM behaviors.

The result of this is that I currently give individual BPF LSMs
largely the same consideration I would give out-of-tree kernel code: I
am not going to go out of my way to block, or otherwise negatively
impact the implementations, but I'm not going to sacrifice the
development of any of the in-tree LSMs, or the LSM layer itself,
solely for the advantage of an out-of-tree implementation.  If you're
really craving an official policy, that's the policy-of-the-moment.

--=20
paul-moore.com
