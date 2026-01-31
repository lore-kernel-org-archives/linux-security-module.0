Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F932B99F
	for <linux-security-module@vger.kernel.org>; Sat, 31 Jan 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854953; cv=pass; b=NsdIOxlFezPn0LdJvNO/Y0g0LMTHVVhqs8PuCWNP5xP0KZ7WJlqLJPCxsVTB6/mOedsYo5STW9eghP4d3dAL1jGa01dAT5PgOvUy5g4uOfH5wDVNun58rr6L97jQrJOh7+++u7h1Np0aXCtH1aE84onZA+VXIwB0F+4X14X5NQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854953; c=relaxed/simple;
	bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOyKnTFt5QNed8VXQw3yTkfivn+At/w8Cz2OCGxUV05JsZpF9u8ReOTLsBw9vodLqqkM+hUTHyC4VsmZ+NQG9j1bh/KubFfvZ1LPvKRrmEJnxEhEQ+gxuq9x+DyEzzxKZyQe0aLdA5mn4dA61JG0K9I/mprg2BkidboyiiRdz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfIBMRn; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfIBMRn"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so5799391a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 31 Jan 2026 02:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769854950; cv=none;
        d=google.com; s=arc-20240605;
        b=VmD5BDMydKzqp6NykR8sRQWU6bD1kUTUfpPgoLFU2ckculaTCtpRlb6z9kS73D1Zhg
         BVy+TiCH0cvJyqHylryVGbmANKbsuLnXQ0JTgfXCs/Onst83xT4hS1+wWMPvgySXg+MK
         PDS5z82MrCkNL8yk9GGiBjThPIvGeEOPLtxeFN2IE+zpcD2Xb3xhkXAMVQv8IQRJqOph
         vb7GDg+mJYtcQlelGJ8USLBBX7ZL0N4OtllK0uly1lYJs4g68iM+58c3i21Ti9PyW5J7
         qFqBYBhVSPn9Vy6Ps6U29djvo0IWgDzw0GwY/lvfPEGcynx8gD3POCgzIK6R3Cep3DRP
         zxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        fh=tu2JRCJHTvKA6stDEdspeqbiBH3sEJv3xq3mWxqpLCo=;
        b=N43EA92nTAF0d35eftD4N/D5GNCpgIRCUl5PhEnVCBuGwU1PB4PH7ZTQ7Jfh9NRd9w
         cGmEc7dIzYi5IZ/oYvpxUoul5Z+ZsRx5glhc7tLkf/K1z3aOSVX0T22Un1N21ybDeW9h
         7h6HiVNTr9bmruE7PazSTYsefq8Pw+8tsb+KyK2pAmrky+Ke7QgJp3b3+lMi8cCTcwAk
         WeFI6mFxuHVIJ1WzIIjcFdiL3qGflGDigrpGKPUCiOUvAIqhfcq1TZiMoFtFs+QTx0RN
         m/6EoIxnbYSy5mtkS7mPOsejvDQvO9/nwId20ScfgxHVDV3T5xbtd1/TpZABWZ4xQVwn
         gbuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769854950; x=1770459750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        b=iGfIBMRnH7Gv9C7JGDzZjOlHDgMv60hNIFmw0+QIXRVzM7SKUTps1f560iBkOWzFat
         H5w+wl7KDxwD0tG322MUxCsclAiTZP2uA8lIi3quR9Zi/En7F8/MMhFaG8HQWXSbpVJn
         wa6P2GwmCAtUmwH0W6D0u0Kj8Tert+BP1Plv55xmvT6b5/9hvyVRoSzSRjE+HqInNn7u
         Eg+9zFCNKM08fKBnV56xXR6rqqy0ijG5M/Z2FeIS358PE5AP3c3xE0JwwJMVCGYcBYel
         Jxs4oDIFzxfHplRXxSUAyJm7/II/SrX0xEum3A5D4NWoD+iXcyVU+Ex5OUEAAOrF5hZy
         dLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769854950; x=1770459750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        b=Af7PovrJ2BqOt2N/aboimHXsQjzCo56ziVC2F2o/68d+XlmplbOOv1RbUbj52ljCQr
         N64/7ZNnZXiCrWwPHEzB7f+M5YLsmuZa2fwn8leCy0Fk5BCymDpnFFwZWQ91MtpiFCn9
         0BqDFBG/7GIePhILwmzIKL1HL87cwU5hX1/9VwW3d1oOyi13hFgpGj1IVSaDQlolRuMd
         6qyJtZdJj/TEmJckODELiZK8UfFvxk/IjPzWZ5MUOy4aETr0RQaXztaH6a+2h/rZnxcJ
         1Wc5Vbq0S1rVaMOS7CkVZa9H5Ka+3p57CcZIKTfxJm3QEvfFrgoJEHkEuWXarDZd5Q65
         kT9Q==
