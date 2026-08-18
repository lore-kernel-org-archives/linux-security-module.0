Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDC35CB6B
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084192; cv=pass; b=kUvdDNBNxD2NKMsLGy8WwQ0JNtuDELXznJirO4LC2aLAuKRXLl+1lsMoQv3kkdjSnOx07+LQVWIRF+8uB3AE2s1p2X7d+dcW3Uu+qOCt7+VgBdDwMCjBIORlgMibzqRzjwnJuYGm6PHtRUVyeM+S4FA8KDyiulManjsoX3cUVPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084192; c=relaxed/simple;
	bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1p1htC+KqZNgS+FXxCZD1d6aun+o0+y1VpgIN0qXlw5x3kJbwL5FJZpUZefcRVRlN8GHn260hvl7EWZwr0htmEO8G7/BOEKK/FTBRQg1JbQQaW2YDcv918d4SMB0s2uWaahKpXTDfXoM6SugpXW7lV9p745u/nB3I+gOxdQXVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJo3C8G7; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJo3C8G7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e54f8c051so20765685a.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 13:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787084189; cv=none;
        d=google.com; s=arc-20260327;
        b=goRnpv/B1rqlDpPHvA4tHc6Y+nFVgKLgm7fG3qDcf4pkabUT1P8CZfK2yEZ2+Ztuti
         g/ZPMq8TYcFyIbu6mAJflJupMjKATy3dZIkYrJxrUexRSpp8JrtmufmALIRhZS0T+pJg
         l8P46F4uwv2KLUB7QEZEg9oM+Gff218NjhfiamtUce7pfG8i2aPubgLLz0tVQ2+/zK9A
         GpHmM1XKoWZH380ric6uxXkEgvZThEgvPkVk265D6yJSxxJgSOsP2L+hgX4GlhJjoacq
         EklzxMdFRjvI4NucGCIaWOyouFNWDcxf4snIbgM5UZimkWA9m8FzZeF77sTmvjkV71/o
         eTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        fh=z/SRuX0xZzokRS/1QnKg+YPeSYv5GV9HwbAudZcjNTQ=;
        b=RCw/7Re0u/bfGcFHI8IXKGgpQdIOXLKxME8UUl3/wft3eBVTN49qGOY/xKQrujsHHT
         nLRwHP2MJh9IQxRuKxnkWcd59b6L5lFCGfDX177N1sqFt65DEUcQ2+oZuXLRqWZ704Sx
         u1byNLkGc8kcY5243nq4RGNS4JD943HOCo0LMUBWzc1cHJZ3IhLqpg6sUHl+Bd9/ITe8
         P7tnCGU2xz8JGE2Zz7bV9FyFfN8Uivtru1/UYluGe5+/EtZ6axDDXDm/ZLmkWfsrBelz
         zqCpZJ69qflBfto0OR62e4SNW9yvGqdNPHpk7R9hjgRSgUBAJstGFQg5D+9GJnpWrNrs
         gokA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787084189; x=1787688989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        b=QJo3C8G7+3Ax9M4jvi7dQqv8/P5t4tF97m88qWzhD0vTpInsOaI8CywoCZfJXDoj/i
         B40DpFKyeO6IMjbMAt8UkaGc2FjtMj5Re5NO+ceiXnb9QeZ6V+FbHQHJYspEZUH6W2HK
         1lyIb6wKe62zN+4YPUVGg9JABkxAyAkoDee737vSCpieMwnLHwoZ7VMsiBjcKWprmePp
         SlnITAsMs/dZdvLkI4nfPVKPN/k0L86nTc4eQA2kGY2khc/to/gKD7Y83KorTPuVLDB0
         y4mEmpx2js5QBQtUvK1Xz4ZO0v8x/T+Hs06eWrMD84J+qx9ZP9AmJAV4OggBcKb4lBjO
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084189; x=1787688989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        b=gIHzn3g6U63FlCZSlcGMfVVBU5EuKGrrgcQx4y4JUGv5VpWkKZmhl0gO7/ru+gTjWU
         TYaPvqWPmBx9O//kE21oJw+8GkivRdcWgF7C06m2iNR4wUCcBlajTKn8gLEylU5jzNVW
         T5FqG0mBM8VU1qXs9Z0nIVdiFrhUm3V4qnadNhyMKEIkqDCEbL3EcVAa6jphdNk34JGh
         gODFqulYeDqn+W/EJRUXSqontSRfNXXSsK91Y39f+G9VzIEkcqKsjTTJx271u2XRiYhj
         0WdtmgqI7r0qlompapA28URMI6h/wb0WfJwGv7CjwPRvv50FAGESF7JasIaiaf387l3F
         ZmnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5KCwJvM5WCht5RMXDlRcdhk406pUz6I+Rr+YmFDsJbQf3QJOCtq2u8bGpZE+SCXKNpFAWrDLhPUNNkAtHwX0CFBwz5DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlA32z2A1NPGbd3d/97JdtoRLIl5GdjVkHX/xGaNo06DflWnb
	vBT4sKpRu7iG6/XZHbs4Eg7LRv5lZXYIslQbG641HSBMm4ZqyT4VQgshCfPEylW7S/XNOL8Aqza
	dxG3OocKBzWD7IJdkten0UVmiw4Ix5kM=
X-Gm-Gg: AR+sD13pTEVIIUYaVZvlMekE447b1rxoy7eqWj0hhxhiu68vM2rfBBQFlvDDa0FWmK6
	8K/TtXwJ6JmIpb0dlIL6PKAKFdTpPg2ejAmoKx4ikKWJeghqxlBGShUqdFRd/U1g0U5EzN8hrMW
	AVbqH4TJzXG9Zc1NXu83yztEqA2B3fxfFsRl8+FN3Ll8SzIT/N3w5U+nL5Ecb68fJcqRnaO0A7h
	ZU/Ylbu18al5+DT42aRTRny1JcJqrbTea60fKjjfp/aunA5c/ejRsCEfXw2HNk1Vg0X9sN3Kmrl
	F690D3nC5F4yGylUA6vbyO9xSyh8m0Z3Cpx+ldduwBKGJclByURpgl70x/Dbd41vg4qD1FSMF24
	=
X-Received: by 2002:a05:620a:890f:b0:936:883d:89c6 with SMTP id
 af79cd13be357-9371df950a2mr12671385a.28.1787084189450; Tue, 18 Aug 2026
 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
In-Reply-To: <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 16:16:17 -0400
X-Gm-Features: AcwNN1XmyoBwjLZW5dDGiUk6T0a33HIdvZ8D12DpgCUEXpkFqvB5_cWXzPjArcc
Message-ID: <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > >
> > > Lastly, given the difficulties we've faced from the LSM maintainers, =
I'm not
> > > inclined to waste more time in explaining again why this cannot go un=
der
> > > security/.
> > >
> >
> > I'm still going to send v7 of bpf_init_inode_xattr series, even though
> > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > inclined to leave it where it was (in fs/) since one side will NAK it
> > wherever it lives. We can record NAKs and take it from there.
>
> As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> in security/bpf_lsm_kfuncs.c.
>

Hmm, even if it lands in security/ you'd not ACK it? I thought what
we'd settled on as acceptable from your end was placing it in
security/, then having a broader discussion about the rest of the fs
kfuncs? Just trying to understand everyone's position.
