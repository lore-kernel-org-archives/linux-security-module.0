Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCD329367
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014276; cv=pass; b=lIS7rzL4uNJircyA2OmBfvgRESYwrxOM3XhNAF6JfbD6NJSf8cOdSML/ZtFt1acVSnDv+vXpFjDQGnkhiaRm7dVycl1Y3DOsvBwyoPFHVP7zhwxuQT5U69Qk9MJ2y9iFSf4/Qc2xXQ9b+1RQ40w4c0KVOhFu8G6QDpvY9fkg+Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014276; c=relaxed/simple;
	bh=O7/vXOHmBuDEN6iYoEcXZX9SQVUOxuFM9K3LUsWI6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIcn2G9x/RP+cJTydHerC33qcXMZPz583ccjkspcxoe7wOAtyN3kFg1/Mw2yRM/CKZHMVMz1hlPZIlI67E7Z5hc+yOsAgNGPNedA+gXc4rDtvk0ZXhpbGgkLLgHAliRiHzB0eZZEbyUYuTiG2gcX1gZTVixq5qUf4YtOFahV4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO6mb/Mj; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO6mb/Mj"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3042a99f0ceso652514eec.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2026 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
        d=google.com; s=arc-20240605;
        b=aVBZF/Hs6kR+iyEWu1hpwc5rp0pofcSeDeQGKlb76QWout8UsY75Bys6q3ZRhcWz5s
         cU2Hi5m+u0IkyHvKYX7u8b3RPn3zu9ghhqjekqjeggZbwrM7iScWiWrHJzXSkfHdGKRK
         vheNR7+30FSNMfeDUx+x5/X9NA2oAv8ti3GKkP3AKsuKbZGTcMzoxyg45GBMpXobMWfz
         qPFTtIHoYK3IMCR4h9HYRiuDMijLl2Gsh8GqAtZGHi3eA56DsT+etj3qO8nNek1BAESY
         xRg3HBTDwH457i1djio6Iy23YwEmRBtLMUY4Ims8pIKsboXQrMh6blIZatmEVk88/WGp
         RwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        fh=D5jRLbeJN/lzyPUeeHgm9NH/6u9eRxzdPoRW7EePKB0=;
        b=Og8RSMjRo9S3mvxhuH+CasIg3Dj9AT2J5JV6IR/8+TRPM7WxM1JSCFTcyFO0fYhJn1
         wwwBRTUmZFA/fMM5kVKU9ttR6sEFbuNM3RSe/i+w8AkX+oSnsC7Beo3TJKER19BatxIm
         fYWLwsazxjBvQL3gEP1QHuiW0hNpnFEg7gDXTPAOBtbJkS5nDSS/8FD4JReQD3gXereH
         T9d2671PmSfIm6Wid16Gu7aYciwa2P1h/4P3QT2C/MBZotAC84vin+tqsavFTtdw438w
         KQFcLJG01RazGNKv0tnmsfy/uo+5K+2D1mynbSSOt0z13El42JhLUYY3XMxWisYsoCkd
         ICjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=pO6mb/MjV7+9Lyoy7qKEe8jyrmAVmp1sVk9ZAQekGJY/qcYqRSPwEAedKazW1YDjAo
         daWkJzVnMyQBtO7fmggjHQ1cPEQGXHlt3VIr6I1Kj1CO/2HtnymY1aGpvzlRB8OH+ilA
         890WtpQyksZUJj37x9K37O3XCrrKWsg/O8Y8q+MGEolHuY3O9nF+Mz46OcSl6XEeAyYn
         PpKFuaWCdq+j/LCZ8xHOrMCCjyi8dyUYIO1ZCC3Qs9hwAGz+a0asgrLpY7oQ6QrXmnr+
         SzEi2Ndcvrsr6lg0pp6Uccf0k7gE8QI2hRsXCNfmZx5mer8km0ZAI5cl8BunKE5GWZwg
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014274; x=1781619074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=UAS23tUpwUOliEwu3eV8f+TxLF0Vwj3ZvTSZhvCaEU4f7mnuSiz6pY/+4BrdoOeKrq
         aWN54as6KCgMKa3fguv8OEDsv6pVAxo0zLJCIsuq0otnF8XLVIYDuGtQGXK3baSIANEH
         Rp1dkUZYiF8S/dSURPJ/1P9butiOby0cgkriKIFRUULcgf4+JFUs6UIhV76w3yz8Rm3r
         UQ/hmto1bV/GUykAtsDV5YO3tiUMtTu/16syheMiz6tUvluqBPhnvx7kRXZyQmrB9wBX
         zLIYtMprjjz4plX5z2BsUEwtS04QcjHl5AOm3xku607OSpZ+gXk+NwyHVovk2R4izZDY
         HjPg==
X-Forwarded-Encrypted: i=1; AFNElJ/cCDCcOeD62mKtZ2LgPxuIIfmWFf376pqCrHhej+NGdOE18yOtfdEeTdf8NF3/5p7Ifo8MziCz+0TGcvxgsPE/YMuHExw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTp6osLmv+sOozWhlU2A7fxg9L/njjCTyTaI+dSNBmpM24b5i9
	EQgYHmuDfqQcIyOIj3qsIXj7IXQ28tnWPM6ouBlbxrNx5SYH+/oqE21jy653SMH3R2cz6Z7/jDv
	QEsc8Pr0ekqlha5I/52aAO/+Fc2rTNl4=
X-Gm-Gg: Acq92OHqCOdgx4L2a+WAm7OEDDYc//BqMKp8jAKYwhKzhvsG3BtnPpNnr3AcOACGP+2
	pqJ0xr2+drQm5n/Goo2a7QGLkejdoXPjlrN4zihd9vT7wWxpYyU/R8GYhpGLUolthbpPB+JDwJa
	uILEXHD9jUzZ11oqi+mbNSSzgIN/IRPwxjPkQ+NLgeGM2LhdYkJqhOgy41RxO0ly62iHNRESfC1
	d2m2rZuI6JNaNzLSLErXnKMHA+qJYp45DrPHkByo2RM/3neSskCuOE9/XmEFRWo6A/AzAipv/Ly
	F2epPGB1OyB4mJ2Qj7AsA8KkCIuxUeOEVgtbDlAhgqN+FGs9+RAd4FyIXkCMUSBIY+c2RGKKHhb
	s0p9icQKDUo6dBSYoTTnKZTG+tLuM/pHcDw==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
