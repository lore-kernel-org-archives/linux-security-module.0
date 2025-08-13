Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C828935D
	for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118940; cv=none; b=gpFP1LAbAMfm3f7RrrGszRb/nTD6g5gnrZb3K2/z4WnCNYChnzUwMwsoTR2DEk6tmhJ+6fUWB5HVwPJNVdEhRNILTlhzSOnVXe3xf+oJaBE98RUGGAuFITDwZOrFjsP3W1fg3d2Ab4Ep2VU0GHlx2bbut8mVdwuKPICIsPn7LNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118940; c=relaxed/simple;
	bh=7Sq4L0c2nWPTCDqZUHYRelBKQrlX/ySnaFOTeYR71P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHnWI4tvbQPzWj61b+H7DWMExfYgagGdokvHSgLolLJ+QkwvJ9hkNYvAdY3i4ONq9MqKgt8t5Zgia2eSr1Qm/VbwY+aLp4rTxpkL30i3uPgZR7hnq/KdAcu2jpzKzWhQ7JBOlGe2rvxsqGgdCGW92F+shCIy566Pq4wtG4yMzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZZ/d0ZJe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZZ/d0ZJe"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47175d02dcso199835a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755118938; x=1755723738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDYcmpvGq5GnRcKH/wXhuqWMX4zThVNazmLmfLUlg4U=;
        b=ZZ/d0ZJevw/kdMil5G3l8gW/OA1lrofeBfeE87R6bezEqe0NIidwwVsoNk3TooaZN9
         anBNfrFrwUdy8h2J50OQ4D/iZuz0e+FCmxkMWMl89q5iQE1x5NkeKPet/gfXER+8Maui
         E1LBUEo+JeYLc6ihBHt5L1s5u4T8VAS2W3IW7R+zKnE9d0McelIRdYmWZ/l0ytpY8cv/
         6SymFga1+H6UTmhswgJs1Qgy2M+tK4heo/TuhBv93bxFXRDAxaXvO7XZGbwFDGJNN0e4
         nDAwkHMDh7dU3vN3OmD/M3NAmgebrMQ2LiStOpAyk7hD6J5/vR5HP7SC/lQ9rk3+DJcd
         94Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755118938; x=1755723738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDYcmpvGq5GnRcKH/wXhuqWMX4zThVNazmLmfLUlg4U=;
        b=uZvDF6QXenadStJZeiPFPZJKoYH7+F3qeRP9POyTOrMKjuf2TE0WAqh2AO1+vsSype
         bVm6AIni6KwXfPFlR+/0Dq/mo8xCYKpgpki8UrLb/bon/TEaczNIV563RbTruwozFu5Q
         XzbhK4ZcPa708H0N+NQXu/62bKj79ezuUAhExpjyuXztnEYQlPoc6rfV6X7Ngo3SvWIZ
         0994UINCvq82z2Yz+vxt4IFTww0sKnQPghh5XFJm3IJhqOUejVKUbR6e74Z2cjQ6hLNg
         N4PCYyylK5asBtsVbCsd4c+JKZHsB4cs3dslk3DHwsourWa+CdIrUC7ToWGAd0+a5uQP
         DnAg==
X-Forwarded-Encrypted: i=1; AJvYcCVano6ihjFfQEOjP/CY9n7NDCWBRcAn+2uVDy4TUXCExFiItMlKULMD3Jgm/haoTKUhJPc+uzEmq+GGw1Cfau1E0rlPsfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxKwX9XYatUPLEmbovxMHaloUYXWXE1NrYcvuROSDzew3sOox
	UPEoibz3ufbkG9LcHjzPwsCYKGDFyvKPvpGVrH4ttKr66gfB+UGgPdQ+U/M+QPAydUaNxi4ELh3
	WXTwC/eL1RJOG2WTUmyEeqXGRiKmX3l3JSV0nKAbb
X-Gm-Gg: ASbGnctM8S4grud7iY8lq9eCbAT5MWyK7ZZTczRTnr/URM8q6u4SVIMV9dCpPzCFi9G
	xVw2sEnP1M739KQzMiclNE168pRaBrkiwA3VTidxkgYfv64M2mYCPYMYxpSEpTu+M7z5YDAsr+H
	ju0k/HyROPpVnJU76lf3PVEw43vJ80NNXUuM6144Lc+TbPXjJayvPTDzQjehivrE7lj7gcw/z3n
	80uvzw=
X-Google-Smtp-Source: AGHT+IGiYnCEJarZUMsQTkKeyOA6xYKcU8FKy/vval7IrvZnKFoHwiLj/QXM2eZhJhmHHcd5HZCnpE4B/A2FqlOY6O4=
X-Received: by 2002:a17:903:1590:b0:240:6406:c471 with SMTP id
 d9443c01a7336-244584d3ea0mr7225385ad.10.1755118937877; Wed, 13 Aug 2025
 14:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-9-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Aug 2025 17:02:05 -0400
X-Gm-Features: Ac12FXzp_hhYxPxfyJ_yhH3oL7S216L16ifPT_wlsUm91HMM7nJa8jJhGAwjElM
Message-ID: <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> This patch extends the BPF_PROG_LOAD command by adding three new fields
> to `union bpf_attr` in the user-space API:
>
>   - signature: A pointer to the signature blob.
>   - signature_size: The size of the signature blob.
>   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
>     the user or session keyring) containing the trusted public keys.
>
> When a BPF program is loaded with a signature, the kernel:
>
> 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> 2.  Verifies the supplied signature against the BPF program's
>     instruction buffer.
> 3.  If the signature is valid and was generated by a key in the trusted
>     keyring, the program load proceeds.
> 4.  If no signature is provided, the load proceeds as before, allowing
>     for backward compatibility. LSMs can chose to restrict unsigned
>     programs and implement a security policy.
> 5.  If signature verification fails for any reason,
>     the program is not loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  crypto/asymmetric_keys/pkcs7_verify.c |  1 +
>  include/linux/verification.h          |  1 +
>  include/uapi/linux/bpf.h              | 10 +++++++
>  kernel/bpf/helpers.c                  |  2 +-
>  kernel/bpf/syscall.c                  | 42 ++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h        | 10 +++++++
>  tools/lib/bpf/bpf.c                   |  2 +-
>  7 files changed, 65 insertions(+), 3 deletions(-)

It's nice to see a v3 revision, but it would be good to see some
comments on Blaise's reply to your v2 revision.  From what I can see
it should enable the different use cases and requirements that have
been posted.

https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.com

--=20
paul-moore.com
