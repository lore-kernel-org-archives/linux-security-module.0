Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABF3C0603
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566610; cv=pass; b=DDzIfJTSM1K1jwdr40ocfi3CRuQHsrvld6crRF5iz0hOasQTvHMowUGs1bjjfFazKE8UoVe4rqw1bx8SdoqTHmf91lX8uZjEZKywGJrmRPr5DuLpmkKF6cTDTZSMJY2p7VaMoDhvmWlFTU7jdIHczzuu7rnI0DMf1AiBYQ9SKyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566610; c=relaxed/simple;
	bh=Ju7gwhPhe+gDtBXlanX2ZOcJL4sUKBXDC/LuKD7vhrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlMiKpGoBsbzVqNLjaZWHMcDbb9V/Zo8dPp+2pHqr2eTpHqs06Bd4s9z14YK3f4cGA1fapyJbZsXycscFudvki+yOpix1tXY7hvQlK8w+9Sf8U85pO4HFKxOYsbiDUAOBk2MhPITavJEZppJfbG34958A0BMYLDuwjS7ybcZi14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvzCa+VK; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvzCa+VK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-486e70f2457so14224f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 10:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791566607; cv=none;
        d=google.com; s=arc-20260327;
        b=rgrnkjxx5QkQEoaNAGxXYntS8CHUbvDSSIuWU/E4eWdFHIGvQu8iz59WBit2BSjzF2
         44iiDay6GoVw0c0NGAsdl5OHvgg01/SoOs00Ax9i7yGUrwqHpnG/NPsjE10qSUp6onaM
         Y4zLuPs2o/G56mnPTvzd2/OFhF0Le2BtZxcbBLqaDV8mDTVcY/XUNpof3+sB2cvLU8xF
         fNdxpavVnqe87igwoFrM2dfEjmIUzmxQ1WSO+4GQ4uXNEhj4FYeqtZywGvCirf8Mdw6X
         Keo2RrRlYaG/kHQc/vcfUd3b0KgCsj5j+IribRxmc4bGg3SQHk9aHqZAcgcfDRQSaoYZ
         VqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        fh=U7FTS4CFEnYGEJOfs3AT7qKzRP0yGrFp2YtxYbMBS0A=;
        b=cvEw/QsvLrCps6q/eur/MkMWz1/t0nQBQOGOKKni1EYRIqMuDx7hadGQ2fXAzgXRLX
         KK1UDKIVn/EVfX+c1atLDDElng27fBuPyHa8wXdy75/0QMKxCpSYdGwuIzH2HPIcnkue
         +EX1rNrRCYKNTksm+LIWo3jCwBBsbyRrXn4uwyw2pGFyWOjtL6psaIkLDun7kbSsPIJh
         Z/oaABhbzxzsC631UXRQnysW3tC5K7Gc6/TEgdBqx5X2oDpC72llWTupLspnN4KYksAO
         A+f/6cqqh6JZeVmYKzQpyTyuqSy29Y5j7mNP1Q/3fC/yhcCrOvpo3eJBrlcpP1ao6hwc
         BwRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791566607; x=1792171407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        b=MvzCa+VKiyDnelHUmjUccg00cB9OywmIWuU/UXHneMkBqq1XMLSK6/n/9Xc9DKNwFq
         DGdEKXPBMYnR1JyEnf8cveksXRDGdwZ85EcAjt5d9i+nUW+72rZGzL9iBDfaxB1Qnfid
         m2Un+0IFsd192m1N6/pQGwZDF58jqbOLuUxsiGiw+bMadnTQm2gUP2HGZHQBNJrv6PNc
         v0ZztsoiTIHuLKhv9/+npOX73T2uw4nOecIT3tbqKMjiNGWAQcFzJcQX520JgQdKNCcN
         r4s5GzG2gBNldhH4T04J3iPmZ0JjMeeukHvyC3IcMHY25ZoiQX2bOJXerZ6zteM72FdM
         9sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566607; x=1792171407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        b=XwWcif96hbExQTwaaJ2N8AcxbCoHO5ACuxaGrUJ3e5RHBZcvKPmHg0XCDGT4VK5hpZ
         7GuuA7yWyjYvjxsFCegRzJ/1yG/3UFp71NYoIuNsbICritdhIANMxaDE8uFNNM0fzBwX
         PvK0J2ZPKyOXkKuUzvm6Eu4SHQCVhG/qVNLeeQozMBsR7eG1qK2OR7Xw8f2W5uhTwW1n
         mUJWKRl3MFVKN4zhs/sJ9ZphHeYjoMhE+MFw16zHByHC/2LiUqoPmjO+pWnX8liH4k9O
         AGHYrP7Nvr02gcXfEUEJGixSK+LeoYnMVsklrVD2RfpZqHBOj9r8LabAfyxCk3z8ObZY
         DSmA==
