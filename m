Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0133D6CAF
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245183; cv=pass; b=t30NIl9w5i5fKcuqukl0d9WzaviGWVVRFVspMKqOs4Rl2B1Pfyv2ngWuKzemBdJzHCJP7ydHrLD46B9ELL5yJL8pUoeGDUyshAgotWpnOwtwKVxfg+nPJVk9I/tkfC/NkSh8ssmcaFIBeo+tIpuWE0/5Ki5GIjXBzyfHAUoF1i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245183; c=relaxed/simple;
	bh=NRIwXOg8AdkA9vHzfWMDu4X9liGp4DLxBb6tiCZpKA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhqVcw7fSkGtAgxuQMT1r0C3qfAYWcdX9hu+qBw02coPX0NOr2WdsAhAxSwJX1czDcqJX8OqqhzK90ASPnAuLwuHwVEFV2Y7FVjn+0OYUeCXc+lAaWn3b3FO4SzKbPGcyQReQFBYeEvNI9H99N4z7QJkv04zCi8JAxwe33HjRhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YxCC/j1v; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YxCC/j1v"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73c990a9cdso655097a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 09:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245181; cv=none;
        d=google.com; s=arc-20240605;
        b=cRwi170jUkQKTOiDjPhBD2AuQ9hK8Ihfoa+ol5Bu9G8Co2Km8nOrlftFF/QJBry9vD
         fP5Lxoft4yaytvMOPkPQx0/HLLPGqV4X3pTeuUCAWUt4xMpt/+Z4CCY9o2qu8Ax0Eh7d
         F1wCx9w2HcUQjtDt4U14Iw1z/2Ci3UCjX5gIAcl1qqwR+ag/VV4njZYB8UTn3GbjWLyS
         daVKzWrJu9nQDBv4dOp28fbuFF/i2E34rYOpvPTlgV0PGdIsynLN3IJG7A6XNH0pmzae
         kjMSrPp+mGzVGrew79olt6O8iq1ugeAmQ20wEZfIiLkYgaq0GHcZV+qqMgQi12sVwE+C
         6mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IVGW/WeQwHNutjLxB1wvk4R1nb3pkKjkp9meFG8IuI=;
        fh=hBOaSNFyzIZbGLfOsJfIfRrSnh+tJBqH0fCGsP9RE4w=;
        b=EO56etOSMj17UnbONfD16hO3x2q79wPqvsvmkswe/02VjvN1E5kB01iC9pUPUwSkHV
         j2Hp4AcF9ml2dvFSSOwxI5EXoS33+dYNh29S/hsZLE0JL5VMaTcb6LUfWFq7TnWQWH7z
         vpp+ZwMJeWwHJ9jArY44kGNjD040+fBSkjwHYtGGzeD/YK3Cflsl9dXA2/ft+SHsHnc/
         lJ2oWnf+ktwdmdvkMzyWlyRjsZhcuZPFzIi2o7WZb2c2yt6VgR+wFti0GwU+Snj4/jnQ
         iAUAjlzz5rpGSDhXqxFH3URo8eEqeeD7Qyym+5ShhbjRzEShNpuqlFQd6P8sY/MrNO7k
         O6sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773245181; x=1773849981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IVGW/WeQwHNutjLxB1wvk4R1nb3pkKjkp9meFG8IuI=;
        b=YxCC/j1vYioxU572cwyGrOT/92X1dSGFbi849nLb9rfnvCoQ4pB0LR2Mhrxw5UN3kE
         2H97ALjUFxPkVuP+Kgz1OZF1O2GD89UFazhf2qcVt35WQDseq4diF7rigq8t/VRVgvSW
         IH+l6vC6Z0im/LnIDxcucoV4YmCmaXCVpQ6BJyGUN4mCOsYgVX9NTtbW5I7HRGAYPYVj
         KNy5SpFaMVu3Dhih7rXTEZHLa4a7tAEprG9qUbCe/qLWli5JO4CYHbByuOwQshFJJtc1
         I0h2IldFHGyCHe1QuwqBURYX5s3cEh47N8rgdN5IvX9yzmVUcNxNZOx/w7YLWhWH3s01
         2QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245181; x=1773849981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6IVGW/WeQwHNutjLxB1wvk4R1nb3pkKjkp9meFG8IuI=;
        b=I7TKrnVngs80wxsPfWwXKCcbp8OpLJMGJ9hJD2cUk024cauWEXl5YESthEcqTy/Ddx
         3xNssiRB3QOBn87d90lQtwMtg0GxZDH5tEOOcEQeUSuGkPQYgxMOmybgzYP226NVTIk3
         aLcXOli7cULudqe+evhVjtQD/XO+DwoZwVl0x9ZNnM7ihMfYN3xXE6SBGJ8DPNrBcltD
         bsG1g3ks0XTLWLI1VNUm5loqeIlc6Mk6To0dszWRpTUQpjomZjkmyEIl08/QCmrg0L8F
         KVVOt29f1n4deQ0A19eq0YnDYGbgSFE2D1CCojWe+k4b0sm1uiH8hzhEPtoKlmBMgppW
         Crcg==
