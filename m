Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D525223336
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404101; cv=pass; b=NSGOxZUqUxHqx+S37D7jMUycpKH6/2JsKg0lMD1NKP1fZPUwSkyj/PZe7mJF9b9a2LS7sjD7LD+uHNPP5ztZdXSExXhn5SxAD+PV6wPKpRJDDh51pUCkbqsBi+6tgcRjvGB74vEQVNt/kciEOjM1H3Trot67TeoMVEv8lWG/iAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404101; c=relaxed/simple;
	bh=ZBsVD6kxKzurT7H7DtCLfcoGufza6/gI7cdcVlj4q0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCMcHDxUuHya2oRNvS3gWURscMwGHN7+Zq7lHo8RNBwZotIKGSxq0LkC3zbEZblwZW90vkhQd3pUd1lQzUA9OCh1cQp1dRJUI1qydovtOIaxiskmwbrAiNGP3ZxYWq11mYbWClx6aaVIjYSI6lHMf2RYWqwlMnBf2yAhZW7pqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9kfJBC+; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9kfJBC+"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6a868ad45so434179eec.0
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 21:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404098; cv=none;
        d=google.com; s=arc-20240605;
        b=XCll1loJqN0EsCiWR8nEH/0nZGreR6iDUN+5KPzW17l1ozHaGpQXbh9/O04pg1FNYJ
         Nn02Fu6ICga4Y4Agg2kehnwWjd3n3t83urhDA/cbZtKFSOsaF0PZglmFb4QKSL8EiAmM
         qRpcq4j9yOPf14ZArCjt90AtGqoOjjHQPtdjLYwrEmgk3mLYAuwqrbJuxkq1YqxMVmGr
         XSqvGsSR/JUlbMKpbHvDv4d4TUuO7+FLvtsqH5vD2gNxYWsb0L80goJUke/iM8ojZ6RE
         2Q4VdAdSktQcVMW4CSymOHbAd4jNRjYkn+rAx3eoIxau0y//Xpb6ZatI0FViwyQurFP5
         enLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        fh=gWSsRD37vN3AaCcQEVTsDLaJsVTSMxAOBGw8oPTJvhs=;
        b=lYiRD5StYF+7hm3owJYv93kzhU8QCOSrGAkbcPWvuHNX94KyO/0Rq0IBpNwA9YsT2K
         oK4VLPT8PCrhQniW75bYW/tNf0Yw0bCVrit6KvNWwmoY2CuhxBjTSZf+hrB1iILwEDW1
         lf83cQeyKAVVtfx/nXACgXkB9tY+0WGhihLP7GEsJ87dPZH9/DAG2wbhtvD4Oelmq1qm
         4l5AFge8E4hVAV5hKk6al7V+Nqx1QD2iIU6jASNIcsljdgme33XmaXUh/XoHmXAcg0kh
         mlOBeuZ/ewGVKWJ+SSM3CPjqCGKZn4hw8ZNjgOUHOItv3UpbF42DkZoKybaPzfdFHSLb
         1x/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769404098; x=1770008898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=k9kfJBC+ldCHGEir2hpwOAhElO6egoRCIxzj0IKfTEqmro2/yY4nV/+ZWVpPnASaL2
         +mKMYxEvPEWQ3mA0MifDdWsjJxAV9WDFd60bga1tQmEuwjCMbcYXGnmdKnOy0gkl2ch2
         Mwj8Ks7ue/Tv0fi0t1I2FGHTzLLGzLT7EpWkOR1/bqd5u34W9Lgxxo6NypTHOKYsnB2Z
         KCh6L7ducVKh/8PXfUb+iHCyyPnIdAB5ON83DnVEVnBfpqvtvEurIJrSHBLvIkSub/iU
         dCIDy2cliqsDj+61/J2ss/bUZVs3zCGOy2Q26lc2sW5MOSWlOjMrzV8iWQUqiUi0YrGB
         4lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404098; x=1770008898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=Qx7x4P6Az3e/N2qy8sdVnamq8bgo6YSgQ9fEH3sGmRqbQAjfpjl0PcRkPJ7UYMLx7i
         hMaZxgRoqUHDPT19bc+89sd0UkOLDk+BJ2woZ9E3MDNGb4kMSvrbnJ7LUrYdMlGPBq5U
         kCGaqGE4f/zeKyTsxvB3CurIx1zEM7JyCy1PD5HoCUgpqrJBsDpqkfnLeWgiQ9TpK9Wr
         CAjB61gRIrV5RzqZiZ/LcjYWehFEF0a4G+/8hhADf2HgS1VFZCeGWPICX2tXWQrHIsfO
         K3iWHps0avy57qXEmBy4jPSt9kAoTHLQH8qu0S8W2e7lAs2TwV9T2hExjRdHLhghraBo
         xDCw==
