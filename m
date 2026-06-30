Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185B37AA81
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845212; cv=pass; b=acHtmF5TfjYR+dIAhjXpC3K1HYwHoFYt+0ZIwKUNIJeyoXi4Uvbvdtfmvxeq19zPqoPyJQPIpnIkyK3uyA8N68oYlTjZzjAcEktaXlQd7yeJkoMi74nsQmt/SZMy0sQkh9IOTUDqDcrPYeDKwunj7WDANk3/Tl2GYXGrGxEkatg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845212; c=relaxed/simple;
	bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagPiu/M8JJzhHGRma+PV2v45T1fNxXfnq6PXyf8AACB0pzum4dwzFPP5oZDsNDk49Nnx/kAjUNjukI3CWDyw2kOk4OkfP9yPQaCitOrusikFsfaB9zKEZ4P0ixR7V0L8D/ZiHIjpYimoyQFo198NMemIu0uYzcJyiweryqTvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSgW7XY; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQSgW7XY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efb708b1a0so29217416d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845210; cv=none;
        d=google.com; s=arc-20260327;
        b=r1nqBsb0jRrLfwbIVKbJhJH3cATxvzmLFqFr4b1LcgGqZ3AKdgUWSYm85sYOrrF03/
         4FW2wOzCk4vpZen/GgRnGNMV7ArDtTkEXQOX1VWDT6pIVzotCG6hsPHm23MTP1Fef4Td
         EoCrsfVcgNelqor92NJBnEYcxmFKtQUNBBhbbSRsSHTLdV2P0FyeW3mXis4X2J9O+FiR
         gHLfuBTN0Y3p7oouihzhfevHGjd0aT/QcSZtuRIEUCL4KeuiUG3Ir3ucWJjGRmdmLABx
         P0d4ZPKv2krcFGGe4kvZ69IrTZHU8ctwDL17YuqqKKyZ3+x/FWVv1Q4Mqg4UvtHTehrk
         i2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        fh=RCXPhOYQDYtvpgbZjoBV1EiahzGhblfV8wwoel62EdA=;
        b=MEyK3ghj15nJPBOS6GeQRv5vRIrntcpKOFMD/xg8s9lecqFSKiad52hjED6LvM6+bt
         PTJgABDi4cPwup6R1MgxhsE0bKFCojs/4FwIOpfhvGWS+jOIvoErLXApqhYQagzzta+d
         ST3FkM+u0YGmTzFpRAZX/xlR+MeiMmFVJJWe54xBwZTa0vi0o6GlV4hAiv4vVCPv/BC6
         sjYwBdt64yc1CACb/X9gUitS1827kl6Xv4rZ9QgXtubyF4UAHZ39LWNpCUreQlp8l9Vd
         C+G0rfnhRIMu5/CM3AUTaSkbgu1OfNPwabnnEIuAfVpWLOG7Qmz1/8i04tXGWvV1xng/
         o3Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845210; x=1783450010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=EQSgW7XYwFqpR2UhR5oIjGjz1p7Sl5z7prkaHtU62QYm16o5fwYNMZbZzXDw4N1o7w
         TjaTc8/oiqjtm0zKD8i/CcS95pH2dm+43MADe2rn9aMf1hKPGLdSdl+rh7nEvSKdwdWb
         QjR+GW8xwXjKE83wXgRxXBKZFIbpxBvEorTFKDTnaw6FQqAGR1E6nY0qU6hw6SonOJ6f
         UnNgIa6B4mckZ2hxw1SIudwaouFYge5A1ubJndzfYxye9NPihpkUAmXXjBYL0RLjqY1x
         hVUSvSmtURF36OOyxm9jT4L44uwrOo02x0k956HPazkIOlQs3pQRuCDykMIY8f+Jh/HA
         PW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845210; x=1783450010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=SXwluXx0Z8pH/VHN4zjr1/Wwy4uLQ4mXXu2ZZMFWbf6Yob1uq2mn6WLHYeNx8faKBS
         HOKwUoIVw195bk8M22q7S1qLqnNB57+wQXc7oMQzfwdbZ5/E9sbgmVnRjjgdmP0nCo0t
         gXXNMC7/3ejoH9PFRYRwzGK+4swHJx/js7hKWvKjC+vJpOitz37w5mF4jtx733BUmwcE
         zWPTXBTiJ0ESLZDTeFBDFWIkL6fRnuLcgRP//yoEl1E4WrED4tHjRh5UnM0QwlLD3GDO
         XWD0cHZW8BYy8A8/JjIhNBX2qCqsyPpcFlcNnqnhUUh4HfPDvBW5+96ngsBkLoLgZc9K
         xnsw==
X-Forwarded-Encrypted: i=1; AHgh+RpImS1JC2vUlepXqdb4CKRBTkA/+Mc+aE3LMhCOHpddvm0KEl6f/24NEWYjujNlwv8sFbjeDNow0CfN0kgkfOpte1nzJE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCO7IwUkRuXOeemmTl9KnAg9H3aO8ob8fSuDIX5VPqVJ/PyooT
	UqZjwLNM+ZZqnelHiJQtrblDSZpA0F2ufXTBBChgZXWGixmZ5ieE5DV0nwSAmlGnKk02PddQKon
	E7d6zfGtUhKikLgDoCOU+FX/Vvd5D0I4=
X-Gm-Gg: AfdE7cmlSMKP8GaZuJHlne2t5mCU+KaAvk1yPRgJbFp2aJBw/eBy0HQHQFtjlSoPurt
	O0F31TI6KfvHGCNYG/vSDm4LC0nOUz0FaGc5gKTyMw2TSYUnvS4xTE8zBl8bIGaiQqNWWi/jNob
	vGPxi6JVMU79d+SgB/ghodu74ZZTVjKOTp+/8fyTiAwiuQ43LHpNqvOxyJWyS7upk9Zpx1B1npe
	UWLj+rp87frenvHH3jl2Wg60en5ICEJpuMOk3N7sJMfjyF33gwFg7A7mFpNu3Ff3ksYVy7sAuMt
	LjsiBYRcUJeTsNn/BfuGndJ83lXY4ZNfP6jHtQ==
X-Received: by 2002:a05:6214:4d01:b0:8f0:b08d:1327 with SMTP id
 6a1803df08f44-8f1bab7325amr66906576d6.20.1782845210237; Tue, 30 Jun 2026
 11:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 30 Jun 2026 14:46:38 -0400
X-Gm-Features: AVVi8CeaiheJ3F5i-jO4LvtVLGlRB5U5ReoDcpDUEtFteA-6-xXjOCWxSS0LCkE
Message-ID: <CAEXv5_jCoYbs63RRukH44CMCxiOFzvWWraBOunKrgTVw+inUPg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
<snip>
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

After Alexei's requested changes removing the attach-time checks,
there's really not much left to go in an LSM-specific kfuncs file. The
bpf infra plumbing for registering the kfunc and bpf_xattrs_used()
seem to be the only LSM-specific bits aside from the kfunc.

I am willing to put this code anywhere. I've tried to CC all involved
in all 3 patches, even though there's some split in concerns.
