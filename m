Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37653F9F4B
	for <linux-security-module@vger.kernel.org>; Wed,  6 May 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081639; cv=none; b=H1TzCqi74ZmztVpVzX5Ma5zr4W/wVIw6N2Xcwg+EMizhZeTprvGmGl8m+rpQ4xO43Ld5a/QBoQdyu9gGDBtm9v6x3BwDxUIhUfyGm4lxJiAwqpj6TYIob935QjjCw/A5Q11HUYf5QAYHwXk5mdu2m9zZ1a7ikXwqUMHD4dvCYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081639; c=relaxed/simple;
	bh=v7iWJA7AOWqAM5g8QOaOTdACaW3JaQX1YwwtDoobk+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEt5yAkAO4HhSPz4DyiSDZbA1cnMlrpO6rDoyNt4d4QH7Ftp52iex54znc/qWbIEpBCANy0i04te/Xb7+4SghIFTiX44lY9XpBZBK8wQz4g7Mzlv8tkm3HQWbiy//I+Nok4a3PU43EvYKHEZHz7Mp2TXGnn8RNf7eLLgVOyGRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/O1ZBHG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/O1ZBHG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so93335915e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2026 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778081629; x=1778686429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPgcwkvVhL8aXocPAgoIRAhV9vFqMpLjuj83PIidEBY=;
        b=I/O1ZBHGO+5NYtv/Jz2fe90F87I4XbCwMI767rGH4xPBExZDXi1S1dANoOUY1+U/O/
         iQpEea5bZVhTq0A0E0e95IsDY/R68RBGTk9NfOtHLJqrGnrsthwY5au2Lmx33YsjV94S
         Cm7e2DYF+7Oo9fjkO6c2OArRKhPOZ2uV/k/m2Qzj8hhcNL2z0m4RYRwkBVkXJndfWJiZ
         ShHYg8pUmSOiD4VsEr60z1T5t4sQLGSsCCQwtDEWREXDGJ25E/sk8RdQy17SDCp9fyVQ
         4ow8Kd2xDtXvVlehyU4lBrMunGPrh/H4e5xzcXL8mJV19LHUrtocfVL4rFOQz/aY9ISz
         bobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081629; x=1778686429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPgcwkvVhL8aXocPAgoIRAhV9vFqMpLjuj83PIidEBY=;
        b=VDQU+O0uwRxu7bcJa8zWgwvCPSu2vqtaBMewb/JDuSRUmdDygn9xk6vGepM6jP/oeE
         5YZkwcm2o9h4fTT5fUarcXFe9Klkig495X+8DlblMJAkerzr0DE62lNws7rtdJGB7P5N
         9ZzFix7YZ16dIPfy8hXPKJY4iSqsnTsPILITDoTupY9kommsNv3Qgda5/BcZtjTjTzT7
         NUqszZ+hmUosD/aUeq7ulWnKPQpMNtUuvrmto7jrsgNiKYARacfRKcoqAeBhKxFfAXSb
         UEh9Qd8bEkEjomP0S7HFVrgj/uD3LUcWUxov0aifVjdOgesXuORi7Se736bZaqVupTEv
         nQmw==
X-Forwarded-Encrypted: i=1; AFNElJ9zne041TbwtjG/owkxBnK1kOKGMPT6j4THVvaTcYxcE3EddlHdTcsjdfqRFKeHTscPCKuf3kM5O6q9hvgdplWhKpZwhn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9P7P/i9HTdOc7K4ocXMw6/xP/YoKsws9Hy/OxUctLztMu3Jy
	EhYyJTnv+fwVfNbcP8sAr8xY+RYO5dxp7qEqJPMRQBr7WYfoXjtBYtvX4JmWVFQLFQ==
X-Gm-Gg: AeBDieuxymx9iNBnNFpuCSED6FaySR7E8lT0ruZCQMW+KAEPFtN848kR5Ddo+pr+UXB
	hWxHl0NXcUDNwAmdxYhalI7MCskATSJgdgMg+mYnlZGnkOotOqsJsElsHpWMlY14qF6pV8j1miT
	bi2Ctv362gnKivCTW1cq8GGaShF6rQVawkrL+I+k8myxgT19I0uaziRU7Rb72cC2r8LMZ3F8SK8
	FNbHebJK6gFqB42zAaIE0odlH7jZu4g1PAgoHwWp3nc58giadE1ljkNaAfu5XX7yJXF8iEiOs3U
	Qb/9CJvTBTByQZOoiIyUSo7psZgnTLhvNfUGr0KoCGjMClsVItiMSghKw5vAiK0Svt+xBUaipWl
	Husyc8jwzWx4y9k5Y6lS/YdI/qKifBqGehq/G8YiPdayqVvDU9kT8iHbIaXlx18Un7CmBFc8Puk
	qjlfrm2EWLPQ3m/Lu1CY5J69Vf2P7h45lHsGsDIFNWLwl1zwao/e2wzdAvRBZIvxsvj3YFHJuPd
	cNhxLP6aIi2dA==
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-48e51dd689fmr66886705e9.0.1778081628773;
        Wed, 06 May 2026 08:33:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:ad61:8ca1:7cb9:f2e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm91608975e9.5.2026.05.06.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:33:47 -0700 (PDT)
