Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97411374721
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160782; cv=none; b=e/7Etngop1ibLn5BILHQHRjq8lw/FBEBxmo85RQQsMx0CiFhQmG8qkzb0s8/7vYdjfCN4QCPpLTubC+LTsfHhItnysS2OhzrMp4r3GJK05U2pnz4Jba54shZbHMXR9IlHduLkioNpfpA8LdEMGlifRcLd6NDRkLjP65RjeFf5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160782; c=relaxed/simple;
	bh=BA3ZOMsHyP2GTKp/rqwxW3xgiYBeA3bbd1xCYOxEnto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcqW0LzTsAdaYwb2ou8wYpRk8Tx12sUVcLt8lp2JsiGiFgox97sBzqoq9BqItVTWwfbzz0s/duKK+WI1v5EfOyqHT3vgQ2m/nodvS35ssfuJmQWC+GrV2EVz9a8VXjsP9S0rE7yL2EfRCloYJfJq5+rE8MbL3g73h32mT0UYaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRUpRL1M; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRUpRL1M"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so6162216eec.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792160780; x=1792765580; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMcQDGMpfF+Xt2i/WNjW/x8k2X+ctHzEstRfrAzmcvk=;
        b=NRUpRL1MzMDAaRTXXFuHrqn4wko3xp/8JnOIn7pYQnxhCO99toCDQkZmTO/2bTJcnv
         H27wEl9FegfrAHFdfBpSt9Yg3x5ZTbOiqmd1gsMZCczKn8TpsQ3iWwwuI50XfFtW3k5t
         Rf+e2PaT7aVBSAL+fPosWssDsQo/R7fA+kfWTvK34LkN8M9S22wL9nbP5+NnwvxGVyqq
         lPEQHlXLh36DzpNw6lokYGHVhIwzKehLN+PgmkUISoOyKg0o0TjZzoY+OLSDyNuRMze7
         VwQ69ZsZRMMfvy6qwjuN7PWYzzWc2SXTVfU0OBrPlP8A2XRp1V89hx264PDzphYX6Z2G
         41LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160780; x=1792765580;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMcQDGMpfF+Xt2i/WNjW/x8k2X+ctHzEstRfrAzmcvk=;
        b=JA3Yw/ZUtra+IMbJsGuDPATVi07e9VBJOkkHwrkd+o/UUQCqCcZh3nIm5NcFPoa7zQ
         zi11bATlI/cZCqsFvIBobosIzfa6TaCISgE9vw5fv7fwQ+cZVbIZ7Rcx0BlOA9mHcPQ5
         BoSNhE9YcBeSLyoN2SKnSUUp5ovX6Js8dhIcK13LdOZRsWh+Bq3+uD9YjtNABeGk+gg2
         f7S9FQmusv1ycR+P3EoA9dAVHiYJw9sa2QRlbn0q8jh1REziyAhJf/5CsEh70yruPuEL
         SkIEZ4qsSPCD7gPM/S8FqhPe9Zhj9bIgxEEkyqPHe12GmVxDDvJPUXTnkkmTHs6XcRAN
         UlBg==
X-Forwarded-Encrypted: i=1; AKwUvBzx6RQStRAWyAy4f0wmtux3A510/tvckCKqnhO7yGwKd8RzdJzrfLvWpSuxI4RH2cm+yktAOAAWYE+IrxCt952nRTggoTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOHQwq5et68HJM5HkTLt09rfDdjGSCY3WGq3jm0/pjeI1Z6hD+
	G0A6YOobIPAHCyT3VddwqacI75DssE48zRuA2OIqzsDaXwaCReQLiZFt
X-Gm-Gg: AYBFou2PKyQr2clOgMdAtc7zMN3eMx7UudTeq+OMcxmwCFgpio/4MRUlDDFpGCHVLKA
	R16tWgzIMRszSagzMtnM3KYsPM7Sboflpw7XjpoVrH0/7V4MgAOsahEac1V+sYu1ONO25FFpfRu
	M8/NQkLkt+aiZLefSab79lQKy7ZdMKZYF9mQ1zEt34Exr4/FBFzeg2ZKbNRsIPIY1QFrQL+WMBo
	7SjSQ+9lTmkhQ3YT/pG88jl6p/unUedb/REgi0plkFT/tzp2b03i6dTfxeLO2CP5bLWE5fTU8XN
	VnkRrE/N5IyAibO1R5yeXNHfYjEq1AUTlrd3MyqA+SxgnuwX4aDV/slfmYp41dRR33aPjFO7gDg
	zyKaX1zpWBmNem7HLBpAr9U2rp1k+FQi24umSLuHJkRrXynYCm3xMHIeKM/UJuXZ2beL1jiiwno
	iGbdW6TZDnEsjv8BvVUr4kYt2Que2lvmWsKnV42tlNaV/0K6xnYPtqznpKPSjuFrwiHHwmrJQQi
	sj11SSoXs3wH2+L+zft+WZRJr++e4ezDnDClnDEk9wsKQcmHzaa1yFEbHN4P6Qv1MS9/ppS5Wh2
	D9Ao24iMQ6YziTZ28hEb1HZjteFZLmezHD9t/VpQtD1P6nN7L4SMbAW4
X-Received: by 2002:a05:7022:28b:10b0:16f:c9db:c5af with SMTP id a92af1059eb24-185118eded7mr132172c88.11.1792160779405;
        Fri, 16 Oct 2026 07:26:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:ece0:b5:bb23:a54:ce61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm6348059c88.3.2026.10.16.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:26:18 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject:
 Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
Date: Fri, 16 Oct 2026 11:26:14 -0300
Message-ID: <179216077404.22091.15636720633867774901@gmail.com>
In-Reply-To:
 <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com>
References: <179138670045.80227.16292613517250896744@gmail.com>
 <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
 <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 9:39 AM Paul Moore wrote:
> while basic CALIPSO labeling is tested via an automated test job, this
> particular code path is not part of the automated testing.
> Improvements to the tests are always welcome.

Hi Paul,

I opened a PR adding a forwarding test to tests/inet_socket:

  https://github.com/SELinuxProject/selinux-testsuite/pull/106

It builds a client -- router -- server setup with network namespaces
and checks both directions: the router removing the CALIPSO option and
the router adding one.  On Fedora 44 (6.19.10, without the fix) only
the removal subtest fails, with the forwarded packet dropped as
truncated; with the fix all inet_socket and sctp tests pass, both as
unconfined_t and sysadm_t.

Until the fix reaches the kernel used by the CI, the removal subtest
will fail there; I'm happy to gate it on a kernel version if you
prefer.

Thanks,
Joas
