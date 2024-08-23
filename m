Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73155566A;
	Fri, 23 Aug 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416402; cv=none; b=BmGyHf6XPts4hITHTX3++qpUrVKU7BwzxFJxB0n8nG8um9bv2icvnGFKEgLfURUkF82Lx7yQ5eA07UIVC75ugcgu+NRRYFm3Fgrk9h9hfEUhCnU3Trs6ub/6W6nkanzCX71gFnX8oFlc1wLyx3AC+Bws5nnYfNpnChuC/iCneAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416402; c=relaxed/simple;
	bh=/Ukm4fm7znP/Ta7B6ApX6f4A6aUn1RWroLgpHGfuj58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8Dvx1Zqv43Jyh5fQqnqgsYl14fVGJx0rsTL7DcuHYaUw9xtxYhgDltZOIJttDW4l5S4ndp7mtNcF7RE8sYeMTF9FE5bBggDV7DnM+GXsLI1HQC8eLNywgU39vX0iNqw3MDwP7mKnhiZb9twJMRhmM1HPYdRIYSUD3kvpEnFVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKBxorso; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKBxorso"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so275525166b.1;
        Fri, 23 Aug 2024 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724416399; x=1725021199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kZ4U6DAAC5ZTrsCyacBjxvIViMUSw/QAxySbFMAfbA=;
        b=YKBxorsoiujLTAgbFJeNILmP7oiA/MQyg5HcOBvAUUCLyxPdmSOcKuvfevz6pck4I+
         i4wGMXEdA8J5y3XH2lTd4BZ/3MPUgDZT3t/h9zLmKMGCgsZmN+2T1AKn1U2zqBrizfZw
         L5mbFpnIXp6qZtvcMB9fZ+xDHsedW3nqGzMfCUAiXkYNkQmZs+Imts2YM9J/aQ0Aw9H0
         tn/8OaKN00Z6B0E+IHSNr2a09wtNIrOd39j1V8NKXuBmRiBca44PCghHy2SZubX2WVVY
         WQhpKuyeWel67mHKoC5GAg0RBqzUe9mVoOIA4jXssU3x0pz0rrKfbu/Mt71AUodKr+lO
         B6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724416399; x=1725021199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kZ4U6DAAC5ZTrsCyacBjxvIViMUSw/QAxySbFMAfbA=;
        b=qMJdgX3kGjdu80LNLmlwJE8QECT/RwBLrzvUfqfu4Cpxb9i9pstzoYpLAckzgSNlmy
         QqGzBHW34o6x/+sod55HfJQ9SVbT0vhffa2h4U+62WleRuzqrbI1sFnftvaMTxvyNqtq
         donXF8mZVJBrlYxPCs+mXFw4zXdPwi9QqrUEwNmQTbvrKgnLUsbHsuB6tTg7KDVupBwG
         OztNnzQ3RNs7m9ykI5IvX80/7l+MCgN38UUbqN5vDkKevy0b8IzoaejPXmR7XCoRmYaD
         SXTZWTyqQE9A+zT5bZjsbiYVj7iK6yycpm1fnIafsC2O+xHS/4fWEeFh5QWtjlA1GpbX
         rI1A==
X-Forwarded-Encrypted: i=1; AJvYcCVEyT58mmh8SHvJyewmwIG6ijg2pR/dm9HJMfIdPsoybmMp/9VTATXTgjIQ//Af7aCmzD02lb+4d8b1Mzk=@vger.kernel.org, AJvYcCX5fVKfvQshs+r3pY3gaIdJZg8DX9jIK5tgrNFTV2wZdkTgYoUr0Ik+ex1E/B88lFEASjb7yZ2CuiH1yeR3TxUzu8MmKmlP@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW9lloU6OYe7NLkkzzmBrIXS1rfJd66FbMKOglBqc7WiArMsh
	32e2oYOkVDp6LTlO/zNaUfx7sTSR4Vv0er+4a406aa6A8Txid9FbLF8liQVW/VwhR+TRjMGkUs9
	iPNZInhjG1wVLeJY1wAI+8po4c/U=
X-Google-Smtp-Source: AGHT+IGlQ5kyAhs/JlrLdhyKzBWhsT9Wcv37IYTrMREOj30x1g61xzJENwkJO1BiIan9knqxXqgVO3ICfBLJ3CIOs3E=
X-Received: by 2002:a17:907:7e9a:b0:a86:a4b1:d2c0 with SMTP id
 a640c23a62f3a-a86a54b8ce4mr193002566b.53.1724416398473; Fri, 23 Aug 2024
 05:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com> <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
In-Reply-To: <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 23 Aug 2024 14:33:05 +0200
Message-ID: <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:06=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 22 Aug 2024 at 21:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > The refcount shares the cacheline with uid, gid and other frequently
> > read fields.
>
> So moving the refcount around looks sensible, but I don't see why you
> moved 'non_rcu' away from the rcu head union.
>
> Isn't 'non_rcu' accessed exactly when the refcount is accessed too? So
> putting it in the same cacheline with ->usage would seem to make
> sense, and you literally moved the RCU head there.
>
> Why not move it as a union, and keep the non-rcu bit with the RCU head?
>
> Yes, it is rarely actually written to and as such can be "mostly
> read-only", but since it is both read and written next to refcounts,
> why do that?
>
> Did I miss some common use?
>

It gets looked at every time you grab a ref.

The layout with the change is this:
        /* --- cacheline 1 boundary (64 bytes) --- */
        kuid_t                     uid
__attribute__((__aligned__(64))); /*    64     4 */
        kgid_t                     gid;                  /*    68     4 */
        kuid_t                     suid;                 /*    72     4 */
        kgid_t                     sgid;                 /*    76     4 */
        kuid_t                     euid;                 /*    80     4 */
        kgid_t                     egid;                 /*    84     4 */
        kuid_t                     fsuid;                /*    88     4 */
        kgid_t                     fsgid;                /*    92     4 */
        unsigned int               securebits;           /*    96     4 */
        bool                       non_rcu;              /*   100     1 */

        /* XXX 3 bytes hole, try to pack */

        kernel_cap_t               cap_inheritable;      /*   104     8 */
        kernel_cap_t               cap_permitted;        /*   112     8 */
        kernel_cap_t               cap_effective;        /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */

Thus consumers which grab the ref and then look at the most commonly
used fields get the non_rcu + rest combo "for free".

consumers which already had a ref don't suffer any extra misses

--=20
Mateusz Guzik <mjguzik gmail.com>
