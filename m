Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18952370D4A
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934039; cv=pass; b=hVCj5qLjBc1SoakN4TrYYLSz6OQsG1zGRSwF73IbeY8heY8o+HBb1IGtS4oiSSVsAcbiCuGwpNt5QaGRW1zBQHkAM4gPsoHrx781GQIurj2yDnr6yY9uM0Be8kOX6A1PFNr7u9oZvZZeLxrAr0mLEICn0dVL/+2EJGdd7Hjhyd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934039; c=relaxed/simple;
	bh=SRyzc0UaWv+n7V9qD3GfiNb+SIIGW8GsbwmzjOQHX18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMtD9z8g7ldAxJe4C0x6h0i5BrLcCSTDJH4pYU/VFcAf2KLcvDhkXFDTAjlqXOWTXQu80TgOVtH2sPf8xNONOECEONt45bD/2vRcXSbFMUo+eL0VReVpokZVRs5MZ5CMfv51G1lC3kl5nL/KE2SduORQCikXmaE9BGeyHBH6h/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b474DNHm; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b474DNHm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-362e30526f8so1887945a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 15:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934037; cv=none;
        d=google.com; s=arc-20240605;
        b=km5+GCphthdyt/aBxr+ZsgKCfDeHVsRlQ4zyq8n/h1auwquBU9tpGAgtvp5x2mXDyf
         5mkT4VDKQLDkf/bfXIbi5sgUc08KpxypEi5n0Mz73beOZQyRODSAkqw2ityD2JBN/W+X
         FWuUkmOfqYvoS9Rt3t1zsKxt1hD8bDrLW5W3lXMhVl1h7L1uUV7kl0L16bUBis9oxqU7
         MV6Drjxoh1O903wQeld8OELk1zIzYprTQ8IOA6IlZkwR16ynYUUO2Ke0vWwEsLsbNYsk
         VOvnpHVrzn+jE/omm69fzFCpuDAhZwhRoE+WwIDI4l6T0wlxU/sMnVPggGpYkUc3yUS6
         7y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        fh=uxxl2ai47aVP368Vhp+ENRraDPa1WHTFhOJTVQHytyE=;
        b=eBjlJ8w+36nyChr8Nu8GPfVaiUiHkMIhm8cvQiij7TZ7XNar/l2szGSBvZMRq3CGcr
         IyOhq6jBzodRgkI007pen6//gM2H05t1aLHxfRHH6mQQ3pUDbMyDqk/31suEMsTle4y2
         atKm6FgUIuFe7781QYiv65ljxQm0WYF2haHeTz5zMVPJAGUit0p4QpusLcx0sd8opfZf
         mgL+Kkck2UY0gsIM2AAclYnLefLm4m9WJX3F8JX9qE/uB1YF3D2+EhowOjlv6UJ++Pcg
         Pz1Z4/DRNcCnxQoNV1kFtXzmOZvELwo9BM8aqWXx54JYA/aiVBlIQZ1ja4JXEJAHFy3Z
         LEmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934037; x=1778538837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=b474DNHmLbyPnOY4UtiXM5GN+X9I+S0u72RdwKdxeGJHFbyi8dy3N/skGTD8aswwJT
         mQh/fHxQh2XMu0/wXWmILNqAoHVz64tnsQj3uwYrG/nMHnMiR3+62Bg5+hYVAMqGGZa3
         Yhzv530XbxJbU0D0vwHq2/YSke9JUBH34F8cjupFBBSgKFVJDHqdHlHLgKPIsy++DjBg
         CSXKH02/rcKaE2K2wh+4yhWhycJgwprwu1F5I1VKpVbKdHi6Ab35lJlWSVF3M/jPkfFU
         QubU5hVrrXJSyul/eUU6NZH9S3lF2JCWM8rscrobVAwd5+udUgedARCiFdjuMMWnSxUC
         /4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934037; x=1778538837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=b4onjZhnZpx+83M/nn7iKLgJAZQxGTT5ALcy2tGfOjIMgagqEIWCQzYNFpxlLO8UDx
         t0uiBiY66UltGIUNn+lcRtY7amNcqeWpca3gwII73kQ+O8+7UehDYHG89UKxGjyuhrA8
         +hxQIpmWYfkl4ymjPTCuO4CQ25Hg/VYNJiY7rp0O7hYKaDXowzpjUlbGGAfWAoa8L/tZ
         X3Srf0uDDRjGWayUyYxBDlVmSoInNGMnZhySp0TdOoNK7+D+TL9ZFNStbtF/v3730hHH
         9cXKjNeRU7bdPoFldmr2EgwavhF+qs5n+RY/vM2W6lZsVrjNkbH0Xew8baxNDUkdBVx4
         EO4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NvT9prZAE05K36nG/wwNbAIxm8urM0/Dwc9iQ/DXChBtka8hupcwD1z+Fpzzpp0WgM/DW12OoD/9qJ4upxONPjRdBITI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTO2N+Dx7mjvLokJtEhoja0uUf+omS4Ha/RCdx9/YjaA1tjOnj
	9AV36yKLNrVBsFsB83aPgbkEmbR/d6V9TqU8hpMrnS5meluGKFQVOlrXkYiFQRhAWBJZOMNB60V
	+NERL7p/cQIXuhJue1umX+qsxdXqlvjV9Pu6hlEJj
