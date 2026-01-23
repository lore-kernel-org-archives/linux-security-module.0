Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB62F12D3
	for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135970; cv=pass; b=MkAGvJfrpybeppHKdIaz6HdGXCcwHAZxSKhhfyGxAym7EMn/1pQIOrT5QTZdReZBUJqswPiT3Pgdq0YFiRh93sm+JVgz69c6UtR8YIVEBANK/R/9jVYM7I+RB2TzbGX3+aaITjIAaorzARwFCLfwTzyBLW8+DO/r7uT71qL85vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135970; c=relaxed/simple;
	bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZSBLe3bts3XpN4eMUc637CEcGs+RPv8uJhufK6ABJdyPAEBXLMMEnKSMno9qC9zGIXh3IuY5dis1XPrN3VRsAXSPzTx2ZrRZz2JB8EyjOV1lErlh65Vp9O6K4L9YKw033GGXmRL0QnjhsZolfkjTxNfD+lFXgNjiww4orDBYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8v2Zedg; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8v2Zedg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35305538592so1843404a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 18:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769135959; cv=none;
        d=google.com; s=arc-20240605;
        b=bRdLd7t+54tPbokJ7yoKT78Dl4p+0/qVxkj8prkSzESkLNIL4hCToR+FbSrwmqOPf4
         tEG1+D7cFuExXDRo3NudnjNOkCRRYz2QgPUSIO+CmApBOQZ6rfU7l9l9s9yLMbjIhX4J
         t1ZTMeexo45KJpNRcRjYvFEvh2bLbDt3xlFx13DFqXGWL6LJxQwNgnTyqEfIe/YSq5/a
         tejKuz5I6x8NKBzs9/6P7StqYU1migenWxy8s7LK3O6be4Ism5HgR7CCp1m1jKEKhYDe
         v0rmptxQxy8jzdKT+hytbKesmrltm1pj8i1B+Gs+U41imN6W5AoEa25z2i6oL3bi0siv
         LS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        fh=bECgp5THlSr0VPYbr2kD08FaEos8v4KIlEa2T1JYuBQ=;
        b=SKwZrViuyvZ9YMumBSxCh55hDZ7M4NkaLj57YbNMFZSseq3x2ZQ+L5NH22x/IrDptz
         i8O8nQx6M5lAJPP7UTc+Rv1vtsrJF15BBb7SFZ6o15pxfUNvRFTCGgHJVs8P8rpRHgoG
         9hlarOFyvaQw5gsTBKx4rj9Q/DgjpjHK46KM1753/j5ZKvfbTxzkzQiRcU2ORLSHJ4w0
         ySNXraABbz1hjDpeF1H/P57Wo/9iSD4w6Oo6EVE/G9n3BrreP/jwu4TrCrL8Pj+nRWth
         DxnQh7T85B6slvHaSLT+nzRBNxH/vVgckF/f0LYiEnpyMFkEs3ScFHVt+CWlHCiy2oey
         VKjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769135959; x=1769740759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=I8v2Zedgw4jpN7rWa/wxZ5lSKgncvp/c2tGHB5oayIw2Jir2n6HijDzUeaZatg3dry
         74zKOxDEger65D9PfEvo8WVzvHS5qITyxcYM7zbifKxEBqKKIsHwN/FH0FhGeMtSxqT+
         EYCtaX+bNCDzml4wckFzmtu+WvhF008yFXP4skx5IgI11JrulmYqTeCT61CRq/QBOt1Z
         KbgWeogB4Uy2Z/rOSq2ugxRqxtgB4LRumVtQfZjWJTwGRiGgwLKWK4ybhx+vNOvzu7bO
         +xKGZnzOCRKt7Oq3GFIC0u81b2ooU9JwBZc86cxmJNNX0910naWlT7xsUHWha8yzEKt3
         HQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135959; x=1769740759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=uv+Byp+ZyHczCJsKOZPAuLeBVv67II6kyLJ/pyCYF3H9UmJS5f/DAuq58RK79My1Wb
         7mxkEKzDLkoOoW3dEOeJex9HIclKSgoV8mwgdErxJWAPOGunY15BqQPEujgGBtk9KzH4
         +FWpnHRCJftKBqE+Mv/dJR7jvX8ONFc5R+9jo/q5ElfruwEFFDbtxEXhaK1ltyAwDMK8
         lV5buL953g/4u3OhCMZ5LXXVLCuTnUTDOtvabmovcyZVs2nDsEoEgKP13nYldzdRlF6N
         D6KyBwN5cToBQEpHIftE5KPQbzm+YW0YlpT0R95TZVrbPZ/ds2A/zSFWZ2AIPd6QaI/+
         HVCA==
X-Forwarded-Encrypted: i=1; AJvYcCVMLwg8G8PcPD7PdRY4o5Ddub6V/9yMyMDFMgmM59/xjiITM/kRwNUKIuMnBbERClD4BDhDYMO90UWW0n/VSlX5qVobYpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl7WifpaC6iw6PxOFKyTOuSbqkTmevwbI9u1nVpWuu8Gbd+Pk
	wrl9Di9vNpMXg1W87ddVqIwEoDf8jRGoLL/vK8CFhNCn1l89Kj13Lf6jfjshUowXxZnvzCRFrLU
	4inoxU4ZYwxKYLpOXt27rPkCMvYPFRl3g+/j19FbF
X-Gm-Gg: AZuq6aKR5TzL30N/XZyBzGljXTHuJiliy0lRH4i/s+2X8GGxvaF16tyrkf8V8ImTtbx
	9/LzBtHrKKam9BPDvX+bk6F9cIJyBE79fyiRPSXq5a7yvBbsQEcBmwUBKNI9e7BtUzxY5YIUnm2
	aEgE4ad6c/SeLww0BXNToK0Z9xflhJEhHoRJ/LasW1ZSHVbhIzYVw/AhMIlYZX34Rb+ouGvgGX/
	zdA9Q/2NBWR50/V4+Vj93kVCMJ2trnruYI1m2qgYZQ2ijMja2ogXPQPhAFIvcCHYomUUIs=
X-Received: by 2002:a17:90a:d403:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-35367024a1bmr1261929a91.16.1769135959102; Thu, 22 Jan 2026
 18:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com> <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
In-Reply-To: <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 21:39:07 -0500
X-Gm-Features: AZwV_Qiuw-WOvpplG3_3YRv6P3Gqf8NRc7bLKC5WTsb9MkYny2ZAcVsltSt3mLs
Message-ID: <CAHC9VhR0F7rp=ne3BWPtuu_KjUao03iYoHuNsQdYgWygg0DBkg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 6:15=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Thu, Jan 22, 2026 at 9:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:

...

> This issue has been bothering us for quite some time. Therefore, I
> don't mind spending more than necessary effort to get it fixed
> sooner.

Help on identifying and correcting any deficiencies in the LSM mount
hooks is definitely welcome.

--=20
paul-moore.com