Date: Wed, 6 May 2026 17:33:42 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
Message-ID: <aftfVvru3npQ9kWq@google.com>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>

Hello!

Thanks for sending another revision!

On Sat, May 02, 2026 at 02:42:59PM +0200, Matthieu Buffet wrote:
> This is V4 of UDP access control in Landlock. Thanks to the round of
> review of v3, access rights have changed to something that seems easier
> to use and understand. It adds only two access rights, to restrict
> configuring local and remote addresses on UDP sockets. The one that
> restricts setting a remote address also controls sending datagrams to
> explicit remote addresses -ignoring any remote address preset on the
> socket-. The one that restricts binding to a local port also applies
> when the kernel auto-binds an ephemeral port.
> v1:
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> v2:
> Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
> v3:
> Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/
> 
> The limitation around allowing a process to send but not receive is
> still there, and could warrant another patch if there is a real user
> need.
> I'm just not super happy about the clarity of logs generated for denied
> autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
> addresses and ports are currently only logged if they are non-0. A later
> (coordinated LSM-wide) patch could improve readability by replacing != 0
> checks with new booleans in struct lsm_network_audit. I'm also not
> exactly happy with the integration in existing TCP selftests, but
> refactoring them has already been discussed earlier.
> 
> Changes v1->v2
> ==============
> - recvmsg hook is gone and sendmsg hook doesn't apply when sending to a
>   remote address pre-set on socket, to improve performance
> - don't add a get_addr_port() helper function, which required a weird
>   "am I in IPv4 or IPv6 context"
> - reorder hook prologue for consistency: check domain, then type and
>   family
> 
> Changes v2->v3
> ==============
> - removed support for sending datagrams with explicit destination
>   address of family AF_UNSPEC, which allowed to bypass restrictions with
>   a race condition
> - rebased on linux-mic/next => add support for auditing
> - fixed mistake in selftests when using unspec_srv variables, which were
>   implicitly of type SOCK_STREAM and did not actually test UDP code
> - add tests for IPPROTO_IP
> - improved docs, split off TCP-related refactoring
> 
> Changes v3->v4
> ==============
> - merge LANDLOCK_ACCESS_NET_CONNECT_UDP and
>   LANDLOCK_ACCESS_NET_SENDTO_UDP into
>   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP (everything that might set the
>   destination of a datagram)

I wish the name could be more in-line with
LANDLOCK_ACCESS_FS_RESOLVE_UNIX, but since this does not need
resolving any more, "resolve" in the name would be confusing.  I also
failed to come up with a better name for this access right.


> - make LANDLOCK_ACCESS_NET_BIND_UDP apply when kernel is about to
>   auto-bind an ephemeral port for the caller. Block it if policy would
>   not allow an explicit call to bind(0)
> - only deny sending AF_UNSPEC datagrams on IPv6 sockets, where there is
>   a risk of the address family changing midway
> 
> Patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> 3457a5ccacd3 ("landlock: Document fallocate(2) as another truncation corner case")
> All lines added are covered with selftests, except the "default: return
> 0" in current_check_autobind_udp_socket() which is not currently
> reachable (net.c goes from 92.9%->94.6% line coverage).
> 
> Let me know what you think!
> 
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Matthieu Buffet (7):
>   landlock: Add UDP bind() access control
>   landlock: Add UDP connect() access control
>   landlock: Add UDP send access control

For the final revision, I think it would be good to squash the two
commits that are about LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP.  That
reduces the chances that someone backports the first but not the
second to one of the distribution kernels.


>   selftests/landlock: Add UDP bind/connect tests
>   selftests/landlock: Add tests for sendmsg()
>   samples/landlock: Add sandboxer UDP access control
>   landlock: Add documentation for UDP support
> 
>  Documentation/userspace-api/landlock.rst     |   89 +-
>  include/uapi/linux/landlock.h                |   35 +-
>  samples/landlock/sandboxer.c                 |   40 +-
>  security/landlock/audit.c                    |    3 +
>  security/landlock/limits.h                   |    2 +-
>  security/landlock/net.c                      |  161 ++-
>  security/landlock/syscalls.c                 |    2 +-
>  tools/testing/selftests/landlock/base_test.c |    4 +-
>  tools/testing/selftests/landlock/net_test.c  | 1146 ++++++++++++++++--
>  9 files changed, 1341 insertions(+), 141 deletions(-)
> 
> 
> base-commit: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
> -- 
> 2.39.5
> 

—Günther