X-Forwarded-Encrypted: i=1; AJvYcCW4NOqNUyqyh0IMk6uF6vhceojihKvbZrqCy7hWYeVWEYjeGhviNFxBo0nNyF1gAwWn6OiezyzgkeknRH2uogEdzgd3ucQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsBuOlvbOmmSGtXw0ET2uME5EaFlyNU9GCqTx0VYJn1FmDk53
	/qKhw7B2PhNa6pCVbnWXAaUvyGtVlQk2P2GQLlHNZGLt7xuOtAYI7lzAzLlL7JsMERvH5aHDCfM
	FRPkdGWMvwYSDRUA33RAl5SY0ndAYsXnBgyHG3olb
X-Gm-Gg: ATEYQzxTXn9IXvW2JIlnAW7pwnq50/XHR76dHFVtenFgX9jP0yEWejck09bUkpy56Me
	E55+lc5y7Ua3BDSHQoZb4GjQH4Ko6HIHn7/3icevuVtBcsxSJJTQz7r3Od65sKk+2PTHS+TTKW9
	3OjfON3gnglJCRYBMglwFiG28/fqN6zHHBfp0UscuDxDVlDCapoSCOc3NNxiPv8fvw/PlnBGuoK
	23gkg6j0K5VNT3+FePZd2cfx7ngj7SUl9ddt3TXeLq/fIl12wybc83dP6e2HZxv+ubBDtPNlaaM
	kCPCZWZ5tylEW+FPuw==
X-Received: by 2002:a05:6a21:a0c:b0:398:b72a:94c1 with SMTP id
 adf61e73a8af0-398c5f56143mr2683555637.30.1773245181276; Wed, 11 Mar 2026
 09:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal> <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
 <20260310193000.GM12611@unreal> <CAHC9VhSh8A+yGHT_+BqFGaLNqsZDcaz_cuqf9A+neRQQ3PMY4A@mail.gmail.com>
 <20260311081955.GS12611@unreal>
In-Reply-To: <20260311081955.GS12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Mar 2026 12:06:09 -0400
X-Gm-Features: AaiRm52dAjakjLFCSom8AaXbODj-QE-Z4_Nd0uX58SslP9L9TO4kIsM6LJNK_sE
Message-ID: <CAHC9VhR0iuzYRpi3vPdKAbsOJ-DoMvWV-c7TXVcAmb3u8J4JwA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:20=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Tue, Mar 10, 2026 at 05:40:02PM -0400, Paul Moore wrote:
> > On Tue, Mar 10, 2026 at 3:30=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > > On Tue, Mar 10, 2026 at 02:24:40PM -0400, Paul Moore wrote:
> > > > On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > > On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > > > > > On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@ke=
rnel.org> wrote:
> > > > > > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > > > > > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leo=
n@kernel.org> wrote:
> > > >
> > > > ...
> > > >
> > > > > > > > Hi Leon,
> > > > > > > >
> > > > > > > > At the link below, you'll find guidance on submitting new L=
SM hooks.
> > > > > > > > Please take a look and let me know if you have any question=
s.
> > > > > > > >
> > > > > > > > https://github.com/LinuxSecurityModule/kernel/blob/main/REA=
DME.md#new-lsm-hooks
> > > > > > >
> > > > > > > I assume that you are referring to this part:
> > > > > >
> > > > > > I'm referring to all of the guidance, but yes, at the very leas=
t that
> > > > > > is something that I think we need to see in a future revision o=
f this
> > > > > > patchset.
> > > > > >
> > > > > > >  * New LSM hooks must demonstrate their usefulness by providi=
ng a meaningful
> > > > > > >    implementation for at least one in-kernel LSM. The goal is=
 to demonstrate
> > > > > > >    the purpose and expected semantics of the hooks. Out of tr=
ee kernel code,
> > > > > > >    and pass through implementations, such as the BPF LSM, are=
 not eligible
