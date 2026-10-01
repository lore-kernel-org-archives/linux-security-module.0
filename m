Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D173803F1
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872697; cv=pass; b=dzceY9XtAiCiQ/N6stVl01fqKj0aibSDY/eOcJIgJnsHgGHcc1Z8iLryUcs5OWhDhEoxBBIh6ugPLEGS1OcFdWMd2CMfP07Mm17/WifGkZbv/9scc4Y0YOdD2/VmszsDbT25v369ed1jjlYe46kA7eTCClxMaQ8qufw1KnQVJAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872697; c=relaxed/simple;
	bh=zTzFHP+jlHeUdEQ5vb0ZGqSBPiDfPT/kEkT+MC7FqqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In3g+ATWwUoWKKUSXT5UmBvmtnAqMAiso0K5+4zBLWcMDuXrwAQmafJPghx1b9CmMvtikXspBYJx8gnwTRWb/kau6E61y5gcSEPoTHOPFy4TTgnoFXUhqfJ0VuCxtH5+96zh3n07O5hAJi70znTu3PDubneRri++2fLUba6BHHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0zwbtj2; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0zwbtj2"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ac8e048735so22336597b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Oct 2026 09:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790872694; cv=none;
        d=google.com; s=arc-20260327;
        b=eJAFlP8dg13LUjL9lDYXM7O0H/5iYTE25fFv0yIBzk7LGgMn4V/7NJO2sK4maq/T+J
         r8U5oJBjWO46gZ1rCUqaJm0zu1fdmEE7kRyJDAm7MZ+MeswQmoiYLH1aawuG8bMAFC/F
         bTYTxpe+yhrv0QC4oUL5kCgpFBJIJ2VDbYUrHer2sKKUr5f1GIb9X7oEY3XPMxOwxJwK
         zSv+6gen4OFX2UxE4pIc3yzhFtU5+p4gtCVM7h0H6hjAjLLkU+KyGsICOFxuJjBcbxlv
         VKSyIQ4TZkhjewBgIvQDubHOCRVl4qG/E88QD/HDOv4LhMm4Yd89jFP1D3d+0d9T05i+
         Bzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        fh=aXDW4ogPwkTwzXiMFK29AX7+yOLcK4ArYz0fyyfamLk=;
        b=A0RGX88F47HFh4DR881f4cNxUnIF+a6gdeB2yUwqJ2fKK39//Rs4l14LodeMj1BvcQ
         jz+xXEtyjlS7Ep/oml/BsJCf5ncbORHk/siXPCnZTb8V1Ie5oWYU/tHLp1o1F8nW095A
         OFAwkDNMX07VGx0P7flakInqIzOjmXnPJw0yknIwqGyCSugpvG0a9GKqnA+uB298S8R7
         5meXZfGKJszCFtsTawOIwM9hDRMtRJFPkxwv2HJ5Pjn2svVOnUQqS3qqnnEiycPEb80o
         K1mNEtHzdzDzV61byYY4eYxXBoCAbN8RJ9Hz3xKWfNBc/vY2KkNEppeohRiq9OjqZvNb
         cQkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872694; x=1791477494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        b=p0zwbtj2iMdxEh/A5vyx+HjgSR5La6BfqoMiH5mYCyIL7SPycfOwxsNRkKpQd6fCVR
         SAjbTLXSZC2UDWklN+JlivAc9Xtfz+y5g7IJ6onnyoG5xWsXLBNH6V/CATcWqxgQ0cB1
         AleETTEBOSE1qLEJgtMUmeWlrS7RdLXxXEUBRbkTxR4FaOL4HwIVtu13enYP98mmlfGo
         z6INaT1ysaqe5X6lVryLh90S3PiHnltipGLuak0EUm8kkGkdnpG7aE25Cb00aAUPdw4a
         zZJZh2pPi7+mBoCD1bsrC9sRR3nBrccTpdfXkQHx2hIFodzCmz0ugVpGVQ4V6gyaMU/T
         6hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872694; x=1791477494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        b=2trgXT08xhv4OoyEb3UCxA72lVkrGDsZ3uFp2vZzwHklOPyna+x3OJzrN60Q2K7HVo
         XovPJPJALo9a6DDDgYmG32Z66GO35DscgWdTILyRiIIxqgEnUB2RvjjyAuo/CN9ivcZ9
         fvqw7tVdBze/zrTF5rWqMck2J+Ea2NelJEtFPgkZm+qRAt/SbcCZgOn0sJlzHZ75gFI9
         P0J8cvPX6NFNrEUkzaD9la/tydzIdLuCLTwj6HCo9GGeSniBJlnfAoXIpV3zkOBBP7X/
         DnAkH5hpE2uHUNmc455t17i/FKLu23aZsO19DTW+rRbnudX+0e7uqij62NLU9PdIvXvX
         O2ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxFq+NL8A2ezNwyt3Jt7dJZEGpFnPrZ/GNLnIlrRoDeA5M74HqJkj72J39fJCOBYMaTlVGc9JdzQOJNCoRZtB7Q2lykrvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaZ9tGA6weRFGC4VDPN72ETFVMS2srW0XHtGGwX4QBnx+XHob8
	3qirRlDBRWIHk40TiC7cirSrwLrA9Ma18B1J5MwMv5+trK2zuGqB1TLK88ReK3L5IXYOBJyiWTS
	h8Jx3tTOSUkq5VqHKHhUFFT17tKmTKEI=
