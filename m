Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34912328B5B
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599633; cv=none; b=pnu1Deza3P6k3Ld+17OO1EZRzkVwUy8LHF0vDpPmaGYPiF9j3CHyyOVW245yR86pTvldvj7zZqtquQ7iHOwHZvCZqk0RpQ+F+HpGA3Qu0g8GFLxg05E6t02B6b54ub3O8yczgSEAdjbQIK3JkUp93fEiDJHJP5Sg/TrEAQN1fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599633; c=relaxed/simple;
	bh=4EweoHeGLGjUekzAwEp/mlNRn2hhfYJFvwlGhd4n4o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4PBRQwlUMvXbPOy/Z0qllAiraBJ1yycIkfQJfFjQX9KAouqhbEJCvaMXTqxrLKXW+2blsxQVjJtqGdQh1b1Uya8517WV0ET/kjPgHGWJpv1cYroORAkmLsFWbuFzX0QXiwkd9vr/l+bfu41NbSGYQ8Kkc6sCj5wbffphHg/oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RMgmYanv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RMgmYanv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so3751391a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761599630; x=1762204430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jrVXvo1sxS+kkD4SiBb2KgPCsJAsQQlPep2kWwdt0Y=;
        b=RMgmYanvHEyCPMxFVECnC+ybax57zDdptmZCtkTu9ss7NzCCmSHn48dtPY1CkmI3lO
         OH8snjWMadQQWTN5ICUm0Yx7lI3p7Aq5+O4DppWrEoKOMzt2UmimOu91kHCNX/Dwf79L
         Ei1fjLIqd8DWj83fkGjNFArKXHr50NfvPuWeEkxOa4xf2NGqyH2s9moSymaPwcmwA5mc
         TBry2k11ac7rG9C+SkqOezYe4v4LAMMNQjCyMFzHk34i6HCouAnrmd4Dyf8ZptvFEPGy
         SAMZ0vZpmJck9Sx8IOMrD6G1XwcFAwZrVp6sbequUTXVIgaIFocE/doEvYDb6J2VL+HM
         4GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599630; x=1762204430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jrVXvo1sxS+kkD4SiBb2KgPCsJAsQQlPep2kWwdt0Y=;
        b=RJy/sAh/2UfhOhtaDZ8MNGyyu3GT0tjx0cJpENSGEHWJetoAgmTQBd0OMgrABJEWyQ
         bs18lRrvgSfOdtH87Zt8qSZ/kjfchqnNiX3lXMl8d6NYQ0EkUSCXSLGSHsW8zGs7kmKb
         g8GqFxSxTpiXIIMFAa9YzAfau2jDeImnGVpmcwzpy9tvCp5asGSMwdo9c6ZFYthCE2P9
         ax2ZfUhN96dLG6FNta10yF6QQ2RDCDxeZ68dRp36TBjiAojR1A7Q0rXU2g5rHSS5Gjd7
         ugokmRxZuAkunWnO/A8e6p69hREfxlPQ75GLj08AH49+6jner7q1azKV7SXALsdxMouB
         OwNg==
X-Forwarded-Encrypted: i=1; AJvYcCUCAtrWrtUPHsZUtpYlg3MJxCzhRd6iORZWxPj4IsPQTFzYaSCkhUB/xgM9O+baJT6o4919GeWiTisdMd4SAV0hEoKyXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxPOvv1f9IF1W5BwoZnmuJ+8ZuN8mCn37FHIQbpjAykveXUiT
	l5pMOr3RhDJB3yYI826ipWX20xrFFmiM19Vd1//CCvhUGiglFeMpDrPWAv1dgS0X4OOPceTRTut
	SMpD0BSKo//Eg+gVL3BIo4n2U8phQOUnOhs8Y0Oyi
X-Gm-Gg: ASbGncsFqeH3yeDUGqTXoeWUcUl8pat2kkYSErkuhvRmISqmTiZ5jRMYM70gNKcvMe1
	zU9xusep5/p5QrVLTI4C0Jq0WL433wyYhschHbgTNU1SoyxK12AAg1YL8gHnFwnXXR8o7AT4yjo
	9EdHeqhztDyHdhJScQ/0Yo3ak88bRM6v2Xc6Y56Xq36lf8AKxX8mV1Z7ner1RlWnYBfm/LgaW17
	9WmFtHVEdQ+nIHftM98gDEPpLr8PwHlKYD+7YMvpUthsV56MRVYucjsWtjVzWKnR5Wo2e+iQUG4
	3sZ1Yg==
X-Google-Smtp-Source: AGHT+IEwaQ9u7CDQcWu0C61kO6NbEn+57lxKy7x1+QqIy435OFjjlqJSAAMqjBFL4hOzhA13sQ/5CCGEn1QvdUhFskA=
X-Received: by 2002:a17:903:32c9:b0:267:44e6:11b3 with SMTP id
 d9443c01a7336-294cb500981mr13977335ad.45.1761599630068; Mon, 27 Oct 2025
 14:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org>
In-Reply-To: <20251025001022.1707437-1-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Oct 2025 17:13:38 -0400
X-Gm-Features: AWmQ_bmI3jMDm7ZEMCwy3hCYNaQKhc6ZPkcP0O-rsrnQwkrNmYQ0qY0p4ovzgaI
Message-ID: <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> lsm_prop_bpf is not used in any code. Remove it.
>
> Signed-off-by: Song Liu <song@kernel.org>
>
> ---
>
> Or did I miss any user of it?
> ---
>  include/linux/lsm/bpf.h  | 16 ----------------
>  include/linux/security.h |  2 --
>  2 files changed, 18 deletions(-)
>  delete mode 100644 include/linux/lsm/bpf.h

You probably didn't miss any direct reference to lsm_prop_bpf, but the
data type you really should look for when deciding on this is
lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
struct instead of secid tokens, and without a lsm_prop_bpf
struct/field in the lsm_prop struct a BPF LSM will be limited compared
to other LSMs.  Perhaps that limitation is okay, but it is something
that should be discussed; I see you've added KP to the To/CC line, I
would want to see an ACK from him before I merge anything removing
lsm_prop_bpf.

I haven't checked to see if the LSM hooks associated with a lsm_prop
struct are currently allowed for a BPF LSM, but I would expect a patch
removing the lsm_prop_bpf struct/field to also disable those LSM hooks
for BPF LSM use.

--=20
paul-moore.com
