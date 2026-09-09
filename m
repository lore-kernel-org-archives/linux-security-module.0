Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785C493D5D
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993847; cv=pass; b=u5C6sVOqKxA7QGmmoYvfdrGgcX+deddl/cMkMqlXg/hC/1ZvgB0nbGcab2RdR2xr1j18o5nwX6Yuue+PnB8czncP0XYb6A0+6jc78aAhcvQxxmnhRqkXoJHvchL/27+HvJ8grZzfBl4O2S5yRy4yAV8JyVXVP4o0LsXLuVBTPbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993847; c=relaxed/simple;
	bh=Dr43X1ahte5L2uxAcXX7bum12Dy+2lPWXBmGNV5wrKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2sXOfsu70d8RGBAoPQxrx7XfexbNvp/vQ34Z0vFjHn0gWmETsHxjnypMO/jki4k0P8s72YhxnvUprC3FzkpimDeI9hNxWJ6A2B9bX6MpltEzBQsRDAQuDyMjepxSOta0USXHc0VwqykCQLffkaajuBLfHEzzg94a/wGmq8joPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl0haaP2; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl0haaP2"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39931869b4aso631228a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 15:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788993826; cv=none;
        d=google.com; s=arc-20260327;
        b=nDewdw7ANYJkNkJ3BKWKSQgFucM0bLSHhLnVREWRp6vhD1kDb0oh4dL5b5qpzBLhEp
         CZ+u+ajB87DmpmPnH5za5OHV74ge970w5GFDUnwoFuni6Tiq4SWcWBOlw65JtZYaxXjO
         QXUt676JY4ns9OjWoD3FHyVyHBhejO8nGQiRD6smNavbBfvatXqsVCEQYkxjJC+/1GGu
         5o/8ocjxbu8NMMVMSKzCOvesj7eyxDWXCzPpLkW/ZknMytX1ABBvUUskLoqvDWrmBJWu
         PxFEUXYF3e4vLR9bFJo+y2HglvsV2lJKbN6rB/GNqDpV50o/nCgPJQPzbZ+zvGlPxawb
         PJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dr43X1ahte5L2uxAcXX7bum12Dy+2lPWXBmGNV5wrKI=;
        fh=auwbFwvnsVVhRRPfszycmzZhNo9NjdgM0bFbtXwR6Bg=;
        b=chyCMIXrQkmZR5r5plQlQDgSLVtY34z6MJ9KHfBOXLqY2EC5SNPOirbYOHvGL5LO+q
         Vgigg6qcmti6Zy02q0zmEY/oyWl9lRORG+C8YjNhnrlEHcQT/8OcM9IE13Z4LAF5S0rn
         QaGNpRZEytX1yzritL+Ly8apoQBaQ2wbvs3Vv9NbCfeB6KJut1ttMxQ8jU0X/kOJIIUn
         dUBNDSugF/18XzPc2xtkFM4eol/yCzbMqYNr3fRFw5ewczwY9QSEEPsTxhEpxC6HRmVC
         y4lHktXx84hn0qi1pz8Qqgn3HHWbfsCR8No8Kl4KPu22mbGZUM5HA/qJipWCzt36lJT1
         ETcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788993826; x=1789598626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dr43X1ahte5L2uxAcXX7bum12Dy+2lPWXBmGNV5wrKI=;
        b=Dl0haaP2Sh5sDJzrcdE9F7R9ya9UVTGuVZ2/1Ay8ymSpmK0NJblDWlFbWvIycPIYSm
         oqsuJ6c26g7Gd1tZXyow5ymEzOey68Kzqsu8f4CVDZI6GuGRNNJcDttxf5LsqIxU9hsL
         OAiB0z4TZ+TB2aPjD45eaiG2TQ2oREzFakTguSbsAxGLYHTOherjoGcfyXBZdzWJr4e/
         jszKNgkLLpxW7vpw2VdEC8p8VwJRsyZ3tGZ3OhwGHBanK5ffNCencvdoP5V8o2lBuDY5
         MI89bYOUpl6Od15ZD8J1mUoG7Vmuefv7jbHq5KrnDl1vvhFMkXBzmEDcMAQURgD4a1u8
         94mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788993826; x=1789598626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dr43X1ahte5L2uxAcXX7bum12Dy+2lPWXBmGNV5wrKI=;
        b=iN7/kzK1CMEOG2m1Qmim/2f+cVMAifisQyWyQWSKAHEZhsh/bQ5JKzvXQcCwJEd9sa
         udLSc+x/krA6QvnKt3toTkjcntl42Bog24o3MkAThBNXkCb93OCMZBL3gOf35w4b1F9O
         hm9yKwpQUa7bYJGxNZAGe36wZBM3oO4BTX7VVB+cbSo0eMhdrm+emwgYCcOW4DeICwEP
         xIDKwP75A2otVSnMPDDG0ATfRMomUBNOLgYAw2Q2ejF5egtD9AWy/R6NuJh6dbAs3val
         AT260YaLm4F9+JGfsHNdK9+ibCVbPap5FjlkkuBsCUuRkH8xKsM8wKGNsOF4mEdqQcCu
         fHXA==
