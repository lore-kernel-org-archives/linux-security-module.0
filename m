Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8B3DAACF
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923278; cv=pass; b=DaSnZMyHGXYG9F0ZNbqbDoPdvrh4xz5zBmeOmhPghIUq2PLiaAUlWdiMq51rJXjyq5GEIsdcWlBWSTANJlmrFXTmsA0su4CNqbjMjBKUA6jCmV9Ye3wqyErPopJY7Hj/7MrSx30QhzBv1AOgxSTqL+PjirfCIoAjLHBVMZ6GZXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923278; c=relaxed/simple;
	bh=5BzWTvTEODadIF56TEz3lyokV3iJPu75tta+h2QbYzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kksQJBfXRmdLUzfwKOFS74lq2CWel3n7PC2OzwZtI0C4ZKj1yFUMu3sw2cp++eSr2CWFDmuAAK9ThrT8nENMYpMeSmHYkUCQ31AnpnSGTYkOiRc3cEe7q9Zk18GxzsR+qz6PKOQuLc6zah1hdaG3lNTE/p8/dWQ12pjs8jI7LYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t40N7rN8; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t40N7rN8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d3b445a84fso94075ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 06:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787923276; cv=none;
        d=google.com; s=arc-20260327;
        b=JAohp5a8h1a1MNmzh9OuIrEpVESmVlDxpPZjsCGUZ8rPbqcScEnCI0XdgoXgzGdYFH
         KvvRElkmfk04sgXw7QenEVEHtpWp1W3YYpmgNUIW6tMsis211feqYolmVHLhyNO2XX+c
         p82/1CByvA3l6OB0qRPDQfmk9Q9G+/qbiszWXLElRerhczzgHuH6k5wTGeyPtcmU9OQ7
         W1/SjRhiJa/IKi06aQK8arIaUFYj9Mkcs2zCyuPhbzs923YORN+tG/hclY1N8DNnVm7O
         SXyZ1CQ0cbtj1x39/cmS6jozd4ocfq1EGr9ODF7fDbgYIYinkUveoNzYUm3s3Oz/ADAQ
         icfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        fh=QJBrIBQcIt5xGlgV4RBobzNsm0IUB0uxp86v4sPAfq8=;
        b=aKFEKPxrG/tP3Mu/hJQxl5XAkQlIecdhhQx7sDEIMDNfDlnbaWYTKFsvGQjBZmOIv2
         qpkJtxsC7nrJV8KxDw8wOjESyONoh8t0Q+C76MD87XlyJpYjk8JbHGQlMz2J6B6gbLOt
         0h+zzo07ukGKRfSiH7ys+AVTdDoKwZ7ByxcQdT2vVbXWBOVqDf3p2IaOoIwCiYERfGhg
         KK7RzXQQH0TbvtFuu18jK8grc3T9T9Klu45twpBpY9VlpsoQQiDD5Hp/cgB/C66yEhVV
         z1Qg8pHuV9yyrCBiO3xNCDPgTxIQdzKNI0wbnCeNOFAWZChPAFVVORXcRvmLPW3WoMiB
         jAWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787923276; x=1788528076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        b=t40N7rN8XJSRScvkqe0e98xgccDBcGcUWgc7Cj4HBKEL44sPdsOFqJ8qPbUkP4/uo9
         IsyLSVx8mkN8ChMd0M72M6PfFDkEVBkD82/+Pfmv/auq7qjv8GNk1MR5K8DGE8bd7hoh
         JH48/8IQL8oUHvDiWs3q2tNzIHo50KblaVvpaXZ/0eew8cl8d8c85FOH3fOu8qgfFvaV
         4IBzLUxYnnY9cq46Y++W5GnuR+FxFD8MYtKN0T8EDRJAgaz9jTD7wWRljOutCRpjkj+v
         2D6X8x1F4WujtWCnuCaYXotHT+mSGXlbiLdvEtakky7KzJH+9OcLatIAo1qEGacnAOdi
         kJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787923276; x=1788528076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        b=boqPFnivU5bpFqSQDt2QMjRr8zSdvHUz2WdQ9OMafAfKy7MXfItEBjl0c/tI3H0vAX
         pW8LOqZ0yxVPay4DK1Allr4zdNNdAw9b//dRK6TNRkluib3BMTmn+CvR+VeOIX8tM4jO
         U6TXuHOKFQxMZTeM3Us9SIf4OS2bFgRdMEWjdWKFg92WLorSyUMulrsgiIQT7ekjDf5/
         S3PVtj1hDJy+rVj/MZV15ZfNTpEGjhARccMN/fisxNWugF5PAPk1n0dSwZK3iJomNwv+
         s9iVPJRtXymljNFjuFKDbJfjl0HUR/jq1RT3bcNyI9AjgjTF/J19tkID8CBvbaV4+rtr
         ezqw==
