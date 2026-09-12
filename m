Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C3379ED2
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241598; cv=none; b=k1bAp4XAU0edPzNiZPQvpoHbrqjKvprSzch8gyIE2eL77JtcyuRvXX9/LEoUhiShWu3mmMQ1XrSc5gq2pX7kXcOH5LVs5CyB7SnFhhNO2L/NE5kxoQlhnz9KGw7mR428BUjmdYD5kD/UZD3KrGpW2bZV9EtdQKtLcjN3ORto41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241598; c=relaxed/simple;
	bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J8gOBu4eD7gF8zIX6FEQBKj5QlfyXB/ML4QyOPGr3K45OVESZ7iwTkLo15QkTLK5qn0bxLki/0bB/fMc/v4KYkcDebNypbf7bJq1JiUorJbB2m2Ml6eRUCZ07TtATe2ghbPhFa8nRJm8NmtzEo94AIgPTPafaS1Ip7T6GGjZ+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDeOobMQ; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDeOobMQ"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6b200fso540055eaf.1
        for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789241595; x=1789846395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
        b=tDeOobMQ1tXo2VcXdtudpww7ZK+qjwx16fcnShR18zkMtmhhAQ9WOqc4ZeOCIqMuMn
         xOrhiqJlGLOseu9ssptphrWyhTG0UeR0/5/2pf2ZvqFt6f6/Y+l6Q1wyYyKxA/CkRAKJ
         sj7VGRJ4S8jpvPeGHYO5UUQyfzmBTXt8DBacXZoyuNVZtcQySYKr+lwBI+wugKrLwdug
         2uclifhnLFD+ZSt0lYlNOHf4d0YKxtq0XF50clMdqAGrEH3ntqpzlPIIyXKvRVOYOvST
         ixqMGSWURQ9hObiZ4P/Ir6RPlUDXZcKY6hcC0YUJP747MQam6fROTvrxkmhHSHhq87Vr
         xEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789241595; x=1789846395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
        b=mfsj6YvHY2uJABsZYV5GVX89aDiWDCCVNXdsN1nj5C6Kbuc11BwijggZ4y/3qGW8aR
         ITEWDQod3mvSebhB5zJGie0b2VL3y/YHelNgFTN6M+mR6bZGLZp0aEf7s6Y2wJtq9yrJ
         4+73WP2gF3RJ//ZQQMylk9be2jPLdNYWEGa/OXUCCOLDHkOxvjdLhLkEX7GOr5s3xqew
         Fmsj9Mzm33elN9edynk9BEKDFWQHhU9iINnKmPCIV71eJ1yacpuW3wK7VwjdJalQQVCR
         az2MZi2DuV3YqOaKHiH1sieAgZ6Drbquw17rV/MaA8lRjq3ztlXegLQYGIMgmkFau9A4
         59jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhbyGZ5OSNawoPUUxgzINFmBc3AD2js0Tm/rSyEjpKoN1zMdiDyfua1ysxLcjbWWaYmV17S/HxeEbOjt/n2QbkVuc/Krk=@vger.kernel.org
X-Gm-Message-State: AFuF++kRocS67hAvIBkmfbEv2xusPGniEdJQjIVV4AJJczRKgyzMU2qg
	bdDHWdAFcbfyKuLWrZsLgLWH1c37ESHdLP6p/0xBbrD8r7Ow+9lWnAu+
X-Gm-Gg: AYBFou2toGqqZMyoWIRP3ubX/RP7OQcDuj9it4uRelvTot2Jx3N5JWYhbbo4fG5cvHz
	kGV/D3KG9OCLPPXz+TnAJ7h+vIU9HR/a3DNXiJQwFhiitvHC4skVe8so6IS9DhPW027ee0d3mlT
	yhNHTlZvuoKfNLozbiMk4jzayN4ECfiyWo3x72qxJwqDF08tENyTVqRpRdUTqZOT7RR4HlGGtwn
	uSso5NAHM9sXxYdk5BOslhPSZZpukaOCXw78le0shxhaCZxQRcZQ93xl4CqUaBOFk/Zvo0vtNM5
	1K/BJFMIJmyXDhkBRq9Ols0de/cmyHHvqnD27pIxd9kOkqbADrDJHsja6f2EZuF/VLiBD7G0BtD
	j7TmS4CIzn69SuLAudQdYNJptGJjpa87s1f1oKBn9FJz8WIuye+u1x/8YNd7QoEMB5/CKpyBFW0
	fInHVgoaHFCSzt6dB3NyRBfANRKb/SlLm+F/8Khmm66+6BPYcElgJI0i9kM5kxhC/KhrXxE9E0u
	Fr6xJGFTSuOOl6OK8VSBJ8xOCuG/Fg73Uggmdiedu/gj7JS1wv7V5Ce4bUJ2y4iJg==
X-Received: by 2002:a05:6820:5706:20b0:6b1:aa44:fc16 with SMTP id 006d021491bc7-6c0b9b54c2cmr4593859eaf.12.1789241595403;
        Sat, 12 Sep 2026 12:33:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09690af1dsm5938278eaf.1.2026.09.12.12.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 12:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 12:33:13 -0700
Message-Id: <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
Cc: "Paul Moore" <paul@paul-moore.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <mic@digikod.net>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <kees@kernel.org>, <casey@schaufler-ca.com>,
 <gnoack@google.com>, <jack@suse.cz>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <jolsa@kernel.org>, <m@maowtm.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
In-Reply-To: <aqTZdCz6JaoK16Fp@zenbox>

On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
>
> If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> security/? kfuncs.rst doesn't seem to forbid this.

because fs, mm, net see the value in bpf. bpf helps these subsytems
to focus on their core technologies and moves policy decisions out of
kernel and into bpf.
while lsm people treat bpf as arch-enemy.
kfuncs are not stable. we keep refactoring them.
while lsm folks treat anything within *lsm* and *security* as stable apis.
So any kfunc where they have a say, will become a huge burden for further
bpf development.

> Where would you point me to?

landlock was designed for unprivileged users. bpf needs CAP_BPF.
There is a fundamental disconnect. If you can tolerate CAP_BPF then
just use bpf-lsm and implement whatever policy you need there.
If bpf-lsm is missing a feature we can fix that.

selinux/landlock shouldn't be calling into bpf
and bpf shouldn't be calling into selinux/landlock internals.

