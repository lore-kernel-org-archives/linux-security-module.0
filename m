Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475864;
	b=piQJITPqrMzVfmiX4iY7bA/f7X01XrNHlqAJgn8VI+RwJFY2dE1EjRYyqutZBFyecnGy
	 svzJGRzSLgeEfz5rrWrV3oQ+ZjbDGf+rStbxdEvEkBaKwGqqFJTtvQWQIE29tyqKjmtGv
	 fQ7i5GN7xFw5p285WFiJuAe2DLAi4p/TIb9DQaZTFBQI49MwXBSATU0qq3f6cA59JRVvJ
	 od1AaCRIEvXTGpAChAFEjTdWqoK09FuxhEEL4EFvPY/z2+kzSq6c5/NIMkWJyTF5nZqfC
	 7HFpv7pyc6zXf2bAD76Jz/Q82QuOmR5Y12GwodamRc56kwb6AgLwzdW+OC49pvaiakg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
	b=XwylJHJnHQigq2FT7CBcsVmR6N8F6I61/r71JdW8e956JzAWNqZ45DGovDzObyUfDdev
	 JCJpKkXy/FXXgdoLorv0USwJ1ckZcmrUlIS3g5/7K9Fv1WvG+GcNtrH2LRr0FcgEHcgoy
	 S4KF0bFdQGX9s4jGlC6WjZ53WpWNATCIjB/cvAEK84J6cx8A8m/Bd4NRKhIBDoC+xqXrT
	 I2bajCse9G/yW4c2cZpprqhe9EhqRmWbsaOGVtsNgQPNuCMfGFH1AaWAORHDBqwl5UJd8
	 5FV/PXsH7PKr80Rf0rsIVWSXCaErXjgaQvn0GhkD3drTco7VX8g40oW6je/8WcR/cNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227A606A326
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 23:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9227A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1600215a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 15:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475863; cv=none;
        d=google.com; s=arc-20260327;
        b=edDBM/f4APW+6wygdVl1SWqjG4brFNpTHIUB7Ok8ygx4JCv+DYoSwTFFaC4ZSj2a8T
         +NEo7v297f9cXGDL55/qCAfKhe7EyigtqRrVKpljiq269fz5mFKPgdRhQ6cvgboyzmhn
         ISGv3j3A+JLCR1xdj9XsBMpOMuVWuoudGgshQaKl4NmeadZBc3O73M5pcAP2LtZ7+TOE
         mKZ3CYtGoUD2rEwtkDRHDNMtMUGIqsGzGV9Ixa0GQloPzf/SmvzyVo8F469hvD0N/Q+g
         96DHYm5kwMLumKxFNV2Jpq6rWqcJgceCT9rUDzgFMfw9LA/mJM1DabEIhJq8m/EkCOjS
         OnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        fh=J8RDtRadtUywOokuMwSoBPHACSnLWmrQ9lk5nWOpuqs=;
        b=JM1GM59VMRMllo+9BeMFCVKZxGsNsQwdp7AEDXTzu4WMsVT/fvbIa/3QQiEVfrzzgG
         xhnLxlluOeqfvqrBXrO+uXHjAPqOS7sxfw760nL6D65RLb9yiARBJBhychphDgjTAwNP
         pMcjSIWTSoxodQBohKQ1lrxRn9bLF237nuAWW8Ka2Ug1XixWIPb0zKzrKcH70i+eZXw0
         9VTqUEtQZ3n6Kx4rDN7o8fC0xtoM+DKQIHG3EOwtlCRmfIfNPT1h277JEwGvTvL+q9Pu
         tGz/NUNBRfO5gtHWGnipOSLHIh9D0p4BREuVTppeGVxoeRJo4D7tOWSqF9u3EweA6ocn
         kJJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475863; x=1796080663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=f2URxq+PdSANt2DyfE/LnSY1XFoTYnOosj5xEXQkbA7SxI6W4QwU0HmSJshejcTWky
         S0FQGoGeqWv/V4cetnAuhQG9AIsuiihN0orRNBCn6WjeSaid26HA+lT6VUTjWcBQSD62
         qbB1PFXofdfinS7Mln/088yRU9CiCBNNcCiudlFZlzwG2Ibxhw2O3aFEMNMwREoEyrb7
         CsDxG2c54h+p3PHCJY7OlHB3qiqGkyYxICHT/g7CCS/5/T31+MIRFHRPhTmhfz3hmzG1
         Fon7afxI8wozcjBzuTy7rCmabVdtDYIth244kS2420jGicRJ8THCQhWgSfEHI5cYMGye
         12ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475863; x=1796080663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=DoTVlUtACL+DXHFXrR17snAClvbXPuRMgCQu96O7dN3jTzMNoKgnsdBL3YSZQP3WDm
         33sXLvbqUcsXHoJUmQ2cbPfYiX8DuwKPLbQu4cMMTMhmvYEdfLDewSa2wn8axckVatSL
         W589b8GN3e0j9Y2EJcqkupdzK/ahF6yOoyAqt2POeucUNCuAsXzOT/D87XCKox2EXCSG
         D8+WwAD4Jd804gSbjTeoV5MY6h0VUSkBK2mazosF0cHcbaGpuxJD08LPIHr/AHJRmN+S
         scoK8yh6d9p5+gK45G+cMGlgYMLEOpcvz6Rcs/OkmO+P5ZzMzCtVGY0TqldKMtaRtPnS
         NgLg==
