Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A193BCD20
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942918; cv=pass; b=SUaTDFVHF759PoQd4LDWu3u3c9yww8SONcC7I1iydFQbKRNTN82kQHk4AOw04KiFJQ3qDHyFwDxgGcuX2B5+VNlPbVqhDLNn9cPjc6k2Sw6xqMuL2MICxwpjco21zL5x0Hb175cfslGEeG3kzpNpe4kz7TTGB/0rHEZYmUHbD2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942918; c=relaxed/simple;
	bh=adx6fIvXjZgFuJ/+Gl0koLCR6NGkKja1b0VlhelWFtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbiOVutBR4mMVdBcx/ydgnf6O9K+VBbsASYY7AHD/VQl5U0R7KghczQah8PGGMPAwDmoqkbKXQm3yk2Ka+rGDxxLXVxrYg0/oYVEOavoTb+zbkyHk9mr0YrXGu7/ErW+B3tC1WfF1oyY/1dPPoWpFCCKa7WF1OWPMXB2gNlG/ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TfueFUTV; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TfueFUTV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1478703a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 11:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787942917; cv=none;
        d=google.com; s=arc-20260327;
        b=PcQF/ZmdxT68Re+VJIVGADqyqf1vdNRJywYMTakgW94L3sBtHJYvT3xkBKHKWq2vRi
         asAOSPwy8HwS44q7WLH4SLQYlGCLfCh2P6MUVe7jpaSYpkCkrOA8FQPCAXo+TNDsZsIp
         8Igb5nT05LOrP/rvA2kiST6E21sUKy2OnHY+ib1tEX7hLyQeAXoG5eN+sDLtLL4cjN7F
         wpnqMcbqK5Vwcd2Yg87Q8BOdprxB/Z19qNGRrGNGs+bz/yVYCOyaKYPRaxAZLpjLSZ+t
         RTR5ybNbanpxApvCg7JWPVTMdVxBcrW0XNNf2p+ahdU67UN3x62+wWhGWvBwJvLnCjhz
         CGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3Y/bbGVtW+ZEOaZ1fAMBPmwdyLY5JaPej6ICz5dmE4=;
        fh=8C30DctEtRj+xC+RqnbfKNxg0Oloty84A8RYTc8wCH0=;
        b=iMjECNBvthF4QjKtUvHYG3PH5FF+lU9oJsIUuETGmXWOfBHHsWoqa/xcVsoTYsbN+j
         yykCXwV2+QbYUO3EJkoyIE6tObAS+8mERF1/16suBi5oH6HotwqahtPHWltCHxHH7dNw
         ixBFhBXtqo0NbiHGXlzwujW8UwYiiNRd2FyjkdBUy3v/Eux9KppAPhijC5ean3sLVXeh
         PYkrVE50VFzUat07+wk3Zu7koGthKVCSD/cJLOZCgWPe762uOFNIPc9NEBJzUjW7nKtx
         TuRjOhYDWXBcFjBBHlTBnxBp0vMriFsv9ptWG/WEAzapFR1JJrgMp7ELG6Cg8XinMq/t
         c0gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787942917; x=1788547717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3Y/bbGVtW+ZEOaZ1fAMBPmwdyLY5JaPej6ICz5dmE4=;
        b=TfueFUTVz91cKtiaYW0RTm9RUJPq76aWAH7Gt9e2ICbnVEB7DtAlpTLVIU+eeJVHkg
         ObQvExnZ2U00ymD7TZ+NozoLskbvwKc+ndQlOFzvhuHQN5QJF/PQRaFF2rvDk+t3SnDN
         k6SAFDI227GK0M4fZ6NgGUVub+FnWfIbcXXEPCPZmZEF+6eh/smOpo6NSEm2/4ROFk10
         3R1OPSLXKnVg+8BVRsbF4QvmqXfWrg8UKCLakNpFHw5QIt1uRvRD5nt5UqViFZVGlc2w
         U92BSrZjCI0sn3//5Rh/UkFJrsksajdC8vX+kltuPLZXV9TkQvWBC29/c4c6DVeTb/IV
         Ba8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787942917; x=1788547717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3Y/bbGVtW+ZEOaZ1fAMBPmwdyLY5JaPej6ICz5dmE4=;
        b=Juf1WZn3XKiVzOoNZfXDX7KCHWLGHruS2YCuovXx3R1me71uKtYUDE2qB/nlSWpBvG
         ABf7f9ZWB4tSGz7sRq6JwhV2+T6hOARKrxewihRaYVu8PTjzljL6yw6QLPFyIapo+Kuc
         Mt23ag3YvHo9u2hKZ5xjgGZkrAhNXyreZc/tUENxu9A2w7GFaelCoK3rT7UkBMzUL1vY
         muzU40hWUkwU2j7JaLf+EoDFEgHgDRc1sxXTg+rQ8qkstecjgJdAmew8BfZvi6NKWRwE
         UgG7m/iA2BRr3vwcITGnBNjJfFNjWV8finmo21qEaXXjteTzZGBvgVUVflRRydaCCpBH
         Bg2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqsp795IdgWDINy5RRu8UNq8J+GkjvkOjf3QT6XAks2MTLXwObPIK7iURPeuUxxa47MGUWgiMIdMyuFjtzi6YfpiMYE+o4=@vger.kernel.org
