Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78D36CDEE
	for <linux-security-module@vger.kernel.org>; Mon,  2 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454758; cv=pass; b=XVqY1QTeDkQe4uZrlh6nzXnxcfa3nYNfigxhGRgN8DiNsuuq23BpNObsexYt3mHA5/BfqPvXz9YfAEnR36fF1taxF+N1bZRzD4VhZvjzU8ooyOwgFjiQiCVToLK7N7xo0fINf2rHFQv2XUdyPuUR+tP2YklaM2RXXGhk9H1pIII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454758; c=relaxed/simple;
	bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWd+XDCSd2MP+WTvR0hWVcFQtNmsmWpG6Hf43wxoRBgx2cbPBbibltxEd5XYMZJPHlJe2rqHCb22ty6PxZotq6OjNUH8lQjfcGdQfWPUqqcAldaMWkZQvob6AYDcxLgc7s3zXxGIHnv13wRMyectLRDd5QJ2Z/oFXwMuz+glx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtoUIMmv; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtoUIMmv"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd801b40dbso316424eec.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 04:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454757; cv=none;
        d=google.com; s=arc-20240605;
        b=FGDaIuxirS3yHd4rkvs8JWN/NbvwMIVQxBMyeU6CjiLGKOGk4YD1FKHR5YcLqEME32
         kF/s2gKDT+K5Ni7D9Vd76ZKSJhvvgdKKCPgtv8oVzcrIvXkmCzcFyV53F+GDEwT342fC
         Z/9Kgn8yeBqOaIdllFev3a8zsnTcRR8uFFJQUoIRUVqBY5uny4BJdOhXMICOWMXUT/pk
         sF8yHDnqQ/SEVtYZ/nCAxG09gMFl0sCDIcYL+9beqgYIiI3YZzsvOfpfHeJkYbl7eut6
         +rdN4qMwijejAQiWxUSouUh8VbfnEEXIFXVt9YJJxzZ/kgYdjYO8n7Ff4YaejPJvN81B
         NUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        fh=RVh4YmKApDSrt1GKx4wkumKRbFrUhHtGXr/MkHQVbOo=;
        b=dGwQwIR/WRE4M/pMZq5k7k7jLTRQ5x+GakALrI/fVDf86dyDw/yz5vaAljVAn0eFxX
         9ihQ25dIvB3F6yrCucfQW7TpI2EAE5jheHvS9yiLxU4t77LRoAxFVnoywahFdkgXXH4o
         xTKYl52oCiC741nK163+jAE3eqtwAtL8Wg27Prkv7jH1n8aZaqVN+U3fWYFWsJ8PV83Q
         KPE+/aFlzH/2XpN0Gs2p1+8GdbXVAqs5fzph9Oj0Vmvohn0SytHlG7a1WUvnBpj2xezH
         D1q/HDeDWedQKPlRVL6IQrt99jK74tevXFu0u2HQLNpC+KA+FZ5eAE9h7BTxze676grf
         HW3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454757; x=1773059557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=KtoUIMmvcT9a1/mJwfhsK4ojPgzcyjaxTFsEcYoZHNxa9cIO7JLI8+2vzY7sr6IXWs
         INDCyzwkjX7MYDdtmfTXbb5lNbJJyUd8EAH+GUZn1TLJlwfVj3XfqpdzLvewFUhWegbJ
         houyxh19vsOHE3ucUTuT46UASQcLmznDmqjYrOFDtNM4GdWzVpPFJaAnG+iJTZcL5I6+
         43i7B8ennRgMwdU1GhdIbMex7AT/IqbwGF5F6KAHYkjL+3inuUfXyYPZ2WU77m7wvmrV
         tX0DqNdR/hSNUqoZYQjeE3p3Usu63AK42R4NCObpWHhSI0UjKEhpWhjgROxcziVYmWdo
         5M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454757; x=1773059557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=A82OiGEBaXvCZWqUyni6CLaZeWUwB48hcYlc/N92GijIWFOXbO4LUgFiERWykTuLgu
         pTg3Vq91EwzivPvlc7mFlH+PiZQRYnK0sI+9BL6mmMw+3w82sE/lpctiYiypI2pMOME+
         eS/BBXA6+6KXrW0eI7T1JuNdc4t+V3TKOWElKJkB1jhhuuMHcJUKi4X9mGJhdwo/RlTX
         ZldPAMxCfGBwuDTxFHZ9Mc53NdxwjtpcG+pH7AfGiLlCVivc5qzj+kdFFdvdY/vzJpor
         F68LAiPQSD6qrQ+zdVN/z3vDXaMT2HDAZfQHjBigM0yOo8JUB4RKE0Wb44UKPutIhcsG
         CUKw==
X-Forwarded-Encrypted: i=1; AJvYcCWO1q1GWdDrjP1BDxzHV0lD72L+JTTJiLrTLMvpBfmROOh784WEdpJqP7I0T7UAa5GxYri9bqhDvYeo/Hl+uMaDugD/7mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnK8wyGn5llqc8xXFirRBtie3pWE1/1zDcWRhCI8TTTlU/zkBf
	Wrtt5lVgUcZhyAwAYFaHb3eTs47UJBRZ7GMXGVNVSb9db/P/WT+AvtNWEecgKDY4p6rLQ4j1ICJ
	2zWeqeE18eCRU5ChzUr6rhWnuNMi53E4=
X-Gm-Gg: ATEYQzwT0VAhj1CUQGX2Rtfi1ZAUSUfbSlKr4QB54plmvBojIio0Hhyivi5kFPxMAcU
	uClnGKfX/G199IfnpUKoppJHSp2L3LUS8dcUAIeoQyeuiOhFgfMqKI3h1qAV5u23yRpwkUCTgnR
	t8FyX/EMqnxUuXzF2uy9ZiL1Hepz5Nl5W9PYKe+xkadIs3rfRVHVgsiEUB8z5cm8KvEjvaTSqHO
	VOH7en6FyUR0X/UzpoclNYl2iyQ8j8ziIcAVwphdB2CSMjZ9b7HsZ02PZYGXRKCS4sTrrW912ji
	1v2BS6+P0gy3V+7/YTmRVysqvJ5e/D4L1HbF8LQNcKZogr4ricMbsvM6gl3H0HsD5KJwg3jzAev
	5ibHxRZBm7i5N3A7/Hj0652iFIoCG
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr221836eec.4.1772454756603; Mon, 02 Mar 2026
 04:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org> <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
 <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net> <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
 <p7rsBPaYxHKSMFCYVUFY5hdI1H6jxHK0s7lxLQkqH4rylM6yS03Yt52SCjiTO5qBVUmc41ZHZ7XZ0_3w_U-O0g==@protonmail.internalid>
 <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net> <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 13:32:24 +0100
X-Gm-Features: AaiRm52T7cw5MIQan-WghpnUecgDLtb8HLJUgWIjNNPX7ugGbu9wZy-93BfirNw
Message-ID: <CANiq72k_c06P4_JVDCNmwu8SwCUP3UjofLCAsovBVzQi=fb6CA@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> I was thinking something similar, in clippy or checkpatch.pl. If we
> should always have this attribute for small functions, we need to have a
> check.

No, as Gary said, we do not always want to have it.

So something trivial in `checkpatch.pl` or something like the existing
Clippy lint would have quite bad false positives (and even false
negatives, in the case of `checkpatch.pl`, depending on what logic you
are thinking about).

We would need cross-TU heuristics for this, because at the end of the
day what you are trying to say is "this function will end up being
trivial even if it may look like it doesn't before inlining
everything".

Cheers,
Miguel
