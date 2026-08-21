Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600C3DDB0A
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341734; cv=pass; b=BqRi5/ltDNWS0owa/FzErDByBwJHvwq10ZYtNoXquZX/QYi/2BNwBPBKKtwnMDNIZkUtGrLCV8oBlUaBpZdImyWH8TQJXNOjQyEwcaDHXVQ3OXZYmr4C5ZCewOxlS0i/Ko0LdEmEmg/8fEwdbcR5mgB6kG8AQSG54xG6YjBgOi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341734; c=relaxed/simple;
	bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uqa7j5YSueDUb3JripCB5bPXtM7MUiGKBZ46NihWJ42JURBrqKoPih/7r1L9jgRmEPFg3Ap4/7AdLT9m3hr2AfIv9+hqTkTDrGY38gbQon19i8gd5ttTTGf0j/WcXfbK6OoDqd5hDcbIYC3RwCsKC3BEuZlxNpEpiiIecgJ/0bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcpGF+qM; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcpGF+qM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d30c22b1eeso1293345ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 12:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341729; cv=none;
        d=google.com; s=arc-20260327;
        b=EXPUM++YDoVRXGcjAG2p82A3UC7Gzh1znRc/GHNhPjRNUuuxXVl8Z4RWQV/TrgWMqV
         9CKeliDUKSiAFrOXiEW1xjgW0f30XAMvS8ET6zszqFk+q+Z5QyivQQ3HFxWPzUNwvd5s
         GIN1s96+bMM0Y879K2uXmI367vZXqWn5fWVS0Vg+x7e9tnSmPc3merNfF0SHy/9sKO/h
         6XA0uMJtDk1KgeeHe59LK8Ww1prTl6oDVXqXdyZOFQXj6tRJou6szIdgMi6j87I6CoTy
         l1BRcEa+OQZWMeqaNUkGSYqov0eLOPEOLL1Dgwq0DU1crvz32zvjYy/mHfQgI1N5ay5j
         ozdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        fh=3cJj711v5tHfnZuecmQCBtJXcTBZ5rdMlJY0JeVOltw=;
        b=PkC+Syir3Xn/l4JwXrAqxCpHvmEq+FeooPg2ypjbvKVH3hUdeuhOUF47hQtL+GWvjO
         NmJYhmKVxtVak79MSAgO//JzMPEqqXdkdm+Wbk+0kaG+SMiTO6SMLwfD5M4p5uQUmTGp
         DoiG50dcmd9BSUIkTGHIJzu25Kgsl+3GU5EfU2KNiIiYtsS0zy8tGNjj29nSbtM9a6DO
         48o8wmQmiUfsz0f1GZc8W3lT1/KWOqqD3znousLkD6qsqDoMGtyeMZndw/SW3EOIFC6p
         EMsqENo2ucEVwSlwr+SL3Qv8fFVDpFG34b6s3Sp1Z2ZDp3qVYc2+pDFJ9IYd7EC7PsET
         JCqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341729; x=1787946529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        b=CcpGF+qM8yYIih1cSAqy3lWYBxp96sh1Gj/OttiHxqrpYuMRGm6FlAx0tqoh4cggSM
         Pb+i2/SSzrnOozG/OY1Mw4F34yN2J9buwvFALEeUp2O8avFAgv3oDJozaIWVMuWgGTwX
         akBoWrOuYNOmL8B94SPxjS1FXfV3gJzm9aqj+Y0/f35EsfiDaPT/gQ9aexZHui9q3mFv
         pnZ48ywdxsD9JVj2BqSl5Blw7faLWP6QbXdXdvpyXdnag4GCND9d51YbRxFEpWtZ057I
         63rvLD96Dqcu+HJdNKZarWcS7c1CJqleOFSOkFZwJfQwpeum1UVbxyA9Jej3maFhMIhg
         uwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341729; x=1787946529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIOe0gksc2TBFCzVC0UABUDWCb5y+xK8eszlV06eZyA=;
        b=oFEVCpV3aOIGAeNq3GG7HtQKQQnosZSPwaoH/FYKfMn+9UDLjAusVYMcvYEwxnOP7q
         ZUiyRDUU0FpqVm9UgCBMfc4Xa3WdJ5Nheyq+emBvT9itR4slbQdFGUA6E3ys7geUNJKx
         hX8oNB/Os7+K1OqyIHpwc+ACUtsjMIjapzwRZfdtXkP/ehXAJJ2YCXup61aYhXqkgvKT
         w7wgnQPzLnpE78hMxAiMWyg/FoAEHP1VjPfB683A2gMD2lp2Qs1j7iNV5CWwwBhegTJM
         1YVd34EVCkqwe0YGqyM0QrtVUhEokGUnivYA+d3IVCuVm4bCraabPq860igQSuHidrYr
         c6Hg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/n3Mf2z+AhARpw97vRAUSZ+zqqGBtR18VButjOMjjLbJQEt/fixJSadYCeJgubRzc1rI+tiW3SaCSZ8eXbhpwBxjhTHw=@vger.kernel.org
X-Gm-Message-State: AFuF++nuey2rtjWtQDkxjghR1xVTZKdfcQiUxR+RKNd1ScGNP6hsDKsP
	ono+uRKrKK7jc2n7uIZUjLLAyA2rINH8dnRSDzkYOP6PhCJ2iWObtCqEFAUDirvUqq+TmjCLMA7
	K1MzMUlBWMjBhYrbCoNKfvIxP4bAwQOw=
X-Gm-Gg: AR+sD12w9dcGkfhu7llEpI5PYJnASZWlzYNe5GYf/Ta7IzGAcQiuxgH4XwFUxgLp98x
	WaftX/JdFUTSX9fcGqp1DMdk5WRO3EJhjAyxb8xlkoNbKsLr7mdbo51oCXM6e1FriaBTKCB6b1k
	4+NJK5H6p71/f1A9OmXQ1v9CSXeOAlN5N/GzXl+B1NoTGA2o2EjiEFJzHpLMN02058ot2fhatD5
	/c5wAAMnHk2tYW+esH79k/ljagZvejGDZcoBBS/xwb5h/s6TaTn7QRFi8BmFQ4e2fRUXgps+Gh1
	o0Foe5uv4xLJhgG55KMKxuFO0pJIueHFClutJkeGoTN0FJF6BvaP/0x99H8Dk6hrb8FpNclCR1s
	nTXd4tKsXIpqrMjLkzHkMschgG9UYJqw1A8RG9js3GnkEnnCPaKqsV1QgaMlV
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id
 d9443c01a7336-2d64b13195dmr82640675ad.4.1787341729446; Fri, 21 Aug 2026
 12:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
 <178733378275.2181196.3186172911325132761.b4-ty@kernel.org>
In-Reply-To: <178733378275.2181196.3186172911325132761.b4-ty@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Aug 2026 21:48:35 +0200
X-Gm-Features: AcwNN1VcEKRBJi5joKYnArWy65OxDBbAjzWAsN3BQpiDLg4VMvQL2Y1JGnUF-bA
Message-ID: <CANiq72kE4tf9b5BJnK4mcY39e2KELqErxHTZM8b3_GLiEvPt6g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] hardening: Default randstruct off with rust for
 better allmodconfig support
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 7:36=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Applied to for-next/hardening, thanks!

In case you want it (I mentioned this in previous versions but I think
I didn't give the tag explicitly, sorry):

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Typo: "likely go give" -> to

I assume people does test (and enable) randstruct elsewhere, so this
likely will catch more issues at build time in linux-next, even if it
feels bad to lose the other coverage.

Thanks!

Cheers,
Miguel