X-Gm-Message-State: AFuF++lKitTgTCKsibgVEOHCIfFr2uTrk5ZzyzLUKVpzGgBDCd9JtNx2
	JB/t1tU96gWUBc+C9Y/xqtFdZQDCgDeIWSNohnfkOc32H7SZVOSVvhc8+gsXBMWdARJ4x28d/Yi
	npZN55rLmGKNDMuJhuGMaaKDsT0E6/lnaiLbcL+14
X-Gm-Gg: AR+sD10nKsugWooG99eT2uo16UQsR4b3ULYhl3T6svH7Xrt+MNSKnoMQFZeZVHHSPXS
	NCmDUxAvjoyf491R3TxvbXuRPHrI5AEOF3/8JGzqYr31TkbYOHEH7jJiEiH5FFRGs0fv8QJcbF0
	hEDpCJS/LSNh4G63swyf5bPXS0sHgXFnsSXtAWxW0A8A9IQoU+LYBe43ysS3FfcdSC9y9BgyPUj
	6EFJwVUMz0s6b2HAaHWlOX7J6dp/Q0D7abOAHOdI1xkkpYeFx//Q2PX2fqQuqKL5TFgb4gAeFx7
	sFL+duDwdoTjgdNZf5JwAsc3MPWkETsIYe1qUpZDE2uw
X-Received: by 2002:a05:6a21:8984:b0:3d3:aed2:6f25 with SMTP id
 adf61e73a8af0-3d3aed27354mr1179453637.25.1787942916987; Fri, 28 Aug 2026
 11:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovChn8nTkgAs3sw+_YDhKWszxMj-tssbPdwGjPMMC7zEpyw@mail.gmail.com>
In-Reply-To: <CA+0ovChn8nTkgAs3sw+_YDhKWszxMj-tssbPdwGjPMMC7zEpyw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 14:48:25 -0400
X-Gm-Features: AcwNN1XKi_Z1xekj--_sqjnfGWMHJnkG7-HImC4ofFVGoJEsumduMPxYISz00Kc
Message-ID: <CAHC9VhT-xBQgidnKEwFZsOX5JD+SPhwrNSph6gQNLZR2-Uf6Pw@mail.gmail.com>
Subject: Re: [BUG] general protection fault in security_path_post_mknod
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, falemi@asu.edu, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:11=E2=80=AFAM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> Hello,
>
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/178-genera=
l-protection-fault-in-security-path-post-mknod/
>
>   Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:security_path_post_mknod+0x49/0x1e0 security/security.c:1430
>   Call Trace:
>    security_path_post_mknod+0x49/0x1e0 security/security.c:1430
>    filename_mknodat+0x40e/0x660 fs/namei.c:5172
>    __do_sys_mknod fs/namei.c:5207 [inline]
>    __se_sys_mknod+0x3a/0x150 fs/namei.c:5204
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0x146/0x480 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Our reproducer.c is available upon request.
>
> Happy to test a patch if that would help.

Hi Farhad, thanks for the report.  Do you think you can diagnose the
problem and submit a patch?  Bug reports are always welcome, but as
you may have noticed, we have plenty of those at the moment.  People
willing to not only identify problems but fix them too is something we
are running a bit short on at the moment ;)

--=20
paul-moore.com