> > > > > > >    for LSM hook reference implementations.
> > > > > > >
> > > > > > > The point is that we are not inspecting a kernel call, but th=
e FW mailbox,
> > > > > > > which has very little meaning to the kernel. From the kernel'=
s perspective,
> > > > > > > all relevant checks have already been performed, but the exis=
ting capability
> > > > > > > granularity does not allow us to distinguish between FW_CMD1 =
and FW_CMD2.
> > > > > >
> > > > > > It might help if you could phrase this differently, as I'm not
> > > > > > entirely clear on your argument.  LSMs are not limited to enfor=
cing
> > > > > > access controls on requests the kernel understands (see the SEL=
inux
> > > > > > userspace object manager concept), and the idea of access contr=
ols
> > > > > > with greater granularity than capabilities is one of the main r=
easons
> > > > > > people look to LSMs for access control (SELinux, AppArmor, Smac=
k,
> > > > > > etc.).
> > > > >
> > > > > I should note that my understanding of LSM is limited, so some pa=
rts of my
> > > > > answers may be inaccurate.
> > > > >
> > > > > What I am referring to is a different level of granularity =E2=80=
=94 specifically,
> > > > > the internals of the firmware commands. In the proposed approach,=
 BPF
> > > > > programs would make decisions based on data passed through the ma=
ilbox.
> > > > > That mailbox format varies across vendors, and may even differ be=
tween
> > > > > firmware versions from the same vendor.
> > > >
> > > > That helps, thank you.
> > > >
> > > > > > > Here we propose a generic interface that can be applied to al=
l FWCTL
> > > > > > > devices without out-of-tree kernel code at all.
> > > > > >
> > > > > > I expected to see a patch implementing some meaningful support =
for
> > > > > > access controls using these hooks in one of the existing LSMs, =
I did
> > > > > > not see that in this patchset.
> > > > >
> > > > > In some cases, the mailbox is forwarded from user space unchanged=
, but
> > > > > in others the kernel modifies it before submitting it to the FW.
> > > >
> > > > Without a standard format, opcode definitions, etc. I suspect
> > > > integrating this into an LSM will present a number of challenges.
> > >
> > > The opcode is relatively easy to extract from the mailbox and pass to=
 the LSM.
> > > All drivers implement some variant of mlx5ctl_validate_rpc()/devx_is_=
general_cmd()
> > > to validate the opcode. The problem is that this check alone is not s=
ufficient.
> > >
> > > > Instead of performing an LSM access control check before submitting
> > > > the firmware command, it might be easier from an LSM perspective to
> > > > have the firmware call into the kernel/LSM for an access control
> > > > decision before performing a security-relevant action.
> > >
> > > Ultimately, the LSM must make a decision for each executed firmware
> > > command. This will need to be handled one way or another, and will
> > > likely require parsing the mailbox again.
> >
> > As it's unlikely that parsing the mailbox is something that a LSM will
> > want to handle,
>
> I believe this approach offers the cleanest and most natural way to suppo=
rt
> all mailbox=E2=80=91based devices.
>
> > my suggestion was to leverage the existing mailbox parsing in the firmw=
are
> > and require the firmware to call into the LSM when authorization is nee=
ded.
> >
> > > > This removes the challenge of parsing/interpreting the arbitrary fi=
rmware commands,
> > > > but it does add some additional complexity of having to generically
> > > > represent the security relevant actions the firmware might request
> > >
> > > The difference here is that the proposed LSM hook is intended to disa=
ble
> > > certain functionality provided by the firmware, effectively depending=
 on
> > > the operator=E2=80=99s preferences.
> >
> > My suggestion would also allow a LSM hook to disable certain firmware
> > functionality; however, the firmware itself would need to call the LSM
> > to check if the functionality is authorized.
>
> This suggestion adds an extra call from the FW to the LSM for every comma=
nd, even
> for systems which don't have LSM at all.

If latency is a concern, I imagine we could create an LSM hook to
report whether any LSMs provided firmware access controls.  The
firmware could then use that hook, potentially caching the result, to
limit its calls into the LSM.

> The FW must pass the already parsed data
> back to the LSM; otherwise, the LSM   has no basis to decide whether to a=
ccept or
> reject the request.
>
> For example, consider the MLX5_CMD_OP_QUERY_DCT command handled in
> mlx5ctl_validate_rpc(). DCT in RDMA refers to Dynamically Connected
> Transport, a Mellanox-specific extension that effectively introduces a ne=
w
> QP=E2=80=91type family on top of the standard RC/UC/UD transports. This t=
ype does not
> exist for other vendors, each of whom provides its own vendor=E2=80=91spe=
cific
> extensions. All parameters here are tightly coupled to those specific
> commands.
>
> It is unrealistic to expect different firmware implementations to supply
> their data in a common format that would allow the LSM to make a generic
> decision.

That's unfortunate as that would be the easiest path forward.
Regardless, you are welcome to work on whatever implementation you
think makes sense for any of the in-tree LSMs, with that in place we
can take another look at the firmware command hooks.

Good luck.

--=20
paul-moore.com
