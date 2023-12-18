Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F337863
	for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="g93WYT+Y"
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E16DD3F2CA
	for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702916284;
	bh=QB+Jj19JnPHT/m+V2bxDFjIga4gzUMzhCmv6eWWgIMU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=g93WYT+Ysw5vut6ghy0JNTrFPpjEfWlZbmRtvhpPss4aRvhnKSiedT09GcVyRoBK9
	 jixI8r8vhwDlRkHZa+rR7JRRKYwPJ8E8HzyTnAKvZugS+w/FE1LqcMjse1bbDUkG3r
	 LPuMzEvO4scxUqi1QjqkC04vWnGlAeaYeuA89+ZlRGjgzi9+JJFLh6RkEDYsA/WIBR
	 tA/GytX/L2k1tf4d/9mfiYuA2RlpWAKdbopwbFXambBYIWANTPJ9zktk807ERmT9iB
	 ikDwv9LIhx2NCzruY/tq7I4hUh065XfmRI4Ex08vlwLYjDfuikAItGUjerghifzmr9
	 IEwdXv8EaIdug==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-553825a2ceaso55168a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 08:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916283; x=1703521083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB+Jj19JnPHT/m+V2bxDFjIga4gzUMzhCmv6eWWgIMU=;
        b=VOafqsMckuAZSiz/y2fg8Y18jBHLvYAl3rk6Qql5JBN5HEsm0oi3lSfy25cUz/uRZa
         uhl99aiLg25Mz36NdhaRCJiHknA4VrPL4LH4/nuuveP35H9mDH7jiHI29H/CRCRqnOvT
         r7/mN89y7gQMKx3wx173HtsjI8s9B2rdsm3FUXEHvr/cjpOTLFZtlLo4tby6IAj6+py7
         mMdOb38rmoyjm8JCZEmwR6uRcdSqmEN36ocfFGh6uCQul797ZMiyrGFvIgEcszjxdGAv
         hJGAPUfr48GmhhUEKldP/fBUeK78pDzZ3l5wjOUEwYUYJeyEoHyqPlPeBMi5Co/8Cp0a
         RfYw==
X-Gm-Message-State: AOJu0YzkP1as3lY5FmNHde6BGUsERF7hLw1/E7BFQPNGLn5lrhxfJZIN
	QRbahuML1+lKZRlm9UQo7jSRtLX6iGmlpOHqnzWuiGwv8yjWmcWd1xcg7uWW8u1DR5BwAJpRqr4
	l8bCFaX/wcFpalCIawiXQk74A9OB4dG0oDLnUb78i5yutaJh7nHIhMQ==
X-Received: by 2002:a50:9fab:0:b0:553:4bd4:1d52 with SMTP id c40-20020a509fab000000b005534bd41d52mr1350512edf.75.1702916283145;
        Mon, 18 Dec 2023 08:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/014KPPmX/2dQoNTubOi4CoRRFxNtgfqu+tmEfmjToiKyFQxTOvuQxDG5OCH2haGP47bAYA==
X-Received: by 2002:a50:9fab:0:b0:553:4bd4:1d52 with SMTP id c40-20020a509fab000000b005534bd41d52mr1350484edf.75.1702916282769;
        Mon, 18 Dec 2023 08:18:02 -0800 (PST)
Received: from amikhalitsyn (ip5b408b16.dynamic.kabel-deutschland.de. [91.64.139.22])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm4566692eda.59.2023.12.18.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:18:02 -0800 (PST)
Date: Mon, 18 Dec 2023 17:18:00 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Michael =?ISO-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Quentin Monnet <quentin@isovalent.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir
 Goldstein <amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <gyroidos@aisec.fraunhofer.de>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-Id: <20231218171800.474cc21166642d49120ba4e4@canonical.com>
In-Reply-To: <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
	<20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
	<20231215-golfanlage-beirren-f304f9dafaca@brauner>
	<61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 14:26:53 +0100
Michael Wei=DF <michael.weiss@aisec.fraunhofer.de> wrote:

> On 15.12.23 13:31, Christian Brauner wrote:
> > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Wei=DF wrote:
> >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> >> namespace in cooperation of an attached cgroup device program. We
> >> just need to implement the security_inode_mknod() hook for this.
> >> In the hook, we check if the current task is guarded by a device
> >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> >> helper. If so, we strip out SB_I_NODEV from the super block.
> >>
> >> Access decisions to those device nodes are then guarded by existing
> >> device cgroups mechanism.
> >>
> >> Signed-off-by: Michael Wei=DF <michael.weiss@aisec.fraunhofer.de>
> >> ---
> >=20
> > I think you misunderstood me... My point was that I believe you don't
> > need an additional LSM at all and no additional LSM hook. But I might be
> > wrong. Only a POC would show.
>=20
> Yeah sorry, I got your point now.
>=20
> >=20
> > Just write a bpf lsm program that strips SB_I_NODEV in the existing
> > security_sb_set_mnt_opts() call which is guranteed to be called when a
> > new superblock is created.
>=20
> This does not work since SB_I_NODEV is a required_iflag in
> mount_too_revealing(). This I have already tested when writing the
> simple LSM here. So maybe we need to drop SB_I_NODEV from required_flags
> there, too. Would that be safe?
>=20
> >=20
> > Store your device access rules in a bpf map or in the sb->s_security
> > blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).
> >=20
> > Then make that bpf lsm program kick in everytime a
> > security_inode_mknod() and security_file_open() is called and do device
> > access management in there. Actually, you might need to add one hook
> > when the actual device that's about to be opened is know.=20
> > This should be where today the device access hooks are called.
> >=20
> > And then you should already be done with this. The only thing that you
> > need is the capable check patch.
> >=20
> > You don't need that cgroup_bpf_current_enabled() per se. Device
> > management could now be done per superblock, and not per task. IOW, you
> > allowlist a bunch of devices that can be created and opened. Any task
> > that passes basic permission checks and that passes the bpf lsm program
> > may create device nodes.
> >=20
> > That's a way more natural device management model than making this a per
> > cgroup thing. Though that could be implemented as well with this.
> >=20
> > I would try to write a bpf lsm program that does device access
> > management with your capable() sysctl patch applied and see how far I
> > get.
> >=20
> > I don't have the time otherwise I'd do it.
> I'll give it a try but no promises how fast this will go.

Hi Michael,

thanks for your work on this!

If you don't mind I'm ready to help you with writing the PoC for this bpf-b=
ased approach,
as I have touched eBPF earlier I guess I can save some your time. (I'll pos=
t it here and you will incude it
in your patch series.)

Kind regards,
Alex

>=20


