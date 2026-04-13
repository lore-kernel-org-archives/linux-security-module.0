Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE10200110
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044331; cv=pass; b=caex6kCgGD6pePW/+m4OgGwe3mFxytcBmPu4HsuYyiVqWRPE0gIrPMf36SAm5/WzzbFD0VRb1vymgpISpnc71ljlGJzCC2JQX5pcDyHv56YJ07RRcBe2X4V7iHcJyBvmmKNiHIdYtKXBy+dKzhxO6hcGZB43x9BlbCjsNM34glU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044331; c=relaxed/simple;
	bh=nFQMxFVF63QIAvOySvI+1iQgD3HbEkVh9BhKaGfv3zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdJLTjpfjjnTc3U5eCkk/N1YKNjS7l27IEFG7KPZRfyoPxodxhCd8bv8XXDx0kYgSe6VdyoIbMYMgoBwRM1bYTSZF+UbX8a9QAdtVWkUbOlZqVJfqBbGSWCPmX70bcqVitB5ifGTY9b77prpbx+nxd4ztGFT5OdJ9KoeKvvt53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eKE915kT; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eKE915kT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2422369a91.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 18:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776044328; cv=none;
        d=google.com; s=arc-20240605;
        b=STrN78QPM9FfmVlXWEtoMEViFeQoaqZvkAuiArpz6MDbR5s2TIE7DXjNGi2Uqm0YZ5
         zCouvSPy7fHEUpUOol9nk6JFdY95wN39PT2lR4N+RR6g3fo35P1VLgdJmAqQPlfz7qxy
         tcbjsPClPktgcqytlc1KE3U6RyVp8W258vQLU5Kq50xqOKriLRcSV3KbKEw6/P4Sc85u
         g9J/MJ+DRAJAiNpQCSr7a0eEOy7VbRVXgdQj+OTXTluc5jb/7P2rqfQH8uZDMyTVZHDn
         h0b6JZYhsQIxMzcR2SSI+ShSY2NbRKNSN9LvWKa+L2EZFR/Hka4xzkTeyfh2Yj95Xajh
         AgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        fh=46dxSrv7wvudTUH2L4PiXUNkiaDV7pWP0/YYf4LtJus=;
        b=j5DV3R4FcWtkQP0jLdEMkww/HC26tNufcGCB6CnlQvuGOMNXzv6I2WlfRtqXsmE0PA
         EWb6MsnsBgFFkA1XySPFyJkiko6Z+RHpN/rvjptAFMvYOr+492feyY7ZwrdexMVc0Ace
         yzPERkimVLYG7LDBQhSWepaFjRdOruEZeUTujFEHCJAGx/Vo+O3egi11j7KmkXLYl0JE
         AgnSILjdeMASGNNe+RBRmljgjlKNtY8Cwj8bACoTf4MaJrRJbkAjmobRJDhK+C0ADqtO
         1/4An8baL1AE0PJz0k4kmacrwEDj/U+zXZvNeD7HopKiWcJqYicBcNvSQ4bN6pHZFE08
         NpUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776044328; x=1776649128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=eKE915kT3+S+mLQpSv3WJJllJZL/rf+5tW81dTt/VcQBQmgXELrog27o4zy4CEjsoU
         +v3RHtxTvZeZt2a9GAo4Qmr626+pPtGF3BOBmSlcJ8ZBDxC8LM7kCyz4QShBkEC+5w3f
         hOpDkHeIynke8mnG7Z1NnJXU2fC1A5ZHio1CnH4fR887v4rM26xdrha6gmofMI5Duh/N
         E/CAq+/NIBUNICffAMLYY+17nyxZaBuK31dz9PyF7xfHLF2nrXJ3U+ipmQZYS3/FQSFh
         HhDDtTrE02yaipqxGDhtYhVW8CEBlnX58VdF3oDqn6uaZEj/ruFLfnwN7FnCvdXbEBfN
         Tm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776044328; x=1776649128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=RjQKxXvkU4ZuOPtZp+wToovnMcW7hpIjiKZUqbYA3nt7jWS035rWxcIFOTWtdrrPsZ
         2NNOPVpXghenYxuRXjsPoNSfJ7IMnmXfY9gfkptNrOi5pxtnbWom9DYPZC92Tvv3KDze
         6KXyzT57FSSRx0zJ0ce0Vi+sBUZySH+XIeeLjTQkFXqfCDG+g8mWjjkd/hc/fzUxxWKZ
         I5sFdxhFkDNFLRl2pPMiQ0olQ3PcokrL9um+ymEjPeqeDBxmCTQ2nMLbeWofYtussvfO
         tT6ZVGkkNZD6kZhr9v/++kZk0ZqD2ThgSVRweammCD6lPDtN6fB9NuZt4G6AtP5TdGMt
         uZoA==
X-Forwarded-Encrypted: i=1; AFNElJ+KEvXRpe/nab/nSJtsX6K/3kfg71O/2tKCc/gmFDr5bH117R/DK/EYDQEt8e1nIXRZ+dI3O/Tw67+R0tYrdkAmwnavRqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8RT2WAIYtwSeXKTR3Gg++FpuU5XglZOWBTtdM2DgsSsQKzrP
	EKup21a+MH0iowaFXmqWq87TVaQdvc2CecwPZgT+mtuikptnETgmcgtqyj/E9d14Cf19mZAVmua
	A+8SgDa+kwQbo8YJj4wrUA5MIJLGnYPtjp7d41f34
