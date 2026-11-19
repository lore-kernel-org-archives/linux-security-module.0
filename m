Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795117043;
	b=SibSkvkOjlW+HETotxwiIzX8pWoVRSSZFPfShOUm3uyoD/VaCY517AsxlNjeiW2RT4r7
	 XAfbqzerdUFedygre6cmqeyf7FajfDNgzJXm6EhvPYuwHi/pbLqK0ovkt6DkaBnFLcekh
	 i3anFMsWC/dxQhAxTZm0HNMlJ9pXIlPFeGvNq5COHHO3xwndOdRJGJ5FutqpTY9ikRQof
	 XKYsPS/Pg76Clce9t5/BxpCTN6yd3Cw3I8HZ1AyfEqPVXPvi1ZXdcKy68WWjKK5fk+iGu
	 K7iYR/wWs5CpkGsk+Qawbn9jEQ2wUa/y1+2ZIwKYbQSEX5gDylqaggqSNKtks6a8McQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
	b=M5iCS7v57ujFeV9FQEUiFRi9hrjfeLXm5b06Kxr4rzIgoomzXYePvkwZyd+XBE+ipqHP
	 Oc6URBvrf5geEqaS4GVmm7m3g2CV/Nk4jj3DDIk/6SXgWt/6WSeXTGUcE6MJN4wQxyQwP
	 aCbFfsDanZjKxxa6cc/bemALMrvu8G++2svLOjHtpvlwYkCandwBm5qI6t26dwZlqyjWE
	 /drMr9SiMWpkWVdi/nF55rFnUPaWzDt4rZCciDb9JqGD3oMxO00t/VnT2AAT+G2ldydpJ
	 Kvwv5f9Dtfitt0GPJPwpYD5TF/sz1GbRP1WSMdXnAMBVtWyar+61/nskKxR1NJBwqrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XodjmMdN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB38606A324
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB38606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XodjmMdN
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso106855a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 11:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795117042; cv=none;
        d=google.com; s=arc-20260327;
        b=L6cF6kxNMmBDc15pxt/z1xD92t+D0UxDltM+jVV962iDowOlNGn8Xzfow7MgA7Ryku
         D1nZy8DRT8Q10+NfVrMubzZWoGJi+u6DV09cPPTMn8q4+6sZBnkSnT2wt8jm7w63Up9k
         EXgltoYdgET92yITFjev7j36hyQ8Td9VOIwQUSBqH8YERufoABJOvQkcbBetU7MB7g5m
         ICzOTgr5rpaN7zZJXUsqCgiGfSfRIP4OOtemrxfNKtKvecHrDi7zucpQIh2xVoFTH3qx
         Rpn7lR/W/mGQY/NMExmhUIiNWr+kpUglaBYQlkJZXVVkpPTYo/luBDI/hB9nGvi6gIx1
         AHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        fh=uQ13iEMleHPIrR589WGH0ctkh1PCH09k6m0i2lwv/po=;
        b=bSAfbYijlI+A5SPWISz/Wsw2x7eS+xYDdvzG/Slj6JWxUYi6OfrCYA2abUm7EjcGJl
         a25nycFJp1Gl2Hd23KHtVxeSptC3jZpgOcIraUqVe302w0uYHLRgMnpO7FdlU1UfGxHc
         6nY3N0UazynFQvHs0HK1/WfWTUegldQf4GVNaievepkmbMYDGIAaKNRkXqX3/0XL/i6o
         KpTBzT9Q0uzIcU85B1v68+BNMAvvYrstNQDm8b1QA0ayRccm60WVSQeFIz78DBzYU2XM
         toGveuys8JbOjHk/C5Kq8P9tbcQXwoXUZ+CpHQYGDI3sGiqvGPiCHqkKlklMPweB0bVM
         CaIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795117042; x=1795721842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        b=XodjmMdNd66sSQHPxgX0Iw77xrzUpXmpUh6FvrO/B/Hk8c1K7J/ubNP1xulYRVIUn7
         0zNyz12Ie31a/acpAaE2JdzOyVZ1FIPVGXO2gq3/Xb7Bd1z8v8sJz+XnGPwAxvBt8xIt
         nRTm2fO0Elbyrfw7YtQ+JmWuR1ealDi/ibMo7Imi71oY+hqZsiiaQQ9dG+C12cSBrwK/
         yX57pzVy1ZeFaPnMkTQAWdMaSdjisCW3A9pZcG19vKHgRG7aioh+XHJFJMVZ6Bw9H536
         yCz7GWX5rzmqjUzUXrTu98st6r2v67k8vlpr+1E/DOMY+/p5qBpWJAVdWcPbbrF9cIW6
         mN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117042; x=1795721842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        b=pB5TVFpSMMCGQ7aMNmnLm4YstD8AHgHBtFgN6xy3Qq1n1hjYGIE7tOlC+IBKOevcvl
         t8tVNg7G4qBPlNLDMRz1Wo991I89lfm8HZBxu4ajKvtgjJ+g/Oc5TlHXoVPUYTL8LKNJ
         b3aYpelyspxoVSyuFWx9PFSWUSyQT3v61pzEcHObzr0pDyM5V16MAcTlukdtE77KdFef
         VBfy9xxjpzSCn8z3EMDHwZUXtCPIXfm9MjpQWshekgabwwcwUPtLZOH/TgAKpoQye5ye
         YoIdwTFv1yaurtp4ZDLjxBnVaCvi66pHSkUucyYUBv2SEqnmfG3rzCfmRuiKQvLJ7bXO
         xYNg==
