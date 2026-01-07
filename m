Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245A1A2C04
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749129; cv=none; b=gKGuvK/hmnwJo2h+ABW8+HK+qYTi29lc5lAgvYn3D+dP4CL9m1xAcOiLoRyUuqiaOwSIg+VdqOEUw7GIhD73x2OVAWV1O2ucOTVq3GK8l7rtsPQ5WpaYXKjUcsfanO2jeFsDoqaO9Y0hHMj7cLfv3ph5GtL+TAsTOfbLR4bRk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749129; c=relaxed/simple;
	bh=Zx95EEstrW+K0evq+lvfYaLZ+4Ggu8HsiKPBLKnQBIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzfNFRt3iDn6xdBk1Unb9ZwzrrfxP1B/jedRQCZ1TkMaHvf6rLZ57UFpj/MZyHKDHTbdW4Ll0sw72Mk4ktcV/ZJH7a3VUMovbKE96EPcXnqlDnKHFkhrhmJRLAIzYwq8/2U3r8n37uujvkOG6tQ98fabBd558IYopSJooOvkiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TzuxxAv6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TzuxxAv6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso1253587a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 17:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767749127; x=1768353927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Hu28hfraDHp3dTfCwhoss9csXL/hEFjjAE3J1MRqA=;
        b=TzuxxAv6wQWxfIQekj3DKt2GOOcN+xmLw9nBeQZKQ7FOGK52mnzBnpCygyIVHZtqx6
         0k0Yb5qC1fnq34CydXa26dI2N5wq28s44czz26aGcz5Kz5zGvtVnUHoE6CNQ2jC5xW3p
         8qZuhdRY2OSwKw26KiyUJ6V3nuP6sy036xCnXEpB5Ue4Pvi9BHWbRlahsTH5d/UCc0Ir
         C64wtucitkzujxt8bHXy7+9HaPd3zWfWhXbtJDz+wyEVCM4fufjH9R3r023dZurNJKyS
         uVGSsf9k/6q6b0pwCptDlRUqtcLZQ0mAKJoIFGz4Z6oBWoaUh/Q84Cm6NXkYpO2MWltE
         v8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749127; x=1768353927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5Hu28hfraDHp3dTfCwhoss9csXL/hEFjjAE3J1MRqA=;
        b=OJyfoxCeZyGJBgJSELXXawSxBGKzSOzY+EVhfePcSrd70fF/G/llJ+WU/KdN+8KQ5o
         a5hDQ9quyE+jDK3C1mejV6410I6rYD9F6+EKjukn3v8zmr6nDKY4J24UFsol4Vw10DQy
         oR3+hex4CG6XkNOeq9K55si3h1VlPglq/zOZVWX9z9vyXStm1FsdF1eI8++ds3QQwrR5
         V9hJZEh+McphkBPsT4+iyXfNXpzKK0NmvEiw/pe1Grt4jfnqKYkwmU/vY5xdvD+WAWbb
         6qJRe7LZdZTitaXHilvEZexUPwT16MSvQBpF40vn5SPw98V+CGKUEsOwKqdCFFbM58Z2
         TpGg==
X-Forwarded-Encrypted: i=1; AJvYcCXIcV4z8Ee34Offl9WyUBXkfX22PIV6p7t9J8ZK6DDTKxjpZehcER0snsEwYCI+HEKoCj7dGlq2A/tp39M7tCdtheHET7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWfm0pvj2lc4XROggBi+T/KID7O+LB5hpQf23pt1dZq3ZvHW2
	6t7zUycFZoItk6ZqtwuSYYNRK6aVgXWDhScCO7SK1uphsuQbAgMORSbXNnlgeOJN852yCltz4Ac
	GsPKLkZAzK6HClxFLnfttHcr0HFxyxoDmVjgh0MaJ
X-Gm-Gg: AY/fxX4B8kShRGcJdznE0fyDdsgXwpEbCyvEmJzpxeQVUHpKcFN2Zh/ogUWTecYzzge
	4tsCytDsjGqZjHcx5wrWH5WNRCogcXdAWwV6MrSrKQ/xZbda02UD1tEHTMTKBRyYyGGFJXAmGS0
	BIhvYoCQebfNYH9F8A2fEwoDA6Mx4G29JM17GKcYMZP81r1TxWJl90Rtz62R+7CZCwBInwwBjaB
	DO6SDdWMtXrFUUXUNvx2gZsAm/UYa5xfv8D31cDokTxkY+AcnyWaGZxOGyMwmaFoB9wwuk=
X-Google-Smtp-Source: AGHT+IESY8RixXEfrF8833UfRSpT7APeC1lId+5K68apgrXSTtEwq35uEZwFa6nkS3e/+qIhJ9aUPsNP0dT4zdl+2JY=
X-Received: by 2002:a17:90a:ec8b:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-34f68c911c5mr906121a91.20.1767749127505; Tue, 06 Jan 2026
 17:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com> <20260105-define-rust-helper-v2-7-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-7-51da5f454a67@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Jan 2026 20:25:16 -0500
X-Gm-Features: AQt7F2pRm5vUDuNulUVhL5x2hSosg9LAixUgwiJKX9y7UPMX5r_6d7kny0l1pt4
Message-ID: <CAHC9VhQthnDRi3yXxnD8W_vAsxKOJPh8Zd1YxpF_fU5YGkj3SQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] rust: cred: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <sergeh@kernel.org>
> Cc: linux-security-module@vger.kernel.org
> ---
>  rust/helpers/cred.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