X-Gm-Gg: AeBDietSpBHKQHrm+32QD+7R6A+hSNhU38xhuPKBsq0IejExJf/DG5wPWFXjOVQ9n8A
	F8bBHy6yWUAP1H1obTvQucPBs74fjpkCLgn3Kk6DsOp4V4BUEAV/6syG+fXQCj4D9MniB/mv6F6
	utVH9nBPakuhW7Okn8c4AUSi0Lnd+qCS3FjkkyXhFLE9bn0yRKR+ivDbp69b+59n2v2RNX/gFOf
	5JWbkKUivdePWKfyejCzsvVERPo5piWU77YIpP5ipEw5GaJXr1SHgWoSNUc2OoOcAUp10HewShq
	CW+Yep8=
X-Received: by 2002:a17:90a:289:b0:35e:58d3:3286 with SMTP id
 98e67ed59e1d1-35e58d3350cmr2477282a91.24.1776044328031; Sun, 12 Apr 2026
 18:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
In-Reply-To: <20260412090006.GA21470@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Apr 2026 21:38:35 -0400
X-Gm-Features: AQROBzAOzVjdc2Fm0JK51NQkLRAYu7tuztXcHDPMGgqzx6OZVzpwqD1l_OckOpE
Message-ID: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 5:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Thu, Apr 09, 2026 at 05:04:24PM -0400, Paul Moore wrote:
> > On Thu, Apr 9, 2026 at 8:45=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > > On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > > > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:

...

> > > We implemented this approach in v1:
> > > https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidi=
a.com
> > > and were advised to pursue a different direction.
> >
> > I'm assuming you are referring to my comments? If so, that isn't exactl=
y what I said,
> > I mentioned at least one other option besides
> > going directly to BPF.  Ultimately, it is your choice to decide how
> > you want to proceed, but to claim I advised you to avoid a LSM based
> > solution isn't strictly correct.
>
> Yes, this matches how we understood your comments:
> https://lore.kernel.org/all/20260311081955.GS12611@unreal/
>
> In the end, the goal is to build something practical and avoid adding
> unnecessary complexity that brings no real benefit to users.
>
> > Regardless, looking at your v2 patchset, it looks like you've taken an
> > unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
> > but not actually exposing a LSM hook with proper callbacks.
> > Unfortunately, that's not something we want to support.  If you want
> > to pursue an LSM based solution, complete with a security_XXX() hook,
> > use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
> > with you on that.
>
> The issue is that the sentence below was the reason we did not merge v1 w=
ith v2:
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hooks
> "pass through implementations, such as the BPF LSM, are not eligible for
> LSM hook reference implementations."

I can expand on that in a minute, but I'd like to return to your use
of the LSM_HOOK() macro and locating the hook within the BPF LSM as
that is the most concerning issue from my perspective.  One should
only use the LSM_HOOK() macro and locate code within bpf_lsm.c if that
code is part of the BPF LSM, utilizing an LSM hook.  Since this
patchset doesn't use an LSM hook or any part of the LSM framework, the
implementation choices seem odd and are not something we want to
support.  As mentioned in my prior reply, you could do something very
similar though the use of a normal BPF hook similar to what was done
with the update_socket_protocol() BPF hook.

There are multiple reasons why out-of-tree and pass through LSMs are
not considered eligible for reference implementations of LSM hooks.  I
think is most relevant to this patchset is that an out-of-tree hook
implementation doesn't necessarily require a stable interface, and
without a stable interface it is impossible to make a generic API at
the LSM framework layer.  As you mentioned previously, each vendor and
each firmware version brings the possibility of a new
format/interface, and while that may not be a problem for out-of-tree
code which is left to the user/admin to manage, it makes upstream
development difficult.  I did mention at least one approach that might
be a possibility to enable upstream, in-tree support of this, but you
seem to prefer a BPF approach that doesn't require a well defined
format.

> > However, if you've decided that your preferred
> > option is to create a BPF hook you should avoid using things like
> > LSM_HOOK() and locating your hook/code in bpf_lsm.c.
>
> We are not limited to LSM solution, the goal is to intercept commands
> which are submitted to the FW and "security" bucket sounded right to us.

Yes, it does sound "security relevant", but without a well defined
interface/format it is going to be difficult to write a generic LSM to
have any level of granularity beyond a basic "load firmware"
permission.

> > The good news is that there are plenty of other examples of BPF
> > plugable code that you could use as an example, one such thing is the
> > update_socket_protocol() BPF hook that was originally proposed as a
> > LSM hook, but moved to a dedicated BPF hook as we generally want to
> > avoid changing non-LSM kernel objects within the scope of the LSMs.
> > While your proposed case is slightly different, I think the basic idea
> > and mechanism should still be useful.
> >
> > https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com
>
> Thanks

Good luck on whatever you choose, and while I'm guessing it is
unlikely, if you do decide to pursue a LSM based solution please let
us know and we can work with you to try and find ways to make it work.

--=20
paul-moore.com