X-Gm-Gg: AYBFou3W9HkeFjC267tZxvfmJ3T+aAiPei/ISJikCveJziC/N1NtpbgxAuqYM7+u/nm
	eG1oV1zrr2XZwtDDPw8dkHwpMu4q4C1r4rfYBZEK+dWR4DXke+0aQzBKzpq1EsuokOTqTptehmM
	K9fgRDuzyRZQXDbznZkxC9hO/JEMhLHEPhZL8ew/+69VzxOYe3VABIzFrnlW+NG9j1GZd1lMwDs
	NMuRvUjUvMhbM7YPMvwCZxjgwHPzyrI/1yHl++LA8AYDF5p2PfecJJPGN/lEK8nEYJk5ZY0EyiK
	HZgfMKnAjWV5t4T5gMQmi8R46M0izdJujMq2oR/115QNO9UvJ+Wqs4s=
X-Received: by 2002:a05:690c:6c10:b0:873:5c6b:a310 with SMTP id
 00721157ae682-8ac948c849cmr22214287b3.62.1790872693677; Thu, 01 Oct 2026
 09:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
 <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner> <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
In-Reply-To: <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 12:38:02 -0400
X-Gm-Features: AclHuK96-5glJSr8F5qL1SZIZo6qNIPEama9zFWhTW_-k1WBXGLnbo55O8cQqZ8
Message-ID: <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > added a security blob to struct ns_common and allocates it from
> > > __ns_common_init(). Most initial namespaces (init_user_ns,
> > > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > > however set up statically via NS_COMMON_INIT() and never pass through
> > > __ns_common_init(), so their ns_security pointer is left NULL for the
> > > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > > dereferences its slice on one of those namespaces (for example from
> > > the namespace_install hook when a task setns()'s back into an initial
> > > namespace) will fault.
> > >
> > > Allocate the blob and run the namespace_init hook for each of these
> > > namespaces at the end of security_init(), after all ordered LSMs have
> > > registered their hooks, so every LSM sees the initial namespaces the
> > > same way it sees init_net (which is initialized at runtime via
> > > ns_common_init(&init_net) from net_ns_init() immediately after
> > > security_init()) and does not need to special-case them in its own
> > > ->init() callback.
> > >
> > > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > > that the list of statically-defined initial namespaces and their
> > > Kconfig guards live next to the rest of the ns_common
> > > infrastructure. init_net is intentionally excluded: pre-initializing
> > > it here would leak once __ns_common_init() clears ns_security and
> > > re-allocates.
> > >
> > > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> >
> > Seems good to me,
> > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> >
> > I'm waiting for Paul and then I would pick this into namespace-7.4.misc=
.
>
> Since we already have the other LSM/namespace patches in lsm/dev I'd
> prefer to merge this patch into lsm/dev so it is we have the core
> LSM/namespace patches rooted in one branch.  Going forward we can
> stick with the topic branch approach.
>
> Are we all okay with that for this patch?

That's fine with me.
