Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181101;
	b=tEYLTTRF9cFk+oKmdc/LZm70wBnwbCwNk1zwwOXik7WMReylgkOj4SS7TnJ8TEpaIp5z
	 3NLR9YdKUFGUEcPumRuICyJo5Y7ZZpvtclLSSnTtnQOWoKQvu9AdiaQ8POU5f2vJPGDfK
	 ePFJ8G+np0I/799dVdffU5hQ5iUD7EMoLQ4GkPAFAOtstYBcEDYbBiId+mr6zngkgpRte
	 3UZ1jt9jpS56+E5TqUIbHW8PIpvyO6aEtk1rL7A6aBcFyQ6hrQhnMWc37CrQ/OauNh2Yx
	 0JmqCG33UKQRZynZrKuXA61S4UlLbYmcPLHB4sOdTFSi3JAx2VfB+bRdBQFapLRymsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
	b=tnGwKMf/8K377cKwPOIJYDNoK3jtBobi1BvFbYQEJKJs8jh8izNvCeFgjSkaF+Nm2S61
	 mD3RN6KkCvFvLiMmOdQ6vtYRYf+iKD7hnvIdESi7x54tTgQu9vxeNsYiH7acnrtcgxUdV
	 cTfugTQXDz5IZaw1YDze8r8dkPOFoOW1XrLcVLc7cL8T0eHZf9hx0+rYGGoL7Q9DM4+to
	 XT1KdhRwiTe4AJmA0C4+9zSkK82rHKVV/0unq8qOOZDKbJVrxlYx9lhi8fxNTemFwI7nH
	 awERZ55PbrTAu9zPYuY5f6xFWdKnnJimsA/pn6C77qnZKep8dVqK9RWqJUfsJTezYCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dCkPrHYz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E6E606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 13:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E6E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dCkPrHYz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6743995e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 05:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795181100; x=1795785900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
        b=dCkPrHYzS+fdPuPuKwS/olhuHCxYtIb0sFo9PQ+SKkZchMrhIdpW2EL9a0SvblZHZl
         6Dxb+/8GGtx377OqpkItP5QDaPJL24HSTEooQb1Oh8rqfcLAAQ4L3UeiVwGuYSAOpOcx
         ZhVg537cx17T2tuC72cgWskMTRuesNMFWD/i3wDku7j8MLPu9G7dWsmjzg9mx1/fiYjm
         +XjPTHGCtTemoqUoqxYrB+hO6G/npZZ0dVWw26L72Noru2ONn4q+r7RaGKuge2WLE+fU
         U9uS79+Q1vOGklxtomAQ2OmUTslQ64f/EWs8HLBPSvH7JWiVWjzaumj27CjfBYhRD6qp
         XWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181100; x=1795785900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
        b=0xBkJV4OOiJLlcpOWcIPCh1t9MeBG24uojlz8NZc3mAp5D0E8J4RjgL/QympPpF39y
         vYAnRye2uSXBa6N5wU9TbbixxOyDKFUBNbI4NTEoMnFLQ9n0yew6HNd7EQO2ioaPKGMF
         x+7R0s9YCM9gs/q1i34BCBZHy7/LV98561tiCj782CDrCIJsPhmSHCzuuRkk6enJmVzC
         dX5+nYjXic/g5/WN7v7rrMh8e08E70mXiPQ/LULZPP2ConuWCGNfFfkMga1WBpZO/tiN
         QcW1D6EtU9jhOPVDVuBvwZjl1oEwSQrEhLUx4Po5h/x1aLg5GIzLclLdjsfrbDFvOUJF
         BTfw==
X-Forwarded-Encrypted: i=1; AL+hErGg8ywhRuaD8D7M6JgucuwQBDe9mumeleBgYlJ0PqP2Q/xLE5+AlnLlFNyNPCCchO+3MHCzyqwUgC6/V/KPE18+4J4yhBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1geeFEBDtR3MCPUaxD1Oc09TPYPHJtS8rqKfDB7gBKGnWHQJP
	mZK9c9wQb1mMhPEUr5eKvq5CSHHpo6xom4mricRoCuFDrS+X//kylVDqFL3kpBtv/Z0d
