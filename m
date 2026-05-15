Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720E38735D
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872065; cv=pass; b=EeAtN02bnkT/DNjSxiaZ5quhXj9BNEvds9L78S6qnoPWQmd5glqZMzSJsFbpDHPlPnHJ4XzB7OQSPZE/Uz9+6k8LQ7HmW+gFY+qyv5dB29MNlOkpxwthIJMQUqtEs7ZjeUEwG/xSsmqHGnXmHSvb+oRmJF1iFl2DMkovqRcHw9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872065; c=relaxed/simple;
	bh=mb1275eXwJqneXc4dEDy2KyI4gv+gxxbGFakf7VbqpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl+3DFluZmCMNE6l65rUnEXHWp53dmmjxIgZZbVmlvpqV7kmGzs2d4FP3kcnFyVNQN1Lj/pdCuWmvf0YkTKCW2Icyql5I+4867zjUUXx8ydVc2MSY0JzTONjT/Yk+REXQQl14J0Uvw7UFpRDQ4US9WZmrvtomObgcLwh0+N1evo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soRkrA5g; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soRkrA5g"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-134e41fee21so11015c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 12:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778872063; cv=none;
        d=google.com; s=arc-20240605;
        b=Roga53JQEJfufu+caFtFJI/IMUsfsgFcVOgpnEDTPwPAD1zHEi2RQEjWxKuaGJOTOt
         mKQdn1Cyl5RaXPK3AgYM32b5cQ76KbFqQj4QbO9BqRb2CFDRyBbYBSzWN/uzo4dXkEAy
         rFc5Nxt0zEemvALspKklSZIVs60dAGy4F/QkLZyKzpHDNkEBlNDUTpdMSLDxHQJURjDh
         jJMScoVxzghn+AQnCKOLjvwQTR8rXVSXg20Xs9VQ+jdjh+9WkapZ+DS2nt8FyqQDSdVQ
         g5w+v7vxPpJzl1fbGefkOByA4cxJHrwNX2ATOs2r57YJyyLrScmOt/EqCJqTpPvWoRkI
         9VCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mb1275eXwJqneXc4dEDy2KyI4gv+gxxbGFakf7VbqpA=;
        fh=zlzlaLlmccn+Ta4gbxE2wWK/LZskiCL5trx8DY+rxVM=;
        b=Vi9DQAou+3pQJ6sc3WhXLpRtIcURZpEddwKyq50qHMbbx/tP4sy/mGtsob0DZeNEPN
         +BfWIK/FXxbxt/0JYqv1Zulopa52fVO7bmoY+hO/cnHoxPaJG+WcMD8d/yOhriS+WwGV
         XieleQf6JI4xH56++89low00EpleNsEsDbGcnnTdHlb7Hjqy2dJ0kiww7LXEZWmhCYG/
         M+UjgxULISFRKf/BJzMAH4B66IPYgic7h/pweYaKppbQcYfQaAGcoCNdcHxOHZOvpW5o
         snxpszcOWtAS5mk4vKSwZWgLFQl5dZpjbntadCIFh81bsqGfZ1Rzp2QgwI/PaWLPNKRS
         rWdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778872063; x=1779476863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb1275eXwJqneXc4dEDy2KyI4gv+gxxbGFakf7VbqpA=;
        b=soRkrA5gqFcht2XAwrqu73/RTed8YJULTo4SxvZjKkN02agNPNmLFsl52dQ/SPpCzU
         I+fqjUr8FmXq1YgJWqx66UDnWYvfxTHbL/xNFjpQzaIL7ghfGPD1KMb9PQ/76V7r44MX
         SNid/uvUtB4euuv1C2xbCY91SYg9owBInFp6C2TJ8MWkKA6eTrg1yrL0INMuIWR22zxx
         9bM7pQsDx90w/Q1kqfdbz2dHo8Z+RwqCWTRTfIu3cURdN65Rz/G0Ojzk6wmVKCOrRkab
         QniCi3HyJv1zO2MRbYHYFsT13fFoYYq7rVMY7idAkOdhEGA2JuXXjQcyGyzI01YO2k1r
         +uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872063; x=1779476863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mb1275eXwJqneXc4dEDy2KyI4gv+gxxbGFakf7VbqpA=;
        b=kI/p/4bOCoFiNxf2fIoRlrEdkiKprfwlIkNlC6ZmMPFZusPWoHirpOjHMje+2XPH1N
         7HqfmeLrQ/HIiDrzqNUocUE3lO2TBPgmiOH5+AwzfC+nDVE6RnVab1hzk5tN37Vdxe2P
         28KsEQiWfNe9fJWzSWr6zgH2YQUZHiBis43gL1ZPBvzca7ufwdu+a8VAOsx8H4/fuK+M
         MH7xTBZZi1JJocUTZzNlmPJE3LlujfxY6ZrQDq9AbIcAIkCKbUAcyG6A/hNIZD7LXu2X
         YVL9ezk/ptvH1YxA15kf1T9gkEmqyyHZCX9/wdRtlN1LXtdQhtGe+flpg60rpbIBUdQn
         TLqA==
