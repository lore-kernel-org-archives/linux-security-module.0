Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643F3A6417
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897733; cv=pass; b=GRVUJMFVyLPd+TY74V3h2yiefrW4PIJrFJ6Ec7Y+guRZ/HGJcSwr8UACX0JOmzx44XCMdzw96nc8CHUi1+O38vYx96/Ak+BNCa4hfKRN2hGaJbi56+wmmK7GBN2T8GHLqB/8TBKanLgdeYIwaZwwxulWEvaVsKrFvubtMmt+ANM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897733; c=relaxed/simple;
	bh=NBZacTtQ58xQanJcHP5YImLJ1HDsw24G+l20TodKtZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2eiT4w4qCW9OQuc0CjYCV1XVQ4izUTy82KBw7tXB0wocedOMk09Q7ZxVs9xt3bUb+f6Dp0B5HPRzxUl+WrM5mmB4W/Iwytc/7wyE0QLl9+8wU2Q8/sGFcbjeO3DXMAtzjbaKQK5NLOPBZ26S3mgymg1znsbYuVG660hcWMJl+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6w6R75G; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6w6R75G"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d70066b704so612185ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 23:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787897731; cv=none;
        d=google.com; s=arc-20260327;
        b=HfYaz75lNuUUY1j6VTJUey+QhP1xDUYlpQi9S/f0pYnQITz2OH5uaByt6LFqx4iVVF
         zwPRT2W8qVNt7yuEr3RMSI9Xo7cpHwDappN8pVd6+ImG8qzB/GqO9ke2jla5iH0E9nKr
         Fe5rCdM/csPqiYpYYiGYU9Svy49nSfXTrQa4Y7mGTwf+ISMRNvPrktFAOO/MXyC76FxG
         v+umvjX4HLxmCSi+49NYl314uGb2+JGRlpO1qYhIu5E/8+WCxKg4dAKwaM9EuM8kFpSc
         TtChbS5M0b/Bhzp+u1Pem5+ugz5eO3v3Hp4AXGOBawIKjt380VGbwPoWH9xrH2u6EI40
         sfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8bSCuSKVP7ct/hSX/j5E/Yvqr5/ozCcz1SLrVvhOooI=;
        fh=eCN8pyoxHCkrSti+o/R2X54zQWXiTPcJUy5ZVhtBwZk=;
        b=VKZYoyABxHuDLyqH2xfd3vlnx95qvxlHWX3bhqvBC3+NNhRL5vzJHoA2lznQSuLg1o
         hUXXsalHhPiqn4Zzg0jp8/22HKgP/UsWFvYdi9HAG6Mf3aRf7r/+TuoG641onQbfGIyr
         coROHdkpeEw2ZN3JqMXjou9Mvih9Y/Fo3Kv+rBmYWHxqPVsgvt4MpHTcBfEJTAk/OAwb
         C7PDdWndrq1i+GDMVlUT1jffkSH3vqVHF4kWmgw9VW47JLpu6G/cd8yic9pdhKuY475N
         JxmoiSbv3yhWnvnzALRrgu8xCE0gbaMkqAGF0JlyByvdhBX6J5oeHCc7V3PyHpZmsWHB
         X91Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787897731; x=1788502531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8bSCuSKVP7ct/hSX/j5E/Yvqr5/ozCcz1SLrVvhOooI=;
        b=F6w6R75GHFcTT0O2xGWj+jHg4od4Y+q7exP7zbgi27PugNyK0eOd8RA/SuuIkqYD14
         8tzenDgzadAUyujO76iyaVubcAJOZwHYEl87r2SSpT+n0SdzcXa3vuVR1G+3yHD4hVT7
         G/We1125q9dt4AiHMM7SI5jJ2SbVwUDbMuTcdjaZq0URLRdye9ttKtAVYm3i7Igipvy+
         2njMmsbcqkLnAot4S0bXcxvfrRyIvTHGgoF+v0e/sPW6ObMkNwN1WFHJiQoshztBN45A
         6p5RTedYXL8jGruT11+9Mx4hXW8pwpDkVby9pi3hi086gO7nFxjKQiHkf7fa8ZKWO1rd
         ylVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787897731; x=1788502531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bSCuSKVP7ct/hSX/j5E/Yvqr5/ozCcz1SLrVvhOooI=;
        b=odX8j2Nxim5y67Ib7UB8Yk+8hiy56uHU6fBfSQ32EBU2c40h9EyEDcz0KVrIO2ve+l
         m7189h3AMseI9qHFEpgXInQLBJ26SMpVxTHJ0TEtdf17ogDT0fBI5YvGsqteCebp+d2R
         /GLNGmKr7WXROVD3T3txfvaL5uu/GFG7O8WNuvn7P4ReSEk8iSBUPfjRS9pSg5XOlvVW
         4PTTjv8qRtnQuTjiCRCLxXMsxTavBAIuYhuKgRrEFvS7P5WjcHuoCISMoYTafdbvIGCF
         QEbviEUUGF9vcPHA/6W+Em+2CFOtXYDZHbbtpkDwET19QPpXe0h2xfdE+FdgxfkzwdzJ
         yCWA==
