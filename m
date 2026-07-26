Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372622F1FD7
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078236; cv=pass; b=ULzVsJdZNi0DrEh/hur+2DnW7SkZomjt+l+gyqU9fcJBNdVI3LHD1HbYCl85NgTC4vtHmO412J83I8abr4l2d7tEiBvzkEFzlmPbZwXXeC3vCthJIzSC/t4RrBP47vMwPqTWXXVrEQmGDlg3XQcNC/YzuI7IQrQhFvvpmd2lj54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078236; c=relaxed/simple;
	bh=liVqCRED6A0BSTJ8Z+3vALEAqve/O95RkgsCR7qCf1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuUptKqEUkdxqq0ibauHxqzKTxBl1QP9EkpVrhBgs3NI8SPJ/jYm108IZmEcuaDK0jTU1DQVFGdh/K5RJa0IchLdOXyWmpttd7ZFi7J867OaESDUFSLPiINkEo4W3CE+T1T5OVOV5Q3bP6XZ0WCl/vQm59X02Q2I4vfW2BXai54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yz6Zdn7T; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yz6Zdn7T"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad8076b01so21864945ad.2
        for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 08:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785078233; cv=none;
        d=google.com; s=arc-20260327;
        b=BxAZspr9ELf7HC1aZYZwcZ0KxE9Id5gT1/UwKlzYrxpxgdy7gyK9gXBkPFfpjTEGeA
         aNsDSQkMHpZCdHBkPbq4P48/7I6RTGzUwjfhd6U1+w0DXN6+My18QAeqS7Hh9g/BOO9L
         zztWrsECXFETXUAXg0WZ8WB2Xmn0vZTK4Mgi3Q9bc8SvlWX0h8bNZd9x0BqrZ2qOLaI1
         TiLCZx4g23hOwp9SzPZPQrXkynCbzgSO1JE6Q/pZiFdkpGVpJNiO29LMd5XnoUQUY4FZ
         guns0SLl4pWfNV3KKUCAnVnV+ETVYuL9v/np1bA76VFgYPqbxPn1+N15jUkAyTCwebQq
         fg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        fh=Xux+TWg3pKsiaG5rOcAQTVhrpv8S57wmb27CcTsC05I=;
        b=Ft/5Z7Mt9Jfea+Li5BBSxda1hfpDT1lUNaFBPUaBuMm1hvoVaJyuem4ZIXwNABmg06
         0HTlsah1RDU7yNExDWi/4rKTW/VKJ7XO4j6GMUd5a7PjQ8ABNUWkI/OL+YcZrKvNAKaN
         Vo14UfEA/icO7Gz+7uNxVUVzBctri0ma1a85qR/isYqfFuiwlsuJVce1oLxAjiwBE05L
         PhJt370GKBjsjp2jknCYPWKVVJyKci9WWl3+XPArgPHy4WHNDx/9pEosNvSgPOvs93w/
         WrXcgezQ/FKYIjKrgjJZ5rNOwJh2Uj3jkOMFqEe2v0yrK6pVEqccWvlp7Co1FYuoSTYY
         InIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785078233; x=1785683033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        b=Yz6Zdn7T20F8lM71MtP2/eb4IqGfaMqCihPxuXsRQstQiOYca0aIsQgU2rxZI8muTs
         hOVjiCEHANpHw/MV21TE+BDEfVECa8ZwOQmfdGNhqkJG3yoiR9JRHBlazpZy663yGpk4
         ucJa8Nk5tiiNl2QGD2VUPhdeD+uObANl378OMTVqMrOmaQTHqO1VpSyAfiw0eY72/M+t
         extIU06kmTztKJWB7IE/jGwlmJjFUP8YrwzE3fMpQLZPOQubTB99EP8U1nurbio1iQb4
         +x99cKeJCLpgkn6CGAQrsETiiATW+AMK2RFYg1UpGGgnCR6ViZqqrdnHp/IIk47BdSfr
         0u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785078233; x=1785683033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        b=dzkUrJfa6trvNuTxFqei7gxTt2sAcHPBL/Djj+MUr51oGVq2NmmsWxWNbelgdCyxYn
         A4W5ULVPmodBKDC3Ej5BoFs+vMKOq54l4GyKd5D/PK7cFYwFD1hOfjjiHO8HsQEivlw6
         9XqACou6jed/QTLQURc6djMtnzcvSR/IbQEcilo2QqsCpEsfqfpICnVGr42iArPrZEeN
         XnuPN96GW9wmpYQqjvIzeRveRJzr1mX6U+D7vZMwJu35ysxfDDJvCn9ZCStFZ81kXXom
         e3d3s8LTJzh2z3JiJYBKDJoQWPJqQhBz8bo57WyY39+Gx0fEP4AbGTI7SH4K5HDorYUg
         Foqg==
