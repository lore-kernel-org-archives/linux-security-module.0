Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB43480DC4
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134214; cv=pass; b=Rspoq3xjqgLHkqxKaJ4ix1zb6i9mx4r40IBaSr/JQrme9I35noK1/dqVCA5R1jHm2l0jLrN0djtZ83TdopwlMcwvlQRKktcesuvQvJsSPQ1tFLAA1ClMmP0THhknij80BBMrgjyF2VetQJqiZeKktgx8aiETda6KAwIBM3E+FpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134214; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZW3DOCSdjDVJz8MuigrtSPJaB5NWbV14nk2vjsXLwMzYRP8kc2AYHkR0HhzTBiCmfIW4eL8nytE2sYb5R4p1y7D7lCrlig2lWSsdkMNMlmKAKrWe16gXlIaqpO3e2bbb9rIUKCzaMRDmJ7gF2JKjH01JtPxiFgGxI12bmFe6f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso12271255e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=oXjWdfA5jw6djeLtyg0hRB9RmrKRnlEZwj3tMLJV1jIg7Qnp3eMnFYUx2gjSaYafSI
         rB2bH4qOiFNhEI+DEn81aWfdw19kGb8hLZXOwbvo4y9L2s8SxoZLJ5+Gno8CQM39+4ZM
         AOy74jIe3fynEOInvGsSaCFs0kJxHjDKNM21at6p16jLKDZTzkFJBneu/jkbMjwl0rVA
         50LZXbRc/sCuqUbxw8Nu8+0vyjBbF0a8j2KsVO3yIXlm1tKmtYiUs7jPWTre+hk3SzmC
         xA2lmu4xIMLaDMmDFepfWAu2F+tN7qQsyGODRRBi05xuxJTu3Pes3kAA2W8jMdrjalIM
         hQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=fO3qAx8yjdzxsuFnDrBu1aVDclglr8RZGL9xKSM8UEE=;
        b=BNyRuHGcB3Cs1pNmzeU1l5YGHK52vyt6IvjZZgnh0JBx2yTnU22g2maYbgvEfK2Col
         iYHYUj39Gbyf7raHZaEuIdl86XI2Asmjj5blgXtIAaS8ZlcPKccoEWK2j0CHrLuLgyLm
         HKMgzUMsAu9WYfn1fjDuE/gqHHxaRTVA4xnRofen/uXfTAk20yKc/o8iEzmp0rwsa7CI
         uKcDecA1DnKto/qDzaRfMmQcaGKzmIyRfVYuo3bnQC8B7O6iY9EmyLrNHx/Bb+TLEaeM
         rA3lxMaPT0+i8ijWyUx/qGJEJ2vwuDwcohbNn/CcgCT7Z8U7HTVSMde9ON+9SCUds1ip
         nVRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=Bv1oE0l7X8fJgBHdaR1W07rFr3Xiy5TJ8lmuG6wX0GxjBAA0wBz5QAwguOWj1m90oA
         wGBGQKHN7qNy0vEspkY/Ee1eV2bW/5XPxl/5IQCFMrdXT07J9NVaOdRI4BxFUqATnIYS
         uUnKSG2BY6OZTP4BC81j4LmWjjTkb+A+9XQKvlhaQ+xD+NDmH1OxjEixjy1jR6BMgXPh
         U0gDq1vBV64fqhVvUacQ7eRj/M8SscXgDY1E3j3dXYGTqvlrX0A9RTAfo+CsZssbOztF
         mkNSP4sEZDdNTf7TKJIUR9amKFnNkEzvKWSiBpJ1//5Y52NKMDbAe4zGJLHdcKcMeNlT
         oqIw==
X-Forwarded-Encrypted: i=1; AKwUvBwwXl17ub+66P8dwvfNM5MDuWVTOL1AH+mbHykHKnyXTIG/HqlA2b4aSxCd/jHLmHgbd+R/I3Y4QDL6KavnL7Mfvc2n6IQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kKAJQ7nWmX56RnuKiLQ49bGQyD4Kcz5srJxAEyMiw2aPsfj4go
	pGr2wicWq/UCRX+gXuT9ZfCgSijvRgrw1gvGoPZO3dDX1dBfAR4ny9CqDt2/L3BEB84/UUyFMxN
	ZuUTCEaqW0r2rFyfBWvAovp2RKynUdJddvQOn3sqC
X-Gm-Gg: AYBFou3UMEB1LKhHir627veTl3nzlNRS/i5CBRH6Hkmm25veq98YkA2AOoLdXhQ06g7
	fFA3SBcELO3IaZS8X7e127BoRVtRdu13OxLF/CbmSmh3WdeLIo7Ij1+ienv//EtNRkdN3SMqzA/
	DI1vGfLtxZjaMnmCDgiq5aprqv/WH1xFZzEEG5HMB32h+DcFLSkU4S32RlDVCFc8Fewh5ceFJsJ
	pgtgEEEgQDVzH7adkhMv2pQdIhhDlCNNAsg/Zs/6DvzxSO4CySuiYfdbizZdnhHxA/aCvS2aD4C
	CJKOJW49B8JL/aLor9YfZCTkmie4WvF5+NOiP7F+hLB0p/yBi11ZTht3xcbzZJ0FxPUuCAH9Y9Y
	b+wXFBsElJuszOJE4mmNRvdWo7rdXfxHaAXb3Ac7SferkZWvgsitC
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
