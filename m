Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED83487CDB
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177876; cv=pass; b=JIWjuuAY8xLx3pmcgW/L2GQg/8ynPzCmVL09bszn6HCGO1sbPeUShwdNSjDitvqlSIqgL0HfZ291vKMlUxKz/gIeWOGot7V8vmdy8Y77XRG9aXTyi7FWY62X3D/MW805k55HHiEMFBYxQ/ojN532YnVWgINb+lE4IyYTOQYmHQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177876; c=relaxed/simple;
	bh=qppVgsYFvGGhHcWK5q8fwgXEoXbm8x8Kajt5Kyll45Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxgCexgAt0/E4orv77ao9c4+JOFLV3kxfPC+OklC99NgLC/HkEnxFAtjwbxvw+KiAU7nrcltc4SS69E2k8JCbZGnO3URczc7uUtMIfGUtpfpBNVrkEjpyLAWK2KJO3bRMAjOfSjN2srVJ4hmKgdS1196iiTxpb2WFpZh0hw+OzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNYHVnir; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNYHVnir"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0d5ddafbcso2396457b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 12:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792177874; cv=none;
        d=google.com; s=arc-20260327;
        b=OXxV1/rC/XYs4ElSX3sXidanAtYDDyTUW2thlWXV09q1Yt5yihcZnTViCrZFIbRbVq
         k8LfWTq9623rR3hkLNmIJg2i/65jhj2DVydbD3nZIdnclXcCh0Hwk5//MPsY6PfiGjjy
         UBYE08WXdiBQl9u0kQEO/Yggr54Vr35NZXDNz5ok08MNthQ71mFZgmVvSHEDHTN29jgD
         bjfGixp+3eWegpf7jC4vIrrCuNoI040aaVeddIUCeyozQ9f+tHec7ItlMv6U3tAnPnT5
         npZnDLpVXibcKD4KRXp4OYVKstY5oodlr93YQeBR+9D6sqvUHEPJ0ghQXTq0dK2gB+Be
         1X6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        fh=qRt1tY6xn3W5Ryj6GcxvD7Bf3TCUp/vH7G9eWxydcqs=;
        b=Swj4Ftt99P7hKPuNeWzyelQM2AFDmfIngu+IDgJ2gGfYECg0naRk6AdW7vCzGfh8fE
         E+Uq1PJGaHd86ErXlHIuYvPtGH/onPOgQ8E4peWKJq4XGpRswuwbjlnO+lyvQJeER9nt
         GEN5rkEEWWj4Y+paXNe0n5qcOSUiVRoMJ7thmLQ1UpsJd+K4HiEtPVsh1CItfLEjgyIb
         NQPLlmMhMtGmIEhJPeH76mlNUd/g3hubAkviYQ64RiMCK4NaxA3uhWxGjGxOeYLYK8m7
         Ji9couLSp2zAr+SCTI8+sVBqtCxsZA4zDuhV2j8XtS+fMolJtq5hjpGAW3rEuv8mB5wV
         aAcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177874; x=1792782674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=lNYHVnirjmv/XVzkDQrJJrtTF9KNDAbXxawbFWCxJHjZruMMjPqAmhqeKnvX8Dhuvl
         FqHZWxxeA1e6BytDa6B6qWm88wVrLzwDEykURFCxQx3GhLCfSWQ8hX24aL5jkY+DOSeW
         a5LUkceNq6eXRyJXYk91Xsrolvl4ZLVSW09ID+JiLAiBJwZlMk/9roGrfDRIobieGdYA
         zRTfkxGvy0mJEEGWG7b8rFrA2HM049eB2dHGCNYgNMRsupgebUZYB35BuuWYyM+WZMB3
         UzicVHJkTFg9yRS0FeittYF0id7wNbKhs14p7mRXpKok2DzsraiYLJVstHVmYBs5nriU
         CoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177874; x=1792782674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=OsPbYiBK9gbnZHFbc+Nxse3mRodUnPd/2h7tOwxNI157AMXSzSE5KmY2Lv2Gy0jIwn
         AE+/5IeCoF5VPpOPD3LVvA1zOwMV6cuDFewM6/Qe27L8REQj1/5yppzbtEcpsmIbHY6o
         ZWWCg95KL+hlv4xD80k/R3a4Du0jzo3Uyyaiz7F3oG3ZxwghJb2xbpmCsbsQwBCngPD3
         /a8VVhWd19f5UNJdw91fL7NDHM+XYM8pYDWMD4sUzUP/XqjEWM1BBoSBCWCt+GBTUdaZ
         RRieGmPZmhq9mAmZ2boUymhYgY/SEHqqolcMivGmjSzGgLgP3IJIsvecK9XiKeu4jv0C
         g+nA==
X-Forwarded-Encrypted: i=1; AKwUvBxt83EkhBGPBniQzQj9yBloMpHhgNS4yeriqofnjWCxbigF0p/AWhuDN3dHcNRDIMIhaa5K/us2LG25AL3GrCb2YERemRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjdVveRRtBRB+WfngId36dmd5/RK0yNQSmGRjyvRSveKFLJsqy
	ZY63bM0suNmNwU/DS29fRrVtwnN9yB9s2X9xR9LBX9O+ALBzBTBbfLFx4N00V8PdjJBGnEFs666
	vEv/8pGzRpcOFmHJybkaBKtwjoHP3s2M=
X-Gm-Gg: AYBFou0+OBAZLvlHBhhk26Mzim2Y157daF7qzaaZHdQp9gzc50V0zf8p7tr+hlMQUST
	ecRgp/stSLxK+Ks/LBLIPC5Xmt/a9GeIyhkHWOsZB/M0EapowHUPIS2g4JMwxCe+OcUPeSlTnbY
	ATFL29gUC0HWcjykZXfuKb7l/+2FVY/fA0NwIchUcp3O1vVAFKCvWd9u5zrlLPxVMuhOk2q8J/Z
	HicEQOESbj6IE3uIsp+ytsM2ToLIcLqcobb1QD9s9pOyzfWxg4D6/+jmYAyUvqRoMNcJPvOVtrc
	XVu0xdsY/Vuqi2sBOhHe5f+oEak0opXWwV7HsV8j5JCKvkR4TSCuzVYeksmGpl3/KQ==
X-Received: by 2002:a05:690e:138a:b0:679:c9af:6d51 with SMTP id
 956f58d0204a3-679ca86652fmr108710d50.69.1792177873691; Fri, 16 Oct 2026
 12:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 15:11:02 -0400
X-Gm-Features: AclHuK82Reo9t1Q_XYkamM6mGKm-uUZWL-8Kv3QM6WU-oPDk-hAS-2iAswxeKCA
Message-ID: <CAEjxPJ7fLbBANfjcgN7Xa+axbQFE5ZALWzXxRz_kQ8zGvmw4Rw@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't label bridged packets in selinux_ip_forward()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:37=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
> packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
> calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
> CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
> header and reset the network header, but the Ethernet header stays
> where it was; when the bridge pushes it back in front of the packet it
> picks up stale bytes and the frame goes out with a garbage destination
> MAC and EtherType.
>
> Labeling a bridged packet based on its IP addresses is not what we want
> here anyway, so leave bridged packets alone.  Add a stub of
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=3Dn.
>
> Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
> the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
> per case:
>
>   case                                        before        after
>   CALIPSO packet, unlabeled destination       MAC garbage   5/5
>   unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
>   unlabeled IPv4, CIPSO destination           MAC garbage   5/5
>
> Routed packets are still labeled (an unlabeled packet forwarded towards
> a CALIPSO destination gets the option, 5/5).
>
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security att=
ributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_=
6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