X-Forwarded-Encrypted: i=1; AHgh+Ro56C8OLrWyfWppeVJyqKNn0BHVmIIfjUPDsr2WNbLUldGNVAEQpZXDCCaj5GFhnlpTDWDFRjm9f8Srx/xKeEthtp3xZ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xLLhrQsQXAHzLOAB1muGqHRDYZbMj61bLUQl3rjQ/F+xetNi
	sDAFcAo7DhYljpFWJTA4ZZQ9Ze9ZdMeBYNHILrxDtwkV2c2lL3o3lQUTzLGI42Z4K8vJ92EtOEx
	Enn8FVQa4qxABpeygOznRg7xvq0stXyKi80AjQRIb
X-Gm-Gg: AR+sD11q6aW09d/iGqSUr/gPvrhVoLgO1T8YiVLkv9oj0xWMIMfzG7UAUpHBqd02D9q
	tNO6LlMpsZggI9KFvU7hH+07cr58G4GtFxZnm0x0B8UAh1mKV6CUupgYwVO1X6mVlOKPx8EsaIV
	ADmV95/MqA7azam/TzJK7ck0BqDhUb2Oyfaju1lQPD+uPjwHHMGWvgCap3WQAgu7lwd31RLyNZl
	t0bd1Pd9VyNITFR7MLzS3+/IlQci36Q1rCRD34NK62+6GaIFwcwj8LJFdZq0w==
X-Received: by 2002:a17:903:32c4:b0:2bf:9760:b94d with SMTP id
 d9443c01a7336-2cfde7ac5bfmr54965065ad.15.1785078233465; Sun, 26 Jul 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260725200958.4471-1-cel@kernel.org>
In-Reply-To: <20260725200958.4471-1-cel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 26 Jul 2026 11:03:40 -0400
X-Gm-Features: AUfX_mwCAvSQk4-T9fyvhCQsQ9yZrf7lX28MCwcHk6mPXjDrRJUIBZdmEFtEkeY
Message-ID: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 4:14=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
>
> This commit wedges an NFSv4.2 client running fstests.
>
> A kdevops fstests run against nfsd-next hangs at generic/086.  The
> client stops making progress and never recovers:
>
>   watchdog: BUG: soft lockup - CPU#3 stuck for 250s! [086:60396]
>   Comm: 086 Tainted: G  D  L  7.2.0-rc4
>     __pv_queued_spin_lock_slowpath
>     _raw_spin_lock
>     nfs4_xattr_set_listcache [nfsv4]
>     nfs4_xattr_discard_cache [nfsv4]
>     nfs4_xattr_cache_scan [nfsv4]
>     do_shrink_slab
>     drop_caches_sysctl_handler
>
> The D taint says something died earlier.  It did: by the time the
> lockup fires, the client has already taken two dozen NULL pointer
> dereferences, all of them in the same place:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: _copy_from_pages+0x44/0xd0 [sunrpc]
>     nfs4_xattr_cache_list [nfsv4]
>     nfs4_listxattr [nfsv4]
>     vfs_listxattr
>     __x64_sys_listxattr
>
> The two stages are connected.  nfs4_listxattr() declares its
> remaining-size accumulator as an unsigned size_t.  On a size query,
> where listxattr(2) passes a NULL buffer and a length of zero,
> xattr_list_one() decrements that accumulator for the SELinux label
> without regard to the NULL buffer, so it wraps to a very large
> value.  nfs4_xattr_cache_list() then sees a NULL buffer paired with
> a buffer length large enough to pass its own bounds check, and
> copies into it.  The fault happens while the xattr listcache
> spinlock is held.  Task exit does not release spinlocks, so the
> lock is orphaned, and the next shrinker pass spins on it until the
> watchdog fires.
>
> The reproducer is a plain getfattr on a file on an NFSv4.2 mount
> with SELinux enforcing, which is what fstests generic/086 arrives
> at by way of a drop_caches write.  No fstests machinery is needed
> to see the oops.
>
> An audit of the listxattr path pointed here, so I built nfsd-next
> with this commit reverted and reran the full fstests nfs_v42
> section on the same pair of guests.  745 tests, no soft lockup, no
> oops, and generic/086 passes.  The two failures that remain,
> generic/033 and generic/258, are unrelated to xattrs.
>
> I am not proposing the revert as the fix.  Achilles Gaikwad has
> already posted a targeted patch for the accounting itself:
>
>   https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaikwa=
d@gmail.com/
>
> Whether the right answer is that patch, a change to
> xattr_list_one() so it leaves the remaining size alone when the
> buffer is NULL, or hardening nfs4_xattr_cache_list() against a NULL
> buffer, is for the three of you to settle.  I am reporting the
> severity, because the accounting bug is not confined to a short
> size query: on a filesystem that caches xattrs behind a lock, it
> takes the whole machine down.
>
> I can test whatever you settle on against the same setup.

I reviewed Achilles's patch back in early July and it looked okay to
me (see my tag in my email in that thread from July 7th).  I had
figured that the NFS folks would have wanted to pull that via the NFS
tree since it only touches NFS code.  If they would prefer I send it
up to Linus via the LSM tree I can do that, but I would appreciate an
ACK and Tested-by from someone on the NFS side.

While I don't suspect it will be very interesting, I just started
building a test kernel with Achilles's patch that I'll run through the
normal selinux-testsuite automated testing.

--=20
paul-moore.com