X-Forwarded-Encrypted: i=1; AHgh+RqDNdvMCjNBQCdq4UaMiCdxjgCcUD05oemdx0j/uWDhbXciznNOn9UqG188ivCmvGr0ka/ABqiNCFzT9agcA2wjE0VNqMM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzejPx5bfnwVbHIZ+RpYCmlhyE/IaNGPFOZthyycPtcnjw+0LM
	Vw1E4atNWFK1+0AgrArovh48QSgiY+WSWa3Bz3Iq2S/WltKRgAJiXf24I/YjA2INZjiOaOQnk4z
	zqbhRDCdHVwxcB4gvspX3fdsawRfgCFI=
X-Gm-Gg: AR+sD11fzXC5ehas0YrIwhFpne57qrP6gtzqZ5ECYxSHUwisNB6O53fmRLSDTq/Ova2
	YSu2jg7H4kRtLOOQL4DkRyyIkpx5XDA4qe3nyR9rtcW7OOOmD1MKPS/RCFbueRpxkwpZpO7eWeb
	rMXz1rnk3aderlBrpIot7TVwmpS+epi1EaI5jpTuyGv3YWRnHc1dIie7cZ7cFlxiTG02lsy44kt
	JnFekdGQIvDcbhHEqnRu1KPu04WRmyOsNA7M29/XU0OS8Z4G8NjQKf6ZCqughlVA4AcCy/P70BW
	7oeSMNs8uFTDeUI3WPOF9iEWPe7eSF2XskX83CQWoHHQwSsL5+f9EeRbIBzm123EVvO2nRehnlt
	CYCOL3RzXUpgh0wZPCL7Q74qFqD/dxMFU+oU/10TrRex7jDB7wjo/xDsEgnKN
X-Received: by 2002:a17:903:1106:b0:2d6:f09a:da1f with SMTP id
 d9443c01a7336-2d74e0bab6emr40520405ad.4.1787897731122; Thu, 27 Aug 2026
 23:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me>
In-Reply-To: <20260828024335.946-1-nils.lehnen@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Aug 2026 08:15:16 +0200
X-Gm-Features: AcwNN1X9Qb8a-HibMc9LvFugng1gZNWxbI0emyln9fJfRyuIE5Vx-Vzi6R0arPM
Message-ID: <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Aug 28, 2026 at 4:44=E2=80=AFAM Nils Lehnen <nils.lehnen@proton.me>=
 wrote:
>
> Two equivalent one-off patches were posted earlier [3][4]; Miguel asked
> in [5] for a resend that keeps Benno's authorship, which this is.
> Cc'ing the LSM list per Paul's request on the original thread.

Looks good, thanks!

Nit: nowadays we typically use a:

  Link: https://patch.msgid.link/...

to refer to a patch that was picked from the mailing list (usually
written on top of your Signed-off-by) -- `b4` can do it for you
automatically.

But no need to resend just for that, of course (and Paul/I/we can/may
change it when it gets applied :)

Cheers,
Miguel