X-Gm-Message-State: AOJu0YxlnE1yWSt5OdHBG7LX/4oPi1933nyX3sfXIur+q+/aTVP/Xo8t
	3RNWgv/3+ZKW/tzt2Let8kCZT4NFWNY0zMKnaB5/0du7EKDGMUIVf+wopJVwqjk7TSioufzIuTd
	1ihfJPx/dUiu2gUABki6aSAqeoyq6JUYClzlrIuo=
X-Gm-Gg: AZuq6aJ2Cc2KZ0PtmZ+awHlIR4c2O/Jye/dOjJiN6BqMn5b93MNP+AHC1BAqzKYIUN9
	EO/tQrQgeyZqYdT7kKBSaO8CeUTlFXrYbtqKV571NaP9g80S1/LM9e9pNvSi/L9Tg5tvfkiYiMs
	paboTRtNSijtzTvIHmbJrb5I7Xyoe1j/cV7XLJ86uSaZuMVEjy/iZuNOdIV9qZEQZRn9M/q6QTp
	pH5mwcsIKSJ4RSF1B7xg7XTfPkZObBfgUR12XI6PWqEOWrHHqk10JFPVsCXo55WxNoiRPr9Gppb
	krn4o0WZBEscfcH2nMJGYnczyxhO
X-Received: by 2002:a05:6402:3483:b0:64b:8d7a:71cf with SMTP id
 4fb4d7f45d1cf-658de5a0ce3mr3157686a12.26.1769854949593; Sat, 31 Jan 2026
 02:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130001418.18414-1-wufan@kernel.org> <CAOQ4uxhf6EQKcoN055xzmi-RW2GPxRzz_ExsQawGQBSmoX2WYg@mail.gmail.com>
 <CAKtyLkG1_evj7=yrB6nH-8fJuP3DsWyxwrhv7O_Mk=Fy8FOvVw@mail.gmail.com>
In-Reply-To: <CAKtyLkG1_evj7=yrB6nH-8fJuP3DsWyxwrhv7O_Mk=Fy8FOvVw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Jan 2026 11:22:18 +0100
X-Gm-Features: AZwV_QhOhPDOYt2J1lFISrx3c1dHs0q3o3EvwGFAflm_-U4v5NyUzpUKw-giy8A
Message-ID: <CAOQ4uxjndETYhGayZH_opeMxH1zadW5G0DUHfdiGt=i+pM26ow@mail.gmail.com>
Subject: Re: [PATCH] ipe: document AT_EXECVE_CHECK TOCTOU issue on OverlayFS
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, mic@digikod.net, 
	miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+CC fsdevel]

