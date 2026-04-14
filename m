Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD734D3B0
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199479; cv=pass; b=gwDKricJX+Jx10dobBsphxj09jwOkEuvdPlL5GnS1L/Y5tyJ88hztc+dtARa6gNQZchV7+eulAkVXTN4DDLLa/7fvwEKrtN7GR/A86gwF7VxxqIfntwlIDBBVJnSUFKnvkiA7qMXaHsRMXolT0nF/ArjsTg5kbzno/t/CTGCFSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199479; c=relaxed/simple;
	bh=aQ0aNEU1NKIVhrIy+q01cYGQ+H3qfAr9fLe4K4e+a7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSD2V1u7WkCGD3TGVb368F0S+78ihPIjQsktqL60M3INUK9gZY+V/ZPw8OsVgImF+LhzREQBLAcuiwL7B8SKRTtdtbJd2aiMoAuqCHCt84hRAnqT7VQrmN1tg0YfUiaSBPhPgYJtVjF7H3gONEyx247r7lacL+1mRnCN1TWqJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mq38fDxg; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mq38fDxg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3867460a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776199476; cv=none;
        d=google.com; s=arc-20240605;
        b=V06uAoSGWyAA3fnz9uhwBZag/ASPg/qM/s22S8fp/2Ks1oJ//qKWYLKJfVA6tri5qI
         rsO6FfccHoBbO/FpZWZpWzvtxU062iAgEKM3srV+iL3HJ5rq8bvc1+zsFA65fT8HpwEt
         YWXt3wmj3/eDGnhc3k488HGFp8DpltT2HGuZRLf9JtLczn2Ph7Kgd915U2OEGnEYkY9y
         nStUP+Nk9tpKy7MVzC15d/pPsBszdjrCRGqBTI8VqT8eV3cJKEynUI8PvBKIslAS+P6g
         GyD1pycE0FhM2qKHIEXXJCm9C+LWxEVwS1+uraCCFXRsCmdsRsZrwBwwQDZEGHj1GThl
         btQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        fh=xscP+dQV3Ps2v6yaflzU6w+mlw2IV+on+KLG4gPMUMs=;
        b=IR7+zIkaS+AmE1B8mGIvTbin99x4n8lJG4Pk4VTDne3vd/QwJwSuUJqC8+8ktjjggA
         2N8fk5S19MRp+CXYr4YYtbRTtxxxoiYbR8wsKUH0u4rkT4fov/MMEF6ss/VDYor70hYl
         IxvoDvYuTh1DRHDf2MmVypoPFFuRfjdMhIf7C4ZsaxLJaITLFE7uUnofHJvhJNXGHVXd
         oBrRiAluWHrBntZZ3U1MQAU1VnI84ZUx3CDiEsb0QIvogx64sDal2fX26vSvBmEKH1g3
         849MWvKpzLUDcxmT9I+G2pGwhghigS9K+IQsbsuuYRIgntfXa0RtKVbKeOn+PuU0OZC7
         XMdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776199476; x=1776804276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        b=Mq38fDxgkRfbZriNhJABnogX4gz7zpqK0Au2qqDIFMX2ogbyvFEPsYjnLGTXlpO2Si
         lW1aaS5H/r2peKduY50ri7h0VcaUV0dGMn2HR0TTNrcnMkksZEb+CN4/ZJprW6ZTc4sV
         vDqSqP5yGnHQEepEQe2byxcoIpBgAabX4QoRoIe2qY4uAaWo9Fv/fdL+xrYqespMfRhr
         CepcKaXSgv+DM7QAAW1CNNtc4sdRDzW+5zSK4iYBZ6Nm4drYrkQ5E7YWpiw2IGT81Y8U
         FRklGCDNW+FbZIMM4Va/IH57P7gti6geKYN7jVTnAu2yrwx6o52NsPoEPbRpdXGQpQzN
         XR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199476; x=1776804276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        b=HobexgbGNumNzPixaac8hbQ0ZHHYcnsGArCn3xn9pzrksGwEWrKqwt98s4kns7S5jo
         NdANpwG1Rxg0DOf7LNnSOQCeQS6rWZNUbbjAfpgwvcVapX/zoheypbAL1ayp3qxb/YW4
         f8Qrq3qvbdhYBBbnPFyOmKpzKFmDqafZye3mYLogv6ap2z+Tj+KQ8dU5sBlqzrCgE5kQ
         KC17RRerOKha7Z7Kvn371KdEj4X89FbESgw0OUj++XhLfIvYRozjNd4PnqQLNSg+FK2W
         JQMoVmVJl+yt6anK5B2FYN2dWYC9qpCxojKq1EV50eiXv3sNE6HM7uBETpqetgbbDipO
         VAVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AzMFpmsd9w369f8848tY+1J4R1Au0ZJxoPA0VDbuaUK4nwEEytmRcd6DitBLIhvjbNIYGzsDci8UmjkZtChoz2HoFsqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDJM5RdDw42PQJzhLhx5KDpmSV+xh0t9sxEqx01NHZNj1EkTb
	e2+zPOkqtukD3MHv09euW/wQTvLG3AnmPN5Ica3Wd09bT7IvFcjhvoYItHs0th5vNBXavqNPPGZ
	RZ/hPMyr8SKlEkb+o7hyb0ARk+he6sQrvgp5EYQjk