X-Forwarded-Encrypted: i=1; AKwUvBwejHs6GgPeUuifOnFxr4We23BUuFiMUGsTtO88W7sUd17sviYMb/Yy8AWj7PoUbNpszKt6t09NHwMgP8X/ZtgbUuGlLUU=@vger.kernel.org
X-Gm-Message-State: AFuF++l3pdzwMIWB/VbEGNhRB4c+nYSgWj6hrGE0hpf9DKoHZHrpp9ES
	qTMEhA7OB9YijgXVXDJ0CtFb70Mi7aInHnHX+I813gVUuHhaKI06MhE1o9SPOxAG2TZ5CucHyox
	0BSbhzWS+DSIW7rqjjEVnx5CcvSu5eurfvOD5nxKd
X-Gm-Gg: AYBFou3qPGOUr4IMbLC0CmBQEeYGg1lYqrjZ5nkwE1Qqfg9o0BX+NSWXlX1tJ2+m01u
	atzPoUAq1HLLhtjvd/+QXQqLkjXyHdsCrUy4QeoY08BBW26pjkODwl5BpalAHANDm92dYYiJHkI
	h8/qm6OZZMAtuOa+UwB9g1WwzQ56emON3G6BFRouM7+hiHmAzOprT+vV2uvu4KX8OC/ljmHt4aD
	fx4Hy/Iu2WOPuN14FLZ9BQwGZaGkJBjFxN35e+sUe2MkA2w89zpGPL0rQUAbmaFh9+mIODDY3xh
	XFTcAxmDB6KPsJwQEnKNwGTi6TBmHFx06k5O0PU4UMyfAJ1erWh8+FTR7+reptgH+/pEUgq01TS
	99XUyIBosofxF9FEuYFk+R3PiZRNuMI+E/yLYy0fN6ozwXvGd9h6PmzpsUEm3fKhrY2jGDPYFf1
	Go4xv/uuOUnq/5swoJ0EZJtklmGKsc/hd4+FK7LcjxLTiHeuO1bhSbCXIv
X-Received: by 2002:a05:600c:628b:b0:4a0:251f:dabd with SMTP id
 5b1f17b1804b1-4a18e48edd5mr43689545e9.16.1791566606839; Fri, 09 Oct 2026
 10:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com> <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
In-Reply-To: <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Oct 2026 10:23:14 -0700
X-Gm-Features: AclHuK-CLR4BQdqBSfFuLWEHCSgtnQKEmsz-7EKl2ZGIqsJwmtfHX25-OeazvEY
Message-ID: <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	michael.bommarito@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:49=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> On 26-10-07 14:49:28, Nick Desaulniers wrote:
> > Would you consider this a bug in clang, or an error in how the
> > __counted_by attribute is applied?
> >
> It turns out Amaan Qureshi has already reported exactly this Landlock
> issue and proposed an LLVM fix:
>
>   https://github.com/llvm/llvm-project/pull/228309

In that case, I would _not_ work around the compiler bug like this and
instead wait for that fix to land in clang, then bump the required
version of clang for counted-by.

Kees and Nathan are traveling for LPC, so I don't expect quick
feedback from them, but they should confirm whether they agree with my
proposal.
--=20
Thanks,
~Nick Desaulniers
