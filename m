Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB3265CC2
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353118; cv=pass; b=Pyi+xuWwxML43EPeHpvCGjzMGf4vrXjLmDk6LWRN6sQ/2F1NkgEM42a2CiOZtccxO503RxwLEg62KSpxpc5vMwN2udkSqmPKEp/oppBNFd2MCc8fK2epgPl/YRj5RuOzIVJHSHRfuk3ab5T9ei9URUwbvA+dGeq7mxnHt1LaOAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353118; c=relaxed/simple;
	bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0mDhZFpC0hslrnlTptK3FQbdbBGP6ih1LZuYNpByQUNWuDp8eUOe4+Y9KqUwceA/YfxFCDxQ6AlwRDdKzoj+juk0sBUHtKp6GrAgohz8lqKd3H0unV9qlSp6o0LzgH5/TVsdR5E0eTMuwF/qzoVdPU5cYIEiSy3g1BypiEAsuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR7RHqfO; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR7RHqfO"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso13117455ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 19:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789353117; cv=none;
        d=google.com; s=arc-20260327;
        b=Myd2jBDtWzGVQgu/uv9yDb49Ww6kVJK4Um84EYcH8QuWC79H5UOGmD++iUI5y3jEc9
         oEYXwuHxtBaLHqXWgdvXYiBgYxbwDDLWX9RprxoWjkMNL/2M4fQfU22UT30f3+/68UWg
         8wOb+X7Z69cwTBRATqkfqyyBxS88zQLX2Xms09pTPBZEHxJqMyk0vyYUHhM+e/pLIafB
         hAD7ZxjgIAIRUjjKxh5L2F5Ic9iVoJs/rV4FAaowxsJeYHKk13B4UHN3GAHIMPZaprBK
         XD5/Gh5Gy/TRVblGylFjyxUtFDYk3nQxLWl1HSeYn97J1FBRq+uWy1A5bsd3X4tgS24R
         ZD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        fh=Llhbowidepyvbz+bR/k0DdCkBUmNIklyNyKqUyt/Jvw=;
        b=RkdL9lYRiM/lXLSJ9VBqZfYe9jWXJ0EfO21PzPXE5GVRWVkpsa3JcaJz1EpQEKysBz
         lhnOajFIsjbMZC+pivj246+zU9IAQuTAV6uevq6e/G3j9zbxhK7pM8fLkHV6x+YkigYs
         8tiv7nVws0GCHKVlEamMybjmfYuL9gqFtkip62aGdQ0GBFNY/9em5hGbXbNIG8rqMFDS
         tAONXlBe5XdY+41OTugUsO2oYIkwRnGucW3X3epOw9wFQTTpTba8P7NCbR3BtiZR4Y5W
         +LQjH9gE3Ljg5HtKQjKenuo3pyHp6mHzonqjcOBjqMzgFfu+VKyoHcqo40O6SxbM58kw
         Griw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789353117; x=1789957917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        b=eR7RHqfOWHsBRsjzCCOY/b1NL2mC8XZ5If2LevX+KTQVQuIs68/9VWnmBQ8UIhmt1a
         gbJ30ZQxJsc9mQTqeIVowRxS+LhbSMkLWRWpIq5Ylq5/6b3yxdBX5fRm3wG5N/bNtVj0
         DQHIpnJUXG5YGh4Vy0xKONcf924sC99VK3R+ChgRhExrD+ETlxJmHWG2Hnm21fnD8FCa
         tLYm12i6cPc20VQaqSkfIMDBZcpCGx9o2ch4br/p+5kc3fvU+CjhAtvZAxKvtqBqJ8e6
         AOAY88rQGUSvzFn/bNpkro768xa2F6M6GTXzRslAontz9DMazVMzYceEQXFYZv8zyjI/
         /H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789353117; x=1789957917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        b=aRsqpYRnAM5HNQ9rJ/iWcsdyrS/NvgCBMojI7kyn8H4HoP5IuF0VcHNwoezgcCD0Dg
         6eaXvJw5/d49bfBllD5Wyi9jY7CNCeLT0/5hyH74B82c/HnMSiNdXUvCcseCuWiXTSvT
         gieUO2yfj0SH5IO637IqXn+h5/XHPTbMnA6n7CTmA/eF/zfQSFoz906TpFfV7GuHxt01
         mUCqwc//Ru5Q28I9EBJPMQGiMEvWoFc6FHMXygOLN80VQnnMwMRG50OiZQdlQMfkboGV
         23BuMfobxXdpPhtKPDEdOc9m/i9zioptMbXWKBaiIarP18lVphPMyETURq5Z91ZlQwep
         oosw==
