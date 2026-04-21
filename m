Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07903A0B13
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809707; cv=pass; b=rvSv5uqd0bw1VWH2nWZBb+NUTvSzzUUoGqPTbIfqks2aRmWmBd++AyqWDBt7v6QMmoyNezkj5mUPzR2WK4lKC09HHJ60/Ge5pVNI25ViKjBG8YKFJL0Ub26NB0XbKCXt3Loz9DE+IXcL1G5KH6pXFeQZydNC1p5oEG/G4HTlW74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809707; c=relaxed/simple;
	bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI+wkxUaZ1prxGGyltB1v8UZNI77WJK4YaTy/b1UMSpc0EANuWuJ5EcYOzQuA54QZHaff+eu0sd9cR1rHLmVkce/ARMH7vwAI7DB/4lY4HtVlBWp1tLwY2r5vzz7tOnbX/xBAsqMeAanHYnO3dMCErvU3wORAg89fECHgnXoK6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyW40bs3; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyW40bs3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso4233909f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 15:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809704; cv=none;
        d=google.com; s=arc-20240605;
        b=Rxx0pEoNThyLhNmyDwB/ZXxFJFbaE3z9ml0VtPNYOe2eA3fHBZFAGl+sZkceTB5GpL
         6gJZe2fzLWxVGWovzRU5/hZUQDb3o+6ynIJutzcijL/DMTTgeE2PtzZXHwjfsiRGclr+
         FJgJiVW7kixmE8mO7gMD3HddH0qEWWImVTqBZks1pya0T+w84Zy/Garu7Aai1B83hz7y
         eYo7pV2dkwpWRPeZ0Cl612OpgM1Y4Qvm793fcc0m+unnL8qUf6eNtJD0H/EFB2/5BZ/1
         x9MJ0in+Oxif9zxzfsfF6gt3uJNLmDBOt46cLGpltBZ/6uDCetVsbc/r2rp0YEMblsoi
         jpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        fh=q6yCM0TF5AH96lybigSMGW8DE88d/wmzz6ZX4enHyCI=;
        b=bBc8yjLwok/xVjtSKmEulTPJnHHYcc6KyIVXi9474eJLONIQeXkbmwf4g0r6lP+bHR
         rrsgraXn8nxjU3FtmNQqVSeBf9D3ilc6cikBx8MRLzqodml+prUiq5WM/VLMLHnJmdF9
         0tnj22rrGCwK+KZNRg3SAO2uZTyRNuuFT3e8rZ0CWRoVf6egPM6I+GvXSKmhnSXtWXpG
         eBn08ycSOjB5+5Bo2WowYKaQzdGjr04pTvjElYXxhCfDYtuSYMWVTrS8VAuj4O122FXc
         1yiZaAtadzuVXbin9IGzJtEW+wl0cIoWCcX6aN1Tu0sAd1dJYX+c6UnGaDaH8p50ZVCD
         bj6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809704; x=1777414504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        b=SyW40bs3pvYSD6Zxq35BIsvasL9iCLeKK8i6S7Q3M4KBXnv6E49eW6UMlqGKayZPg/
         fh7emUQW+vCw6/DICpkj7Dxzt5rA9b5TwgfO5SKnzLxf1UmRwalNMDOeI0h/15qxkuW7
         w9FUloddTQJ8X4DGmkhCVrf3K/VEjEf84O7WmlukVbEVw8/BvqHQWI05UtVWPhYpCqwk
         QJxy90OskjJgOGHh9pVTbIHbV8T6UAzNzv8a/DCpL1pN+WYLN5vb4dxU9888FyuFCV2g
         tCbIuwVt74wcfrqRAFASm1oCamBQlMseOBSCfXePu6iO3RK86zV801og3mKEcLhr30QD
         J/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809704; x=1777414504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        b=fQghRmiVDUkhMLatEg874FHXayctI83phK3h14Dn9pbujtxWbC6r6wKaRvY+O01CTo
         cUySyiEfKsILRP93mY1KfUgCsFaqGe4mMTvg1lM9FBVpqtE4utmO1G/uYyAJqZd+n463
         tTlJ74R4tRJZZVwuYFPSpRK53WMBQ2n4nx7oT0NXg/abuhWpIH9GgM3KkWcJRS5WOu6s
         31kRXo+vSjzfxTzl77814VjugJnTCH5+B/qzb5SswULAh0maK8J5kduOKXsP/nI2Xn8s
         b8Md2JyXcxTSpncTQ9hMeu9gyoLMFsWquSse97TBvEp9p69F8So7nYQXBYy0qW6bqU+i
         6/SA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q4gQ/bFOsQ8M1VCor9U5B9JTHSW4AuTW6eoMzlYoTA0Xsnfdn0ZQfC+VkFVduOTvntpNyOi7cvsuFoTFtOkZTJUq5aTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4PwLq8GN6z3X9m88tf936VWMVPabD+Sw8TKRvrWnbhYuQxia
	PMSKggcTAwng9HshYM4q9MUaQ13hT+dQdX2HkCXFi2I+KpQZBBIjDYaOx6UAvbT5sT2hDEVBh7r
	syaQDrO5u8WXDdN8cPd3cUQ1IXzhpxhA=
X-Gm-Gg: AeBDieva1hpcQhswhw9fPuyx0Lm8Eh3suaK5LVwdmbjgu2EntKx55x2woHYSAcNizOa
	WKpnf4apSA/8+TW2uPc2bXgWPLjPiGxwzv2QNg10cBoSwtVtIebalMpb5wu17LNIAoLxJ4av92k
	nzFsCbYd3joUQ6Z1fMHlevc99xchiaVCrhgTEnIRP2mzS41XK8cdraO2leppijcPtE0lkqQgBLX
	glQCVYXvMXLNp6bf2T2ykofjseHdKwAXuJ5lyBeLpmUTmiuCoBCXy91xliqAb5w+5oj5xzKTwzp
	Rb90Vio1KlNdDMhN3ZOtiS5vWyzJ/ixWVEc92a9rWl00r9C+ZJPvbFjAtz1zYfb36Ma6x51hG5J
	IvUH/wkG0VJGv9e63PrwK/z5O0pyPTv8bQYL+
X-Received: by 2002:a05:6000:1a86:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-4411df54848mr8169717f8f.42.1776809704286; Tue, 21 Apr 2026
 15:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 15:14:52 -0700
X-Gm-Features: AQROBzBdesRGwaAbHppflZu2UlSyoGakl7XBoNVRSXZffbkUa2RMfex5iK5obzM
Message-ID: <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frederick Lawler <fred@cloudflare.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> > It's still Nack.
>
> Based solely on the diffstat and a quick look, this appears to be an
> LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> but they are LSM/audit kfuncs and not core BPF functionality.
> Regardless, I want to see how the LSS presentation is received before
> worrying about this too much, but your NACK has been noted.

Paul,

told you countless times LSM cannot touch BPF bits without
explicit Ack.

So, no, you cannot add bpf kfuncs in random places in the kernel
And, no, you cannot call bpf internals through bpf_map_ops, etc.