X-Gm-Gg: AYBFou3EgmuFiRQXX5J3VVw5TzX7fwH7dy6N+tFZvrV3BU8eUNuuLza1QgdqajQzlZI
	hClc3/GFLKxzHPo0ymz3MM66GXje7MXLMzN+AlNLYa7KV+PI/nLSlXcgXN0paWpdMQY5KB/qnSk
	G2nfnDRUAF1gclxok6SoL7O/mI+QiqXnH/1SvzqdE63lb9y4BugFmGz7tEl3yGl50mIK9EEv4lP
	vmd8bSlg5XAHtYx4azzU/dcxx7sCGoSFPDseqkKpI/OUsQxTL5ElxboBuG6RftGIsHOitPVrYdH
	Mn5aQkcbU9eOYk4OKXeOg9F1uWBYWI3u4100JJCmRF5WvO184/ymXXfqRL0k/lZSQvCwDyoSc/1
	Un01lsri7gxJT513vNebmDEIQPJAeSTXz8+T+jnsjJOPGCXkWUPhy0eCx4gE8KqCYGIYzDn8M8/
	vNqBfrbyjOi0jSJNIJ30Ix0amHinhLae0Fhzumy6iawHdXtcGgZl5+68SbFgjfhgnRYTjvy0rGb
	RgTxaXatpdZVAe/Gzdvhcp3YdRdnJ236OPKyCKJ8/yaJmluPy1LZYsq1gLUV25x620qZzpySPLB
	KkG9VWTw1MyV3dRQy+wl+yxVpc9AYzlvnr9XjsciAvd8jWqJbcFKXC9RbMRucTUCNA==
X-Received: by 2002:a05:600c:46d0:b0:4bb:7987:fbc4 with SMTP id 5b1f17b1804b1-4bb88817eb2mr65637465e9.19.1795181099572;
        Fri, 20 Nov 2026 05:24:59 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm6280903f8f.24.2026.11.20.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:24:59 -0800 (PST)
Message-ID: <1f12636403bb7af3759cd933b2612d8a5d7317a2.camel@amutable.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Josef Bacik
 <josef@toxicpanda.com>,  Christian Brauner	 <brauner@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, David Howells	 <dhowells@redhat.com>, Jan
 Kara <jack@suse.cz>, Serge Hallyn <sergeh@kernel.org>,  Kees Cook
 <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, 	linux-api@vger.kernel.org,
 linux-security-module@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 14:24:57 +0100
In-Reply-To: <awBHZO2VwWyJzvBN@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
	 <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
	 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
	 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
	 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
	 <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
	 <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
	 <c301fff20a4920fcd3baa31dda2e31ad99c93436.camel@amutable.com>
	 <awBHZO2VwWyJzvBN@kernel.org>
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

