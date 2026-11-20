Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177982;
	b=qZr33UNxS+W+cb220C/RqaiMiqAwpdnDk15yn52zrny2lr0om8MDO54wj7MsEZh4YK1I
	 YTDdgvPOtd1lwpF11xj+zg0UuLOsYRINs2tk2ZyBNx7QVu542bX1yu3lVdv+yHipNWFJR
	 q5iz3kR6qYsBjYwzDqTPKPU7CUIDLvjCbFQDZt5eGCkUezPdmkQGTYhFE1cBNSgen9XuU
	 Y6yTAtANdXOdBWpizf7MKhHBu2nsZuGQK7bzJ+mgurKMQGF1FYM6DMQDn4RvQuKMb32LN
	 fGHzZl1p9GnUYBu8D9x53aZdWZC4MA7MMhYl+9gW6YOGnreuHGL3Mp4rBuJOxIi6O+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=y1Wkg0jR0Nndjb05E7cUt8QKw6kiQJc1XIXRzVqfiAU=;
	b=Ho1p9gWjO52ozuOjDNtfodXh914GSTIzzXnmEcqIFEEYM5m9RreG1ko5yX9XX1K+7d3r
	 fwf00y3MIO3p0g8AvgkewdHnGzDYyVYGUZVgIyEW7Ov8/oFM9kMO+/T+hcxhGJuZOk96b
	 eAhn7e3jDf7aP+SASrKWb99QqogWwF99PnrxlXI5eDfG+BHEL/Wfvx5OxKO6xv40U/LyQ
	 j2MpszUYtMp4dN0KmDR19PkZqRQtF035cgtnuO74oo4c9pR0U50/lzhA9e8B1lvA/lGwr
	 JZTxhVyjMKJea9pncSI3DXu/tJmZzLD27iEjz3Ci/quoZ7QGmX3mia9hVzAfk8irlSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qbwklCFC;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22E606A33F
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 12:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF22E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qbwklCFC
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso194635966b.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 04:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795177980; x=1795782780; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y1Wkg0jR0Nndjb05E7cUt8QKw6kiQJc1XIXRzVqfiAU=;
        b=qbwklCFCQWBYYh7Vdm/EvOhgnw0GN36ZdBdjQhkPfUQrBI5NBk6W9T4MdRJopZQZjo
         P6262a/dhJ7Co2zQpiKrl4G+woYgY042jWu8/3ZHeVK5ALDluxaUnBxbAIoZRRHJPu8I
         giCejoRuk/NeTe6oUF2GyqxtzLSYol6p0d/hxOP1dljaEd3BGsyiSxjP1aQh+9pKGEZ+
         PQ9OGYDSwCcUE41GIQCd148T7eMUZNRhT3F9VOX0RluZQQ6m3tXsa64kVRnLvhW5Q/nX
         YIq71Ek0W8WB4hUCj8xaGcwb6t0xcDq0L45GukMS4+fS+2IyVZRwH7HQwRq498rhEgbO
         D6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177980; x=1795782780;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1Wkg0jR0Nndjb05E7cUt8QKw6kiQJc1XIXRzVqfiAU=;
        b=1hs2O8A6xyAFS67aDqEIU12ZhPGns5gKk+JLSpEpdknkmPGom6NrdY5jKadDIEyj5+
         KQnkdyOnZOuwXBpU5BHiuDhPaTnMN5iTQhQ5DqqZb34fyLbCBDI/rWDlqKT5VJcWHSL0
         a4qP3kZqvz3LDQPPJdQ5gBcFcVihDUP6CJ/1Ul9pfr4p8BVYMKy3az0seBJqvhf+ecMk
         clVXy6Y/JC8mWmKt6p7jNbb6vd83MK9QLrl8tay1MI8ExdhX62ewRuGdTmqqfnXwpDEG
         kSrnE6lV00WMSmecsVsI2vvCE+hxnM0/IEuJz4/hYfmWet/JILTB0ala2CKYysMpS/3I
         BmQA==