X-Gm-Message-State: APuU4Z/siYJkoeFdWEz9HtP+GEL6dJAyN3zyw5znBFo0WEGYfqCrskxo
	RU+hCYtGDGMNMGYyfJ652ZwxvwpsNnViJQfG9yiX8o5usmEuyzCYKRH1iRjVhJPOHKOEcVIqUlc
	UUZQP4Hu35e8Z3ib3FzEMDF5ANA8y82TEAjhsQG03c43CKz+fM4c=
X-Gm-Gg: AZFdTZfgoJaFH4BLbWJvCD6wkD8GIiqT8TIvlnFe2fuqeW9qUts4Gk+3YYcjKcflk0X
	iBQNFsBARfAykZTzevf+sMvAe73lDciYEEdrshGqFQ81ttH0MndV25R14Xnub5ZJt6GHHBuQhdQ
	dvGfZIDBh3DAMNGgN95C71l5lsfjR7bjlg6rcx3oZYpwukIF2HpkQ8tG68KkRgvUsSZuF+T1Z9W
	rtOltI0/810PhZzrYB8uayjPPXUnguQUVLgyIZ2Kq1Ubm7h/xYyQ99AyfJEOrQuqPQvJoVmBu8F
	y8jCqdU8iYr7TMCKs1d10tHCUppZOe0jDp1RaHmiIMHuUGNYZUopUIxIJH0sLqCu+eUETeXbx1W
	/7q7qdDMhhSm/rg1uLb9jAtLSVbnX9u4uDeZEbkuKMOEqlO/Pxx/eFyGszr0GGTiRvzyvug==
X-Received: by 2002:a17:90b:380f:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3b41cb0cae0mr10882903a91.51.1795475862780; Mon, 23 Nov 2026
 15:17:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
 <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
In-Reply-To: <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:17:31 -0500
X-Gm-Features: Aa3M54o74z8pn5Pvit6S16im7-Wxu2Y0a6J5-TPpee1sYBnPKi6ZczEefWRjtvE
Message-ID: <CAHC9VhT78Ktssi1gLWTKPC6KEgg9npeTf+2-vjwANeAbPoSC5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: always call the namespace_free hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 29, 2026 sashiko-bot@kernel.org wrote:
> >
> > security_namespace_free() returns early if ns->ns_security is NULL and
> > skips the namespace_free hook. But ns->ns_security is only allocated if
> > an LSM requests a namespace blob via lbs_ns and currently no LSM does.
> > So the namespace_free hook is never called at all.
> >
> > Landlock only uses namespace_init and namespace_install so it doesn't
> > care. But the bpf LSM attaches to every hook and a program attached to
> > namespace_free never runs. We want to use it in systemd-nsresourced to
> > get notified when a user namespace goes away. Right now it has to kprob=
e
> > retire_userns_sysctls() for that.
> >
> > Note that a bpf program can't work around this. The size of the
> > namespace blob is fixed at boot and the bpf LSM doesn't request one.
> > And security_namespace_init() allocates the blob before the
> > namespace_init hooks are called anyway.
> >
> > The check isn't needed. __ns_common_free() is only ever called after
> > __ns_common_init() succeeded and security_namespace_init() only calls
> > security_namespace_free() after the blob has been allocated. So if an
> > LSM requests a namespace blob it is always there when the hook runs.
> > Call the hook unconditionally like security_sb_free(),
> > security_file_free() and security_bpf_map_free() do.
> >
> > The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
> > stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
> > prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:
> >
> >   bpftrace -e 'fentry:bpf_lsm_namespace_init { @init =3D count(); }
> >                fentry:bpf_lsm_namespace_free { @free =3D count(); }' &
> >   for i in $(seq 100); do unshare -Uu true; done
> >
> >   before: @init: 200 @free: 0
> >   after:  @init: 200 @free: 200
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Cc: stable@kernel.org # mainline only
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  security/security.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> I just merged this into the lsm/topic-7.5-02-lsm_ns_free_change branch
> with a corrected subject line (namespace_free is the callback to
> security_namespace_free()) and the stable tag removed; both changes are
> annotated in the metadata section.  I'll be pushing that branch up to
> kernel.org shortly.

[Side note: my apologies, my script got confused by the sashiko review
and only replied to sashiko and the LSM list; adding back the original
To/CC list]

--=20
paul-moore.com