X-Forwarded-Encrypted: i=1; AFNElJ+6B2KaWMfdwQxKgaztO8eVsQz85Z3nbHviod+Pz1zZwDXxi4/F8l/Z8prHk9G0mlB6I78Jg+CSMSp7AwfXC5hYXAwIHnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtS0exftUjLjSeW90Ktj5vrFaveH/+LaqyY4HAhG7gT8cNx6Tq
	9Sq0Hg9ZG7O4VJU5swxpfA0BhKxQwbnUjB4ml82yTf3VjJXXTTBB5Rdi9MZW6/i4r4mbScQQ6o2
	btp6fIudTMkv7xm90vSrExc+utn2xHgk=
X-Gm-Gg: Acq92OEx4gDGuq8VINRd1Vxc9MP2oCXKLIQcVxEesrwJlV8zU028csju9ptvfP/iFtc
	rtreCiMjcQF64BvppIMOLNek1X/E2QgMmwH4e0+iR1apY2Gq1HfwRp+8NWD/uMBs5rOi1KIJjzj
	rXaAx/5Qtsl19CI4OlnB8WnHb0HZ7Np+zS8znBP/7q8xq8geUuFlN/uUsC1+rz7w5x7SUQhwmQG
	wYN/TxZ6PH6i4pTA+wFIU5QKzot0kk/zeuIEw5jrV3zOVIKkJ8vr3YzbWpfve78i8SJWz/SZZhG
	LFJ+4QP3ugczcNcWAUy1CoL7psSXSWZbMAcSTHatvSk4S/i7HWuLC3pOvd9Znhp1xc0ussdo3bG
	v7CaFR/FiVXpK2bkj/E1moaA=
X-Received: by 2002:a05:7301:6785:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-30398176f35mr1270947eec.2.1778872063122; Fri, 15 May 2026
 12:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACeWta-RVTqcmLVmLTJ7yLrStjrLEyL_oYpG8QLAcy7sEyKmCA@mail.gmail.com>
In-Reply-To: <CACeWta-RVTqcmLVmLTJ7yLrStjrLEyL_oYpG8QLAcy7sEyKmCA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 May 2026 21:07:30 +0200
X-Gm-Features: AVHnY4LEIX3vOzKlV2ckoEdFUoIObrLviqRMWlwHLjWbRjHNlz5QC0VlkWAildI
Message-ID: <CANiq72kVzYdu+74M-VNSRgq53n201qjoOaua1K5S4abDqrsn=w@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: add safe abstractions for capable() and ns_capable()
To: Arnav Sharma <arnav4324@gmail.com>
Cc: lkp@intel.com, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, 
	paul@paul-moore.com, rust-for-linux@vger.kernel.org, 
	Serge Hallyn <sergeh@kernel.org>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 7:13=E2=80=AFPM Arnav Sharma <arnav4324@gmail.com> =
wrote:
>
> I don't have an immediate in-tree use case for this. I'm fairly new to ke=
rnel development and was going through the existing Rust-for-Linux abstract=
ions. I noticed that capable() and ns_capable() had no safe Rust wrappers a=
nd attempted to fill that gap =E2=80=94 I was approaching it more from a "H=
mm.. this seems missing" angle rather than "Do we even need it". I understa=
nd now that abstractions need concrete users to justify their inclusion, an=
d I'll keep that in mind going forward.

Yeah, in general, all kernel code needs a user, i.e. a justification
for it to be added (i.e. it is a general rule, not just for Rust
abstractions).

Please see https://rust-for-linux.com/contributing#submitting-new-abstracti=
ons-and-modules
for some more details.

(By the way, your email uses HTML, so it may not reach the mailing
list. Please use plain text instead.)

Cheers,
Miguel