On Fri, Jan 30, 2026 at 8:21=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>
> On Fri, Jan 30, 2026 at 3:06=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Fri, Jan 30, 2026 at 1:14=E2=80=AFAM <wufan@kernel.org> wrote:
> > >
> > > From: Fan Wu <wufan@kernel.org>
> > >
> > > Document a known TOCTOU (time-of-check to time-of-use) issue when usi=
ng
> > > AT_EXECVE_CHECK with read() on OverlayFS.
> >
> > Hi Fan Wu,
> >
> > TBH, I don't like the way that this problem is being framed.
> > IIUC, the problem is using IPE on a non-read-only fs.
> > Is that correct?
> >
> > That fact that IPE metadata is usually coupled with read-only fs
> > is interesting for the understanding of the use case, but unless
> > IPE feature mandates read-only fs, this is a generic problem.
> >
> > OverlayFS is just one private case, which happens to be common
> > in Android or containers? IDK, you did not mention this.
> >
> > Please describe the problem as a generic problem and give
> > overlayfs as an example, preferable with references to the
> > real world use cases.
> >
> > If I misunderstood, please explain why this problem is exclusive
> > to overlayfs.
> >
> > Thanks,
> > Amir.
> >
>
> Hi Amir,
>
> Thanks for the review. That's exactly why we CC'd you and the
> overlayfs folks, we wanted to get your perspective before documenting
> this.
>
> Let me give some background. IPE enforces execution policy based on
> file integrity properties, primarily dm-verity and fs-verity. These
> are the trust anchors, and files without these protections won't be
> trusted by IPE. Since dm-verity and fs-verity are inherently
> read-only, in typical deployments the TOCTOU issue doesn't exist. To
> support overlayfs, IPE uses d_real_inode() to look through the overlay
> and get the real inode from the lower layer.
>
> Recently a new feature AT_EXECVE_CHECK was introduced to allow script
> interpreters to request LSM checks on script files before execution.
> The idea is: interpreter opens the script, calls execveat() with
> AT_EXECVE_CHECK to verify the file passes security policy, then reads
> and executes the content.
>
> What we found is that on overlayfs with a dm-verity lower layer and
> writable upper layer, when a script file only exists in the lower
> layer, AT_EXECVE_CHECK passes because IPE sees it's dm-verity
> protected. But if another process writes to the same path after
> execveat() returns, copy-up happens and subsequent read() from the
> original fd returns content from the upper layer. We verified this
> through testing.

I don't understand how this is different from any AT_EXECVE_CHECK
TOCTOU race on a writable filesystem, regardless of IPE.
It seems to me that it is the user calling AT_EXECVE_CHECK who
is responsible for verifying after reading that file has not changed and if
it has changed, then the AT_EXECVE_CHECK could be invalidated
(depending on policy).

Maybe multi-grain ctime could provide a safe cache invalidating check?
As long as the filesystem is trusted to report true MG ctime.
See below regarding overlayfs...

>
> Overlayfs is popular in container environments, so we want to document
> this for IPE users.
>
> We noticed the overlayfs documentation
> (https://docs.kernel.org/filesystems/overlayfs.html#non-standard-behavior=
)
> states that if a lower layer file is opened and memory mapped,
> subsequent changes are not reflected in the memory mapping. We also
> verified this: mmap keeps the original lower layer content after
> copy-up. One reason we CC'd you is to ask: is relying on mmap to keep
> the original lower file reference a reasonable choice? Or would you
> recommend against depending on this behavior?

I recommend against depending on this behavior.
Please do not document this as a solution.

It sounds like you are documenting a recipe for how to write a safe
interpreter?

The advice to mount overlayfs read only seems impractical to 90%
of the container users which use overlayfs specifically to add writability
over a read only image.

If the generic ctime check is not considered reliable enough for checking
if a file was modified and copied up, what about checking the
STATX_ATTR_VERITY flag of the file?

ovl_getattr() reports the STATX_ flags from the "upper most" inode
and then merges some specific fields from lower layers.

I think that would mean that in the use case to describe, a copy up
would result in STATX_ATTR_VERITY going away when doing
fstat() after a copy up.

If this works, better document it as a good solution.

>
> The narrative in the patch can definitely be adjusted. Would something
> like this work better:
>
> "When using AT_EXECVE_CHECK on overlayfs, if the lower layer is
> integrity-protected but the upper layer is writable, a copy-up between
> the check and read() may cause the interpreter to read unverified
> content."

Sounds fine to me, as long as it is clear that overlayfs is just
a private case of the AT_EXECVE_CHECK TOCOU race.

Thanks,
Amir.
