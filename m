Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A24AF681
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442163; cv=pass; b=FBy0lmo7HKowVtdlECGK2tkSz4n5jK3YNC57ogX4oVe/lJfYLWiMaZquNfvBQxuF5shvryF0OKy6qwg5ONCTTKrVQuGxZrZKccp3u778P+mlNFIiHkLgJ9R1cJWcV9aZGksgb2Y0QgIQQMbfPuXeAsaMv2bHCVW7BgB8CuHpIEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442163; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VysLf7MuWkcPBnryTd2iRC0vNn5Ft5Y0gUPdD+pRk2sLoLQPziFxjYHV+sotc/OTZreeVE7lME3obYdecZ7RCtyGdmT6lz+385qhnp6rAKSdsDdDSdBH2H/9xhsC5QaG+cNs879EwJ5b4lYQD8nV3AsooGwNmDbDbMxYm8F1q6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d70066b704so3531735ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 06:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=Jhtih1bZsIrmjYrDluCR4RsghdiZ+nqpPvsxWWPNypBXLEBqR+afBi5TAaK1vo7wMF
         zxPlRrHIb/+5ShWmT51jWNZMMSt4lGAlfNxHomXvdgkAWlQgVmbIvTE17x6/eZqiTHeB
         ZTKkzxOw2fK3zU8qlo8fe+Zbs44VK56DDz2jOxc/1x0BNx7V09Th9crE8T0NGtOgeoSB
         oG8WIxhjtq94TcfLONsdvgWPb7a9261yhD+P5TpluYzvgpdkwc3QbmRiSvzBL6UYGcRj
         wUnUDuTmUDRZ8HIq8ZVCox6d6lzIP6T+7m6MYGaAiSOvo/S5jYeaVJQGUOC5VmYRwGMD
         aSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=47iAmsTbDNpySy5FwRa6oBjkDXAJSOlKlYMa0OPfhpA=;
        b=L+/4wr0i4lgRpDpaTEA1Gp9JrhaFRV3o56ep3VkMQR245g0T5rXX67cmxvIC3dUvJk
         hh9V0z6mJLotqUJKk6Wsx/ShubouA/gHHtP+v1AjTrSvt111hGGAYXYavADDZTnvKYMy
         8U282Ns4jA/KfhkrGxyNXdhZR1XZq4VBoSbSVtt06ODi6Bxd7BlYTzPZvgcwPObCmwHn
         AEPxzNpbkh5tzvVDW0Sf3Yj0HK7rDdsHm+O+aS5QGUHwnsjpMvwoJoBgj9OiaQ0GzIkp
         Hbyv0nIbFvhD1+6JQlr88xWxy7T6XpwYZSpkOzRQDIZVjqgJk/eZXqv69Jvzpp6LV2T2
         wkig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=c6eG3JphwQO1pkqO1wh4jSG/8g9ll//Dn0ESmyVY2ZWt7zIm3A1id3t0SPBmnI0HQt
         KXnMjN8gYkmttvVlLg8s2P6cjYcnTWbRse0dGyFLulVxP1eEawfnizVbBhIAoZ8B4O4z
         hHfziEuF04mP5COS26quy+iSvFxJr5l98bNwRahi3BaqVZCjhQ6k2ypSHI5aEGK9fp6d
         qhl9zIEdhEvR/jq3jS9avp7KdnK46U+VpcCULGRa7L95qegkGWOkIk6vb37l+MhSiloj
         h+xSL3Pjam4rsB6GCH2TItAz2cq0gMe+RGXYESKJPhuEUJOSfdb4PWmdEpCehBOQIl39
         bhHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPjxhQ9KcXSVM2iB4dfeMpqxq2pYrCW5SIAoS0yclzxTOssQXjokoY0lt34QDp21smEHFiNKLBICEV79+YqfpxAGpFsO8=@vger.kernel.org
X-Gm-Message-State: AFuF++la8kJCJXdZDXLSX+ipqjYF4C3hFXSfhwkUhEpyBHwMZlfWinrS
	hcO5FhCCt1OHSMVKusC6S/gsiGEoXzCXNdYo5m1Bf2/xh6BkVtvTD5X3I/dDoLdMHlCnBjjcvqY
	mJPksCRm8oj30wC8Jjy7YfiarcKiGEao=
X-Gm-Gg: AYBFou03xmlxvs4YHxSIfqx/WYEtq9guLfOxyw/D4b0IFyo5pBIh5QAMQBI+Myf0D5d
	tv7TbGloB09kXPxq1nKKPKyJNvMeQbLZ7K5/Hqck6Dxqq39RZtO5gkrxJxI6SCdnmAtMQwqB6oG
	ZnIoWCYmjhQQ6OE/Cu/9az+jk3capwRgrQ3Z7aL9hPl86P5x6Q9gULxBdPfSUMzqJ0n6OePSfBU
	gmQG61vIuKEn6AdRnCmrypf2tXi3fQbeWk2IlYOiJDK/iO5tHOiQKapV2iBdzkq7GejytHE8Hz4
	kRqbns75fvO2LAXbZAYgigXf+LNnPJCCpZypXk/3vqaCnMPfTJfMOA0/oq4yd/M0WFmooGHULOs
	eRoeahbwInAUKTavk3gqZO4X2QhJ1DoHodfErFba5XKmhAk0H26hVTAZyCfmE
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
