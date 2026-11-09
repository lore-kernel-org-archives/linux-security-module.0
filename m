Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255250;
	b=qnX2QDvq2PT8vsCe6TkK8RRCvxg0U4owiRGxYofD/j1ARsNKOwxyBWVIKyvKp1CJAaar
	 3fudScha/FMyezBOK0p8JCPnc2Zpc7rKJyh7o8qL74XZIVKIISmsvWnfOqCy6I0Kl0NOv
	 Qs0kCAFZ5VIn+dCOMYbGqOMuyNfxf0inzItJ4Lc2RMR5wwTpE6LWfSUP95Jtq8H+rpQHz
	 Bib76DRd1MFqD59Kojul40Ab8DxXqyYAUEVJ0jkNeQxn2azZ7e0KC+hwopUorwdg4puIm
	 5XO+8k+BzWtk1QvNyxqp0hVD2Vk653oW9mZHNe2gdUtsm0+ZrsLzvN/u1Po9JyLPRGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
	b=k0IMzUSk0rSamU2mHnsccrdGDXgYwtcvz3wTH/+6IIpVETb/WHTp0TPsvaeeVbkITksv
	 NgAXEdkHh5y1jgi4S2WD6a/qIwBKEd412uR9zwrHPlJRAGfU3slYWW+wXix0rONAsRwtJ
	 C7pwXeaXdKzIZ1nzIviBGwAiydvkyFscMsN5bXBoTlnTDEJB97oUVWTD95ie9gXDMHDqQ
	 zpN+20SGK/rtA4xd/WdGrsFx3hgOKqc69mVAIhVfVsJUKo1Y0hD98pr8IKFuNeMEITs62
	 jtpmNx9ojrF3/h+b7iDg3/1HxF1lFQMLohfUjWhxkvePtaQZdrw4yizZLN2mNnq0K6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C358606A339
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 20:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C358606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso659046a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 12:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255249; cv=none;
        d=google.com; s=arc-20260327;
        b=oy3Nav1dsWcDDzWTC/nK7dLYI4tK7bwmn0ilEYyKDpVh2UmgspDqUd/ObBu5TylUvX
         Z4aDMYUbVVoakC7kbMEFNV48QlkYSagc/hPKENBGB3I51Qn4oveVfnUbIBk5QIYuZtVE
         d2sz3w7/6/IUoU//h89vl9M156oJjcLHoFtYl/LomJHgj0XiscvVobwXXlLJVAmGsOYb
         Lmw40ASdMbg89/Hto8AOGlFBGvduNgvbPn0ixgF9Ak1zejw0A7ov/+ZB9Q/FvmgIBPDQ
         YA7bkJGpJB9lnp6kmj1oDSuFQ33znRjcsacG5M6IR8FGMR0NDRgTwwZIM6USQE0jeprD
         tJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        fh=pGh/1PDA5oyAhKfCC2sKjEvOvFUxaX2l3Q+w8ouACSw=;
        b=ESlyns5fkGFu9m0GBELH6p6NLvrH26QFRjVm/PCzWR5LcHLwOQV24gLWITOzK7KRLc
         ATWXMPlFvNIX6ejfCxbFtDhdwPDYl3yIzmBqmZ/q5GskNBCIr1nkPmsitXnHm/sUPAQ4
         IoWfA31ib4yeo07aJ7vXvZFHj1czTkxvUy+xyW9i8bk47fXqkhkQn2LdrKHyvpFgeuJ+
         kcbjWH9FwsAT3Rw35Z7Wz/21iPCtlrEKO+G4ef41/lT3MSkVAIoWknJc4l10TWtKza3R
         iLdERetzwz/kiG9njinRSGs5x8LOLWq7O05EQ+w7AkXctxlgoKE/txTb7R3uxl/QsKRY
         S5DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255249; x=1794860049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=bPMMvzllU0yTQQX3RK6h5UbI6bmYfHGmNNP5VaRJ5GDzkjEjLchbGFjBkHWEHWVEK2
         UVDCQ/Oq+cuY5K28yKE33O/gdrHWK2TsOlIpihV1+nrZJAk6wpYBe72IS4kJq9D9D7S/
         C+ATpmS4If8e9tGs/YMSBnDvsJXO5L48Wfr0GIxatVJTgOHI1eAkPn5yJpjzpyWSBJzH
         EE2xD9Du9nOx8VLIHcCMDu84GpRqn9QthLL6xH79XsJhVZoG7KLfwySEMsHLt4TvjAaa
         B7CkeP8mxW9zMB9eeQzgd+Hh+Tq11ml6UIUa7rXVebk4yGV1EII2xqGWl+Y5bJhJyz+N
         8V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255249; x=1794860049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=qyKMc5JUK0vYVaMWVMFbOu9ajdaDhWw1naMrF/BRfDdyOZcUKqXANTjas/yTEyyXNX
         QHULXDWNokefuE3NVpNh6XJg6KrtGUVMRlGayjAwyf/1N+kRQOEw3zsoOXNKtSKtTq+8
         JIKMC+EK/ex7JE5dJZzHRKST/ZBwdFzAh93Fj7wX0HLugCgD8KltLvmQFfcu3+xSSmRy
         ZlYUoW92p1T+bi/P44DED9YIhEhyOSOMKTIYX2xD6MBzqY0wHBL/rvDt+I6DI6BAhg2/
         m/JbFZY49exwwPGX+l6HyVkhyV+Kdx0/OCgoXCgpCgjismZah/a7HWaX+USa579MgdTC
         tOIw==
