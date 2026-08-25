Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B058472780
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664065; cv=none; b=GZcyGcXuLe6goebgP+zA9id0VhArvszRN7g7IbkozlNn2PtlrU6TyXAiJ7T4cUtdNj3vaa0bONg06msgQkcOLRU21yxR5I8dmOMl6HuSGGU4v1Jb2G+/UPlqtc4pyXcWvyw1m0yYV49nPjlInvagkdXv0acdyAbGiUykAudkzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664065; c=relaxed/simple;
	bh=dZXT/FK7+tblCR4etoX/B8DPZXP4pkVpPaPoQ4mCAI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVxbvxpf6VQ8757aiSRFiSayYl3yGFDQlSbT4y7/qMTtttVJijGVLP3SDCRVPy6cMoApAizJCc74zDBjvaN9ZifrIOq4P8SNCuL/bVJ1Udj6zBRfhxZkXJ6HxNL0chW7uGLwcHRK8XSub0ARtKVz+yPzAEcVEI1mENAwvud5mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUpNRjw/; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUpNRjw/"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496c06ba017so4509145e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787664059; x=1788268859; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
        b=LUpNRjw/bDi1PJjzxflotWRksbTiWTYvDgQQ5KG55K3hmqXRo0bT8fo9bHkbgPE4ax
         g5SGSqtCC0FFSxNnCfZzxIT6+dcUPucNZ84l0NtbcxUMJIzzo/MNz7z7ej3E4cJ74+qo
         db0c413lo5dZ+c8gjq7c4AzzeMga7Kt1kEStbViOdwtxf2AsQsjU66RtnOTF56JiOiCh
         3NpQz9LuUb0DEkzW1e/WVKTY8X7HRePmvIH1DvndSuwazDPJ5M65HnPI5c+DpV0luIU8
         YIHHo7GUjL5G5ezhDRr7iScqT9Y4RqZf1wkC/7E87/FBfa3LgoK/FwPgwVlw/KqEZV8p
         Q9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664059; x=1788268859;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
        b=V5guHXfIpCGDclPGsSuF+xJwD7dORpKiIvp/L25J/RRt1KP8zn203puQvRLkvw5oNe
         IhjrsyxjtOwXAnxvR9yjlzAJE3yjAI2eW5619vD9Vz1xZnDcrodxqqkghlLjQJiv2ghE
         a78IhjhpW1QKOuIssJN+M+/aVH+CdQViCKrGH1uAv9qAKRMHiwbQLcJuUKPoSZAMVuc5
         gjhaThGeYegCdof/dTVlaUWb3CNAP6GPpeW0GD7BQyNMNLvMSe2qbBuPc9hRBNtY5/uq
         11Zg2M4fxmK4WWnYfUZ+fQ+6SNf4d76MY2sSDKp14Ev9Aa+NkuHBirS1E26+JxyVwOSl
         yFnw==
X-Forwarded-Encrypted: i=1; AHgh+RpGDpTo6aoGDyLBjGflFK5MqSpvZPGOdz3BAL4oZAkhirpyZ7kNHIXF7i9awoQ5VLh/1QiAltlcDmuVJHphnMUotRKnSWM=@vger.kernel.org
X-Gm-Message-State: AFuF++l0LEVK+/MuzUBDj6tRFn0v2Xw/5vEeHC+IaEWNf6p8aVFgSrW/
	ib3Esln+uvgvDB9P+HQSzm7KgpUhfsuLADyLJ0d+R5c7FTwlOXwjPBFJMjXtMJzjfg67SLIUmM1
	1ZIE0b718eucwpvi+2Q==
X-Received: from wmjs24.prod.google.com ([2002:a7b:c398:0:b0:499:9f79:18de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f89:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499d63308fbmr60648795e9.6.1787664058484;
 Tue, 25 Aug 2026 06:20:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:20:57 +0000
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-4-490735672187@kernel.org>
Message-ID: <ao2WubjLtDuHvRzx@google.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> +        // SAFETY: We just successfully allocated a page, so we now have ownership of the newly
> +        // allocated page. We transfer that ownership to the new `Owned<Page>` object.
> +        // Since `Page` is transparent, we can cast the pointer directly.
> +        Ok(unsafe { Owned::from_raw(page.cast()) })

This doesn't satisfy the safety requirements of Owned::from_raw()
because the page may be used with vm_insert_page(), which increments its
refcount and causes it to be shared the vma system, and this occurs
before Page::release() is called.

Alice
