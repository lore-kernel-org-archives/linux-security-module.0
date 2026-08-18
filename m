Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD89484243
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074924; cv=pass; b=nCedadTAnaBjX/HFG0IglZcIJiTvdwPzq+9vbJZEfcy+FqP+z6S1WbmsoSCyWf/E3ZlyQ7fJhsFFJTdaRTVCO+OcnmL1fis4a3sHhzNI6oO5cRRPu7r6RCz08ek8q1jB+rXHx1LuUtg6QCSQ5vX8qhpzFF2rK/Cn02ZghiwPsBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074924; c=relaxed/simple;
	bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP+vKSB5acY/Z4xyCD7RG1Br10or8QOpNyIpmwtvjYgbV9l3jF6i+DsLbxygk1+4Pe6fXASGcZsUjfXdia/0XAZVVUUPGw5oLNxK8RwVLmJJ6Mv2CwUlPLvlN2cF0Hn6t2qIB5vOkWlwjcnMC1pYMKyJnSkf92uzgdAWyPKiLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVgCyOLy; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVgCyOLy"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f256eaedf8so2216926d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 10:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787074920; cv=none;
        d=google.com; s=arc-20260327;
        b=JaOMP4ueauTZLdAUAQrE9+KSJ02JemGeI9xwVdu3nnXJC+kF22560Oux6BqGfqZzE+
         BRQPMS7e6cR0OljC3+B+Am6E1FiZLD6nnBfG23aTEBVF0yFCIBIHijFh2UOfKxN32V8d
         IkXeprjFwmv/FqTxd05Ks2P4yQBovBwUvsPy5c7HCSdxvoZtIK65yWN8j/dMj19Vquph
         yz+jUUs40l3NV2fRTum5q7rVw1pGlbvOgaBuCsp/a4kc3roycjPrUTi3U0gruoYqeaYb
         hS27Wpa2niIvQtn0dEFuiTEZkQ6dZAfwLcpQHO9Xxkm1/bvvsnIiRQik0/JTESZp2SNp
         IBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        fh=aPwB20zpN1RPTLHbkcrxSBU5WU4HMlsNi2JhTqv+Sio=;
        b=i/PTtvvajOZ06/xUai+c4dRXkYdx0WCaXHufeE0QHGPU3YI/wsI55s6/F7WmTYkUw7
         pEp7DOGqjfJxx/tKWUkxEyU4xceLbp7AoBUJhjJISrqC6AUFymn2yS95DHTJ9Ifa4nxw
         7797KJHb4/Su7wUXXDf456XbrCy51TtrlVHgs+8Xl1yhHcXSYiTlX22KRrVNeVLaxaAB
         8E/VqSN6+50BO6TLvddt5GOJQ2t8YdpIzRXwfqvajOYDeH7+q0Tra+8mgKmQ6lcDP4Ir
         y0CEx0J2/0SB80CXDdNiY+7cUhc8eXbnF7XN6+QbPM2pSFzwaRcQpUtEbzcBkJRVn2b2
         lUkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787074920; x=1787679720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        b=QVgCyOLyuehuQgFYAb4QVdKb1IbW4B45cUA+Vk+6lmNzR4uDW6tNHYcZH77qh+GVyt
         IjwNBMwbq/5D5T2MLHAqUcqC4xbmIYgr+dmrfUwQInp3Ii7c4KDUwP7F+eC9eg3Utz9h
         GKT/3qkjvwJVnPDjgpe2dusIN7N/bwlZY/LubM7eZ0TTzLve1Lgggtr+ql62WI2ZRTXy
         RPTp0hMYbhBrBG0c7Z+s90xAwJ1gz4/edcYrHI6TzRFYCu2AUTy/JQt6cZuPZY29F2v2
         i84AUCk/NWwDkpL6ZrNp6THAtNeCuglTWtpYSMihlQWN9Y7EUQ+XpYtvosCV5UJlQdrx
         G7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074920; x=1787679720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        b=eSVRSgJkzl3UWe53ZFSvjWQuF5+cRN/SzC4LUEcZhnl0PNIN9Gr4rqCldVjposp55b
         hvRX3VnpSiqoYGMN8akxm/CJOCR6vbY/Tic0kMyEfk/nrISvDzSY1juixJTAUJpheuja
         r2dsjjej+RAlIq19Gu2sckX5OErX1IwF+NLXNAEd0GjfI9/Yo0Iyk9xiZvleYwcfUvmz
         ecudCFuPP3zignIrkHTTn5sA8Rv1viduab/tHhEVZ01K01M/03Q8pTvEhB9mgjOJftsY
         iH3n3JahAEDImU+Z390KwOLwlpZ18RWUtYfzpjFzrWWML2PYVTSSy/LCH3E1CPKZGekJ
         ygmw==
X-Forwarded-Encrypted: i=1; AHgh+RoVZP0vcoKuF/IDE9X3GEANJm4JT/HrR984aATNh3k4WbPiYD3LHT4PEXgNrkx5Q7pq4CEPjIr5aoqm+MRnmN165uHgFbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroB6j2969d/fks/rJNX5pCFqomL+Fda6zBMkreAVN3QWA1kEz
	NLZsdkCjUC9xuDh+6rQelG33bGjgxxpNowreJrwL8kc+svy6RZiM3qKYuMKcJ6vCoc5/ttMpbP4
	Iry8O5ay+ttt6jNg1wYylDrvbyQcQ8RI=
X-Gm-Gg: AR+sD10Rt25XOUrlAsvZ2DckfRVD/ndQXMUxi4hYBESNVhn6CxIo9DajYx5edaWPDr+
	/BYpkHivZOXgqj+P24OnbEXnAnhaUmLt8rM+Odd1HhsqD2fg7pcPDoJPwiQqU3xrugaRq9267+N
	hNkeGWyUV/r8Ij+XorYpGuO9JgYdHKWf5husdOyp52TETWnXOVrsV/fRHdg+ASk+zV/79LRxSeW
	S1s2jCxOBmfs7jQ5iRqt4OPM3dzduoLLUcnXndmKtLtHKu/z2hmewAX9bgus7rgNmUCThgKNLEY
	mFJTfuU8JRn/cfuXv4CWZWFJxEX0de+QWxTvdsytKbMeTzs9QStnRUZAYXmMFduOj92j5OQ1898
	=
X-Received: by 2002:a05:6214:2607:b0:907:88ec:6002 with SMTP id
 6a1803df08f44-90a91d23fc6mr359439716d6.12.1787074920246; Tue, 18 Aug 2026
 10:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com> <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
In-Reply-To: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 13:41:48 -0400
X-Gm-Features: AcwNN1XLdyaSasMTp9iBpNvyrMss7F-pcwuEvUrbotoGcvR6ijlcZVek2kfbZ2k
Message-ID: <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
>
> Lastly, given the difficulties we've faced from the LSM maintainers, I'm =
not
> inclined to waste more time in explaining again why this cannot go under
> security/.
>

I'm still going to send v7 of bpf_init_inode_xattr series, even though
it's a stalemate. Haven't yet decided where it'll live in v7, I'm
inclined to leave it where it was (in fs/) since one side will NAK it
wherever it lives. We can record NAKs and take it from there.

Just wanted to state this for least surprise when v7 does come out,
which will be soon.

Thanks,
David