X-Gm-Gg: AeBDieuqFmol4nc/95zwZv3e3U8hhZ00Ql1OjkW38ThGqx+dn8xCREWw3aUbD/z2Old
	ghSMluMJiYkoth3IvELrnu0hiyAevlHH1xHhnCnCAqCcxhQqFNLXv7vbmhgN5gZHQjuXDqANLY7
	VIp8DUSZr2s2aMTGF/oroRaSrXxlaxH51pvscyCKQA+Is3PVJniawwRhtnYJ5ObhhDcuDn1nBTh
	ai1s3mWdEUOTKE0q/bZCKE2V8E/5j5MmVmMXtAz+ZDuUmUa/NFCTqnIMlS81QG2cUYGmDXHFfat
	OMMs+As=
X-Received: by 2002:a17:90b:4d0e:b0:35c:b02:b5c1 with SMTP id
 98e67ed59e1d1-35e4254fa24mr18173516a91.2.1776199475615; Tue, 14 Apr 2026
 13:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com> <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
In-Reply-To: <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 16:44:23 -0400
X-Gm-Features: AQROBzCEfz_j_XIQqt_9SrRpougQ4lYANU563js1WLhMuxDlob1XiduX3tGAPf0
Message-ID: <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:10=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/14/2026 12:09 PM, Paul Moore wrote:
> > On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:

...

> > For those of you who are interested in a more detailed explanation,
> > here ya go ...
> >
> > NetLabel passes security attributes between itself and various LSMs
> > through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
> > is an abstraction not only for the underlying labeling protocols, e.g.
> > CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
> > NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
> > then translate the attributes into their own label representation.
> >
> > Outbound traffic is a bit more complicated as it involves changing the
> > state of either a sock, via netlbl_sock_setattr(), or a packet, via
> > netlbl_skbuff_setattr(), but in both cases we are once again dealing
> > with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
> > underlying labeling protocol is configured within the NetLabel
> > subsystem and outside the individual LSMs, there is no worry about
> > different LSMs requesting different protocol configurations (that is a
> > separate system/network management issue). The only concern is that
> > the on-the-wire representation is the same for each LSM that is using
> > NetLabel based labeling.  While some additional work would be
> > required, it shouldn't be that hard to add NetLabel/protocol code to
> > ensure the protocol specific labels are the same, and reject/drop the
> > packet if not.
>
> Indeed, we've discussed this, and I had at one point implemented it.
> The problem is that for any meaningful access control policies you will
> never get the two LSMs to agree on a unified network representation.

That is also not correct.  In the early days when SELinux was first
being used to displace the old CMW/MLS UNIXes NetLabel/CIPSO was used
to interoperate between the systems and it did so quite well despite
the SELinux TE/MLS policy being quite different than the CMW MLS
policies.  Yes, there were aspects of the SELinux policy that made
this easier - it had a MLS component after all - but they were still
*very* different policies.

> SELinux transmits the MLS component of the security context. Smack passes
> the text of its context.

Arguably the NetLabel/CIPSO interoperability challenge between SELinux
and Smack is due more to differences in how Smack encodes its security
labels into MLS attributes than from any inherent interop limitation.
In fact, I thought the "cipso2" Smack interface was intended to
resolve this by allowing admins to control how a Smack/CIPSO
translation so that Smack could interop with MLS systems, is that not
the case?

> Unless the Smack label is completely in step with
> the MLS component of the SELinux context there is no hope of a common
> network representation. If a *very talented* sysadmin could create such a
> policy, you would have to wonder why, because Smack would be duplicating
> the SELinux MLS policy.

Interoperability wouldn't be a problem if everyone the "right" systems :D

> > Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> > require some additional work to convert over to a lsm_prop instead of
> > a u32/secid, but if you look at the caching code that should be
> > trivial.  It might be as simple as adding a lsm_prop to the
> > netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> > and not just a u32/secid.
>
> Indeed. But with no viable users it seems like a lower priority task.

You need to be very careful about those "viable users" claims ...

> And to be clear, I have no problem with netlabel as written. Multiple tag
> support isn't simple (we did it for Trusted IRIX) and the limited space
> available for IP options make it tricky.

That's an entirely different problem from the LSM and protocol
abstractions, but yeah.

--=20
paul-moore.com
