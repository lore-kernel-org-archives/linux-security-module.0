Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014739061C
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896852; cv=pass; b=utZ0Q1r0x2BEuT0a/c3azXxY9MXK4+suFbyEfuiokKXLh+se1LHREDHr2X3dEC7UbltQB4xDVnEd4T9b9N/m1yJOkFOItnA/7t5zXNc4Wg53E1MKo4jy77oe0QuayKYEZA1Jato/Cs/Gd/WxJlJ7OwKn4pDZGgPJruhiGB/MSjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896852; c=relaxed/simple;
	bh=6TiVNxxeDpdSAagBOty9+KDqgyZClTo7hXYVmhdgD4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmApGRU25ITacP8ZTCR8QaIwkW6q2wHGH8/wjkK3GDSwEMaHPqc4rsacPZGygcoEnIHJ/E4rvtmN7TUgnd0gsTx58aAxbL2AEUlMsn78yrs+fhm51rUoEvrLZfYnU6PoK15UYExkyGI0Xn3m/J1oxlWZRJLL3J8yAvalPyxduqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChCnLLDN; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChCnLLDN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6767d92cde6so2538482d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 06:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896849; cv=none;
        d=google.com; s=arc-20260327;
        b=BhKjL3k1ljABTlEiZravg/o7xjH7zcUejzZvsOudnhSF/ZNkJ9i0gWVM29kBlJPDjm
         6GkECVXNZl0UXKs8Qj0iRRPM9o+5ZNGoUBrIcQHs9kWy8VrKRMSJ5POlhSClktzBHSXW
         WzkiQEyUK1yeMA7D35WPvTPDpPze1u4Ahptk8Eewn/iEAswHtV1WqxJbdfotXtMqk4ZF
         zdQLcszRbMyRa0kXlXv9C8hqTk2DQN9FDo5VlvAcA1PB0zvjuQdlhptF6UfToBG54s/V
         q6pl0qhUjzfB5oKOExRX/hInl0MMFsPsYUJDFro8H7oxnSe6kxIkk/5V03dQLSxUdLfz
         fitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        fh=VDX932OB5lF6srUPDfrCzpbVLnaDbDPTBveszOzWhhE=;
        b=UIKXPQlTTDWLQwEHXmBkHg+wzVU8J6H96bJ+O3F1m9yiQdThyfMPxtIXr86E6mEpbu
         ap6mNCLEfDP4bTzTYbgctswk0P3B6vDkZnwnLbwpOBmdtbWVlt/NqGZOmCqp/iBf5bav
         CzplTflg46w1lJt8BvnSt9seLnZCHTZac8Qh/sdIrEOQUWAAFCNB4+oTI4EuXeCcvDU3
         oUdofWi7AdUd+wxU/Da5KgZWpY6eJRF2Hm7ESXjZ6zoakDeMJswlB3R6seGRN1m3FNSN
         Ajt4tHAJiF0oMMf5n/O8q20EGoePokN1kYOzn+E9Tck/VyyifPaFXH29j9IWIw3ueID/
         vzUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791896849; x=1792501649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        b=ChCnLLDN0HrodCru/tKtCUmKXKNwgnQaCvvNBUByqdBDCIQ3mkdmJCGpAeX3jAxF+P
         R+Oo89B+esq6iTJ3eV/5t9BE3qRS4VEfVQi9pgkqVmt4FF9u0zfVTTj7wNlyRpw5BvvI
         1TEhSMDZDbfk1ZIu5DcPfBqeOQ9+Q5Itab85rR0g7WWrIEfGe/WNZG9HXPiuVwi+skLr
         jFZPFRbq4J1Qi8pJaIgXl//pZnHFTo44Vhfa1DRyF/xMxs0LWZQs6rQYxpDRpQr18P35
         WhU23F57sI9D02Hzcp/l5i0TMBs4CxoJxS6IeQ9yyTueHAm8+WDXoDYChnuDJEmpQVhE
         xF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896849; x=1792501649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        b=dr/fgDhDV3aNPqgq0I+draW2w5YXsWrSgTSUIq77/MdHk0R1fKzb4ofaGpIwEN46ge
         nByeH13uKx262xG+HdLl+cPXL0KU5bjOXVKKcq964wZtm794l7/DZOk4riGQH2/bJpsZ
         zuYinHl1gKd76f+a5I5vF/0HlOkauZ8P4vmBdCSbuKPrC5WRdn/u6W35oOcn5lPz7e2w
         TfdTnhuuKi2qNAJuI0L4YUKC6Xa/dz6iB/LF2pvqoyEa9WJst+hUYJk82ti4zsegvFbM
         BY4VC9v/moaTUsY9JgEfWnHQfB7CKOQIwpt40XDr57QN+Aw7Ov09aW+6jX44aCpq8JnD
         +vZA==