X-Forwarded-Encrypted: i=1; AKwUvBy+pxk3IDa08rzszSXBxgHcJ+QP9PIBC1Dr8Zwq6Zkc/0qb0ouQCvgpUR0BheUF027C6COzQPZbEPZsf8v2aQMbfSFEhoU=@vger.kernel.org
X-Gm-Message-State: AFuF++lQfF1Ev/DH7rLDwl3t1wl0Ze3E8DD4mjj/fM5X+f7ZbwinoERs
	lPj0gkkztdYn0D7wrNEcQ01XVQO96bzP5eftzSbVoanjkcbpzEYptL7DiDxXh9tzHhoXRS+5rsT
	MPj4/cqJ06pjmfKbCe3RbbvtEixCj8fo=
X-Gm-Gg: AYBFou1o7FKiaMUNfhRr6aW9/mgrQCw0L5Km4dN0CCwPmESc1yLoKbKGxE1NObjp/o1
	BlqF57qaKAYig5yEtw77ieTw8C4kQlF0ZPFKl3zXqwNmDdREYNX3roWyQJ5SLk/vKRsaTKDMpnU
	hHMuVTUmMfNj6wrney7d3jxBSl7TCjkFUpjwS5sYhFPo8E1MjBK3fZGsK0stxg9bzRXNo0Qknbh
	ECDHVdbgJK8Av2OG8n19NU6KdPBMy7IJa1MEDK6KWlkGe4wyquB1h+s8vLCOm0/b6FH7E8kU8GQ
	k6PySHktLDN7Of2BSF0kp7IqlH17dVLM7pCj6rNvfdyi42eEL+q2PcNxZDHDKKbnO3qdkMr5R2r
	dJ5in/bWE797rYojYIzwUCLAiiViSpiV/8WhbhsU5HuwgquBh8vwKGeD+N1I+YcvSchW4/Iexi5
	2vE9RMIVLWklcYfA08JKplctYq9v8MyvuC8tLvD1mZTQJem2ahRug=
X-Received: by 2002:a17:90b:4b0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39b3d78fb3bmr30315158a91.3.1788993826465; Wed, 09 Sep 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me> <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
 <CAHC9VhSuuNmdRQ5puaxWh5ez3Dz9LhtAmZU40SUGgEAL8Sn9-w@mail.gmail.com>
In-Reply-To: <CAHC9VhSuuNmdRQ5puaxWh5ez3Dz9LhtAmZU40SUGgEAL8Sn9-w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Sep 2026 00:43:33 +0200
X-Gm-Features: AcwNN1Uyn8Ra7gcy_xftoK-U-ANDYC946VFJHbtC8gYw4KcE6ReujmH5Kp4eAgY
Message-ID: <CANiq72m0yYRj75RQBRprcHTrqfd7=m_OnZAAQfZdO9T3dfUQdw@mail.gmail.com>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Paul Moore <paul@paul-moore.com>
Cc: Nils Lehnen <nils.lehnen@proton.me>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, 
	Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 11:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Looks fine to me, I'm assuming the Rust folks would prefer to take this p=
atch?

Up to you! If usually patches go through your tree, then that is fine;
otherwise, I am happy to take it of course (ideally with an Acked-by).

Thanks!

Cheers,
Miguel