X-Forwarded-Encrypted: i=1; AHgh+RquIRTh/IwtiDaBU6GlLbkwjmBpkCiZ9dGWytopacSe15wOm0pI+hmF7WLzDZxGHVqbAELUDiQI3qsPGTyxl+RICIcNGcI=@vger.kernel.org
X-Gm-Message-State: AFuF++mWiOXFNrg2umB68NGxe9PLuL8q9u+/KpPnODwdbPI7Jb4PIGom
	E8ZrBuJj3I2B48LyVLgl3W931SP/5clcBZsrExf99K2eFq+vWcjkpxg3wF1HORdATLd7CiSY1PY
	vQpPocPV4Gaq5y1AjI/48jEssrRnjbt2GhtjhCJSM
X-Gm-Gg: AR+sD11LVg0RbSYeaw2m5N4MOWWJRsv70isP68Lq9sLt/rkcZn8FsvtpFF7kJoEiODW
	gpB0sksOsoTbwJZ9LXLIwVUVuDfTgJOtars78stRUxPYxt75xM6YAZ2nEATA3xXHzyGnaunIepA
	+jocOWWs5Bu1KPMLxUjBDCUqxkdceFXy6+lGLRw7LsJewLSYfNw5W17+Vby4U0XvadpZ3CZ7vXz
	ELEpwDC+hKaq+t+s66dyOu0aXhxjcydM2870wajhHUQRc6+brvO2lZtwpd/BfaCivukflrWpc7N
	++ilZBoOBbGO4riJPtYhSEUAjYqooJedeHQwdQIHMSEuTpKMS5T6ptosB6KaGMSKZ2ylBWNbFrr
	Zwd2EIyn1XinVJj4Mj99jCx8163qXug==
X-Received: by 2002:a17:903:b48:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2d74f403213mr6682285ad.4.1787923275276; Fri, 28 Aug 2026
 06:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
In-Reply-To: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:20:37 +0200
X-Gm-Features: AcwNN1X1_-cZAxs-C_zVg9dDOHf5DCa4yCAEiND1xrtOkQ0sGqfzpyFhp0b8haE
Message-ID: <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:03=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > Beyond that, we really try to avoid making LSM hook calls conditional. =
 It
> > can limit what an LSM can enforce, it tends to be a bit more fragile, a=
nd
> > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > parameter to the LSM hook and calling the hook unconditionally in the
> > default switch case as a replacement for the 'return true;' statement. =
 I
> > understand it may seem a bit odd, but we try to make the LSM interface =
as
> > generic as possible with respect to different models and this is one wa=
y
>
> I guess I can do that, but then the question becomes, what other modes
> of using the LSM hook that don't currently exist in the kernel should
> I be supporting with this? I can make this a parameter, but any LSM
> policy that actually uses the parameter in a different way would
> probably be buggy/inconsistent, unless other new LSM hooks are added.
>
> If your intent is to make the hook work for any /proc/$pid/mem access,
> including when the caller is ptrace-attached, then I guess I have to
> move around the security hook call in proc_mem_foll_force() a little
> bit. I guess I'll do that in v3, though I really don't like trying to
> come up with a reasonable in-kernel API contract for a scenario that
> currently has zero users.

I started thinking about how to implement this, and an annoying aspect
about this is:

Currently, I only have to look at the credentials of the opener of the
file - that is both the subject and object of the access. But if I
want to provide a hook that works for any /proc/$pid/mem access, and
want the hook to know what the object of the access is, and do it
race-free, then I would need to grab the creds of the target task in
mm_access(), bubble them up into proc_mem_open() and mem_open() (which
will require touching all the callers of mm_access() and
proc_mem_open()), store them into mem_private there, then let
proc_mem_foll_force() extract the creds from there. All that would be
unused code.

Do you think I should just not provide credentials for the target, and
document "if opened_by_owner is true, the subject credentials are also
the object credentials; if opened_by_owner is false, you don't get to
know what the object is"?
