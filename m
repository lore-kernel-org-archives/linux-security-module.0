Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670332E5B34
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950698; cv=none; b=l+EONCvJ71+4qswd2UL2GhOH0eLA0CGI3rnCQD8rX1pQJCRE3MqQ00bpzB/cbbrWT9L7Ki/W80QPlaRODalvzKGmag3crFl0psw5B8t+VFwKYG8Qsb3OLkPxsx0LSbkgP9A2cjtFqCGQ0MWbGpdMhZZ8XEYnRDi25y1ptMruIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950698; c=relaxed/simple;
	bh=AwbGPzNmPVary/J6WIksxD7TIbFp54DCEPmfitu2QsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH/fuuWTpO3ozATNQcvxNLs8Ie4tjuWfURhFSMo9KsMIhZImHBrMR8VbbSoitISYPW8zuLodk9D/cpmhtAea+SHWGn1/TQA3hC9q65UA11YthKSB7fn4tr7zD1CNKcmXNm4BZFRBiNFk0bTqdtpAbJVYW+kBfkM8e42K7qhOLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EByJj2ET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EByJj2ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C29FC4CEFE
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754950698;
	bh=AwbGPzNmPVary/J6WIksxD7TIbFp54DCEPmfitu2QsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EByJj2ETwGK6AhoemMsEkSNw/FBqCsac0Vl8pFZNpkXsFZbRQezsI+fyXhfdc4pZE
	 +zakIIA0j5qgE1V6UzL59o0MCGTx7Cc5xRSCu3FEXVe7FpriaxSl4XstdPmxhvkFLG
	 oj7XpE/iNzCrZrzCHE/ZH2jR8bQwuemlrD50s+DO3uyunpPX4V4e9H59rDbZH3B2FD
	 sgEHTRShBQZNDj/Xs2MFomtTk1HGvKMTHMb3ShHhv2zjbNmfsHGa5VtpZbpJqsQDKt
	 W/Nw2HVdp+daQSYXFRofMon0Bb+W4G0QyHTcyJUY87vApw9oEXOp+7gpy3zYIallvz
	 YObawirdqN1mg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso7577944a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 15:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdAwnmcCjj9UgJaDi+2VvSnThXRUtixtSESwzaYzzX43TZ9pTTvg+t0hyLFIuhWCPGV7DRnXoMfJAHxR1WzCpaye1DApo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYga09BxXSNffhSadEBiTKmVLQNZ+Z1yaLtxiXHLSXgndZPqW
	tUQHorDLukDtY+mlWiaVzguJtTzjfSk8euPYkr2CwYH5kiSJ2vYdrjYcAXlPfdKixEQHvMgwmgA
	UwRpeJw1znlwXPzRsqprH8wQrKFVsmJhtTPZWmydw
X-Google-Smtp-Source: AGHT+IGxEOUErs45f9i192mdKIA62vfUhxTEw7FwSHJfH2LtzH12m9XGbkQCFPu20+bdBssNq4CMoIqkcAKHbidY5A4=
X-Received: by 2002:a05:6402:5246:b0:618:30f3:1d7d with SMTP id
 4fb4d7f45d1cf-6184ea28edamr758767a12.2.1754950696469; Mon, 11 Aug 2025
 15:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-5-kpsingh@kernel.org>
 <CAADnVQJ=8Y_k=JtbNQuhTTCJn33iAniAEh6MLN1BfTZ6pmP=WA@mail.gmail.com>
In-Reply-To: <CAADnVQJ=8Y_k=JtbNQuhTTCJn33iAniAEh6MLN1BfTZ6pmP=WA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Aug 2025 00:18:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5kCZ6Wy7J3oWpAGBO61adf5+oy-1Ay7TEifyp75LbSRA@mail.gmail.com>
X-Gm-Features: Ac12FXxPEr7GuGFOSuuMZBu8hJQ_1aUCiKIKmCwNxV7tEA7e__L_wPOBvTdFzRM
Message-ID: <CACYkzJ5kCZ6Wy7J3oWpAGBO61adf5+oy-1Ay7TEifyp75LbSRA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] libbpf: Support exclusive map creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> >
> > +/**
> > + * @brief **bpf_map__get_exclusive_program()** returns the exclusive p=
rogram
> > + * that is registered with the map (if any).
> > + * @param map BPF map to which the exclusive program is registered.
> > + * @return the registered exclusive program.
> > + */
> > +LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct b=
pf_map *map);
>
> I couldn't find patches where it's used.
> Do we actually need it?

Andrii asked me to add the getter along with the setter in:

http://lore.kernel.org/bpf/CAEf4BzZghpnHaV+z2GYDNCApzLuxMW6_=3D4afgpO+D7AG-=
zTSFQ@mail.gmail.com/
