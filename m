Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14555192B75
	for <linux-security-module@vger.kernel.org>; Mon,  1 Dec 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608965; cv=none; b=m4FsDGjh1dHlVcCtFDznLowCEqGtvrPvnfQTpZLqJwbxVv32whXEtLn0iUN3GPe2t+D9c94YKqWRLD8zKo7wd3J1UVwNSMurBW1g6UmV59UnUlDOwsYICQpo7vtHaoPZM0WUf3B5ST4i9+a9m8nYPCt7KrcRzczWCiQMB4lnHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608965; c=relaxed/simple;
	bh=iBbiUzvYi/ln13SU4XKUqRn4bX9H63vGL1eyD6pfsfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2MxSN+bT0TvQtDIo5MPyLC4+YEiUkTIH9LV+PrJpt132l/Qq9Pak5Uw5ENkSIPKq9RxoLixUG0Qg6YYppjLzA/H4a2vS8jbVGeC7W8SajKla+A1cL/BiGqfDpfF6x3nMF2Qvb0wJTPk4Xgzu0/8Pxl3x8FHsnMUf2QBauq9T54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC15yTDF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC15yTDF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297cf964774so7212445ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Dec 2025 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764608963; x=1765213763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10oqy7XG0ziR1jN7iIJoYu4N7Sm/NTHUpb4SiggOXnk=;
        b=HC15yTDFMPAT0Lb1MqdcRSii4KackGdOk4+mnSLFKvQu0v3nYYM0yymTsluA866K0g
         4wPZylYTIdvo1CrxrAEL4ajRaxaaWzButBecL9BjilU3/dhFAtW+rojUu8vCC6Yl5zsX
         BLsenFBgxhaHLFtQuVHpJO+eFAvHVAHZKnAM6STfeELlh3+kopFlC9AJHQmfN9YvaXOK
         EYX5i08LaZ1RO10SUaY6TrqF+SiwDI4iUDzElt/WUX6WEqCTYSCqHWt2H58UcW3HLowI
         DTiRX73GhsiFHjfZHTHaRofvWJxqezdVthpcMV7iFihXwXRktd+rLkQb82BU8QLr12Jk
         /EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608963; x=1765213763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10oqy7XG0ziR1jN7iIJoYu4N7Sm/NTHUpb4SiggOXnk=;
        b=trhkUID2pQfn318c3/VFgX4GDCyWDpCWqpAZro19pl9opylC2Fc5fAFhG/o+1kabU7
         cVjKDWfG0/hNIuKOC60aSKHTgkyME8I75Di3XlojAUJwfgacLxVQj5MVuvgMZaAFoqVF
         Nph0BuePfj+nSeOVuEdhd3aObIAoCHsv42FREtSJKjv1JWqxJnuK/6gnbmb0v2x6OqSl
         BX5CADgu8Jbi3GrVSWFLarRYwMpgDrQKUjjAhvzC+oUg7UcAQQxV8yJKTs2MRUSIy9m2
         rwoD2tA2NI7rWSJK1KnEjOYsNDZY7mgGQIvnieS/H8dsHKIjb0BRrvz2Uh5WEdxXsQUg
         guzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb3EKLkRkxs7Slp3Hz62aMmJQyTqY3KZD01E2PuJTNQ5njRBxVzRojAOL9Ny7TxC9iB1u2MW/tGcKu7H7ZEvfI4sXOjx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXb2V+al+Jip791ZkTOoT3u8z1CNGJ75zNb7dv4LeiLdj/GAEH
	7MXu3kFXmEVrA3KmkSIoO/LuIMDDSxynS5vCuDnQMNUROuIKfzKLtmaI4jjtXYsVFQL1L4oS7uu
	cMwxCmsbQ2s3pLZpjRoH/5hZOBQCgXN0=
X-Gm-Gg: ASbGncu/lPrERZ1ZrsgdNhu/M6kmpFauj3hGqRWMLjyOUMujWeJ24XWemhK6qcRF5hC
	GuM8iuGS/Yp/YhDPQMlfN0kMXy2L+/QVb9pzK18rAiLCf4JVtnKz9dQ4wB5eeWYUs6PUouK+GPS
	tk6kN8TGmLDQ4rWlAUhB2qr6uc4cblnnnL/JZXmi8tY8ewwgYiAXD3iNdpcb1ekt3XWq/YYuy5L
	1FYFWBVvAUf40PnBe/ezgS/5MZsj2rCUUmgwv9T87EWSaGo9/d3eHsBpxrNnt7DWXuHN/pN0gNr
	tddrGCvCFTEXdGwfYOM2dOucbsNe8jhvxkgWJV9EI5biFAPhA5mVcaqsLib+/wNZknoOmRGvrjl
	VMcoXGgVfnY6FOQ==
X-Google-Smtp-Source: AGHT+IF1YPYGD/E+eDHxFkwlvTUf8jqG51M5LA+tdLWxMqHx4a8yCVti7p4nga92l9CsKYM8VN2f66dz5zEFbxtTTgc=
X-Received: by 2002:a05:7301:e24:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a7243ec7b9mr21959223eec.0.1764608963077; Mon, 01 Dec 2025
 09:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me> <20251117-unique-ref-v13-4-b5b243df1250@pm.me>
 <A5A7C4C9-1504-439C-B4FF-C28482AF7444@collabora.com> <aS1slBD1t-Y_K-aC@mango>
In-Reply-To: <aS1slBD1t-Y_K-aC@mango>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Dec 2025 18:09:10 +0100
X-Gm-Features: AWmQ_bnmy3Os7dUuxEXbA4TScnRqySjzLSX-NOnwmbpPdF9z2OcK2znpi-34sDw
Message-ID: <CANiq72=mZXc5+fMzsdTRupUsmsuLdsx=GZucn2MNoCTLAT1qkw@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] rust: Add `OwnableRefCounted`
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:23=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> Ah, yes, rustfmt must I done that, and I missed it. Will fix.

Strange -- if you noticed a case where `rustfmt` wasn't idempotent,
please let us (and upstream) know about it.

> Not sure what you mean by fictional function. Do you mean a non-existent
> function? We want to compile this code as a unit test.

Typically that means either using a (hidden on rendering) function
that wraps the code and returns a `Result` or directly a doctest that
returns one (better, when applicable). Please check other tests for
lines like

    /// # Ok::<(), Error>(())

I hope that helps!

Cheers,
Miguel
