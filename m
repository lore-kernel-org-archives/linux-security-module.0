Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C8403AFF
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265125; cv=none; b=tsvQJxaEYBujtrsgNaaOavHsqPoF2xmnxb2vfS0vslQdWaFoSqLI3kGaHj3ZaVQRkeGrSerGJaDlLLfWcntcar8SmxOaEmL5B+3RsmWo/98hMOrDaQW7Ko1ezwmmS4Ze9w1aSOtzt6i/DCJxMGN87bVbyqIUGY21BYGpMm4X46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265125; c=relaxed/simple;
	bh=qW1HlWkiOh12WtBJNB4SoIzKTvcqx/5szKKI3A5OMMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHBkRUAP1ls4Vh6+KF9ovvzBVn3/pbIos6AV6hq5hmX5l9A1fvTTiLxMY6LiiHFVUmZS3TolmMWovx+Cad0dFFlFE+RPUPmUBxxZsI1dhU5BjkfiQHbjds4lFtqXoMwRdSyyCZfEt8wbXkFlRX6JKt/ywsoJahy6evanKxTAW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmMov3ZT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmMov3ZT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so9203205e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265121; x=1788869921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=07yu7OM3o+Uy1/uNfXCagmF0K1rKdP2PBdLVsuiyQAY=;
        b=CmMov3ZTjRs97mVGVc9iquLr4HNrjx62amAkHwHQV7dJvCAL3IUwU14rWEW0b3FM6p
         PPzcTBm74kCLQkdGkcqDbhfHOA4ZaW27gOATjmSOoHrbhEWJe9bEVIHG43tbbiguF/+B
         PATEzEXyziJrhinG/67UvjERQRn5rB70uAfQ4eyR66VbJupCGnVqz0qFazdIcvGUX94Q
         U8yKBQobV4BAmX1ASPyptemY9plmMGc+V531bDh3/N0FGHMbY8ZS9pdPH1NhW5kdV0a9
         3c8lKHc2NYa4BOMir8gQRh+mXASx9W5ImpaPfmJjVvwSZ0/zZV+536criacceJ48g43Z
         RPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265121; x=1788869921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07yu7OM3o+Uy1/uNfXCagmF0K1rKdP2PBdLVsuiyQAY=;
        b=I2KV0Q3PeKOes8JwHihGLYr2ysXfmdZL4aCAbSFrmDRIEMvlSAhXFEIiwzmaMnDRYU
         lAOAYhM06PDTewVpU1b+c5YlXopNvLx/NxzHtGku47buUY4Up1sPoHwOJekRDw77cKo/
         3t6XZrvRC9CThpc2jlrcLkY8tOiCgeubSuz3biAwculS24T16bwNN2Abp5SAmZb/m03E
         VBrctTmM68dw8TZsuYP6Bd68X1BSv6LcwmWWqz353hFfKpE/IjD17gLrfm2rOyEpaRXS
         mMGnCdO5d+Vm6USb8++QcxNoU1me6gDErDd+gVbSI24uKdmWFNXXHSbifeDV+PpC2E8L
         Hrwg==
X-Forwarded-Encrypted: i=1; AHgh+RqEZRuRlVLAqYgSSKZ+Z0NJG4r40DMnzq0Q2blJEAP1h50UKMYhof3G+sYmISxKBBoIChJMuwIXTXRAZOYzjr/NFrIlmi0=@vger.kernel.org
X-Gm-Message-State: AFuF++kI/SfOsL8esXVyXhSV23G67k+yKNinHv0/0qaRHN5j4Y2se7uc
	wwlLO7NLTIoRRgpb4CnElNe0aNTwoXgjxXz6SJC1qC66SO/XKKp90RZB
X-Gm-Gg: AR+sD10yU8uH7XH4l+JYXI3BFTRHBLJnzog3Yrn0T7M2SV1IBIg8ZbWrwKj1w1P0pqT
	4LXZcezhwHeBu2EcwslQSr/NIe+p8e3ZeQ6z1IMopHN9iBxX+LLJQ9rg3hJzHkBJgDAlc0rHOkF
	l0tPTa8iokMcP86NL9dETSkaeJrdVyKX+WbVkcLibQNiyEbIWo/yEia3UIFo1DQoarSx6lEN5o3
	MdWH9HNA/0ki36Xl8WHLI02MQIwWW1F9xCBMctBKMiQ+WwuhJ4vsUajHLsq/EE2Zgr//lc2jYXh
	73+oFSX1gJrjhsxe78y2vZFMXfIVasPEvT5zXU5o4qE33WAyJCqhb3AYB3bDxWEn5IB8dtvr5BA
	MTut93UI0kibKCSICa24qVagCG+1X6OCngaPSNqBkv4g4VbZJ/RCJbhet9YLGwp8bESvlKg666r
	3DtOcsM+45PvToSd8S5/omIiDd2Ntj7BNviKhxOQZRbsnZ7T7eWVt922yhq7Nstw3l1Iyl
X-Received: by 2002:a05:600c:a00d:b0:49c:e1ed:26b1 with SMTP id 5b1f17b1804b1-49ce1ed26eamr30445615e9.16.1788265118063;
        Tue, 01 Sep 2026 05:18:38 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce44ea9sm60262685e9.14.2026.09.01.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:18:37 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:29:15 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apbFG4WKaZNsURo8@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831153456.5a7d6937@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831153456.5a7d6937@kernel.org>

On 26/08/31 03:34PM, Jakub Kicinski wrote:
> On Mon, 31 Aug 2026 11:09:25 +0000 Anton Protopopov wrote:
> > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > operators to mitigate known bugs without a need to reboot or livepatch
> > machines.  BPF has shown very useful to create such runtime policies.
> > However, many APIs and parts of kernel aren't covered by existing LSM
> > hooks and this would be beneficial to extend the coverage.
> 
> Dunno. Do you have any reason to believe that any of the CVEs your LLM
> gathered for you here are actually getting exploited? Spot checking 
> a few they seem to be mostly driver bugs. What security model do you
> have in mind? Untrusted/malicious users with physical NIC access?

For the untrusted part, here are some existing examples:

  * old untrusted bugs: CVE-2022-50651, CVE-2025-40255
  * "namespace CAP_NET_ADMIN" bugs: CVE-2024-43836, CVE-2025-21921

Also, the recent copy-fail is a stronger example (though not generic
netlink-related).

The general idea is that we gate the common de-multiplexors such that
not only known bugs, but mainly those which will appear in future are
covered. Rough numbers for coverage: around 5% of known cves are
covered with existing LSM hooks. Another ~5-7% can be covered if we
add netlink-related hooks [this series + net/sched, nftables,
rtnetlink, others smaller]. So, statistically, we know where
bugs had appeared in the past, so we can "predict" where new
will appear. Some of them might be severe, so this would be
good to have hooks in place to be able to "mitigate" them.

Just in case, to test this patch locally, I've found around 10 new
ethtool-related bug candidates. I've sent a fix to one, d09c98a6da21
("virtio_net: Fix resize of the RX ring"), which was easy to
reproduce in a VM. Others require specific hardware, though popular,
so I can try to reproduce some, and was planning to do this later.
Of those findings one is unprivileged, it triggers a OOB read.
