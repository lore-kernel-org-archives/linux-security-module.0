Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204076;
	b=OlmgwQJm2T4i+CmY1KRKL0C/J/kPSPslWFbqADP+aaamaoifvUNtubRGiJ+qRc1nKr7P
	 dVLt8c2ZD9ubPKMfEmvSn5jWJNspxQe7btFN+WYUqo7A7mEMDH3wT+vk3P320t7Dg1Rvj
	 7ecgIrXHQc1QjbqFrMS5r+V2XnRcUMdRUQKPFpOumUGf5z9najqee3CL71oMa5pjlNTPO
	 VPj1kR0+NLMwLHlfdPH/mtBLi4DvdNxgN30Mr/yr+kBrTV3kIXFnjRtcqorKhM0AG7Fdk
	 x2CRVOrqXoReu9doAqQyHrR47Utaql52ckDBwkrDl6uRrbLOjtWp+GxpZxRNY0Vx4Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=OLwopm3tfVdYDr8lNpOhi+92U/iyvrWFug9fciACr6E=;
	b=q0noEzo+2VbA9dbQnKqK99OK2vf8iZXMicvLsbaJdEDiyejtgp+imZATTx7LrTKf++DC
	 OESLOhUBZGb5QGazo0x2GaRjdBqp0NyH1yO7uBviQ913V1WaDzLHZFBUKF/PPtZq/8sWT
	 2Zwet13dF2gwVCWhSSQthoS1ZXeJeAsu8BXy0QgRzsQKjBAgwkLSJnNj5o79yyUxoEAmC
	 zvIw6iblU90718akakbgCmMFRltNwddI6jA/Q/ZyaMukyRCNgmAVXM6rYlHg+tEmJReLm
	 ftRMFyoxbpJleGDAmB/3K4OnGo4hKOQmePbulazsO4P7bH/o4QZnHaSruO1yMrhaM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gu6vqnoC;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39775606A6EC
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 19:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39775606A6EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gu6vqnoC
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso1346228c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795204075; x=1795808875; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLwopm3tfVdYDr8lNpOhi+92U/iyvrWFug9fciACr6E=;
        b=gu6vqnoCv/9UjrWbvH5QYc6lvs0DqXp7UDAdwqu9rtACJYlivIYMvs0AjqrEf1FAhU
         lXPYPd8dhc8BVXgFZP7IqIBxeUzppxd+oXbvAaXhAib/nLJKXD2W6TaURHKv+K5fArs3
         lRsbFE6DNIiRgSYWbMzMFOotrCA8Buofq1ADD/x9PXw1dVqNJ6tco2HhJ26/ehYuNhYi
         ZC4vFHUT9JgOMQoFcYofUJ4AROqMbC6txIRFOVOz2TNUGlA3iwtxbGZjRXBz4gJRNvqI
         zGglRt/DObtJUnFJuHJCg4b+GXYEfMXCmErGo0hDatHecerI5wJs+GiQw6KixABlxPTw
         sv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204075; x=1795808875;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLwopm3tfVdYDr8lNpOhi+92U/iyvrWFug9fciACr6E=;
        b=iyYEo44xzViPgTGUEdRbEw6vv2jo/JzLCGEXgTs+tVzs65XQAGL40STR7f6PQ3fCQJ
         uRaBfrIjTeWlMjE6KuARGyssHeGnfmTj97GhOTAxe0UF1LWw33f23+zIFBMFm8iZcizt
         Nqo7Ix9WTXqS+sLFOD+YnM20lBQ8Zx89ndWWQzX3JpCSHwgX9UT2qvc+sL3VnQEz7dZC
         VtjEg4/koWrDtI+ME2mnCqup5FQRnQ2mOyTJ7yHOvILlSZfFor0JP3FITp5mQzAn0E6V
         EngveXU6p40zFoYLqNyrVUe8MZBD7I1Xwuy+VsSN+Z3GMt7lVr9dhlo/VLgzVeg05X6h
         qZag==
X-Forwarded-Encrypted: i=1; AL+hErGGwGu4L+3G95F+LM2WeYSLlwSIB1aupthqZT57qquu6mTuZMflmU7J8liU0lNi45YVqP5dmpO7C3oHo0+fXNEaDweoYqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XCWFCcNBQIddjM1JaVQsKxzyVsY1++Ni5DFURh9/Hql8tsYp2
	4Lm3h9JqT5Jig3UsKtje+80RowgEtS+dnHIlr9CBjN4RimoxKkVIMtpnXFPl4CZI5Q==