X-Forwarded-Encrypted: i=1; AL+hErGnUvIhzdJcYn4SMNkcQyz+K6tRFHBWydP30jaCCNn6F9asCGrj3wcck1F3qt8Qi/Fc66C+HTNSuPnICKPpGTxO37NFTio=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Od9ZFM9bJbZSoTbJMZWKPDs6niUC/sG9oj7tYHVNllr/jgNLu
	Mwp8viXL0F8CPvgLAYtq6fMg44N5xuUkDc17GiqPZjfVpbAR/OgBAkQcHPtj1bzDH6mn
X-Gm-Gg: AYBFou1q7THTcfoxwHwpM9GtR6yxt6GDM+7H9pHsIHHiDi2fBl9jt0v/NZzBxGwyLaJ
	103RGjL/MydM2/IDbKnS2f5aeqnBnN/U54Krj489bVxM3/jlx4VJrl0fOhQSH3BPwZt5A3P5qZf
	E6PJ8PinOD+i2VaG7qFU61AxS0DYUN417A112LhzgPTeKotMc5JB6LX3jqwEcbRIHUTqTJ/73zr
	+YDtWMqMguh7k9ZCt7IXRYNZokWx6MAHwdmhIx5ueAkJyY1N+ZGJuTNi/dcRjMbbdhlEIlCppCT
	kH1rGqALriwikHWo9Os/GYKUUrQfo6uzbl5Au4YOpBW47zpCE7M2rb+37ICdt76WINY9hl7wpzL
	idFdnhyDH5nWTQu6YeFH6/TiLdJilRBWtYnSWF/9lt1ZBjxhAGZU8I3t6DymDrBnmnyu2nMrAG6
	9fYrAWGNOJGRKoy7FxiPLHMpKemAw7w0Pq4sKhEGK4Yh8LAyPjbBdksvIGi4tUJjwev3iDNDrm2
	20tv+rAICRRExUy04ekZPxC5Xbgyal+6FO+vcBSl4SSUv4LTsy6TCeKu+29stkITNqqmPVoG0+T
	2uqjZ9iZp2q0tKA1SfU2B37jX7TuQLfC7Y6dd5c6f83TVbXQ57SAfZY5QVhOpIBHrw==
X-Received: by 2002:a17:907:3e87:b0:c51:24e5:f5d7 with SMTP id a640c23a62f3a-c51313a09eamr445486266b.0.1795177980204;
        Fri, 20 Nov 2026 04:33:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm6008114f8f.24.2026.11.20.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:32:59 -0800 (PST)
Message-ID: <c301fff20a4920fcd3baa31dda2e31ad99c93436.camel@amutable.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Andy Lutomirski <luto@amacapital.net>, Josef Bacik <josef@toxicpanda.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>, David
 Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Serge Hallyn
 <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore
 <paul@paul-moore.com>, 	linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 13:32:57 +0100
In-Reply-To: <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
References: <20261117231352.3816603-1-jarkko@kernel.org>
	 <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
	 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
	 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
	 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
	 <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
	 <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-19 at 15:27 -0800, Andy Lutomirski wrote:
