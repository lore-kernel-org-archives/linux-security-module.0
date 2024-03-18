Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE254BFA
	for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781123; cv=none; b=IhbsF1pQlfEvdVck4VxpSd1AAdfIgJs9pkdL4B84QhceRWhmTG2ebgIGGQ0tcpTuvQWpI5DrEkZe8JSHnmhAMipjlRRGwSF28p9l9dpONBltIXTFlLvwd8on2qdhS6TXKnjLcF44W+6PxIY96VlC7osXOpXJ9WBW5drYy8fL1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781123; c=relaxed/simple;
	bh=KVqYRfusqPCTYdEZzjPc1bR2ty7+lTzXe5JjjqHrI4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE+dFeBKaGlaP/ElneNguAYyb2/xueoQUM7vFvugsP7VfV5GEIBRfqXKwavod1EccSOzr8R3A2KApcrwA+LVRWqy+XkQL7lPKbCXJFILETe0cDEI+tGTIvxGGZJ42rQwV1s1Kot0Ne1nhay8cMj0nMof7jnZmdUMzfjeT95fsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FPlz3qtg; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FPlz3qtg"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso4347246276.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710781121; x=1711385921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRF9WbloJjttrOETZuauc0iCWAwhtVP8lpBp7ZB7yCs=;
        b=FPlz3qtgZHyj7ZAY9QC58WfAxij0HIzj2uP6GMx7eLgZ33OAeEfS1rPl+yW/Avtt8t
         GqlEm/XtihfpInpUR0hdMTEjUVwxwPeJAU8VBFrIdXdpQsBPOKoTFesdeh0rkjWkYFpZ
         FLxbIkkfie66AHzBXHC4mBGJPYRrYaJ3HqgZdDyxSRVIf+tMjf2uYSseoq+BgRjMKWiL
         q31/HI8f48xa3bHlsd7J9+wMcmLLn+zvjw94INuCJc3f7BTcOpe5eLwKPoEeCS9mGzR8
         tdv3OuFI11bgS8wujTzO+cyq4Nf0z0kzIeBWbXumePIADdrnX3fg35XbIJMKzZssp8tb
         dXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781121; x=1711385921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRF9WbloJjttrOETZuauc0iCWAwhtVP8lpBp7ZB7yCs=;
        b=BBgfUjQazzdMblTAZPyO3C9WbE9W+D9g5h2d3x1LTvxUjpHfvF4IGOb59tUCM77GG3
         ENE7rT6SOBjCjftHnzF27ygXxyI1HB3uuoq8PTe7vhF6yYQJDvRaizfAeGcFQjfgDZci
         q7PSKf85x19Lp9eDR6QBkfG8wzxid98ExI90ZRV5/OrTMSUUbIM5pRvDoG33uetlanXi
         cJ9n2yQKO1xBA/uISoOnFmW1rqg1NFc7cp+rR9fUIF6FSpXYpuuTed2i3ZnQs9JGonec
         9uc87lhq+AidMFgetb0zEUHH9WxvZcDIik651RxrcQqh2iO9sOOIZKe33MD1Smqq/GYX
         aEtA==
X-Forwarded-Encrypted: i=1; AJvYcCWVWGs+VMCg9XoPZTVxIl3BkDF90TDdxT/tJ173Sb4YybVTU93IwHDug6WvYSuDXFzHyBHH0m5TWhHDax9rc5kH3WeXdPeI95WP3Jp/CW6fkGVXgO8E
X-Gm-Message-State: AOJu0Yzq/sIUDk/+ceCYC6uwhYq2Y6EW7oVD8sNoWL71JgamnK5Evt3Z
	4cNwv1+Nnyh1bshvEQQQSvTn+S4kk+lKd7pw/pPls8xrIMTzEI5ehjIRWYYo+DsmgB5xD89h6F1
	v//dTkNKVOrEV7Xe4BhZLSqaYycyjZe71gdvi/IHQVrub+t4unQ==
X-Google-Smtp-Source: AGHT+IEnAL/Zb/JwnbZyH47Rg8F2rj5zGqzwxlXdngvXp14rBnjWL5hfDc8PZThKE6P8qVhJE2nP9Ch+W/77OPui+8E=
X-Received: by 2002:a25:ad63:0:b0:dc6:b617:a28c with SMTP id
 l35-20020a25ad63000000b00dc6b617a28cmr10265118ybe.5.1710781121418; Mon, 18
 Mar 2024 09:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com> <ZfhxRZR9ejNt8mgN@google.com>
In-Reply-To: <ZfhxRZR9ejNt8mgN@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Mar 2024 12:58:30 -0400
Message-ID: <CAHC9VhRKV1ATqkCdFQeSQpDc4znuZhBf_=GWuJ=zB=n4_1yYxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Fix kernel panic caused by bpf lsm return value
To: Stanislav Fomichev <sdf@google.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Florent Revest <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 12:52=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> On 03/16, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > A bpf prog returning positive number attached to file_alloc_security ho=
ok
> > will make kernel panic.
>
> I'll leave it up to KP. I remember there was a similar patch series in
> the past, but I have no state on why it was not accepted..

I believe this is the patchset you are referring to:

https://lore.kernel.org/linux-security-module/20240207124918.3498756-1-kpsi=
ngh@kernel.org

It wasn't that the patchset was accepted or rejected, it is still in
the review queue as there are higher priority items being kicked
around in the LSM space at the moment.  It also wasn't a pure bug-fix
or feature patchset/patch, which muddied things a bit.

--=20
paul-moore.com