X-Gm-Gg: AeBDiesmg+hT/yLn8sMuU8urQIP/klT/JjMk9xvrmsZLHktpCiWMxbDXpWfKv0NGGKy
	T29oXbI4xhU8Ulwm+t7N3QCtEyoTSMFINfmWBfnUoEGx/db9RmyZzpm2M3Ry6VhNCbCbyaDxzl5
	f2yvmu5u47ZTlviaBScQvJpIitPBz7W9HI1XhJ5jG8voqyitMVCX3DTMi3pef++rjN48DLQv0el
	htWrEukFCDiiB1BgU4ciAuGpn+O+FsaAByStZpMA3Dd8NONexaO8i2G4Xlh5R9OLkrsMZWTb1qW
	jNG0d0tmgUeodxVtrA==
X-Received: by 2002:a17:90b:1343:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-3650cd08160mr11400198a91.5.1777934037438; Mon, 04 May 2026
 15:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca> <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca> <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
 <20260424221310.GA804026@ziepe.ca>
In-Reply-To: <20260424221310.GA804026@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:33:45 -0400
X-Gm-Features: AVHnY4L0o11c1AyvQPCh6gK_ec0IV1Rogd7iCBcWBXwoMyFuE6qppAiDKI-2lpU
Message-ID: <CAHC9VhTsx6cpKMP8nVgK4F=drXTFJtK3_D9k9pmKr56+ZFUu9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:13=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> ... I wonder if we are even speaking the same language.

Let's reset the conversation.

As I understand it, based on our discussion in this thread and Leon's
previous patchsets, the basic idea is to enable LSMs to enforce access
control over fwctl requests/commands sent from userspace.  I'm going
to start with that as a basis.

Using the kernel's docs on fwctl, the userspace API appears to consist
mostly of ioctls with some basic sysfs interfaces.  It looks like we
can mostly ignore the sysfs interface and focus on the ioctl side of
the API, do you agree?

https://docs.kernel.org/userspace-api/fwctl/fwctl.html

While normally I would suggest simply using the existing
security_file_ioctl() hook, Leon previously mentioned that the hook is
too early for fwctl as the userspace copy happens much later.  Looking
at the code, it appears that the copy happens in fwctl_fops_ioctl()
for all fwctl ioctls regardless of the device or ioctl, is that
correct?

Assuming the above is correct, how about the following LSM hook,
called after the copy_struct_from_user() in fwctl_fops_ioctl()?

 union fwctl_data {
   struct fwctl_info info;
   struct fwctl_rpc rpc;
 }

 int security_fwctl_ioctl(struct file *filep, unsigned int cmd, union
fwctl_data *arg)

Where @filep is the file/device being sent the ioctl, @cmd is the
ioctl command number (e.g. FWCTL_RPC), and @arg is the copied ioctl
data (e.g. ucmd.cmd in fwctl_fops_ioctl).  In addition to applying
access controls based on the ioctl command number, a capability that
already exists via the security_file_ioctl() hook, LSMs could also
apply access controls based on the RPC scope as well as any other well
defined data in the ioctl payload.

I expect most of the existing LSMs would implement callbacks for this
new hook with the subject being the process submitting the ioctl, the
object being the file/device that is being operated on with the
ioctl() call, and the access/privilege/verb/etc. being something along
the lines of INFO, RPC_CONFIG, RPC_DEBUG_READ, RPC_DEBUG_WRITE, or
RPC_DEBUG_WRITE_FULL.  Of course these are just quick examples to
demonstrate a point, please don't take those names as hard
requirements.  Each LSM is free to characterize the access request
however they like, in a way that best aligns with their security
model.

--=20
paul-moore.com