X-Gm-Gg: AYBFou1XT0GnOXrJpnzSTgdUUpsu9NdvkXGpHfHLHW3UBP5Tqwq0yvB2kt1x6ABmf/d
	wwL2RDhwR4A05kSJxxowj1LHS+0cx8YzB/bqRvdhBI+cqHGlMK1aHIqRQNRqsWb5Hap0zpzRUL0
	ZXn8JfJP8hdjSm5OjL+lNSnAJJXIZ/PbqAwhZFe9yGNDwHNpzDI2zTLo0Lf4pH42+SCT8ZdrPEv
	s81uwSXPhcrGLgSCuTvS9WevQaaydSoEdA7V4C4N7nScSPbGqEZUYyEbeKIk5xcaB3SwBhqmJWN
	hR5Ijuun/BOTgp2fEA3lHASAme1Yue08ZchgMElGnpPONJbytACxqENoi9J2z5eUVBVwt1RDHgt
	HsGSZ/KMN6IDiMZlU7F6EIbvtHosPYVjglofQny5q1HUHVTsxG4RDWjiMjmME8K2Mo+h2n0ZVv7
	tQ4CIcPbA2XcDhYmw+0cKGrDChKltHUmFS+Pt6eZcZqmet6Ng6X5+WzPFd/AFSTw9UCFaVFczzC
	A9udUw3Iy75DtEJko1fQ+xPZcviWkgcwZS/MfWs++b79/R/T5/TvYuMD4ucrgeMTZ1jwHG7q/6E
	QqmneRIPW57k9T4FDP3iMvAHm7mViy0MivXtoEGbFgrIQOA=
X-Received: by 2002:a05:701b:2088:10b0:1b3:a22c:7f68 with SMTP id a92af1059eb24-1b5568d349fmr3946917c88.29.1795204074932;
        Fri, 20 Nov 2026 11:47:54 -0800 (PST)
Received: from smtpclient.apple ([76.14.8.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm9027046c88.12.2026.11.20.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:47:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
Date: Fri, 20 Nov 2026 11:47:42 -0800
Message-Id: <ED402BA5-8156-4F9F-B621-120C9C53C309@amacapital.net>
References: <awCg5VYXKJvex9vy@kernel.org>
Cc: Alexander Mikhalitsyn <alex@amutable.com>,
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
 Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>,
 Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <awCg5VYXKJvex9vy@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: iPhone Mail (24A446)



> On Nov 20, 2026, at 11:35=E2=80=AFAM, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
>=20
> =EF=BB=BFOn Fri, Nov 20, 2026 at 03:57:32PM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Nov 20, 2026 at 02:24:57PM +0100, Alexander Mikhalitsyn wrote:
>>> Yeah, detached mounts API solves a security issue here, but it does not
>>> fully enable the use-case Andy describes (if I understood it
>>> correctly). My interpretation here is that to fully cover it we need
>>> some well-isolated communication channel between container and
>>> container manager (vsock for containers? :-D). And some well-defined
>>> agreement of how PID 1 inside the container can get an information
>>> about a hotplugg-ed stuff. [ But it could be that I completely
>>> misunderstood and Andy meant something much more simple here. ]
>=20
> The sequence for hotplug (Andy's use case) breaks down like this and is
> doable:
>=20
> 1. Host creates rootns(ROOTNS_SEAL_MNTNS).
> 2. Host sets uid/gid maps with NS_USERNS_SET_IDMAP.
> 3. Host populates "/" with MOVE_MOUNT_T_MNTNS, optionally combined with
>   MOVE_MOUNT_CLONE for bind mounts.
> 4. Host spawns PID 1 with clone3(CLONE_INTO_ROOTNS) (optionally passing
>   an AF_UNIX socketpair fd for communication).
> 5. PID 1 watches /proc/self/ns/mnt via fanotify(FAN_REPORT_MNT |
>   FAN_MARK_MNTNS, FAN_MNT_ATTACH) or polls /proc/self/mountinfo.
> 6. On hotplug, host mounts the filesystem via fsopen()/fsmount() (plus
>   optional MOUNT_ATTR_IDMAP).
> 7. Host creates the mountpoint with openat2(RESOLVE_IN_ROOT) + mkdirat()
>   and attaches the mount with MOVE_MOUNT_T_MNTNS.
> 8. PID 1 receives FAN_MNT_ATTACH and queries the new mount via
>   statmount().
>=20
> ROOTNS_SEAL_MNTS, NS_USERNS_SET_IDMAP and MOVE_MOUNT_CLONE new features
> that are yet to be submitted but they were not tedious to ramp up.
>=20
> I'll include them to v5 of the patch set. Thanks for underlining this
> part because that led to having those.
>=20
> Architecture scales to this even if my choices to address these details
> would need some adjustment.
>=20
> The clear two-phase (build/live) progress with rootns sort of just gives
> room to address stuff like this, and I have hard time to believe that it
> would get much better than this.

FWIW, my EPRIV thing and cap_userns (in the other thread) only address this s=
ituation to the extent that people think, if a container has permission to m=
ake children that can mount, then the container itself can mount. Unless peo=
ple think it=E2=80=99s okay to use the *existing* cap_bset to adjust this, w=
hich lots of existing container managers due but is very coarse grained.

It would be straightforward IMO to have a single bit on each non-userns name=
space type that declares that tasks in that namespace are not ns_capable on t=
hat namespace. (Actually making this *useful* may require improved APIs that=
 are kind of the whole point of this discussion.)

I admit I don=E2=80=99t see why sealing a namespace is useful.  I like the b=
it in the previous paragraph better.

>=20
> Br, Jarkko