X-Forwarded-Encrypted: i=1; AKwUvBwWTuyP4S1LrPbCJs3qeuqERyeFzFKJm4Kc+YYkApEpbyXRgeYywzfFMvokfXISzRy8hU6BgHzUQ5C6PgCuWc/7+hT/gjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++miWoCK/OMl/3XIEIYMQ2TDiCfY4PTr8zu9tcD29pKu/QVGepxI
	AkFEV8p7nheFLDicMckn37tMFfEQ7ie6J1FRZppTPIlHhAq6wE/s87lj5iHeHy1BTocZ912B9gb
	Sev6MdfCWEIP/QuhpqQUngEbT91yjvYU=
X-Gm-Gg: AYBFou2ljWb5y6S+cWD3jB+DlTcFSvlUMYBBowuJAIlt9FmGrKvwGpJpNux+oeMY11Z
	qC0G7pIZtl/Um0l4EuVehtXHqIPZYB9Qe/Poxxs1ukg2OunM0becQk4hYQJsYsDYYKCzgX6eIxj
	Ap90StaCToMypDI2rbdYr0mRu1QGGHph+m+d3idvDPVSoPNXxDv+h8IHOBgFKdzrizxxttlDqE3
	3+BxjDL4aIxBImunzmhpITdEA1FpQUamFX8+XobMHugQxi3jFsb+Gv4EofhfOquGlYs3acOEkZ2
	de/UzF2dD20PS77WPaPjtTtOLnC4MC0m08xcwKf7UxYj4KgkLUnJVBxPfDec6GYMowPZ3LCs5VM
	DXJYd5tmzF1ZWxllhJkZoZjtnVRADDLn7s/ibhvQ=
X-Received: by 2002:a17:90b:2c88:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39dec0f990amr1390428a91.25.1789353116570; Sun, 13 Sep 2026
 19:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <aqcb2eXw61LaFaqY@zenbox>
In-Reply-To: <aqcb2eXw61LaFaqY@zenbox>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 19:31:44 -0700
X-Gm-Features: AcwNN1WXBVEf_wzXbmqsfgloUj3Usk1t2ym6vBQneSX3XwH8eIEOpV46HQIyMkg
Message-ID: <CAADnVQ+v9_a8Q_YOvS9fmXG+-Ga0ADKrjGDDUCiFaipo2vUDmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 5:20=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Sure, in some perfect world in the future where every verifier
> challenge is solved and BPF has feature parity with in-tree c on
> a 1:1 basis, you could implement something like SELinux, or Landlock
> in pure eBPF.

Try.. give it a shot? What is missing in the verifier?

> Why force every eBPF program that needs to make security
> decisions to reeinvent the wheel?

What specific reinvention are you talking about?

> BPF already calls into LSM through security hooks. This is no
> different than bpf_map_create hooks.

what? It doesn't. bpf progs avoid lsm hooks as a plague.
Not a single kfuncs calls into lsm directly.
It may call into security_*() by accident because
it calls some kernel mechanisms.

> Nothing about the way BPF works changes with this patchset.
> There's no verifier internal changes.

If the verifier is in the way of what you want to accomplish
then please improve it.