X-Forwarded-Encrypted: i=1; AJvYcCWHbzkPyBf+4GnbCgAUp5CG3qSRmiCSts6ueFLFc5hbRxAF6kOiWvB4WsI86NXXqR3iFF/j15ml7vTouanPWocl9NMSNhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JG6P0/qibMVETUclupkMKNIw46tpCQKP7/+a8XcH/KHPXPcl
	XZ7RKK1X6GCH6AAEowazuPFjw9txJxwGAqZ0lBMZ8cKWu+CdUCVZZjOnObHRZoVy3Y+kOCOFzJL
	STcbLYkaVn47D3WhdJcMzvXU9v5gi+bE=
X-Gm-Gg: AZuq6aLoru3TunQXFFAIaYbBxHfJqBHtblcEISTrt1pGo/m+6Glh1PFN4i9SC8dANoA
	plfyCjSos94366WiROb0IlcKVsYBeN1yS2T0yYAPELh4loxEKmf7GGAPcRtO278cEXN7M4gUchS
	AKa2s25c3h+g0PR41VN1jAK6oXPJa3mxm1VkG+qSPtMGc12q6DrqgEPM48JIWaV8wr80tacvti9
	C3+sHbJ4TXPMPvZ3Cf5pYbv66OG+8tFecYRIx87GjAGyywukR4T/WIcdbGQ+JmRsyRJ2QCO6q1r
	CiYl+eYQl329NJZSPfKuTohC0pAZKfPcKHX+Gpf2Ub3gd0gPW1Ca1vImQUIaBg99ag0AX76hbwV
	UnaVV/HeyckZQ
X-Received: by 2002:a05:7301:3d10:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b7644f41dbmr855051eec.4.1769404098278; Sun, 25 Jan 2026
 21:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 06:08:03 +0100
X-Gm-Features: AZwV_QjC45jcqbNpvCzRgWaUDtcYZvulw1uksmCYv_NCU9WJD69mYzMDZ_yhpJo
Message-ID: <CANiq72m4hBinKM4jRrkpZ5nM_wraQ8FMsYtjgKRkNDmK5sS8dw@mail.gmail.com>
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
>       rust: bug: add __rust_helper to helpers
>       rust: err: add __rust_helper to helpers
>       rust: maple_tree: add __rust_helper to helpers
>       rust: mm: add __rust_helper to helpers
>       rust: of: add __rust_helper to helpers
>       rust: rbtree: add __rust_helper to helpers
>       rust: slab: add __rust_helper to helpers
>       rust: uaccess: add __rust_helper to helpers
>       rust: workqueue: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

If someone did not intend for me to take it even if the Acked-by is
there (e.g. perhaps Andrew wanted to pick those nevertheless?), then
please shout.

With this, and if I didn't miss any message (plus looking at
linux-next where I see Greg picked usb), then only clk and jump_label
remain (plus any new incoming one).

Let's see if we can get them done next cycle then.

Cheers,
Miguel
