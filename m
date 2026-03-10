Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381893314D2
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140196; cv=pass; b=VNLCbNHb+l8lI7tTo1mgrE5CqJO+aGfsDO9dAoGnLZ6maK/tqiXYVyVlsxdGKrCgqSM7lR6940QHhXJ/C2qqH6lAXNuvus3gPa0LeT6JlM37tLu4Hm2sKBTMNLll7gGO2SF83Fb/LwkbrGFZCp6dqbppylzhUQsELKIVub/0g5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140196; c=relaxed/simple;
	bh=nL8Tve9qxXBojU4CG3EUAlYMJTfM1E+ZMJp6NeH7Zns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzGjjgJttBBQMYUFotb8oqAIzUqRmn7FtaUCJ3bF8EEgLqswXqro7qzdf8X2arrzSQaT2x+6q+UTU7+AYryRoSLJncqtDYHMmP33FEra2Ot3IWPoBUaZN6XhUKjIR2rL6YhmGtn1Btf1QMrhBwCGDSR1JRtKACGED0+W8pNcf38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbGtEBR; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbGtEBR"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be2ce5b538so648261eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 03:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140194; cv=none;
        d=google.com; s=arc-20240605;
        b=kw+PgdCFzH+VdxL3S3TRMKBes9AOsaxGFthwqqk+TfwYO2Fxwm75f91T5P8z9PecxT
         Z2I5HocHs8L9vQDRIq9WjMPIUIqbSN6aFa1TVk8A17iyqF/Ipy35EJSuXlOSVo4ksvhG
         00jQE6LjhSzAE+CYAy1wrsCaSrz+w6/vU83QljWe2/arY2DtGTO9+EIYQ4BnmrXGMDlA
         j/M5oIdr+/lTJkR97otfg4icA3WCk4JbYFpgaPNCJVHfve9Sbu8XbzmllWlwmkeBH1fq
         xf8/qRLpUZesxdOLWJXLtk98jC8Ss/Yuk+hIcPzwm107H5oSjUVMNo36ri8FoLhC7DWc
         4CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        fh=Dd85NWiz1QY9ztD7wGBmCK7Q59mu8LgGctzwhZ6KPmw=;
        b=OtD7T8E8SciLyS1HIDw0uficXNe3vJ8Mf5mfBO+lmSlTVkbDhg6pFdqSnxTkBJH9ST
         ElN9qtJ2P5Mh5+JL9/NsXN7CdaEbwvWxvHsl2dz4LVlBlaWDvpOdvcvJ8CYuSvouFWDw
         Ox9OVJIoqhZWFLn2jXfon3fr3ZKkErJv82ailx7DelLydoNBz14l84LhV62vEB+yISL8
         +NLT6UQWrV36dqrGWQKWP7mje+vqiK1s8pKIxm9zxv+mA5TxP7iUU00DP4kbwbAb0Peg
         6ERN2g5ICYs4yqt8OkaQ+6CIuu2obmQQcLreRZnZyqQe1UycC1TKJTfm+PrOIZU7Uvey
         lK1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140194; x=1773744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=MBbGtEBRBoxPubDO7aR6dBNxnj1NeX5HfI/2iP8Lzp9seSiN+tybz+fCRUtGLW5x5H
         Dk4DqYa2NIr6W29OV7/5WrHN0FEJ0+ScFhbkZQJ4OBIDWeIUWzj5869zWBkvAx1laXES
         Udu4UtFP+aCcp5tqTGuMUR8kxmr0FTGzsSlplMqaY0hCenwPTPwkdVVfNjLo+2nmkSeb
         ZLZA0ovPwmjNnfImTXGvS4gMKe4x5tYPKrZqYjvhXgCHtOZOaqyl0J7nwehmYLSwCQiN
         4RvcjhTehRXfc9XMyLghddQw5UZF09s2CvUvSITa7ja7/9lOwh6jaZeNRFPG6ODik9Ho
         PR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140194; x=1773744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=hKnxUUQvLNYL9xEkRBrDR3D2EcBIUebfKfe0xAbopg+IldbaCFu7Slky9SdguA1zDJ
         DEtv3QZ3eCJzL/CqNged3VeRjES0jm3t4YBJdMckVVSunnPgL/nV4d659GGN4bpdKAWF
         fJ2sVcbJvHxSWv/uHCYnVsqqaLjigLtcMExm9L+EIBWDHUFhwO9MI2b8S4PqXkr5IEsz
         VVsnON5HhWlMWsOBJqqxlPyNaNSEhfxn9ZpxBQrWvauOQmoWOX7wnUjXE18EntD53zal
         xVMJnJLKd0MEtilKbJe+2NTeDBhqpioPHO7+BUbbwJYl/GiDSZYfiprNwN8TZ50KTMRL
         Wbgw==
X-Forwarded-Encrypted: i=1; AJvYcCVxr3E4pRV5mfkE76PoVm1vGux2NsFO+gJov2MJT+lxVjMC0i913yfSzINJM9D2wjlqXp/6/8atffyMFrcZAFXLGlUTe/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAlz+QEfcb1twxHRKA3+2zJp1YfuuLw1e3si4KkG2tEzbS0RV
	EA7go8upHjSK4Q/NZlrjn3IuJeD/BMzTQY024VVSE1xuPQeU8FL1p+joTWwZIm7NrqaE0SFQWQX
	pGvKbZozHfn0+j3fIPHMmXJ/d4+2oKCg=
X-Gm-Gg: ATEYQzwslcICgQBHXkwwTUUNQK4knkEj98J/4zGx1AvAwYxRVLGSZhi2HGV8BmPXePb
	/9M3qXcOpf3j2aH/aZWXvGNxHMIxwEGeZsoxS3r3azhFaKXEcsR5Ck/tZ7dZE2lOaa3JsmZEv1a
	4hieYrbko2MXfwiZaiEwemZ9YoY/79WRpymbXhRME8OaxTgYzwhmYXSKjSpb2nWXlDDiJujQZ4G
	oisj1IlpZ5Fz1flM+8b3uP+lUgOH9HAHmeEDGtCyXCGfEGXTPxRkkoEarabpadVunvV5xdKuYTu
	Gs1FMP4GMw3cmwwX5FC54mHsc7PYexF5TY3Njo7N5rnILFb4aqb7D+4DblXBQq2Rv2Z1IctqqGV
	xfWVXPp9sqySdBs4t7RtfFdk=
X-Received: by 2002:a05:7300:ef97:b0:2bd:bc33:ca32 with SMTP id
 5a478bee46e88-2be4e09ebfdmr2731651eec.4.1773140194353; Tue, 10 Mar 2026
 03:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Mar 2026 11:56:22 +0100
X-Gm-Features: AaiRm523FMnYeZ1Cbp2n7uyCKjNSK8gDXCio5_BkegPeyUfSKYibfT47XJIo0_0
Message-ID: <CANiq72mT2-8m71NtnodVXVBRkhUSiK3Byq5OkBntEQpW9hbU6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 1:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
>       rust: clk: add __rust_helper to helpers
>       rust: jump_label: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

With these, the series is complete.

Cheers,
Miguel