> On Thu, Nov 19, 2026 at 2:50=E2=80=AFPM Andy Lutomirski <luto@amacapital.=
net>
> wrote:
> >=20
> > On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.c=
om>
> > wrote:
> > >=20
> > > On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski
> > > <luto@amacapital.net> wrote:
> > > > cells: The dance where I create an anonymous mountns, mount
> > > > stuff into
> > > > it, and then attach it to the cell is cute.=C2=A0 But I think the
> > > > userns
> > > > interaction is wrong: you are making me assemble all the mounts
> > > > in
> > > > *my* userns and then clone the entire tree into a fresh, non-
> > > > anonymous
> > > > mountns bound to the current userns.=C2=A0 And that clone operation
> > > > is not
> > > > free and serves no actual practical purpose.
> > >=20
> > > The copy buys us nothing, agreed.=C2=A0 That's just what the mount AP=
I
> > > gives
> > > me to work with today, it's not something cells wants.=C2=A0 If I
> > > could make
> > > an empty mount namespace and fill it by fd I'd use that, the
> > > "root" slot
> > > takes a mount namespace fd already.=C2=A0 Extending the API for that
> > > makes
> > > sense to me on its own.
> > >=20
> > > The mount namespace staying with the builder's userns is on
> > > purpose
> > > though, that's what keeps the cell from mounting anything no
> > > matter what
> > > capabilities it was given.=C2=A0 The builder sets the tree up and
> > > hands it
> > > over, so the cell only ever has what it was given, and the mount
> > > code
> > > isn't something it can attack from the inside.
> >=20
> > I don't get it.
> >=20
> > Using the builder's user namespace means that the contained
> > processes
> > can't be ns_capable on mntns->userns.=C2=A0 But this solves very few
> > problems unless you also deny the contained processes the ability
> > to
> > unshare userns and make a new mountns, and if you can do that,
> > surely
> > you can also deny the ability to modify the mount namespace.
> >=20
> > As just one example, a mount namespace could have a little flag to
> > say
> > that it's *in* one userns but its owner is a different userns.
> >=20
> > >=20
> > > > cells: I find it *incredibly annoying* that one generally
> > > > cannot put
> > > > new mounts into an existing container using most existing
> > > > container
> > > > managers.=C2=A0 I hit this on a surprisingly regular basis.=C2=A0 Y=
ou
> > > > seem to be
> > > > baking this into the whole cells design.=C2=A0 Why?
> > >=20
> > > By design.=C2=A0 Allowing changes to a running container is what
> > > causes the
> > > problems.=C2=A0 If you need another mount, tear it down and build it
> > > again.
> >=20
> > What problems?

Dear friends,

Dear Andy,

>=20
> I'll add:
>=20
> On a non-container Linux system, you can hot-add a removable drive.
> On a Linux-hosted VM, you can hot-add all kinds of devices, with or
> without the help of the hypervisor.=C2=A0 (The hypervisor can hot-add a
> device, and the guest can mount network devices or newly added USB
> devices on a port that was already assigned, etc.)
>=20
> For some reason, on Docker and its sort-of-clones, approximately the
> best you can do is rbind in a directory and then mount things into
> that directory from outside.=C2=A0 This is sad.

+1

I guess the root reason here is what you've mentioned - for VMs we have
a clear separation of the host-side (hypervisor can hot-plug a device
to be visible on a PCI bus, for example) and some agent on the guest
side can react on this change and do something depending on how VM's
owner has configured it.

For containers, we usually don't have an agent (at least in LXC, OpenVZ
and Docker too). So it is a container manager's work to figure out how
to hotplug a new filesystem for example and where to place the mount.
And this was always a reason for some crazy security issues, when some
privileged process on the host was entering a container's namespaces
(partially) and then suddenly become trace-able or bring some host FDs
(and these FDs could be a way to escape via (struct file*)->f_cred
permission delegation model).

Another reason is that in VM you hotplug a device, while in container
you can only hotplug a mounted filesystem. And for devices we don't
care under which major/minor they land and so on - again, because we
have systemd for example and it can figure this out. For filesystem we
need to know where to place in in a mount namespace tree from the
beginning (we still don't allow mounting a block-device based
filesystems inside user namespaces).

I really like your point and that would be great if we can solve this
somehow in a new design.

Kind regards,
Alex

>=20
> I get that there are plenty of workloads for which this limitation is
> reasonable, and there are more workloads for which this limitation is
> silly and people have learned to live with it because everyone
> imitates Docker and Docker is limited.=C2=A0 But there are also workloads
> that I hit on a surprisingly regular basis for which this limitation
> is genuinely annoying.
>=20
> If you want to write a container manager that shares the same
> limitation, fine.=C2=A0 But please don't make it into the kernel without =
a
> compelling reason.
>=20
> (I personally think that Docker has a *lot* of weird properties that
> make little sense.=C2=A0 This is just one of them.)