On Fri, 2026-11-20 at 15:13 +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 20, 2026 at 01:32:57PM +0100, Alexander Mikhalitsyn
> wrote:
> > On Thu, 2026-11-19 at 15:27 -0800, Andy Lutomirski wrote:
> > > On Thu, Nov 19, 2026 at 2:50=E2=80=AFPM Andy Lutomirski
> > > <luto@amacapital.net>
> > > wrote:
> > > >=20
> > > > On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik
> > > > <josef@toxicpanda.com>
> > > > wrote:
> > > > >=20
> > > > > On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski
> > > > > <luto@amacapital.net> wrote:
> > > > > > cells: The dance where I create an anonymous mountns, mount
> > > > > > stuff into
> > > > > > it, and then attach it to the cell is cute.=C2=A0 But I think
> > > > > > the
> > > > > > userns
> > > > > > interaction is wrong: you are making me assemble all the
> > > > > > mounts
> > > > > > in
> > > > > > *my* userns and then clone the entire tree into a fresh,
> > > > > > non-
> > > > > > anonymous
> > > > > > mountns bound to the current userns.=C2=A0 And that clone
> > > > > > operation
> > > > > > is not
> > > > > > free and serves no actual practical purpose.
> > > > >=20
> > > > > The copy buys us nothing, agreed.=C2=A0 That's just what the moun=
t
> > > > > API
> > > > > gives
> > > > > me to work with today, it's not something cells wants.=C2=A0 If I
> > > > > could make
> > > > > an empty mount namespace and fill it by fd I'd use that, the
> > > > > "root" slot
> > > > > takes a mount namespace fd already.=C2=A0 Extending the API for
> > > > > that
> > > > > makes
> > > > > sense to me on its own.
> > > > >=20
> > > > > The mount namespace staying with the builder's userns is on
> > > > > purpose
> > > > > though, that's what keeps the cell from mounting anything no
> > > > > matter what
> > > > > capabilities it was given.=C2=A0 The builder sets the tree up and
> > > > > hands it
> > > > > over, so the cell only ever has what it was given, and the
> > > > > mount
> > > > > code
> > > > > isn't something it can attack from the inside.
> > > >=20
> > > > I don't get it.
> > > >=20
> > > > Using the builder's user namespace means that the contained
> > > > processes
> > > > can't be ns_capable on mntns->userns.=C2=A0 But this solves very fe=
w
> > > > problems unless you also deny the contained processes the
> > > > ability
> > > > to
> > > > unshare userns and make a new mountns, and if you can do that,
> > > > surely
> > > > you can also deny the ability to modify the mount namespace.
> > > >=20
> > > > As just one example, a mount namespace could have a little flag
> > > > to
> > > > say
> > > > that it's *in* one userns but its owner is a different userns.
> > > >=20
> > > > >=20
> > > > > > cells: I find it *incredibly annoying* that one generally
> > > > > > cannot put
> > > > > > new mounts into an existing container using most existing
> > > > > > container
> > > > > > managers.=C2=A0 I hit this on a surprisingly regular basis.=C2=
=A0 You
> > > > > > seem to be
> > > > > > baking this into the whole cells design.=C2=A0 Why?
> > > > >=20
> > > > > By design.=C2=A0 Allowing changes to a running container is what
> > > > > causes the
> > > > > problems.=C2=A0 If you need another mount, tear it down and build
> > > > > it
> > > > > again.
> > > >=20
> > > > What problems?
> >=20
> > Dear friends,
> >=20
> > Dear Andy,
> >=20
> > >=20
> > > I'll add:
> > >=20
> > > On a non-container Linux system, you can hot-add a removable
> > > drive.
> > > On a Linux-hosted VM, you can hot-add all kinds of devices, with
> > > or
> > > without the help of the hypervisor.=C2=A0 (The hypervisor can hot-add
> > > a
> > > device, and the guest can mount network devices or newly added
> > > USB
> > > devices on a port that was already assigned, etc.)
> > >=20
> > > For some reason, on Docker and its sort-of-clones, approximately
> > > the
> > > best you can do is rbind in a directory and then mount things
> > > into
> > > that directory from outside.=C2=A0 This is sad.
> >=20
> > +1
> >=20
> > I guess the root reason here is what you've mentioned - for VMs we
> > have
> > a clear separation of the host-side (hypervisor can hot-plug a
> > device
> > to be visible on a PCI bus, for example) and some agent on the
> > guest
> > side can react on this change and do something depending on how
> > VM's
> > owner has configured it.
> >=20
> > For containers, we usually don't have an agent (at least in LXC,
> > OpenVZ
> > and Docker too). So it is a container manager's work to figure out
> > how
> > to hotplug a new filesystem for example and where to place the
> > mount.
> > And this was always a reason for some crazy security issues, when
> > some
> > privileged process on the host was entering a container's
> > namespaces
> > (partially) and then suddenly become trace-able or bring some host
> > FDs
> > (and these FDs could be a way to escape via (struct file*)->f_cred
> > permission delegation model).
> >=20
> > Another reason is that in VM you hotplug a device, while in
> > container
> > you can only hotplug a mounted filesystem. And for devices we don't
> > care under which major/minor they land and so on - again, because
> > we
> > have systemd for example and it can figure this out. For filesystem
> > we
> > need to know where to place in in a mount namespace tree from the
> > beginning (we still don't allow mounting a block-device based
> > filesystems inside user namespaces).
> >=20
> > I really like your point and that would be great if we can solve
> > this
> > somehow in a new design.

Dear Jarkko,

>=20
> This is for v4 (latest).
>=20
> MOVE_MOUNT_T_MNTNS takes any nsfs CLONE_NEWNS fd, and populates
> CLONE_EMPTY_MNTNS directly and attaches live submounts without
> setns()
> and FSCONFIG_SET_ROOTNS mounts FS_USERNS_MOUNT filesystems
> unprivileged
> without entering userns.
>=20
> The gaps would be open_tree(OPEN_TREE_CLONE) gating (it's now against
> host), uid_map/gid_map prepopulation and a flag to deny mount table
> changes inside rootns() container while keeping external hot-mounts
> enabled.
>=20
> Those are totally addressable issues.

Yeah, detached mounts API solves a security issue here, but it does not
fully enable the use-case Andy describes (if I understood it
correctly). My interpretation here is that to fully cover it we need
some well-isolated communication channel between container and
container manager (vsock for containers? :-D). And some well-defined
agreement of how PID 1 inside the container can get an information
about a hotplugg-ed stuff. [ But it could be that I completely
misunderstood and Andy meant something much more simple here. ]

Kind regards,
Alex

>=20
> Br, Jarkko
> =C2=A0