X-Forwarded-Encrypted: i=1; AKwUvBw84RF8IuMzQQRVRzmSg11A+lqqk0ogApAT85MZCQOt9WAXEvxfzei7cuixGy4dZ9HXsGiF+/Hdh+2CHSQcW/Lem48WCME=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ+sqDAzZqX8RHb4a1lbvFvO8+f7AgMneqlGDAI/U2IgZV/Zo7
	1fxd3PK6Z4I5vNWUYvQ1hY56uJ16RDS45yvaBnD6/BDziswQS1qU+sNwv/Pvbe5tYkeQokOnxPs
	HL/1MmscUz7nF9OGwyZSpItz/b/yg/zg=
X-Gm-Gg: AYBFou1WCE5CjGc39GFYyUCVv0u7O/Wqw705SUxYTBxEoLAEQzH1ZxNRMRz0KiJNBiW
	3UhuAHHVGdWgAygR58HB22ZSlPu5lcEFaOtFd0Q5zAd7BwtBhKEONPFTk/ZA6o7c3AnrYtIoa/u
	CPHFqce8ASLFeObgVQP35Dx/CtXY7IdGh4n7I3DfEz5lh8xU6ZARK/mFENoAYc/lAwl6Cn+Srbl
	DB8+visKTgeeswkZaOWabz1Eh3mu6LIOO5YCE2p2+CIl7bakLeFnqU7XCNSlY/mAvXRS50OZEJJ
	8i2WuZ+yQbwJJEyZKr8llgRlUmI9WiWIuFbTpA1SNZ6AKbpwGRLh4FMjH0gJ6luvU0Fcj/075uy
	mmYR+f0r4
X-Received: by 2002:a53:ac90:0:b0:677:aa92:7596 with SMTP id
 956f58d0204a3-679362b5a2amr4638672d50.67.1791896849528; Tue, 13 Oct 2026
 06:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
 <20261009204554.GA778522@ax162> <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
 <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com> <20261011.Veiquevah3oh@digikod.net>
In-Reply-To: <20261011.Veiquevah3oh@digikod.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 13 Oct 2026 09:07:17 -0400
X-Gm-Features: AclHuK-jtD50bA_uKkhScngguvSwky5SkR9YZhcx-GIvRlFpZZ6iWS7kxU1PPVI
Message-ID: <CAJJ9bXwBo2hqcov46pLykJcdWp_fO8r7bXcDEw7JdZjWVkRxaw@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Bill Wendling <morbo@google.com>, Tingmao Wang <m@maowtm.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

mic@digikod.net> wrote:
> Thanks everyone!  We also received another minimal patch that I rebased
> and applied.  See the final commit:
> https://git.kernel.org/mic/c/3d8cc52db2f86b624308321c58513019f6b21eec

2x FYI

1. I boot-tested the clang PR in [1] and confirmed it fixes the issue
on rc5 and rc6 before your patch

2. I boot-tested rc7 after the pull on clang 20 and confirmed we're
good on this side too

Thanks!

[1] https://github.com/llvm/llvm-project/pull/228309