X-Forwarded-Encrypted: i=1; AL+hErHYwQv//yG1vmAWtVVaNs6XnVYxlzYMphbFOfFyilMpVVKjMh9Gcoa1gvQSdEsfk+TSAFmc0REkWSSdlS87K2QaP4Tiv6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a4GPrUDUPMQZ5/s6+6qgct1LU+EJWhQq/ZmdUtamszK2W0eiN
	CZmGgJZNluw8fftuJmgWDzw+o7QktJKQLWg5YmhxomJBJuo6oOBvL+Itho7sPRCL9dIS/lPimya
	LZGt1oZzrtsfjYBJhQ03ZymMU5Q0yqPr4++9h5Mf3
X-Gm-Gg: AYBFou2hyyFgcmFc+sTXfEh73rvfeE9gPIlkB1yxRkLRuvVhPMo3IO3y9aZdvzMwgje
	74rsEvaCqlthb+mPyISk4wCfXt4YGwzx9qTPIJ5pm/OP43lCA231W4yukUnY0gJZrdFkWUlPNVd
	HMEZHTpD7hBghMEfdK53oQ5mInuU+7TnDHcWkQe4LI6R2Tkw2l0plL3/dL1XQMrLvvs0gQ0J8gF
	S4G9FQy0YkFEVJPiex99NZPHCq8aC24WoSqJiwHx//0N+FDi9kI4X1gd6ZL02FefESYgNUBFA0b
	2YiMPl9QnpbXyi0yS1+dcjGoaDnjSPdL88necMXskQAOuttndchmEwa0FsygNdLngVMqtYfAbtU
	0cUEoUy9tpau+5U7bNhzt31S8Bq8Vt/sMx3j6SwqKa3SNlBd0MVrdBxMby3FiQI6+ic5a
X-Received: by 2002:a17:90b:4c49:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3b166d1dfe4mr716868a91.49.1794255249343; Mon, 09 Nov 2026
 12:14:09 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:13:57 -0500
X-Gm-Features: AclHuK_EGvlYUSv_8gjZT2YZHLuHJRnj0DOmSE59Zf5Dm3hlbe4f7hFETs2MdEE
Message-ID: <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must alway=
s
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I've sent a separate mail with a reproducer to Paul Moore.
> ---
>  include/net/cipso_ipv4.h     | 11 ++++++-----
>  include/net/netlabel.h       | 11 ++++++-----
>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>  security/selinux/netlabel.c  |  5 +++--
>  security/smack/smack_lsm.c   | 14 +++++++++-----
>  6 files changed, 47 insertions(+), 34 deletions(-)

Thanks Jann, this looks good to me.  In a perfect world it would be
nice to get Casey's ACK on the Smack changes, but since they are very
minor and basically just pass the return code through I think it's
okay to merge this in another day or so if we don't hear from him.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