X-Forwarded-Encrypted: i=1; AL+hErGoeyhvx5g2/UC1VOlaFjwyH92nReBTlMcw40fPYrZpFKEmJjrJ6HuODsMrZw3sbVhiY+P+7mbvPyXUUaXiieNN8GyRxpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gmwZTRRa6n4+PgLcK1qIaQ1Pz82PxKjgswGl9Qht+2iDYp8K6
	LMjCtNxkNfzHfM8ydGuPUHp9eGCIcf2QDp/QZWjqFK6Ps6vn26TecYhfm3V4yjIAOxDV6PruABQ
	CRNaD6VHYb3FKSaTY+GHxzoiYKVHBvgv207tfO7VN
X-Gm-Gg: AZFdTZdDqvUkV8jQ0ra/wVpCYWGPK6ZjPIWbXSd6c4RcqxgIT8St4b46ACPqotl7X8s
	pKN0Fn6Aw+QvQf+M+C5/IMbVv+UkPsZBbj6U+oYS99I1v/WjnVxpuEVN8OeOVkuSGJGgNI8USxF
	Kx6aRCG4rXBFaHZjNCKLLn+BUaOR1b1DHR4PMrwpwUu89/WdgTC5CgfS++9LTOsoPPd8kj94Mqh
	auUM7z7bvFcjticLTczqEHMxOwFC8Ng97JCuZj5RKZngQXhHxe1HZdCUzCOxQK2OwBGiGLToQOw
	3fl0bDQiqA5QaMVUIKkpFpIUaShtMfUAtxKgQiXUMnixOrzFM9VDvP8cxTdKJPrpcz28DvJXN7M
	Lvk5aMPcxQshI2ZwrkM8qsb0nEPLVA36Gk5xjP9R5ZwjOtkjKA1gbL2iyJ4fdgN+3aIp8Mw==
X-Received: by 2002:a17:90b:4a48:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3b41c7b60b5mr394543a91.6.1795117042197; Thu, 19 Nov 2026
 11:37:22 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
In-Reply-To: <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Nov 2026 14:37:06 -0500
X-Gm-Features: AclHuK8huO5hL8Cq37FykvhPQRmji6J0FCQEXOUl5eyoX-lYuZrqwKkD8osBd6E
Message-ID: <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> <paul.mabileau@harfanglab.fr> wrote:
> >
> > Hello,
> >
> > On our end, we also have already merged code to adapt our eBPFs to the =
argument order change. However, we would still prefer if this easily-avoida=
ble breakage could be fixed by moving the argument to the end, even if it m=
eans having to revert our fix.
> >
> > This is motivated by the fact that such a change is not made in place o=
n our end because we ship our software to environments we don't control, me=
aning that any and potentially all versions ranging from 4.11 to the very l=
atest should be supported, so the change is made by compiling and shipping =
a new variant of the concerned eBPFs for the version interval it is valid f=
or (7.4+ in this case). And that has to be done every time there is an upst=
ream change like this, so the total installation size and overall complexit=
y grows accordingly.
> >
> > If we could avoid that, especially for such trivial root causes, it wou=
ld be nice.
> >
>
> I agree, and that's why I'm asking Paul to accept the patch reordering
> the newly added argument before 7.4 final is released.
>
> I do not think that the maintainer's personal preference for argument
> ordering beats real user pain.

As stated several times in the past, the problem lies not with the LSM
framework but with the lack of an abstraction layer in the BPF LSM
providing a stable API.  As far as I can tell the lack of an
abstraction layer in the BPF LSM is by design, and while that does
provide some advantages, one of the notable disadvantages is that the
API is unstable.  If you want to be upset at anyone, direct your
frustrations towards the design and current implementation of the BPF
LSM.

--=20
paul-moore.com
